import math
class Oracle:
    def __init__(self):
        self.oracle_map = {
            "hash": hash_check_passed,
            "pinny": pinny_check_passed,
            "crt": crt_check_passed,
        }

    def get(self, test_folder: str):
        if test_folder is None:
            raise Exception("test_folder not found in config")
        test_name = test_folder.split("/")[-1]
        return self.oracle_map.get(test_name)


def hash_check_passed(result, pass_mode_config, cm_start, cm_end, injection_point):
    mode = pass_mode_config.get("mode", "stdout")
    expected_pass = pass_mode_config.get("expected_pass", None)
    expected_fail = pass_mode_config.get("expected_fail", None)


    if cm_start is not None and cm_end is not None and injection_point is not None and result.returncode == 77:
        parts = injection_point.split(":")
        if parts[0] == "pc":
            pc_value = int(parts[1])
            bit_value = int(parts[2])
            mask = 1 << bit_value
            flipped_pc = pc_value ^ mask
            if flipped_pc in range(cm_start, cm_end + 1):
                return 78
    if "COUNTERMEASURE" in result.stdout or result.returncode == 77:
        return 77
    elif "Detected Infinite Loop" in result.stdout:
        return 3

    if mode == "stdout":
        if expected_pass and str(expected_pass) in result.stdout:
            return 1
        elif expected_fail and str(expected_fail) in result.stdout:
            return 0
        return 2
    else:
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
        print(f"RETURNCODE: {result.returncode}")
        raise ValueError(f"Unknown pass mode: {mode}")

def calc_passed_val(actual_output, expected_fail, n_value, expected_pass) -> bool:
    diff = abs(actual_output - expected_pass)
    recovered = math.gcd(diff, n_value)
    if recovered == expected_fail:
        return True
    return

def crt_check_passed(result, pass_mode_config, cm_start, cm_end, injection_point):
    got_p = False
    got_q = False
    mode = pass_mode_config.get("mode", "stdout")
    expected_pass, n_value = pass_mode_config.get("expected_pass", None).split(",")
    expected_pass = int(expected_pass)
    n_value = int(n_value)
    expected_fail_p, expected_fail_q, unencrypted_msg = pass_mode_config.get("expected_fail", None).split(",")
    expected_fail_p = int(expected_fail_p)
    expected_fail_q = int(expected_fail_q)
    unencrypted_msg = int(unencrypted_msg)

    actual_output = None
    try:
        actual_output = int(result.stdout.strip().splitlines()[-2])
    except:
        actual_output = None

    if actual_output is not None:
        got_p = calc_passed_val(actual_output, expected_fail_p, n_value, expected_pass)
        got_q = calc_passed_val(actual_output, expected_fail_q, n_value, expected_pass)

    if cm_start is not None and cm_end is not None and injection_point is not None and result.returncode == 77:
        parts = injection_point.split(":")
        if parts[0] == "pc":
            pc_value = int(parts[1])
            bit_value = int(parts[2])
            mask = 1 << bit_value
            flipped_pc = pc_value ^ mask
            if flipped_pc in range(cm_start, cm_end + 1):
                return 78

    if "panic" in result.stderr:
        return 2
    if "COUNTERMEASURE" in result.stdout or result.returncode == 77:
        return 77
    elif "Detected Infinite Loop" in result.stdout:
        return 3
    if mode == "stdout":
        if expected_pass and str(expected_pass) in result.stdout:
            return 1
        if unencrypted_msg and str(unencrypted_msg) in result.stdout:
            return 4
        elif got_p or got_q:
            return 0
        else:
            return 7
    else:
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
        print(f"RETURNCODE: {result.returncode}")
        raise ValueError(f"Unknown pass mode: {mode}")


def pinny_check_passed(result, pass_mode_config, cm_start, cm_end, injection_point):
    mode = pass_mode_config.get("mode", "returncode")
    expected_pass = pass_mode_config.get("expected_pass", None)
    expected_fail = pass_mode_config.get("expected_fail", None)
    if cm_start is not None and cm_end is not None and injection_point is not None and result.returncode == 77:
        parts = injection_point.split(":")
        if parts[0] == "pc":
            pc_value = int(parts[1])
            bit_value = int(parts[2])
            mask = 1 << bit_value
            flipped_pc = pc_value ^ mask
            if flipped_pc in range(cm_start, cm_end + 1):
                return 78
    if "COUNTERMEASURE" in result.stdout or result.returncode == 77:
        return 77
    elif "Detected Infinite Loop" in result.stdout:
        return 3
    if mode == "returncode":
        if result.returncode == expected_pass:
            return 1
        elif "panic" in result.stderr:
            return 2
        elif result.returncode == expected_fail:
            return 0
        else:
            return 0
    elif mode == "stdout":
        if expected_pass and str(expected_pass) in result.stdout:
            return 1
        elif expected_fail and str(expected_fail) in result.stdout:
            return 0
        return 1
    else:
        print(f"STDOUT: {result.stdout}")
        print(f"STDERR: {result.stderr}")
        print(f"RETURNCODE: {result.returncode}")
        raise ValueError(f"Unknown pass mode: {mode}")
