.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    sub sp, sp, #4
    mov r0, #77
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #7
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #11
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #5
    str r0, [sp]
    sub sp, sp, #4
    ldr r0, [sp, #8]
    mov r1, r0
    ldr r0, [sp, #4]
    sub r0, r1, r0
    str r0, [sp]
    sub sp, sp, #4
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #16]
    mul r0, r1, r0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #1
    str r0, [sp]
while_0:
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq end_while_0
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #28]
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq else_1
    mov r0, #0
    str r0, [sp]
    b endif_1
else_1:
endif_1:
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #28]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_2
    mov r0, #0
    str r0, [sp, #4]
    mov r0, #0
    str r0, [sp]
    b endif_2
else_2:
endif_2:
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq else_3
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #28]
    add r0, r1, r0
    str r0, [sp, #4]
    b endif_3
else_3:
endif_3:
    ldr r0, [sp, #0]
    mov r1, r0
    mov r0, #1
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #28]
    sub r0, r1, r0
    str r0, [sp, #4]
    b endif_4
else_4:
endif_4:
    b while_0
end_while_0:
    sub sp, sp, #4
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #28]
    mov r1, r0
    ldr r0, [sp, #8]
    mul r0, r1, r0
    add r0, r1, r0
    str r0, [sp]
    ldr r0, [sp, #0]
    mov r7, #1
    svc #0

.size _start, .-_start
_metadata:
    .word 0x10000000 @ 0
    .word 0xa+1
    .word 0xb+3
    .word 0x0 @ [r0]
    .word 0x00000001 @ publicN
    .word 0x10000000 @ 1
    .word 0xa+4
    .word 0xb+6
    .word 0x0 @ [r0]
    .word 0x00000001 @ secretP
    .word 0x10000000 @ 2
    .word 0xa+7
    .word 0xb+9
    .word 0x0 @ [r0]
    .word 0x00000001 @ secretQ
    .word 0x10000000 @ 3
    .word 0xa+10
    .word 0xb+12
    .word 0x0 @ [r0]
    .word 0x00000001 @ qInvModP
    .word 0x10000000 @ 4
    .word 0xa+13
    .word 0xb+15
    .word 0x0 @ [r0]
    .word 0x00000001 @ sigP
    .word 0x10000000 @ 5
    .word 0xa+16
    .word 0xb+18
    .word 0x0 @ [r0]
    .word 0x00000001 @ sigQ
    .word 0x10000000 @ 6
    .word 0xa+19
    .word 0xb+24
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ diff
    .word 0x10000000 @ 7
    .word 0xa+25
    .word 0xb+30
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ intermediate
    .word 0x10000000 @ 8
    .word 0xa+31
    .word 0xb+33
    .word 0x0 @ [r0]
    .word 0x00000001 @ loopActive
    .word 0x10000000 @ 9
    .word 0xa+53
    .word 0xb+54
    .word 0x0 @ [r0]
    .word 0x00000001 @ loopActive
    .word 0x10000000 @ 10
    .word 0xa+67
    .word 0xb+68
    .word 0x0 @ [r0]
    .word 0x00000001 @ intermediate
    .word 0x10000000 @ 11
    .word 0xa+69
    .word 0xb+70
    .word 0x0 @ [r0]
    .word 0x00000001 @ loopActive
    .word 0x10000000 @ 12
    .word 0xa+83
    .word 0xb+87
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ intermediate
    .word 0x10000000 @ 13
    .word 0xa+100
    .word 0xb+104
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ intermediate
    .word 0x10000000 @ 14
    .word 0xa+110
    .word 0xb+118
    .word 0x0 @ [r0,r1]
    .word 0x00000001 @ finalSignature
