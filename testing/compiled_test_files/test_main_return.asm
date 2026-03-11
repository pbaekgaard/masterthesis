.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r0, #69
    mov r7, #1
    svc #0

.size _start, .-_start
