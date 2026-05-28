#!/usr/bin/env python3
"""Bellcore attack verifier for CRT-RSA with SEU fault injection."""

import subprocess
import math
import sys

BIN = "../bin/run_asm"
ASM = "out.s"

# Known parameters from the source
M = 65
E = 17
N = 3233
P = 61
Q = 53

def mod_pow(base, exp, mod):
    result = 1
    base = base % mod
    while exp > 0:
        if exp % 2 == 1:
            result = (result * base) % mod
        exp //= 2
        base = (base * base) % mod
    return result

def main():
    print(f"[*] Running {BIN} on {ASM}...")
    result = subprocess.run(
        [BIN, ASM],
        capture_output=True, text=True, timeout=10
    )

    output = result.stdout.strip()
    print(f"[*] stdout:\n{output}")

    # Extract the printed ciphertext (last numeric line before "Finished")
    lines = [l.strip() for l in output.splitlines() if l.strip()]
    faulty_c = None
    for line in reversed(lines):
        try:
            faulty_c = int(line)
            break
        except ValueError:
            continue

    if faulty_c is None:
        print("[!] Could not parse ciphertext from output")
        sys.exit(1)

    print(f"[*] Faulty ciphertext c' = {faulty_c}")

    # Compute correct ciphertext
    correct_c = mod_pow(M, E, N)
    print(f"[*] Correct ciphertext  c  = {correct_c}")

    if faulty_c == correct_c:
        print("[!] No fault detected — ciphertext is correct, attack not applicable")
        sys.exit(1)

    # Bellcore attack: gcd(c' - c, n) should reveal q
    diff = abs(faulty_c - correct_c)
    recovered = math.gcd(diff, N)

    print(f"[*] |c' - c| = {diff}")
    print(f"[*] gcd(|c' - c|, n) = {recovered}")

    if recovered == Q:
        print(f"[+] SUCCESS: Recovered q = {recovered}")
        print(f"[+] p = n / q = {N // recovered}")
    elif recovered == P:
        print(f"[+] SUCCESS: Recovered p = {recovered}")
        print(f"[+] q = n / p = {N // recovered}")
    elif recovered == N:
        print(f"[!] gcd is n itself — fault may not have been in one CRT half")
        sys.exit(1)
    else:
        print(f"[!] gcd = {recovered} is not p or q — attack failed")
        sys.exit(1)

if __name__ == "__main__":
    main()
