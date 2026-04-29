.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r1, #5
    cmp r1, #10     @ 5 < 10, so GT is False
    mov r0, #0
    ite gt
    movgt r0, #1    @ Should Skip
    movle r0, #2    @ Should Run
    mov r7, #1
    svc #0

.size _start, .-_start
