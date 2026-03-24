import os
import sys
import subprocess
import shutil
import toml
import csv
from datetime import datetime
import concurrent.futures
import multiprocessing
from tqdm import tqdm
from src.database import ResultsDatabase


def _fault_worker(args):
    asm_path, injection_point, pass_mode_config = args

    bin_dir = os.path.join(os.path.dirname(__file__), "..", "bin")
    interpreter_path = os.path.join(bin_dir, "interpreter")

    cmd = [interpreter_path, asm_path, "--injection-point", injection_point]

    result = subprocess.run(cmd, cwd=bin_dir, capture_output=True, text=True)

    passed = _check_passed(result, pass_mode_config)

    matched_output_line = None
    if pass_mode_config.get("mode") == "stdout":
        expected_pass = pass_mode_config.get("expected_pass", "")
        expected_fail = pass_mode_config.get("expected_fail", "")
        
        stdout_lines = result.stdout.strip().split("\n")
        
        if passed and expected_pass:
            for line in stdout_lines:
                if expected_pass in line:
                    matched_output_line = line.strip()
                    break
        elif not passed and expected_fail:
            for line in stdout_lines:
                if expected_fail in line:
                    matched_output_line = line.strip()
                    break
        
        if matched_output_line is None:
            matched_output_line = "N/A"

    return {
        "injection_point": injection_point,
        "returncode": result.returncode,
        "stdout": result.stdout.strip(),
        "stderr": result.stderr.strip(),
        "expected_output": pass_mode_config.get("expected_pass", ""),
        "matched_output_line": matched_output_line,
        "passed": passed,
    }


def _check_passed(result, pass_mode_config):
    mode = pass_mode_config.get("mode", "returncode")
    expected_pass = pass_mode_config.get("expected_pass", None)
    expected_fail = pass_mode_config.get("expected_fail", None)

    if mode == "returncode":
        return result.returncode == 0
    elif mode == "stdout":
        if expected_pass and expected_pass in result.stdout:
            return True
        elif expected_fail and expected_fail in result.stdout and result.returncode == 1:
            return False
        return True
    else:
        raise ValueError(f"Unknown pass mode: {mode}")


class TestRunner:
    def __init__(self, config_path=None):
        if config_path is None:
            config_path = os.path.join(os.path.dirname(__file__), "..", "config.toml")

        with open(config_path, "r") as f:
            config = toml.load(f)

        self.base_dir = os.path.join(os.path.dirname(__file__), "..")
        self.tests_folder = os.path.join(
            self.base_dir, config.get("test_folder", "fissc")
        )
        self.artifacts_folder = os.path.join(self.base_dir, "artifacts")
        self.modeled_registers = config.get(
            "modeled_registers",
            [
                "r0",
                "r1",
                "r2",
                "r3",
                "r4",
                "r5",
                "r6",
                "r7",
                "r8",
                "r9",
                "r10",
                "r11",
                "r12",
            ],
        )
        self.default_pass_mode = config.get("pass_mode", {}).get("default", "returncode")
        self.pass_mode_configs = config.get("pass_mode", {})
        self.tests = self._discover_tests()
        self.compile_results = None

    def _discover_tests(self):
        tests = []
        if not os.path.exists(self.tests_folder):
            return tests

        files = os.listdir(self.tests_folder)
        trv_files = sorted([f for f in files if f.endswith(".trv")])

        for trv_file in trv_files:
            test_name = trv_file[:-4]
            output_file = trv_file + ".output"
            toml_file = trv_file + ".toml"

            if output_file not in files:
                continue

            trv_path = os.path.join(self.tests_folder, trv_file)
            output_path = os.path.join(self.tests_folder, output_file)

            with open(output_path, "r") as f:
                expected_output = f.read().strip()

            pass_mode_config = self._load_pass_mode_config(test_name, trv_file, files)

            tests.append(
                {
                    "name": test_name,
                    "path": trv_path,
                    "expected_output": expected_output,
                    "pass_mode": pass_mode_config,
                }
            )

        return tests

    def _load_pass_mode_config(self, test_name, trv_file, files):
        toml_file = trv_file + ".toml"

        if toml_file in files:
            toml_path = os.path.join(self.tests_folder, toml_file)
            with open(toml_path, "r") as f:
                test_config = toml.load(f)
            pass_mode = test_config.get("pass_mode", {})
            if "mode" in pass_mode:
                mode = pass_mode["mode"]
                mode_config = self.pass_mode_configs.get(mode, {})
                return {
                    "mode": mode,
                    "expected_pass": pass_mode.get("expected_pass", mode_config.get("expected_pass", 0)),
                    "expected_fail": pass_mode.get("expected_fail", mode_config.get("expected_fail", None)),
                }

        mode = self.default_pass_mode
        mode_config = self.pass_mode_configs.get(mode, {})
        return {
            "mode": mode,
            "expected_pass": mode_config.get("expected_pass", 0),
            "expected_fail": mode_config.get("expected_fail", None),
        }

    def check_bin(self):
        from pathlib import Path

        script_dir = Path(__file__).resolve().parent.parent
        setup_path = script_dir / "setup"

        bin_dir = script_dir / "bin"

        if not bin_dir.is_dir():
            raise FileNotFoundError(
                f"Missing: compiler, interpreter. Fix by running: {setup_path}"
            )

        missing = []

        if not (bin_dir / "compiler").is_file():
            missing.append("compiler")

        if not (bin_dir / "interpreter").is_file():
            missing.append("interpreter")

        if missing:
            raise FileNotFoundError(
                f"Missing: {', '.join(missing)}. Fix by running: {setup_path}"
            )

    def compile_test(self, test, hard, compiled_folder):
        trv_path = test["path"]
        test_name = test["name"]

        if hard:
            asm_path = os.path.join(compiled_folder, f"{test_name}.hard.asm")
        else:
            asm_path = os.path.join(compiled_folder, f"{test_name}.asm")

        compiler_dir = os.path.join(os.path.dirname(__file__), "..", "bin")

        cmd = [os.path.join(compiler_dir, "compiler"), trv_path, "-o", asm_path]
        if hard:
            cmd.append("--hard")

        result = subprocess.run(cmd, cwd=compiler_dir, capture_output=True, text=True)
        return result.returncode == 0, asm_path, result.stdout, result.stderr

    def interpret_test(self, asm_path, injection_point=None, debug=False):
        bin_dir = os.path.join(os.path.dirname(__file__), "..", "bin")
        interpreter_path = os.path.join(bin_dir, "interpreter")

        cmd = [interpreter_path, asm_path]

        if debug:
            cmd.append("--debug")

        if injection_point:
            cmd.extend(["--injection-point", injection_point])

        result = subprocess.run(cmd, cwd=bin_dir, capture_output=True, text=True)

        return {
            "returncode": result.returncode,
            "stdout": result.stdout.strip(),
            "stderr": result.stderr.strip(),
        }

    def list_tests(self):
        return self.tests

    def _get_next_run_number(self):
        if not os.path.exists(self.artifacts_folder):
            return 1

        max_num = 0
        for item in os.listdir(self.artifacts_folder):
            base_name = item[:-4] if item.endswith(".zip") else item
            if os.path.isdir(
                os.path.join(self.artifacts_folder, item)
            ) or item.endswith(".zip"):
                parts = base_name.split("-", 1)
                if len(parts) == 2 and parts[0].isdigit():
                    max_num = max(max_num, int(parts[0]))
        return max_num + 1

    def setup(self):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        run_num = self._get_next_run_number()
        self.run_folder_name = f"{run_num}-{timestamp}"
        self.run_folder = os.path.join(self.artifacts_folder, self.run_folder_name)
        self.run_tests_folder = os.path.join(self.run_folder, "tests")
        self.compiled_folder = os.path.join(self.run_folder, "compiled_test_files")
        self.db_path = os.path.join(self.run_folder, "results.db")

        os.makedirs(self.run_folder, exist_ok=True)
        os.makedirs(self.run_tests_folder, exist_ok=True)
        os.makedirs(self.compiled_folder, exist_ok=True)

        for f in os.listdir(self.tests_folder):
            if f.endswith(".trv") or f.endswith(".trv.output"):
                shutil.copy(os.path.join(self.tests_folder, f), self.run_tests_folder)

        self.db = ResultsDatabase(self.db_path)
        self.run_id = self.db.create_run(run_num, self.tests_folder)

        return self.run_folder

    def _get_program_max_pc(self, asm_path):
        with open(asm_path, "r") as f:
            lines = f.readlines()

        in_start = False
        instruction_count = 0

        for raw_line in lines:
            line = raw_line.strip()

            if not line:
                continue

            # remove comments
            if ";" in line:
                line = line.split(";", 1)[0].strip()
            if "//" in line:
                line = line.split("//", 1)[0].strip()

            if not line:
                continue

            if not in_start:
                if line == "_start:":
                    in_start = True
                continue

            # skip labels after _start
            if line.endswith(":"):
                continue

            if line.startswith("."):
                continue

            # count everything else as an instruction
            instruction_count += 1

        return instruction_count

    def _generate_injection_points(self, asm_path):
        max_pc = self._get_program_max_pc(asm_path)
        injection_points = []

        # pc faults: pc:<pc>:<bit>
        for pc in range(1, max_pc):
            for bit in range(
                1, 32
            ):  # TODO: Find ud af om den skal hedde 33 eller 32, ændrede til 32 selvom chatten mente 33
                injection_points.append(f"pc:{pc}:{bit}")

        # reg faults: reg:<pc>:<reg>:<bit>
        for pc in range(1, max_pc):
            for reg in range(13):
                for bit in range(1, 33):
                    injection_points.append(f"reg:{pc}:{reg}:{bit}")

        return injection_points

    def _run_fault_campaign(self, test_name, variant, asm_path, pass_mode_config, limit=None):
        injection_points = self._generate_injection_points(asm_path)

        if limit is not None and len(injection_points) > limit:
            injection_points = injection_points[:limit]
            print(f"  Limited to {limit} injection points")

        cpu_count = multiprocessing.cpu_count()
        print(f"  Using {cpu_count} workers")

        results = []

        tasks = [
            (asm_path, injection_point, pass_mode_config)
            for injection_point in injection_points
        ]

        with concurrent.futures.ProcessPoolExecutor(max_workers=cpu_count) as executor:
            for res in tqdm(
                executor.map(_fault_worker, tasks, chunksize=50),
                total=len(tasks),
                desc="Fault Injection",
            ):
                res["test"] = test_name
                res["variant"] = variant
                results.append(res)

        return results

    def compile(self):
        results = []
        for test in self.tests:
            test_result = {"name": test["name"], "normal": None, "hard": None}

            for hard in [False, True]:
                hard_str = "hard" if hard else "normal"
                success, asm_path, stdout, stderr = self.compile_test(
                    test, hard, self.compiled_folder
                )
                test_result[hard_str] = {
                    "success": success,
                    "asm_path": asm_path,
                    "stdout": stdout,
                    "stderr": stderr,
                }

            results.append(test_result)
        self.compile_results = results
        return results

    def run_tests(self, limit=None, run_variants="both"):
        if not hasattr(self, "run_folder"):
            self.setup()

        if self.compile_results is None:
            self.compile()

        all_fault_results = []

        if run_variants == "normal":
            variants = [False]
        elif run_variants == "hard":
            variants = [True]
        else:
            variants = [False, True]
        compile_results = self.compile_results or []

        for test, result in zip(self.tests, compile_results):
            print(f"Test: {test['name']}")

            for hard in variants:
                hard_str = "hard" if hard else "normal"
                res = result[hard_str]

                if not res["success"]:
                    print(f"  Compilation failed ({hard_str})")
                    if res["stdout"]:
                        print(f"    stdout: {res['stdout']}")
                    if res["stderr"]:
                        print(f"    stderr: {res['stderr']}")
                    continue

                asm_path = res["asm_path"]
                max_pc = self._get_program_max_pc(asm_path)
                injection_points = self._generate_injection_points(asm_path)

                print(f"  Compiled ({hard_str}) successfully")
                print(f"  ASM path: {asm_path}")
                print(f"  Max PC: {max_pc}")
                print(f"  Fault runs to execute: {len(injection_points)}")

                fault_results = self._run_fault_campaign(
                    test_name=test["name"],
                    variant=hard_str,
                    asm_path=asm_path,
                    pass_mode_config=test["pass_mode"],
                    limit=limit,
                )

                all_fault_results.extend(fault_results)

        self.db.insert_results_batch(self.run_id, all_fault_results)
        self.db.close()

        zip_base = os.path.join(self.artifacts_folder, self.run_folder_name)
        shutil.make_archive(
            zip_base, "zip", self.artifacts_folder, self.run_folder_name
        )
        shutil.rmtree(self.run_folder)

        print(f"\nArtifacts saved to: {zip_base}.zip")


if __name__ == "__main__":
    runner = TestRunner()

    print(f"Running test runner")
    print(f"Found {len(runner.tests)} tests")
    runner.run_tests()
