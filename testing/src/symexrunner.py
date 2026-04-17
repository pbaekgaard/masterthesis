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
        self.minimc_path = os.path.abspath(
            os.path.join(
                self.base_dir, config.get("minimc_path", "../minimc/build/bin/minimc")
            )
        )

    def run(self):
        wh_files = sorted(
            [f for f in os.listdir(self.tests_folder) if f.endswith(".wh")]
        )

        all_results = []

        for wh_file in wh_files:
            cmd = [self.minimc_path, wh_file, "mcall"]

            result = subprocess.run(
                cmd,
                cwd=self.tests_folder,
                capture_output=True,
                text=True,
                env={**os.environ, "TERM": "dumb"},  # cleaner output
            )

            violations = extract_violations(result.stdout)
            parsed = [parse_violation(v) for v in violations]

            for v in parsed:
                all_results.append(
                    {
                        "test": wh_file.replace(".wh", ""),
                        "variant": "symex",
                        "stmt": v.get("stmt"),
                        "faulty_bit": v.get("bit_shift") + 1,
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
        value = value.strip()

        # try int conversion if possible
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
