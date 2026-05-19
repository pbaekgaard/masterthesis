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
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #7
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #8
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #10
    bne countermeasure
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #32]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_0
    add r9, r9, #1
    cmp r9, #11
    bne countermeasure
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #12
    bne countermeasure
    b endif_0
else_0:
endif_0:
    ldr r0, [sp, #12]
    mov r1, r0
    ldr r0, [sp, #28]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_1
    add r9, r9, #1
    cmp r9, #13
    bne countermeasure
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #14
    bne countermeasure
    b endif_1
else_1:
endif_1:
    ldr r0, [sp, #8]
    mov r1, r0
    ldr r0, [sp, #24]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_2
    add r9, r9, #1
    cmp r9, #15
    bne countermeasure
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #16
    bne countermeasure
    b endif_2
else_2:
endif_2:
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_3
    add r9, r9, #1
    cmp r9, #17
    bne countermeasure
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #18
    bne countermeasure
    b endif_3
else_3:
endif_3:
    ldr r0, [sp, #0]
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
    str r0, [sp, #36]
    add r9, r9, #1
    cmp r9, #20
    bne countermeasure
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #36]
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
    .word 0xb+8
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
    .word 0x10000000 @ 1
    .word 0xa+9
    .word 0xb+14
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin1
    .word 0x10000000 @ 2
    .word 0xa+15
    .word 0xb+20
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin2
    .word 0x10000000 @ 3
    .word 0xa+21
    .word 0xb+26
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin3
    .word 0x10000000 @ 4
    .word 0xa+27
    .word 0xb+32
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin4
    .word 0x10000000 @ 5
    .word 0xa+33
    .word 0xb+38
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin1
    .word 0x10000000 @ 6
    .word 0xa+39
    .word 0xb+44
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin2
    .word 0x10000000 @ 7
    .word 0xa+45
    .word 0xb+50
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin3
    .word 0x10000000 @ 8
    .word 0xa+51
    .word 0xb+56
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin4
    .word 0x10000000 @ 9
    .word 0xa+57
    .word 0xb+62
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 10
    .word 0xa+75
    .word 0xb+82
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 11
    .word 0xa+98
    .word 0xb+105
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 12
    .word 0xa+121
    .word 0xb+128
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 13
    .word 0xa+144
    .word 0xb+151
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 14
    .word 0xa+167
    .word 0xb+171
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
