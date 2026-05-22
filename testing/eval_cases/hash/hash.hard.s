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
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    mov r0, #12345
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    sub sp, sp, #4
    mov r0, #5381
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #5381
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    sub sp, sp, #4
    mov r0, #33
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #33
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
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
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    sub sp, sp, #4
    ldr r0, [sp, #32]
    ldr r2, [sp, #28]
    cmp r0, r2
    bne countermeasure
    str r0, [sp]
    sub sp, sp, #4
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #7
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #8
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
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
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    mov r0, #7
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #10
    bne countermeasure
    b endif_0
else_0:
endif_0:
    mov r10, #11
while_1:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
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
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r2, [sp, #12]
    cmp r0, r2
    bne countermeasure
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
    str r0, [sp]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #32]
    ldr r2, [sp, #28]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r2, [sp, #4]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #36]
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #40]
    ldr r2, [sp, #36]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r2, [sp, #24]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r2, [sp, #24]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #36]
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #100
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    b while_1
end_while_1:
    mov r9, #10
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
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
    add r9, r9, #1
    cmp r9, #11
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r2, [sp, #20]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #36]
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, #12
    bne countermeasure
    b endif_2
else_2:
endif_2:
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
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
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
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
newline:
    .ascii "\n"
num_buf:
    .space 16
step_counter:
    .word 0
fault_msg:
    .ascii "Control flow violation detected\n"
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+3
    .word 0xb+11
    .word 0x0 @ [r0]
    .word 0x00000001 @ message
    .word 0x00000002 @ message_dup
    .word 0x10000000 @ 1
    .word 0xa+12
    .word 0xb+17
    .word 0x0 @ [r0]
    .word 0x00000001 @ message
    .word 0x00000001 @ message_dup
    .word 0x10000000 @ 2
    .word 0xa+18
    .word 0xb+26
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000002 @ h_dup
    .word 0x10000000 @ 3
    .word 0xa+27
    .word 0xb+35
    .word 0x0 @ [r0]
    .word 0x00000001 @ multiplier
    .word 0x00000002 @ multiplier_dup
    .word 0x10000000 @ 4
    .word 0xa+36
    .word 0xb+44
    .word 0x0 @ [r0]
    .word 0x00000001 @ prime_modulo
    .word 0x00000002 @ prime_modulo_dup
    .word 0x10000000 @ 5
    .word 0xa+45
    .word 0xb+62
    .word 0x0 @ [r0]
    .word 0x00000001 @ prime_modulo
    .word 0x00000001 @ prime_modulo_dup
    .word 0x10000000 @ 6
    .word 0xa+63
    .word 0xb+77
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x00000002 @ temp_msg_dup
    .word 0x10000000 @ 7
    .word 0xa+78
    .word 0xb+86
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunk
    .word 0x00000002 @ chunk_dup
    .word 0x10000000 @ 8
    .word 0xa+105
    .word 0xb+110
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x00000001 @ temp_msg_dup
    .word 0x10000000 @ 9
    .word 0xa+135
    .word 0xb+165
    .word 0x0 @ [r0]
    .word 0x00000001 @ chunk
    .word 0x00000001 @ chunk_dup
    .word 0x10000000 @ 10
    .word 0xa+166
    .word 0xb+193
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 11
    .word 0xa+194
    .word 0xb+230
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 12
    .word 0xa+231
    .word 0xb+246
    .word 0x0 @ [r0]
    .word 0x00000001 @ temp_msg
    .word 0x00000001 @ temp_msg_dup
    .word 0x10000000 @ 13
    .word 0xa+272
    .word 0xb+289
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000001 @ h_dup
