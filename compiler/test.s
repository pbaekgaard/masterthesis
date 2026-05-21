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
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #4
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #20]
    mov r1, r0
    ldr r0, [sp, #36]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_0
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #0]
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_1
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_1
else_1:
endif_1:
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    b endif_0
else_0:
endif_0:
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #32]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_2
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #0]
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_3
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_3
else_3:
endif_3:
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    b endif_2
else_2:
endif_2:
    ldr r0, [sp, #12]
    mov r1, r0
    ldr r0, [sp, #28]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #0]
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
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #8]
    mov r1, r0
    ldr r0, [sp, #24]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_6
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #0]
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
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    b endif_6
else_6:
endif_6:
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_8
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #0]
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq else_9
    mov r0, #77
    mov r7, #1
    svc #0
    b endif_9
else_9:
endif_9:
    ldr r0, [sp, #44]
    mov r1, r0
    ldr r0, [sp, #40]
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
    mov r0, #1
    str r0, [sp, #44]
    mov r0, #1
    str r0, [sp, #40]
    b endif_8
else_8:
endif_8:
    ldr r0, [sp, #44]
    mov r1, r0
    ldr r0, [sp, #40]
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
    ldr r0, [sp, #44]
    mov r7, #1
    svc #0

.size _start, .-_start
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
    .word 0x10000000 @ 1
    .word 0xa+4
    .word 0xb+6
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticatedDup
    .word 0x10000000 @ 2
    .word 0xa+7
    .word 0xb+9
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin1
    .word 0x10000000 @ 3
    .word 0xa+10
    .word 0xb+12
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin2
    .word 0x10000000 @ 4
    .word 0xa+13
    .word 0xb+15
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin3
    .word 0x10000000 @ 5
    .word 0xa+16
    .word 0xb+18
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin4
    .word 0x10000000 @ 6
    .word 0xa+19
    .word 0xb+21
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin1
    .word 0x10000000 @ 7
    .word 0xa+22
    .word 0xb+24
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin2
    .word 0x10000000 @ 8
    .word 0xa+25
    .word 0xb+27
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin3
    .word 0x10000000 @ 9
    .word 0xa+28
    .word 0xb+30
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin4
    .word 0x10000000 @ 10
    .word 0xa+31
    .word 0xb+33
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 11
    .word 0xa+34
    .word 0xb+36
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqualDup
    .word 0x10000000 @ 12
    .word 0xa+61
    .word 0xb+65
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 13
    .word 0xa+66
    .word 0xb+70
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqualDup
    .word 0x10000000 @ 14
    .word 0xa+98
    .word 0xb+102
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 15
    .word 0xa+103
    .word 0xb+107
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqualDup
    .word 0x10000000 @ 16
    .word 0xa+135
    .word 0xb+139
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 17
    .word 0xa+140
    .word 0xb+144
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqualDup
    .word 0x10000000 @ 18
    .word 0xa+172
    .word 0xb+176
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 19
    .word 0xa+177
    .word 0xb+181
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqualDup
    .word 0x10000000 @ 20
    .word 0xa+224
    .word 0xb+225
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
    .word 0x10000000 @ 21
    .word 0xa+226
    .word 0xb+227
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticatedDup
