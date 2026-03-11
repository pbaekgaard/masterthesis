.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #27
    str r0, [sp]
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0

.size _start, .-_start
