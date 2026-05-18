import os
import re
import subprocess
import toml
import concurrent.futures
import multiprocessing
from tqdm import tqdm

def _get_countermeasure_location_range(asm_path: str):
    with open(asm_path, "r") as f:
        lines = f.readlines()

    start_pc = None
    end_pc = None
    current_pc = 0
    found_start = False
    
    # We define what an 'instruction' looks like to ignore labels/comments
    # Usually starts with whitespace followed by an opcode (mov, svc, etc.)
    for line in lines:
        clean_line = line.strip()
        
        # 1. Find the entry point
        if "_start:" in clean_line:
            found_start = True
            current_pc += 1
            continue
            
        if not found_start:
            continue

        # 2. Check for the label we are looking for
        if "countermeasure:" in clean_line:
            start_pc = current_pc

        if start_pc is not None:
            if ".size _start, .-_start" in clean_line:
                end_pc = current_pc -2



        current_pc += 1



    return start_pc, end_pc

# Usage
# start, end = _get_countermeasure_location_range("code.s")
# print(f"Countermeasure range: {start} to {end}")

def _fault_worker(args):
    asm_path, injection_point, pass_mode_config = args

    bin_dir = os.path.join(os.path.dirname(__file__), "..", "bin")
    interpreter_path = os.path.join(bin_dir, "interpreter")

    cmd = [interpreter_path, asm_path, "--injection-point", injection_point, "--test-mode"]

    result = subprocess.run(cmd, cwd=bin_dir, capture_output=True, text=True)

    (cm_start, cm_end) = _get_countermeasure_location_range(asm_path)
    passed = _check_passed(result, pass_mode_config, cm_start, cm_end, injection_point)

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
        "test_report": _extract_test_report(result.stdout),
    }

def _extract_test_report(stdout: str):
    keyword = r'"title":\s*"test_report"'
    pattern = rf'\{{[^{{}}]*{keyword}[^{{}}]*\}}'
    match = re.search(pattern, stdout,flags=re.MULTILINE)
    if match: 
        return match.group(0)
    return '{"title": "test_report"}'
    
def _check_passed(result, pass_mode_config, cm_start, cm_end, injection_point):
    mode = pass_mode_config.get("mode", "returncode")
    expected_pass = pass_mode_config.get("expected_pass", None)
    expected_fail = pass_mode_config.get("expected_fail", None)

    if "COUNTERMEASURE" in result.stdout:
        return 77
    elif "Detected Infinite Loop" in result.stdout:
        return 3
    if mode == "returncode" and result.returncode == 0:
        return 1
    elif mode == "returncode" and "panic" in result.stderr:
        return 2
    elif mode == "returncode" and result.returncode != 0:
        if cm_start is not None and cm_end is not None and injection_point is not None:
            parts = injection_point.split(":")
            if parts[0] == "pc":
                pc_value = int(parts[1])
                bit_value = int(parts[2])
                mask = 1 << bit_value
                flipped_pc = pc_value ^ mask
                if(flipped_pc in range(cm_start, cm_end+1)):
                    return 78
                return 0
            return 0
        return 0
    elif mode == "stdout":
        if expected_pass and expected_pass in result.stdout:
            return 1
        elif expected_fail and expected_fail in result.stdout and result.returncode == 1:
            return 0
        return 1
    else:
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
        print(f"RETURNCODE: {result.returncode}")
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
        self.injection_points = config.get(
            "injection_points",
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
        self.current_file : File = None

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
                    "expected_pass": pass_mode.get("passed", 0) if mode == "returncode" else pass_mode.get("expected_pass"),
                    "expected_fail": pass_mode.get("failed", 1) if mode == "returncode" else pass_mode.get("expected_fail"),
                }

        mode = self.default_pass_mode
        mode_config = self.pass_mode_configs.get(mode, {})
        return {
            "mode": mode,
            "expected_pass": mode_config.get("passed", 0) if mode == "returncode" else mode_config.get("expected_pass"),
            "expected_fail": mode_config.get("failed", 1) if mode == "returncode" else mode_config.get("expected_fail"),
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

        if not (bin_dir / "minimc").is_file():
            missing.append("minimc")

        if missing:
            raise FileNotFoundError(
                f"Missing: {', '.join(missing)}. Fix by running: {setup_path}"
            )

    def compile_test(self, test, hard, compiled_folder):
        trv_path = test["path"]
        test_name = test["name"]

        if hard:
            asm_path = os.path.join(compiled_folder, f"{test_name}.hard")
        else:
            asm_path = os.path.join(compiled_folder, f"{test_name}")

        compiler_dir = os.path.join(os.path.dirname(__file__), "..", "bin")

        cmd = [os.path.join(compiler_dir, "compiler"), trv_path, "-o", asm_path]
        if hard:
            cmd.append("--hard")

        result = subprocess.run(cmd, cwd=compiler_dir, capture_output=True, text=True)
        asm_path = asm_path + ".s"
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

            if line.startswith("."):
                continue

            # count everything else as an instruction
            instruction_count += 1

        return instruction_count

    def _generate_injection_points(self, asm_path):
        max_pc = self._get_program_max_pc(asm_path)
        injection_points = []

        # reg faults: reg:<pc>:<reg>:<bit>
        registers = []
        cpsr_registers = []
        pc_points = []

        for point in self.injection_points:
            if point.startswith('cpsr_'):
                cpsr_registers.append(point[5:])
            elif point.startswith('r') and point[1:].isdigit():
                registers.append(point[1:])
            elif point.startswith('pc=') and point[3] == "*":
                pc_points.clear();
                pc_points.append("ALL")
            elif point.startswith('pc=') and point[3:].isdigit():
                if len(pc_points) > 0 and pc_points[0] == "ALL":
                    continue
                pc_points.append(point[3:])


        if len(pc_points) > 0:
            if pc_points[0] == "ALL":
                for pc in range(1, max_pc):
                    for bit in range(0, 32):
                        injection_points.append(f"pc:{pc}:{bit}")
            else:
                for pc in pc_points:
                    for bit in range(0, 32):
                        injection_points.append(f"pc:{pc}:{bit}")

        if len(registers) > 0:
            for pc in range(1, max_pc):
                for reg in registers:
                    for bit in range(0, 32):
                        injection_points.append(f"reg:{pc}:{reg}:{bit}")

        if len(cpsr_registers) > 0:
            for pc in range(1, max_pc):
                for reg in cpsr_registers:
                    injection_points.append(f"cpsr:{pc}:{reg}")

        return injection_points

    def stmt_to_pc_range(self, asm_path, stmt: int):
        with open(asm_path, 'r') as f:
            print(f"Looking for STMT={stmt} in file: {asm_path}")
            lines = f.readlines()
        for i, line in enumerate(lines):
            if f'.word 0x10000000 @ {stmt}' in line:
                a_val = int(lines[i + 1].split('+')[1].split()[0])
                b_val = int(lines[i + 2].split('+')[1].split()[0])
                return a_val, b_val
        return None

    def stmt_to_regs(self, asm_path, stmt: int):
        with open(asm_path, 'r') as f:
            lines = f.readlines()
        for i, line in enumerate(lines):
            if f'.word 0x10000000 @ {stmt}' in line:
                return re.findall(r'r(\d+)', lines[i + 3])
        return None


    def _symex_to_injection_points(self, variant, asm_path, minimc_res):
        injection_points = []
        for fault in minimc_res:
            if fault['variant'].lower() != variant:
                continue
            stmt = fault['stmt']
            (start_pc, end_pc) = self.stmt_to_pc_range(asm_path, stmt)
            registers = self.stmt_to_regs(asm_path, stmt)
            bit = fault['faulty_bit']
            for reg in registers:
                for pc in range(start_pc, end_pc+1):
                    ip = f"reg:{pc}:{reg}:{bit}"
                    injection_points.append(ip)
        return injection_points


    def _run_fault_campaign(self, test_name, variant, asm_path, pass_mode_config, limit=None, minimc_res=None):
        exhaustive = True
        if minimc_res:
            exhaustive = False

        injection_points : list[str] = []
        if exhaustive:
            injection_points = self._generate_injection_points(asm_path)
        else:
            injection_points = self._symex_to_injection_points(variant, asm_path, minimc_res)

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

    def compile(self, hard=False):
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

    def run_tests(self, limit=None, run_variants="both", minimc_res=None):
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
                    minimc_res=minimc_res
                )

                all_fault_results.extend(fault_results)
        return all_fault_results


if __name__ == "__main__":
    runner = TestRunner()

    print(f"Running test runner")
    print(f"Found {len(runner.tests)} tests")
    runner.run_tests()
