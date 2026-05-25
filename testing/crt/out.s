.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #61
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #53
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3233
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2753
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2790
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #32]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    ldr r0, [sp, #28]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    mov r0, #1
    str r0, [sp, #8]
    ldr r0, [sp, #28]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #32]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #52]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #52]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #16]
    str r0, [sp]
while_0:
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_0
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_1
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #52]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #52]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    b endif_1
else_1:
endif_1:
    mov r9, #0
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #52]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #52]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    b while_0
end_while_0:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_2
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #12]
    mov r0, #1
    str r0, [sp]
    b endif_2
else_2:
endif_2:
    mov r9, #0
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    mov r0, #1
    str r0, [sp, #8]
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #48]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #28]
    str r0, [sp]
while_3:
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_3
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    b endif_4
else_4:
endif_4:
    mov r9, #0
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    b while_3
end_while_3:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    mov r0, #0
    str r0, [sp, #20]
    mov r0, #1
    str r0, [sp, #16]
    ldr r0, [sp, #88]
    str r0, [sp, #12]
    ldr r0, [sp, #84]
    str r0, [sp, #8]
while_5:
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq end_while_5
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #16]
    str r0, [sp, #20]
    ldr r0, [sp, #0]
    str r0, [sp, #16]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #8]
    str r0, [sp, #12]
    ldr r0, [sp, #0]
    str r0, [sp, #8]
    b while_5
end_while_5:
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq else_6
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #92]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #24]
    b endif_6
else_6:
    ldr r0, [sp, #20]
    str r0, [sp, #24]
endif_6:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #60]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #48]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #32]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #104]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #104]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq else_7
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #4]
    b endif_7
else_7:
endif_7:
    mov r9, #0
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #48]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #104]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0

.size _start, .-_start
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ p
    .word 0x10000000 @ 1
    .word 0xa+4
    .word 0xb+6
    .word 0x0 @ [r0]
    .word 0x00000001 @ q
    .word 0x10000000 @ 2
    .word 0xa+7
    .word 0xb+9
    .word 0x0 @ [r0]
    .word 0x00000001 @ n
    .word 0x10000000 @ 3
    .word 0xa+10
    .word 0xb+12
    .word 0x0 @ [r0]
    .word 0x00000001 @ d
    .word 0x10000000 @ 4
    .word 0xa+13
    .word 0xb+15
    .word 0x0 @ [r0]
    .word 0x00000001 @ c
    .word 0x10000000 @ 5
    .word 0xa+16
    .word 0xb+18
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1
    .word 0x10000000 @ 6
    .word 0xa+19
    .word 0xb+21
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1
    .word 0x10000000 @ 7
    .word 0xa+22
    .word 0xb+24
    .word 0x0 @ [r0]
    .word 0x00000001 @ dp
    .word 0x10000000 @ 8
    .word 0xa+25
    .word 0xb+27
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq
    .word 0x10000000 @ 9
    .word 0xa+28
    .word 0xb+35
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1
    .word 0x10000000 @ 10
    .word 0xa+36
    .word 0xb+43
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1
    .word 0x10000000 @ 11
    .word 0xa+44
    .word 0xb+63
    .word 0x0 @ [r0]
    .word 0x00000001 @ dp
    .word 0x10000000 @ 12
    .word 0xa+64
    .word 0xb+83
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq
    .word 0x10000000 @ 13
    .word 0xa+84
    .word 0xb+86
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x10000000 @ 14
    .word 0xa+87
    .word 0xb+89
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x10000000 @ 15
    .word 0xa+90
    .word 0xb+92
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x10000000 @ 16
    .word 0xa+93
    .word 0xb+94
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x10000000 @ 17
    .word 0xa+95
    .word 0xb+114
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x10000000 @ 18
    .word 0xa+115
    .word 0xb+116
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x10000000 @ 19
    .word 0xa+160
    .word 0xb+191
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x10000000 @ 20
    .word 0xa+196
    .word 0xb+203
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x10000000 @ 21
    .word 0xa+204
    .word 0xb+235
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x10000000 @ 22
    .word 0xa+238
    .word 0xb+240
    .word 0x0 @ [r0]
    .word 0x00000001 @ fault_triggered
    .word 0x10000000 @ 23
    .word 0xa+253
    .word 0xb+260
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x10000000 @ 24
    .word 0xa+261
    .word 0xb+262
    .word 0x0 @ [r0]
    .word 0x00000001 @ fault_triggered
    .word 0x10000000 @ 25
    .word 0xa+267
    .word 0xb+269
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x10000000 @ 26
    .word 0xa+270
    .word 0xb+272
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 27
    .word 0xa+273
    .word 0xb+275
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 28
    .word 0xa+276
    .word 0xb+277
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x10000000 @ 29
    .word 0xa+278
    .word 0xb+297
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 30
    .word 0xa+298
    .word 0xb+299
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 31
    .word 0xa+343
    .word 0xb+374
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x10000000 @ 32
    .word 0xa+379
    .word 0xb+386
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 33
    .word 0xa+387
    .word 0xb+418
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 34
    .word 0xa+421
    .word 0xb+423
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 35
    .word 0xa+424
    .word 0xb+426
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 36
    .word 0xa+427
    .word 0xb+429
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 37
    .word 0xa+430
    .word 0xb+432
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 38
    .word 0xa+433
    .word 0xb+435
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 39
    .word 0xa+436
    .word 0xb+438
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x10000000 @ 40
    .word 0xa+439
    .word 0xb+441
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 41
    .word 0xa+442
    .word 0xb+443
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 42
    .word 0xa+444
    .word 0xb+445
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 43
    .word 0xa+446
    .word 0xb+447
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 44
    .word 0xa+448
    .word 0xb+449
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 45
    .word 0xa+463
    .word 0xb+470
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x10000000 @ 46
    .word 0xa+471
    .word 0xb+484
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 47
    .word 0xa+485
    .word 0xb+486
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 48
    .word 0xa+487
    .word 0xb+488
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 49
    .word 0xa+489
    .word 0xb+502
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 50
    .word 0xa+503
    .word 0xb+504
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 51
    .word 0xa+505
    .word 0xb+506
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 52
    .word 0xa+521
    .word 0xb+528
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 53
    .word 0xa+531
    .word 0xb+532
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 54
    .word 0xa+534
    .word 0xb+536
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 55
    .word 0xa+537
    .word 0xb+539
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x10000000 @ 56
    .word 0xa+540
    .word 0xb+547
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x10000000 @ 57
    .word 0xa+548
    .word 0xb+579
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 58
    .word 0xa+592
    .word 0xb+599
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 59
    .word 0xa+604
    .word 0xb+606
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
    .word 0x10000000 @ 60
    .word 0xa+607
    .word 0xb+620
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
