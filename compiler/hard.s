.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r9, #0
    mov r10, #1
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
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
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
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
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
    beq else_0
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    mov r0, #7
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    mov r0, #7
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    b endif_0
else_0:
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    mov r0, #8
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    mov r0, #8
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    mov r9, #3
endif_0:
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
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
step_counter:
    .word 0
fault_msg:
    .ascii "Control flow violation detected\n"
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+3
    .word 0xb+5
    .word 0x0 @ [r0]
    .word 0x00000001 @ x
    .word 0x10000000 @ 1
    .word 0xa+6
    .word 0xb+8
    .word 0x0 @ [r0]
    .word 0x00000001 @ x_dup
    .word 0x10000000 @ 2
    .word 0xa+9
    .word 0xb+11
    .word 0x0 @ [r0]
    .word 0x00000001 @ y
    .word 0x10000000 @ 3
    .word 0xa+12
    .word 0xb+14
    .word 0x0 @ [r0]
    .word 0x00000001 @ y_dup
    .word 0x10000000 @ 4
    .word 0xa+15
    .word 0xb+17
    .word 0x0 @ [r0]
    .word 0x00000001 @ z
    .word 0x10000000 @ 5
    .word 0xa+18
    .word 0xb+20
    .word 0x0 @ [r0]
    .word 0x00000001 @ z_dup
    .word 0x10000000 @ 6
    .word 0xa+33
    .word 0xb+53
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd
    .word 0x10000000 @ 7
    .word 0xa+54
    .word 0xb+74
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd_dup
    .word 0x10000000 @ 8
    .word 0xa+98
    .word 0xb+102
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd
    .word 0x10000000 @ 9
    .word 0xa+103
    .word 0xb+107
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd_dup
    .word 0x10000000 @ 10
    .word 0xa+114
    .word 0xb+118
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd
    .word 0x10000000 @ 11
    .word 0xa+119
    .word 0xb+123
    .word 0x0 @ [r0]
    .word 0x00000001 @ vd_dup
