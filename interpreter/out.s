.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    mov r0, #12345
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #10000
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #6789
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #5381
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #33
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    mov r0, #104
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1000
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #729
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    sub sp, sp, #4
    ldr r0, [sp, #16]
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_0
    mov r0, #7
    str r0, [sp, #4]
    b endif_0
else_0:
endif_0:
while_1:
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_1
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #100
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #100
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #16]
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #16]
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #100
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #4]
    b while_1
end_while_1:
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq else_2
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #16]
    b endif_2
else_2:
endif_2:
    ldr r0, [sp, #16]
    mov r4, r0
    ldr r1, =num_buf
    add r1, r1, #16
    mov r2, #0
    cmp r4, #0
    bne print_int_loop_3
    mov r3, #48
    sub r1, r1, #1
    strb r3, [r1]
    mov r2, #1
    b print_int_done_3
print_int_loop_3:
    mov r0, r4
    mov r3, #10
    sdiv r5, r0, r3
    mul r6, r5, r3
    sub r7, r0, r6
    add r7, r7, #48
    sub r1, r1, #1
    strb r7, [r1]
    add r2, r2, #1
    mov r4, r5
    cmp r4, #0
    bne print_int_loop_3
print_int_done_3:
    mov r0, #1
    mov r1, r1
    mov r2, r2
    mov r7, #4
    svc #0
    mov r0, #1
    ldr r1, =newline
    mov r2, #1
    mov r7, #4
    svc #0
    ldr r0, [sp, #16]
    mov r7, #1
    svc #0

.size _start, .-_start

.section .data
newline:
    .ascii "\n"
num_buf:
    .space 16
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ message
    .word 0x10000000 @ 1
    .word 0xa+4
    .word 0xb+17
    .word 0x0 @ [r0]
    .word 0x00000001 @ message
    .word 0x10000000 @ 2
    .word 0xa+18
    .word 0xb+20
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 3
    .word 0xa+21
    .word 0xb+23
    .word 0x0 @ [r0]
    .word 0x00000001 @ multiplier
    .word 0x10000000 @ 4
    .word 0xa+24
    .word 0xb+26
    .word 0x0 @ [r0]
    .word 0x00000001 @ prime_modulo
    .word 0x10000000 @ 5
    .word 0xa+27
    .word 0xb+40
    .word 0x0 @ [r0]
    .word 0x00000001 @ prime_modulo
    .word 0x10000000 @ 6
    .word 0xa+41
    .word 0xb+43
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x10000000 @ 7
    .word 0xa+44
    .word 0xb+46
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunk
    .word 0x10000000 @ 8
    .word 0xa+59
    .word 0xb+60
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x10000000 @ 9
    .word 0xa+77
    .word 0xb+96
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunk
    .word 0x10000000 @ 10
    .word 0xa+97
    .word 0xb+110
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 11
    .word 0xa+111
    .word 0xb+130
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 12
    .word 0xa+131
    .word 0xb+138
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x10000000 @ 13
    .word 0xa+153
    .word 0xb+160
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
