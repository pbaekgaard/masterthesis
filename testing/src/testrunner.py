import os
import sys
import subprocess
import shutil
import toml
from datetime import datetime

class TestRunner:
    def __init__(self, config_path=None):
        if config_path is None:
            config_path = os.path.join(os.path.dirname(__file__), "..", "config.toml")
        
        with open(config_path, 'r') as f:
            config = toml.load(f)
        
        self.base_dir = os.path.join(os.path.dirname(__file__), "..")
        self.tests_folder = os.path.join(self.base_dir, config.get('tests_folder', 'tests'))
        self.artifacts_folder = os.path.join(self.base_dir, "artifacts")
        self.tests = self._discover_tests()
    
    def _discover_tests(self):
        tests = []
        if not os.path.exists(self.tests_folder):
            return tests
        
        files = os.listdir(self.tests_folder)
        trv_files = sorted([f for f in files if f.endswith('.trv')])
        
        for trv_file in trv_files:
            test_name = trv_file[:-4]
            output_file = trv_file + ".output"
            
            if output_file in files:
                trv_path = os.path.join(self.tests_folder, trv_file)
                output_path = os.path.join(self.tests_folder, output_file)
                
                with open(output_path, 'r') as f:
                    expected_output = f.read().strip()
                
                tests.append({
                    'name': test_name,
                    'path': trv_path,
                    'expected_output': expected_output
                })
        
        return tests
    
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
        trv_path = test['path']
        test_name = test['name']
        
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
    
    def list_tests(self):
        return self.tests
    
    def _get_next_run_number(self):
        if not os.path.exists(self.artifacts_folder):
            return 1
        
        max_num = 0
        for item in os.listdir(self.artifacts_folder):
            base_name = item[:-4] if item.endswith('.zip') else item
            if os.path.isdir(os.path.join(self.artifacts_folder, item)) or item.endswith('.zip'):
                parts = base_name.split('-', 1)
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
        
        os.makedirs(self.run_folder, exist_ok=True)
        os.makedirs(self.run_tests_folder, exist_ok=True)
        os.makedirs(self.compiled_folder, exist_ok=True)
        
        for f in os.listdir(self.tests_folder):
            if f.endswith('.trv') or f.endswith('.trv.output'):
                shutil.copy(os.path.join(self.tests_folder, f), self.run_tests_folder)
        
        return self.run_folder
    
    def compile(self):
        results = []
        for test in self.tests:
            test_result = {'name': test['name'], 'normal': None, 'hard': None}
            
            for hard in [False, True]:
                hard_str = "hard" if hard else "normal"
                success, asm_path, stdout, stderr = self.compile_test(test, hard, self.compiled_folder)
                test_result[hard_str] = {'success': success, 'asm_path': asm_path, 'stdout': stdout, 'stderr': stderr}
            
            results.append(test_result)
        
        return results
    
    def run_tests(self):        

        
        zip_base = os.path.join(self.artifacts_folder, self.run_folder_name)
        shutil.make_archive(zip_base, 'zip', self.artifacts_folder, self.run_folder_name)
        shutil.rmtree(self.run_folder)
        
        print(f"\nArtifacts saved to: {zip_base}.zip")


if __name__ == "__main__":
    runner = TestRunner()
    
    print(f"Running test runner")
    print(f"Found {len(runner.tests)} tests")
    runner.run_tests()
