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
    cmp r9, #1
    bne countermeasure
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_0
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    mov r0, #44
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
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
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    mov r0, #33
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    b endif_1
else_1:
endif_1:
    mov r9, #3
endif_0:
    ldr r0, [sp, #0]
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
    .word 0xb+8
    .word 0x0 @ [r0]
    .word 0x00000001 @ value
    .word 0x10000000 @ 1
    .word 0xa+21
    .word 0xb+25
    .word 0x0 @ [r0]
    .word 0x00000001 @ value
    .word 0x10000000 @ 2
    .word 0xa+40
    .word 0xb+44
    .word 0x0 @ [r0]
    .word 0x00000001 @ value
