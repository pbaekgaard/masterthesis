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

#include "types.h"
#include "interface.h"


UBYTE g_countermeasure;
int g_M;
int g_N;
int g_e;
int g_p;
int g_q;
int g_dp;
int g_dq;
int g_iq;
int g_sign;

void initialize() {
  g_countermeasure = 0;
  g_N = 11413;
  g_e = 3533;
  g_p = 101;
  g_q = 113;
  g_iq = 59;  /* iq = (1/q) mod p */
  g_dp = 97;  /* dp = d mod (p-1) */
  g_dq = 101; /* dq = d mod (q-1) */
  g_sign = -1;
  g_M = 23;
}
