.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #0
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
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #0
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
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #32]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_2
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
    beq else_3
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    b endif_3
else_3:
endif_3:
    ldr r0, [sp, #8]
    mov r1, r0
    ldr r0, [sp, #24]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_5
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp]
    b endif_5
else_5:
endif_5:
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_6
    mov r0, #1
    str r0, [sp, #36]
    b endif_6
else_6:
endif_6:
    ldr r0, [sp, #36]
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
    .word 0xa+19
    .word 0xb+21
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin1
    .word 0x10000000 @ 2
    .word 0xa+22
    .word 0xb+24
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin2
    .word 0x10000000 @ 3
    .word 0xa+25
    .word 0xb+27
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin3
    .word 0x10000000 @ 4
    .word 0xa+28
    .word 0xb+30
    .word 0x0 @ [r0]
    .word 0x00000001 @ cardPin4
    .word 0x10000000 @ 5
    .word 0xa+31
    .word 0xb+33
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin1
    .word 0x10000000 @ 6
    .word 0xa+34
    .word 0xb+36
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin2
    .word 0x10000000 @ 7
    .word 0xa+37
    .word 0xb+39
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin3
    .word 0x10000000 @ 8
    .word 0xa+40
    .word 0xb+42
    .word 0x0 @ [r0]
    .word 0x00000001 @ userPin4
    .word 0x10000000 @ 9
    .word 0xa+43
    .word 0xb+45
    .word 0x0 @ [r0]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 10
    .word 0xa+70
    .word 0xb+74
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 11
    .word 0xa+87
    .word 0xb+91
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 12
    .word 0xa+104
    .word 0xb+108
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 13
    .word 0xa+121
    .word 0xb+125
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ pinsEqual
    .word 0x10000000 @ 14
    .word 0xa+138
    .word 0xb+139
    .word 0x0 @ [r0]
    .word 0x00000001 @ authenticated
