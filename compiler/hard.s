.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_0
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_0
else_0:
endif_0:
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_1
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_1
else_1:
endif_1:
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_2
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_2
else_2:
endif_2:
    sub sp, sp, #4
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    sub sp, sp, #4
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #6
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_3
    mov r0, #7
    str r0, [sp, #4]
    b endif_3
else_3:
    mov r0, #8
    str r0, [sp, #4]
endif_3:
    ldr r0, [sp, #4]
    mov r7, #1
    svc #0
countermeasure:
    mov r0, #1
    ldr r1, =.Lstr0
    mov r2, #14
    mov r7, #4
    svc #0
    mov r0, #77
    mov r7, #1
    svc #0

.size _start, .-_start

.section .data
.Lstr0:
    .ascii "COUNTERMEASURE"
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ x
    .word 0x10000000 @ 1
    .word 0xa+4
    .word 0xb+6
    .word 0x0 @ [r0]
    .word 0x00000001 @ x_dup
    .word 0x10000000 @ 2
    .word 0xa+7
    .word 0xb+9
    .word 0x0 @ [r0]
    .word 0x00000001 @ y
    .word 0x10000000 @ 3
    .word 0xa+10
    .word 0xb+12
    .word 0x0 @ [r0]
    .word 0x00000001 @ y_dup
    .word 0x10000000 @ 4
    .word 0xa+13
    .word 0xb+15
    .word 0x0 @ [r0]
    .word 0x00000001 @ z
    .word 0x10000000 @ 5
    .word 0xa+16
    .word 0xb+18
    .word 0x0 @ [r0]
    .word 0x00000001 @ z_dup
    .word 0x10000000 @ 6
    .word 0xa+73
    .word 0xb+93
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd
    .word 0x10000000 @ 7
    .word 0xa+94
    .word 0xb+114
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd_dup
    .word 0x10000000 @ 8
    .word 0xa+127
    .word 0xb+128
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd
    .word 0x10000000 @ 9
    .word 0xa+131
    .word 0xb+132
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd
