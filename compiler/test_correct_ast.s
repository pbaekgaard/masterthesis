.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
while_0:
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #10
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_0
    mov r0, #11
    str r0, [sp]
    b while_0
end_while_0:
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #10
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq else_1
    mov r0, #12
    str r0, [sp]
    b endif_1
else_1:
    mov r0, #11
    str r0, [sp]
endif_1:
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0

.size _start, .-_start
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ num
    .word 0x10000000 @ 1
    .word 0xa+17
    .word 0xb+18
    .word 0x0 @ [r0]
    .word 0x00000001 @ num
    .word 0x10000000 @ 2
    .word 0xa+33
    .word 0xb+34
    .word 0x0 @ [r0]
    .word 0x00000001 @ num
    .word 0x10000000 @ 3
    .word 0xa+37
    .word 0xb+38
    .word 0x0 @ [r0]
    .word 0x00000001 @ num
