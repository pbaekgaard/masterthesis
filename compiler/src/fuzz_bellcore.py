#!/usr/bin/env python3
"""Bellcore attack fuzzer - tests fault injection with random keys and messages."""

import subprocess
import math
import random
import os
import sys
import tempfile

COMPILER = "/home/pbk/school/P10-Master/compiler/target/release/trivic"
RUNNER = "/home/pbk/school/P10-Master/compiler/bin/run_asm"
OUT_DIR = "/tmp/bellcore_fuzz"

os.makedirs(OUT_DIR, exist_ok=True)

def is_prime(n):
    if n < 2: return False
    if n < 4: return True
    if n % 2 == 0 or n % 3 == 0: return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0: return False
        i += 6
    return True

def mod_pow(base, exp, mod):
    result = 1
    base = base % mod
    while exp > 0:
        if exp % 2 == 1:
            result = (result * base) % mod
        exp //= 2
        base = (base * base) % mod
    return result

def mod_inverse(a, m):
    g, x, _ = extended_gcd(a, m)
    if g != 1:
        raise ValueError("No modular inverse")
    return x % m

def extended_gcd(a, b):
    if a == 0:
        return b, 0, 1
    g, x, y = extended_gcd(b % a, a)
    return g, y - (b // a) * x, x

def gen_small_prime(min_val=30, max_val=200):
    while True:
        p = random.randint(min_val, max_val)
        if is_prime(p):
            return p

def gen_keypair():
    p = gen_small_prime()
    q = gen_small_prime()
    while q == p:
        q = gen_small_prime()
    n = p * q
    phi = (p - 1) * (q - 1)
    e = 17
    while math.gcd(e, phi) != 1:
        e = random.randint(3, phi - 1)
    d = mod_inverse(e, phi)
    return p, q, n, e, d

def make_trv(p, q, n, e, m, out_path):
    src = f"""# CRT-RSA Encryption (fuzzed)
# Message: {m}
# Public key: (e={e}, n={n})
# p = {p}, q = {q}

func main() -> Integer {{
    let p : Integer = {p};
    let q : Integer = {q};
    let n : Integer = {n};
    let e : Integer = {e};
    let m : Integer = {m};

    let p_minus_1 : Integer = 0;
    let q_minus_1 : Integer = 0;
    let ep : Integer = 0;
    let eq : Integer = 0;

    p_minus_1 = p - 1;
    q_minus_1 = q - 1;

    ep = e - (e / p_minus_1) * p_minus_1;
    eq = e - (e / q_minus_1) * q_minus_1;

    let c1 : Integer = 0;
    let base1 : Integer = 0;
    let exp1 : Integer = 0;
    c1 = 1;
    base1 = m - (m / p) * p;
    exp1 = ep;
    while exp1 > 0 do {{
        if exp1 - (exp1 / 2) * 2 == 1 then {{
            c1 = (c1 * base1) - ((c1 * base1) / p) * p;
        }}
        exp1 = exp1 / 2;
        base1 = (base1 * base1) - ((base1 * base1) / p) * p;
    }}

    # SEU: bit-flip in c1 (Bellcore-style fault)
    let fault_triggered : Integer = 0;
    if fault_triggered == 0 then {{
        c1 = c1 + 1;
        fault_triggered = 1;
    }}

    let c2 : Integer = 0;
    let base2 : Integer = 0;
    let exp2 : Integer = 0;
    c2 = 1;
    base2 = m - (m / q) * q;
    exp2 = eq;
    while exp2 > 0 do {{
        if exp2 - (exp2 / 2) * 2 == 1 then {{
            c2 = (c2 * base2) - ((c2 * base2) / q) * q;
        }}
        exp2 = exp2 / 2;
        base2 = (base2 * base2) - ((base2 * base2) / q) * q;
    }}

    let qinv : Integer = 0;
    let t : Integer = 0;
    let newt : Integer = 0;
    let r : Integer = 0;
    let newr : Integer = 0;
    let quotient : Integer = 0;
    let tmp : Integer = 0;

    t = 0;
    newt = 1;
    r = p;
    newr = q;
    while newr != 0 do {{
        quotient = r / newr;
        tmp = t - quotient * newt;
        t = newt;
        newt = tmp;
        tmp = r - quotient * newr;
        r = newr;
        newr = tmp;
    }}
    if t < 0 then {{
        qinv = t + p;
    }} else {{
        qinv = t;
    }}

    let h : Integer = 0;
    let diff : Integer = 0;
    diff = c1 - c2;
    h = qinv * diff - (qinv * diff / p) * p;
    if h < 0 then {{
        h = h + p;
    }}

    let c : Integer = 0;
    c = c2 + h * q;

    print c;

    return c;
}}
"""
    with open(out_path, 'w') as f:
        f.write(src)

def run_attack(p, q, n, e, m, iteration):
    trv_path = os.path.join(OUT_DIR, f"test_{iteration}.trv")
    base_path = os.path.join(OUT_DIR, f"test_{iteration}")
    s_path = base_path + ".s"

    make_trv(p, q, n, e, m, trv_path)

    # Compile (compiler appends .s automatically)
    result = subprocess.run(
        [COMPILER, trv_path, "-o", base_path],
        capture_output=True, text=True, timeout=10
    )
    if result.returncode != 0:
        print(f"  [!] Compile failed: {result.stderr.strip()}")
        return False

    # Run (run_asm expects relative paths, so we cd to OUT_DIR)
    result = subprocess.run(
        [RUNNER, f"test_{iteration}.s"],
        capture_output=True, text=True, timeout=10,
        cwd=OUT_DIR
    )

    output = result.stdout.strip()
    lines = [l.strip() for l in output.splitlines() if l.strip()]
    faulty_c = None
    for line in reversed(lines):
        try:
            faulty_c = int(line)
            break
        except ValueError:
            continue

    if faulty_c is None:
        print(f"  [!] Could not parse output")
        return False

    correct_c = mod_pow(m, e, n)

    if faulty_c == correct_c:
        print(f"  [!] No fault triggered (c' == c)")
        return False

    diff = abs(faulty_c - correct_c)
    recovered = math.gcd(diff, n)

    if recovered == q:
        print(f"  [+] Recovered q={recovered} (p={p})")
        return True
    elif recovered == p:
        print(f"  [+] Recovered p={recovered} (q={q})")
        return True
    else:
        print(f"  [!] gcd={recovered}, expected p={p} or q={q}")
        return False

def main():
    print("=" * 60)
    print("Bellcore Attack Fuzzer")
    print("=" * 60)

    tests = [
        # (p, q, n, e, m, label)
        (61, 53, 3233, 17, 65, "original"),
        (71, 89, 6319, 17, 42, "small primes"),
        (97, 101, 9797, 17, 123, "medium primes"),
        (113, 127, 14351, 17, 999, "larger primes"),
        (131, 137, 17947, 17, 5000, "even larger"),
        (151, 157, 23707, 17, 12345, "big message"),
    ]

    # Add random tests
    for i in range(5):
        p, q, n, e, d = gen_keypair()
        m = random.randint(2, n - 1)
        tests.append((p, q, n, e, m, f"random #{i+1}"))

    passed = 0
    total = len(tests)

    for i, (p, q, n, e, m, label) in enumerate(tests):
        correct_c = mod_pow(m, e, n)
        print(f"\n[{i+1}/{total}] {label}: p={p}, q={q}, n={n}, e={e}, m={m}")
        print(f"       correct ciphertext = {correct_c}")

        if run_attack(p, q, n, e, m, i):
            passed += 1

    print(f"\n{'=' * 60}")
    print(f"Results: {passed}/{total} attacks succeeded")
    if passed == total:
        print("ALL TESTS PASSED - fault injection consistently leaks key!")
    else:
        print(f"{total - passed} test(s) failed")
    print(f"{'=' * 60}")

if __name__ == "__main__":
    main()
