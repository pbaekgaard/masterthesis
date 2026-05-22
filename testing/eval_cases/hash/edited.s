.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    mov r0, #12345
    str r0, [sp, #4]
    mov r0, #12345
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #5381
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #5381
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #33
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #33
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
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
    str r0, [sp, #4]
    ldr r0, [sp, #28]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_0
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_0
else_0:
endif_0:
    sub sp, sp, #4
    ldr r0, [sp, #32]
    str r0, [sp]
    sub sp, sp, #4
    ldr r0, [sp, #32]
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #12]
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
    beq else_1
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_2
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_2
else_2:
endif_2:
    mov r0, #7
    str r0, [sp, #12]
    mov r0, #7
    str r0, [sp, #8]
    b endif_1
else_1:
endif_1:
while_3:
    ldr r0, [sp, #12]
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
    beq end_while_3
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_4
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
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
    str r0, [sp, #4]
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
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
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_5
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_5
else_5:
endif_5:
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #32]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #36]
    ldr r0, [sp, #32]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #32]
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_6
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_6
else_6:
endif_6:
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #40]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #36]
    ldr r0, [sp, #32]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #32]
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_7
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_7
else_7:
endif_7:
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #100
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #12]
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #100
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #8]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_8
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_8
else_8:
endif_8:
    b while_3
end_while_3:
    ldr r0, [sp, #36]
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
    beq else_9
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_10
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_10
else_10:
endif_10:
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #36]
    ldr r0, [sp, #32]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #32]
    b endif_9
else_9:
endif_9:
    ldr r0, [sp, #36]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_11
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_11
else_11:
endif_11:
    ldr r0, [sp, #36]
    mov r4, r0
    ldr r1, =num_buf
    add r1, r1, #16
    mov r2, #0
    cmp r4, #0
    bne print_int_loop_12
    mov r3, #48
    sub r1, r1, #1
    strb r3, [r1]
    mov r2, #1
    b print_int_done_12
print_int_loop_12:
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
    bne print_int_loop_12
print_int_done_12:
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
    ldr r0, [sp, #36]
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
    .word 0xb+6
    .word 0x0 @ [r0]
    .word 0x00000001 @ messageDup
    .word 0x10000000 @ 2
    .word 0xa+7
    .word 0xb+8
    .word 0x0 @ [r0]
    .word 0x00000001 @ message
    .word 0x10000000 @ 3
    .word 0xa+9
    .word 0xb+10
    .word 0x0 @ [r0]
    .word 0x00000001 @ messageDup
    .word 0x10000000 @ 4
    .word 0xa+11
    .word 0xb+13
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 5
    .word 0xa+14
    .word 0xb+16
    .word 0x0 @ [r0]
    .word 0x00000001 @ hDup
    .word 0x10000000 @ 6
    .word 0xa+17
    .word 0xb+19
    .word 0x0 @ [r0]
    .word 0x00000001 @ multiplier
    .word 0x10000000 @ 7
    .word 0xa+20
    .word 0xb+22
    .word 0x0 @ [r0]
    .word 0x00000001 @ multiplierDup
    .word 0x10000000 @ 8
    .word 0xa+23
    .word 0xb+25
    .word 0x0 @ [r0]
    .word 0x00000001 @ prime_modulo
    .word 0x10000000 @ 9
    .word 0xa+26
    .word 0xb+28
    .word 0x0 @ [r0]
    .word 0x00000001 @ prime_moduloDup
    .word 0x10000000 @ 10
    .word 0xa+29
    .word 0xb+42
    .word 0x0 @ [r0]
    .word 0x00000001 @ prime_modulo
    .word 0x10000000 @ 11
    .word 0xa+61
    .word 0xb+63
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x10000000 @ 12
    .word 0xa+64
    .word 0xb+66
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msgDup
    .word 0x10000000 @ 13
    .word 0xa+67
    .word 0xb+69
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunk
    .word 0x10000000 @ 14
    .word 0xa+70
    .word 0xb+72
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunkDup
    .word 0x10000000 @ 15
    .word 0xa+103
    .word 0xb+104
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x10000000 @ 16
    .word 0xa+105
    .word 0xb+106
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msgDup
    .word 0x10000000 @ 17
    .word 0xa+141
    .word 0xb+160
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunk
    .word 0x10000000 @ 18
    .word 0xa+161
    .word 0xb+180
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunkDup
    .word 0x10000000 @ 19
    .word 0xa+199
    .word 0xb+212
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 20
    .word 0xa+213
    .word 0xb+226
    .word 0x0 @ [r0]
    .word 0x00000001 @ hDup
    .word 0x10000000 @ 21
    .word 0xa+245
    .word 0xb+264
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 22
    .word 0xa+265
    .word 0xb+284
    .word 0x0 @ [r0]
    .word 0x00000001 @ hDup
    .word 0x10000000 @ 23
    .word 0xa+303
    .word 0xb+310
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x10000000 @ 24
    .word 0xa+311
    .word 0xb+318
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msgDup
    .word 0x10000000 @ 25
    .word 0xa+369
    .word 0xb+376
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 26
    .word 0xa+377
    .word 0xb+384
    .word 0x0 @ [r0]
    .word 0x00000001 @ hDup
