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
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
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
    beq else_0
    add r9, r9, #1
    cmp r9, #11
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
    cmp r9, #12
    bne countermeasure
    b endif_0
else_0:
endif_0:
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
    beq else_1
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
    b endif_1
else_1:
endif_1:
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
    beq else_2
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
    b endif_2
else_2:
endif_2:
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
    beq else_3
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
    b endif_3
else_3:
endif_3:
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
    beq else_4
    add r9, r9, #1
    cmp r9, #19
    bne countermeasure
    mov r0, #1
    str r0, [sp, #76]
    str r0, [sp, #72]
    add r9, r9, #1
    cmp r9, #20
    bne countermeasure
    b endif_4
else_4:
endif_4:
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
    .word 0xa+12
    .word 0xb+20
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin1
    .word 0x00000002 @ cardPin1_dup
    .word 0x10000000 @ 2
    .word 0xa+21
    .word 0xb+29
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin2
    .word 0x00000002 @ cardPin2_dup
    .word 0x10000000 @ 3
    .word 0xa+30
    .word 0xb+38
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin3
    .word 0x00000002 @ cardPin3_dup
    .word 0x10000000 @ 4
    .word 0xa+39
    .word 0xb+47
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin4
    .word 0x00000002 @ cardPin4_dup
    .word 0x10000000 @ 5
    .word 0xa+48
    .word 0xb+56
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin1
    .word 0x00000002 @ userPin1_dup
    .word 0x10000000 @ 6
    .word 0xa+57
    .word 0xb+65
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin2
    .word 0x00000002 @ userPin2_dup
    .word 0x10000000 @ 7
    .word 0xa+66
    .word 0xb+74
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin3
    .word 0x00000002 @ userPin3_dup
    .word 0x10000000 @ 8
    .word 0xa+75
    .word 0xb+83
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin4
    .word 0x00000002 @ userPin4_dup
    .word 0x10000000 @ 9
    .word 0xa+84
    .word 0xb+92
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x00000002 @ pinsEqual_dup
    .word 0x10000000 @ 10
    .word 0xa+111
    .word 0xb+122
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 11
    .word 0xa+144
    .word 0xb+155
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 12
    .word 0xa+177
    .word 0xb+188
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 13
    .word 0xa+210
    .word 0xb+221
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x00000001 @ pinsEqual_dup
    .word 0x10000000 @ 14
    .word 0xa+240
    .word 0xb+245
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
    .word 0x00000001 @ authenticated_dup
