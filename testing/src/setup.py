#!/usr/bin/env python3

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
import threading

SCRIPT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BIN_DIR = os.path.join(SCRIPT_DIR, "bin")
MINIMC_DIR = os.path.join(SCRIPT_DIR, "..", "minimc")
COMPILER_DIR = os.path.join(SCRIPT_DIR, "..", "compiler")
INTERPRETER_DIR = os.path.join(SCRIPT_DIR, "..", "interpreter")


class ProgressTracker:
    def __init__(self):
        self.mini_pct = 0
        self.comp_pct = 0
        self.int_pct = 0
        self.lock = threading.Lock()
        self.running = True

    def update(self, name, value):
        with self.lock:
            setattr(self, f"{name}_pct", value)

    def get(self, name):
        with self.lock:
            return getattr(self, f"{name}_pct")

    def stop(self):
        self.running = False


def draw_line(tracker, offset, name, label):
    pct = tracker.get(name)
    filled = pct // 5
    color = "\033[32m" if pct == 100 else "\033[33m"
    bar = "#" * filled + " " * (20 - filled)
    line = f"{color}[{bar}]\033[0m {pct:3d}% - {label}"
    sys.stdout.write(f"\033[?25l\033[s\033[{offset}A\033[K{line}\033[u\033[?25h")
    sys.stdout.flush()


def run_command(cmd, cwd, callback=None, env=None):
    proc = subprocess.Popen(
        cmd,
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
        env=env or {}
    )
    for line in proc.stdout:
        if callback:
            callback(line)
        print(line, end="")
    proc.wait()
    return proc.returncode


def build_minimc_task(tracker, force):
    if force:
        shutil.rmtree(os.path.join(MINIMC_DIR, "build"), ignore_errors=True)

    git_dir = os.path.join(MINIMC_DIR, ".git")
    if not os.path.isdir(git_dir) or not os.listdir(MINIMC_DIR):
        subprocess.run(
            ["git", "submodule", "update", "--init", "--recursive"],
            cwd=SCRIPT_DIR,
            capture_output=True
        )
        subprocess.run(["git", "checkout", "development"], cwd=MINIMC_DIR, capture_output=True)
        subprocess.run(["git", "pull"], cwd=MINIMC_DIR, capture_output=True)

    subprocess.run(["cmake", "-B", "build", "-Wno-dev"], cwd=MINIMC_DIR, capture_output=True)

    cmake_proc = subprocess.Popen(
        ["stdbuf", "-oL", "cmake", "--build", "build"],
        cwd=MINIMC_DIR,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1
    )

    for line in cmake_proc.stdout:
        match = re.search(r"\[ *([0-9]+)%\]", line)
        if match:
            tracker.update("mini", int(match.group(1)))
            continue
        match = re.search(r"\[([0-9]+)/([0-9]+)\]", line)
        if match:
            current = int(match.group(1))
            total = int(match.group(2))
            tracker.update("mini", int(current * 100 / total))

    cmake_proc.wait()
    tracker.update("mini", 100)

    shutil.copy(os.path.join(MINIMC_DIR, "build", "bin", "minimc"),
                os.path.join(BIN_DIR, "minimc"))


def build_rust_task(tracker, project_dir, bin_out_name, target_bin_name, force):
    if force:
        shutil.rmtree(os.path.join(project_dir, "target"), ignore_errors=True)

    tracker.update("comp" if "comp" in bin_out_name else "int", 10)
    subprocess.run(["cargo", "build", "--release"], cwd=project_dir, capture_output=True)
    tracker.update("comp" if "comp" in bin_out_name else "int", 100)

    shutil.copy(os.path.join(project_dir, "target", "release", target_bin_name),
                os.path.join(BIN_DIR, bin_out_name))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", "--reinit", action="store_true", help="Force rebuild")
    parser.add_argument("--targets", type=str, default="all", help="Comma-separated build targets")
    args = parser.parse_args()

    targets = [t.strip() for t in args.targets.split(",")]
    if "all" in targets:
        targets = ["minimc", "compiler", "interpreter"]

    for t in targets:
        if t not in ("minimc", "compiler", "interpreter"):
            print(f"\033[91mError: Unknown target '{t}'. Valid: minimc, compiler, interpreter\033[0m")
            sys.exit(1)

    force = args.reinit

    if force:
        if "compiler" in targets:
            shutil.rmtree(os.path.join(COMPILER_DIR, "target"), ignore_errors=True)
        if "interpreter" in targets:
            shutil.rmtree(os.path.join(INTERPRETER_DIR, "target"), ignore_errors=True)
        if "minimc" in targets:
            shutil.rmtree(os.path.join(MINIMC_DIR, "build"), ignore_errors=True)
        for t in targets:
            bin_out_name = {"compiler": "compiler", "interpreter": "interpreter", "minimc": "minimc"}[t]
            bin_path = os.path.join(BIN_DIR, bin_out_name)
            if os.path.exists(bin_path):
                os.remove(bin_path)

    os.makedirs(BIN_DIR, exist_ok=True)

    tracker = ProgressTracker()

    is_parallel = len(targets) > 1

    if is_parallel:
        print("\033[1mInitializing Parallel Build...\033[0m")
        print()
        print()
        print()

        threads = []
        for target in targets:
            if target == "minimc":
                t = threading.Thread(target=build_minimc_task, args=(tracker, force))
                threads.append(t)
            elif target == "compiler":
                t = threading.Thread(target=build_rust_task, args=(tracker, COMPILER_DIR, "compiler", "trivic", force))
                threads.append(t)
            elif target == "interpreter":
                t = threading.Thread(target=build_rust_task, args=(tracker, INTERPRETER_DIR, "interpreter", "thumb2_interpreter", force))
                threads.append(t)

        for t in threads:
            t.start()

        while any(t.is_alive() for t in threads):
            if "minimc" in targets:
                draw_line(tracker, 3, "mini", "MiniMC")
            if "compiler" in targets:
                draw_line(tracker, 2, "comp", "Compiler")
            if "interpreter" in targets:
                draw_line(tracker, 1, "int", "Interpreter")
            import time
            time.sleep(0.1)

        tracker.stop()

        if "minimc" in targets:
            draw_line(tracker, 3, "mini", "MiniMC")
        if "compiler" in targets:
            draw_line(tracker, 2, "comp", "Compiler")
        if "interpreter" in targets:
            draw_line(tracker, 1, "int", "Interpreter")

        for t in threads:
            t.join()

        print("\n\n\033[32m✔ All tasks completed successfully!\033[0m")
    else:
        target = targets[0]
        name_map = {"comp": "compiler", "int": "interpreter", "mini": "minimc"}
        label_map = {"mini": "MiniMC", "comp": "Compiler", "int": "Interpreter"}
        name = {"minimc": "mini", "compiler": "comp", "interpreter": "int"}[target]

        print(f"\033[1mBuilding {label_map[name]}...\033[0m")
        print()

        if target == "minimc":
            t = threading.Thread(target=build_minimc_task, args=(tracker, force))
        elif target == "compiler":
            t = threading.Thread(target=build_rust_task, args=(tracker, COMPILER_DIR, "compiler", "trivic", force))
        elif target == "interpreter":
            t = threading.Thread(target=build_rust_task, args=(tracker, INTERPRETER_DIR, "interpreter", "thumb2_interpreter", force))

        t.start()
        while t.is_alive():
            draw_line(tracker, 1, name, label_map[name])
            import time
            time.sleep(0.1)
        t.join()
        draw_line(tracker, 1, name, label_map[name])
        print(f"\n\033[32m\u2714 {label_map[name]} build completed!\033[0m")

    print(f"Binaries are available in: {BIN_DIR}")


if __name__ == "__main__":
    main()
