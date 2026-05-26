import toml, os, subprocess, re


class SymexRunner:
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
        bin_dir = os.path.join(os.path.dirname(__file__), "..", "bin")
        self.minimc_path = os.path.join(bin_dir, "minimc")

    def run(self, run_variants):
            # 1. Gather and filter the files based on the requested run_variants strategy
            wh_files = []
            for f in os.listdir(self.artifacts_folder):
                if not f.endswith(".wh"):
                    continue
                    
                is_hard = f.endswith(".hard.wh")
                is_vd = f.endswith(".vd.wh")
                is_sc = f.endswith(".sc.wh")
                is_normal = not (is_hard or is_vd or is_sc)

                if (
                    run_variants == "all"
                    or (run_variants == "normal" and is_normal)
                    or (run_variants == "hard" and is_hard)
                    or (run_variants == "vd" and is_vd)
                    or (run_variants == "sc" and is_sc)
                ):
                    wh_files.append(f)
                    
            wh_files.sort()

            all_results = []

            for wh_file in wh_files:
                wh_path = os.path.join(self.artifacts_folder, wh_file)
                print(f"Running MiniMC on {wh_file}")
                cmd = [self.minimc_path, wh_path, "mc", "--mc.symbolic", "--mc.all", "--mc.concretize"]

                result = subprocess.run(
                    cmd,
                    cwd=self.tests_folder,
                    capture_output=True,
                    text=True,
                    env={**os.environ, "TERM": "dumb"},  # cleaner output
                )

                violations = extract_violations(result.stdout)
                parsed = [parse_violation(v) for v in violations]
                
                # 2. Determine the clean variant name string
                if wh_file.endswith(".hard.wh"):
                    variant = "Hard"
                elif wh_file.endswith(".vd.wh"):
                    variant = "VD"
                elif wh_file.endswith(".sc.wh"):
                    variant = "SC"
                else:
                    variant = "Normal"

                # 3. Strip all suffixes from the test name cleanly
                test_name = wh_file
                for suffix in [".hard.wh", ".vd.wh", ".sc.wh", ".wh"]:
                    if test_name.endswith(suffix):
                        test_name = test_name[:-len(suffix)]
                        break

                for v in parsed:
                    all_results.append(
                        {
                            "test": test_name,
                            "variant": variant,
                            "stmt": v.get("stmt"),
                            "faulty_bit": v.get("bit_shift"),
                            "result": v.get("res"),
                        }
                    )

            return all_results


def strip_ansi(text):
    ansi_escape = re.compile(r"\x1B\[[0-?]*[ -/]*[@-~]")
    return ansi_escape.sub("", text)


def extract_violations(stdout):
    clean = strip_ansi(stdout)

    pattern = re.compile(r"Found Violation\s*\n\[.*?\]\s*\n\{.*?\}", re.DOTALL)

    return pattern.findall(clean)


def parse_violation(block):
    result = {}

    # extract key-value pairs like: prgm:res 128
    matches = re.findall(r"prgm:(\w+)\s+([^\n]+)", block)

    for key, value in matches:
        # key: mem, value: <0 I8>
        # key: res, value: <0x1 I32>
        # key: stmt, value: <0x1 I32>
        # key: flip_mask, value: <0x1 I32>
        # key: bit_shift, value: <0 I32>
        value = value.strip()

        inner = re.match(r"<(\S+)\s+\w+>", value)
        if inner:
            raw = inner.group(1)
            try:
                value = int(raw, 0)
            except ValueError:
                pass
        else:
            try:
                value = int(value)
            except ValueError:
                pass

        result[key] = value

    return result


if __name__ == "__main__":
    runner = SymexRunner()

    print(f"Running symex runner")
    runner.run()
