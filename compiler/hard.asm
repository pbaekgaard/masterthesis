.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r9, #0
    mov r10, #1
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #7
    bne countermeasure
    add r9, r9, #1
    cmp r9, #8
    bne countermeasure
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    add r9, r9, #1
    cmp r9, #10
    bne countermeasure
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #11
    bne countermeasure
    add r9, r9, #1
    cmp r9, #12
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #13
    bne countermeasure
    add r9, r9, #1
    cmp r9, #14
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #15
    bne countermeasure
    add r9, r9, #1
    cmp r9, #16
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #17
    bne countermeasure
    add r9, r9, #1
    cmp r9, #18
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #19
    bne countermeasure
    add r9, r9, #1
    cmp r9, #20
    bne countermeasure
    mov r0, #0
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, #21
    bne countermeasure
    add r9, r9, #1
    cmp r9, #22
    bne countermeasure
    ldr r0, [sp, #36]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq else_0
    add r9, r9, #1
    cmp r9, #23
    bne countermeasure
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #24
    bne countermeasure
    add r9, r9, #1
    cmp r9, #25
    bne countermeasure
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #32]
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_1
    add r9, r9, #1
    cmp r9, #26
    bne countermeasure
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    mov r9, #25
    b endif_1
else_1:
    add r9, r9, #1
    cmp r9, #26
    bne countermeasure
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    mov r9, #25
endif_1:
    add r9, r9, #1
    cmp r9, #26
    bne countermeasure
    ldr r0, [sp, #12]
    mov r1, r0
    ldr r0, [sp, #28]
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_2
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    mov r9, #26
    b endif_2
else_2:
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    mov r9, #26
endif_2:
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    ldr r0, [sp, #8]
    mov r1, r0
    ldr r0, [sp, #24]
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_3
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    mov r9, #27
    b endif_3
else_3:
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    mov r9, #27
endif_3:
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_4
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    add r9, r9, #1
    cmp r9, #31
    bne countermeasure
    mov r9, #28
    b endif_4
else_4:
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    add r9, r9, #1
    cmp r9, #31
    bne countermeasure
    mov r9, #28
endif_4:
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_5
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    mov r0, #3
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, #31
    bne countermeasure
    add r9, r9, #1
    cmp r9, #32
    bne countermeasure
    mov r0, #1
    str r0, [sp, #36]
    add r9, r9, #1
    cmp r9, #33
    bne countermeasure
    add r9, r9, #1
    cmp r9, #34
    bne countermeasure
    mov r9, #29
    b endif_5
else_5:
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    ldr r0, [sp, #40]
    mov r1, r0
    mov r0, #1
    sub r0, r1, r0
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, #31
    bne countermeasure
    add r9, r9, #1
    cmp r9, #32
    bne countermeasure
    mov r9, #29
endif_5:
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    add sp, sp, #4
    mov r9, #22
    b endif_0
else_0:
    add r9, r9, #1
    cmp r9, #23
    bne countermeasure
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #24
    bne countermeasure
    add r9, r9, #1
    cmp r9, #25
    bne countermeasure
    add sp, sp, #4
    mov r9, #22
endif_0:
    add r9, r9, #1
    cmp r9, #23
    bne countermeasure
    mov r0, #1
    ldr r1, =.Lstr0
    mov r2, #17
    mov r7, #4
    svc #0
    ldr r0, [sp, #32]
    mov r4, r0
    ldr r1, =num_buf
    add r1, r1, #16
    mov r2, #0
    cmp r4, #0
    bne print_int_loop_6
    mov r3, #48
    sub r1, r1, #1
    strb r3, [r1]
    mov r2, #1
    b print_int_done_6
print_int_loop_6:
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
    bne print_int_loop_6
print_int_done_6:
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
    add r9, r9, #1
    cmp r9, #24
    bne countermeasure
    mov r0, #1
    ldr r1, =.Lstr1
    mov r2, #7
    mov r7, #4
    svc #0
    ldr r0, [sp, #36]
    mov r4, r0
    ldr r1, =num_buf
    add r1, r1, #16
    mov r2, #0
    cmp r4, #0
    bne print_int_loop_7
    mov r3, #48
    sub r1, r1, #1
    strb r3, [r1]
    mov r2, #1
    b print_int_done_7
print_int_loop_7:
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
    bne print_int_loop_7
print_int_done_7:
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
    add r9, r9, #1
    cmp r9, #25
    bne countermeasure
    ldr r0, [sp, #32]
    mov r7, #1
    svc #0
    add r9, r9, #1
    cmp r9, #26
    bne countermeasure
countermeasure:
    mov r0, #77
    mov r7, #1
    svc #0

.size _start, .-_start

.section .data
.Lstr0:
    .ascii "g_authenticated: "
.Lstr1:
    .ascii "g_ptc: "
newline:
    .ascii "\n"
num_buf:
    .space 16
step_counter:
    .word 0
fault_msg:
    .ascii "Control flow violation detected\n"
