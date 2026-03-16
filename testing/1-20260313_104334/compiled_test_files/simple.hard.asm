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
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
while_0:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
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
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #8]
    mov r1, r0
    ldr r0, [sp, #0]
    add r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    add sp, sp, #4
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
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
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    mov r0, #12
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    add sp, sp, #4
    b endif_1
else_1:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    mov r0, #11
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
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
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0
    b endif_2
else_2:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #4]
    mov r7, #1
    svc #0
endif_2:
    add sp, sp, #8
countermeasure:
    mov r0, #77
    mov r7, #1
    svc #0

.size _start, .-_start
