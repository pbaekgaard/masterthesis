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

/*$
  @name = CRT-RSA
  @feature = CRT-RSA
  @fault-model = data (BSet 0/1, symbolic)
  @attack-scenario = oracle
  @countermeasure = none
  @maintainers = Etienne Boespflug, VERIMAG
  @authors = Maxime Puys, SERTIF Consortium
  @version 2.2
*/

#include <stdio.h>
#include "interface.h"
#include "types.h"
#include "lazart.h"

#ifdef INLINE
#include "crt-rsa.c"
#include "oracle.c"
#endif

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
int RsaSign(void);

int main() {
  initialize();
  RsaSign();
  LAZART_ORACLE(oracle());

  printf("countermeasure = %i\nM = %i\nN = %i\ne = %i\np = %i\nq = %i\ndp = %i\ndq = %i\niq = %i\nsign = %i\n", g_countermeasure, g_M, g_N, g_e, g_p, g_q, g_dp, g_dq, g_iq, g_sign);

  return g_sign;
}
