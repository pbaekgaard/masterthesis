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
    addgt r0, r0, #1      @ T: Run (+1)
    addgt r0, r0, #10     @ T: Run (+10)
    addle r0, r0, #100    @ E: Skip
    addgt r0, r0, #200   @ T: Run (+1000)
    addle r0, r0, #3  @ E: Skip
    mov r7, #1
    svc #0

.size _start, .-_start
