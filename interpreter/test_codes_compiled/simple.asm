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
    mov r1, r0
    mov r0, #10
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
    mov r1, r0
    mov r0, #10
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq else_1
    mov r0, #11
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
