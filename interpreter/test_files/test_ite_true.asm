.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r1, #10
    cmp r1, #5      @ 10 > 5, so GT is True
    mov r0, #0
    ite gt
    movgt r0, #1    @ Should Run
    movle r0, #2    @ Should Skip
    mov r7, #1
    svc #0

.size _start, .-_start
