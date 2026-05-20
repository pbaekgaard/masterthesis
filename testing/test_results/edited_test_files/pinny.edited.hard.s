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
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_0
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_0
else_0:
endif_0:
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
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
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #10
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #11
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_1
    add r9, r9, #1
    cmp r9, #12
    bne countermeasure
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_1
else_1:
endif_1:
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    ldr r0, [sp, #68]
    ldr r2, [sp, #64]
    cmp r0, r2
    bne countermeasure
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_2
    add r9, r9, #1
    cmp r9, #13
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #14
    bne countermeasure
    b endif_2
else_2:
endif_2:
    ldr r0, [sp, #28]
    ldr r2, [sp, #24]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    ldr r0, [sp, #60]
    ldr r2, [sp, #56]
    cmp r0, r2
    bne countermeasure
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_3
    add r9, r9, #1
    cmp r9, #15
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #16
    bne countermeasure
    b endif_3
else_3:
endif_3:
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    ldr r0, [sp, #52]
    ldr r2, [sp, #48]
    cmp r0, r2
    bne countermeasure
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    add r9, r9, #1
    cmp r9, #17
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #18
    bne countermeasure
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_5
    add r9, r9, #1
    cmp r9, #19
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #20
    bne countermeasure
    b endif_5
else_5:
endif_5:
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    mov r1, r0
    mov r0, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_6
    add r9, r9, #1
    cmp r9, #21
    bne countermeasure
    mov r0, #1
    str r0, [sp, #76]
    str r0, [sp, #72]
    add r9, r9, #1
    cmp r9, #22
    bne countermeasure
    b endif_6
else_6:
endif_6:
    ldr r0, [sp, #76]
    ldr r2, [sp, #72]
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
step_counter:
    .word 0
fault_msg:
    .ascii "Control flow violation detected\n"
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+3
    .word 0xb+11
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
    .word 0x00000002 @ authenticated_dup
    .word 0x10000000 @ 1
    .word 0xa+33
    .word 0xb+41
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin1
    .word 0x00000002 @ cardPin1_dup
    .word 0x10000000 @ 2
    .word 0xa+42
    .word 0xb+50
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin2
    .word 0x00000002 @ cardPin2_dup
    .word 0x10000000 @ 3
    .word 0xa+51
    .word 0xb+59
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin3
    .word 0x00000002 @ cardPin3_dup
    .word 0x10000000 @ 4
    .word 0xa+60
    .word 0xb+68
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin4
    .word 0x00000002 @ cardPin4_dup
    .word 0x10000000 @ 5
    .word 0xa+69
    .word 0xb+77
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin1
    .word 0x00000002 @ userPin1_dup
    .word 0x10000000 @ 6
    .word 0xa+78
    .word 0xb+86
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin2
    .word 0x00000002 @ userPin2_dup
    .word 0x10000000 @ 7
    .word 0xa+87
    .word 0xb+95
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin3
    .word 0x00000002 @ userPin3_dup
    .word 0x10000000 @ 8
    .word 0xa+96
    .word 0xb+104
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin4
    .word 0x00000002 @ userPin4_dup
    .word 0x10000000 @ 9
    .word 0xa+105
    .word 0xb+113
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x00000002 @ pinsEqual_dup
    .word 0x10000000 @ 10
    .word 0xa+153
    .word 0xb+164
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 11
    .word 0xa+186
    .word 0xb+197
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 12
    .word 0xa+219
    .word 0xb+230
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 13
    .word 0xa+252
    .word 0xb+263
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 14
    .word 0xa+282
    .word 0xb+287
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
    .word 0x00000001 @ authenticated_dup
