.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r9, #0
    mov r10, #1
    sub sp, sp, #4
    mov r0, #9
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    mov r10, #3
while_0:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #12
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_0
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    b while_0
end_while_0:
mov r9, #2
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
countermeasure:
    mov r0, #77
    mov r7, #1
    svc #0

.size _start, .-_start
