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
while_0:
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #10
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_0
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    ldr r0, [sp, #8]
    mov r1, r0
    ldr r0, [sp, #0]
    add r0, r1, r0
    str r0, [sp, #8]
    add sp, sp, #4
    b while_0
end_while_0:
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #10
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq else_1
    mov r0, #12
    str r0, [sp, #4]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add sp, sp, #4
    b endif_1
else_1:
    mov r0, #11
    str r0, [sp, #4]
endif_1:
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_2
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0
    b endif_2
else_2:
    ldr r0, [sp, #4]
    mov r7, #1
    svc #0
endif_2:
    add sp, sp, #8

.size _start, .-_start
