/**************************************************************************/
/*                                                                        */
/*  This file is part of FISSC.                                           */
/*                                                                        */
/*  you can redistribute it and/or modify it under the terms of the GNU   */
/*  Lesser General Public License as published by the Free Software       */
/*  Foundation, version 3.0.                                              */
/*                                                                        */
/*  It is distributed in the hope that it will be useful,                 */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         */
/*  GNU Lesser General Public License for more details.                   */
/*                                                                        */
/*  See the GNU Lesser General Public License version 3.0                 */
/*  for more details (enclosed in the file LICENSE).                      */
/*                                                                        */
/**************************************************************************/


extern int g_M;
extern int g_N;
extern int g_e;
extern int g_p;
extern int g_q;
extern int g_dp;
extern int g_dq;
extern int g_iq;
extern int g_sign;


/* Returns: a + b. */
int Add(int a, int b) { return a+b; }

/* Returns: a - b. */
int Sub(int a, int b) {return a-b; }

/* Returns: a * b. */
int Mul(int a, int b) { return a*b; }


/* Returns: a mod n. */
#ifdef INLINE
__attribute__((always_inline)) inline int Mod(int a, int n) 
#else
int Mod(int a, int n)
#endif
{
  int r = a%n;
  while (r < 0) { r = Add(r, n); }
  return r;
}


/* Returns: (a * b) mod n. */
#ifdef INLINE
__attribute__((always_inline)) inline int MulMod(int a, int b, int n) 
#else
int MulMod(int a, int b, int n)
#endif
{
  int r = 0;
  while (b--) {
    r = Add(r, a);
    r = Mod(r, n);
  }
  return r;
}

/* Right-to-left algorithm, returns: (a ^ b) mod n. */
#ifdef INLINE
__attribute__((always_inline)) inline int PowerMod(int a, int b, int n) 
#else
int PowerMod(int a, int b, int n)
#endif
{
  int r = 1;
  a = Mod(a, n);
  while (b > 0) {
    if (b % 2 == 1) {
      r = MulMod(r, a, n);
    }                   
    if (b >>= 1) {
      a = MulMod(a, a, n);
    }
  }
  return r;
}


#ifdef INLINE
__attribute__((always_inline)) inline int RsaSign() 
#else
int RsaSign()
#endif
{
  int Cp, Cq, tmp;
  Cp = PowerMod(g_M, g_dp, g_p);
  Cq = PowerMod(g_M, g_dq, g_q);
  tmp = Sub(Cp, Cq);
  tmp = MulMod(tmp, g_iq, g_p);
  tmp = Mul(tmp, g_q);
  tmp = Add(tmp, Cq);
  g_sign = tmp;
  return g_sign;
}
