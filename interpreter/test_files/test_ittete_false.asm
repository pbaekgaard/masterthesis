.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r1, #5
    cmp r1, #10     @ GT is False
    mov r0, #0
    ittete gt
    addgt r0, r0, #1      @ T: Skip
    addgt r0, r0, #10     @ T: Skip
    addle r0, r0, #100    @ E: Run (+100)
    addgt r0, r0, #1000   @ T: Skip
    addle r0, r0, #10000  @ E: Run (+10000)
    mov r7, #1
    svc #0

.size _start, .-_start
