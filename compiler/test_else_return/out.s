.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_0
    mov r0, #44
    str r0, [sp]
    b endif_0
else_0:
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_1
    mov r0, #33
    str r0, [sp]
    b endif_1
else_1:
endif_1:
endif_0:
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0

.size _start, .-_start
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ value
    .word 0x10000000 @ 1
    .word 0xa+13
    .word 0xb+14
    .word 0x0 @ [r0]
    .word 0x00000001 @ value
    .word 0x10000000 @ 2
    .word 0xa+26
    .word 0xb+27
    .word 0x0 @ [r0]
    .word 0x00000001 @ value
