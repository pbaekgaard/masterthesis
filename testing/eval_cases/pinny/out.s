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
    mov r0, #1
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #4
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
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_0
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    b endif_0
else_0:
endif_0:
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #32]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_1
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    b endif_1
else_1:
endif_1:
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_2
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    b endif_2
else_2:
endif_2:
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_3
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    b endif_3
else_3:
endif_3:
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #4
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    mov r0, #1
    str r0, [sp, #36]
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #36]
    mov r7, #1
    svc #0

.size _start, .-_start
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
    .word 0x10000000 @ 1
    .word 0xa+4
    .word 0xb+6
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin1
    .word 0x10000000 @ 2
    .word 0xa+7
    .word 0xb+9
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin2
    .word 0x10000000 @ 3
    .word 0xa+10
    .word 0xb+12
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin3
    .word 0x10000000 @ 4
    .word 0xa+13
    .word 0xb+15
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin4
    .word 0x10000000 @ 5
    .word 0xa+16
    .word 0xb+18
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin1
    .word 0x10000000 @ 6
    .word 0xa+19
    .word 0xb+21
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin2
    .word 0x10000000 @ 7
    .word 0xa+22
    .word 0xb+24
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin3
    .word 0x10000000 @ 8
    .word 0xa+25
    .word 0xb+27
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin4
    .word 0x10000000 @ 9
    .word 0xa+28
    .word 0xb+30
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 10
    .word 0xa+43
    .word 0xb+50
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 11
    .word 0xa+66
    .word 0xb+73
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 12
    .word 0xa+89
    .word 0xb+96
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 13
    .word 0xa+112
    .word 0xb+119
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 14
    .word 0xa+135
    .word 0xb+136
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
