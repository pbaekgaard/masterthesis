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

#include "interface.h"
#include "types.h"

extern UBYTE g_countermeasure;
extern int g_M;
extern int g_N;
extern int g_e;
extern int g_p;
extern int g_q;
extern int g_dp;
extern int g_dq;
extern int g_iq;
extern int g_sign;

int Add(int, int);
int Sub(int, int);
int Mul(int, int);
int Mod(int, int);
int MulMod(int, int, int);
int PowerMod(int, int, int);

int RsaSign2()
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

BOOL oracle()
 {
  int sign = g_sign;
  int S = RsaSign2();
  return
    g_countermeasure != 1
    && S != sign
    && (Mod(S,g_p) == Mod(sign, g_p) || Mod(S,g_q) == Mod(sign,g_q));
}
