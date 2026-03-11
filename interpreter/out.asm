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
    mov r0, #11413
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3533
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #101
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #113
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #59
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #97
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #101
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #-1
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #23
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
    ldr r0, [sp, #64]
    str r0, [sp, #48]
    ldr r0, [sp, #76]
    str r0, [sp, #44]
    ldr r0, [sp, #88]
    str r0, [sp, #40]
    mov r0, #1
    str r0, [sp, #36]
    mov r0, #0
    str r0, [sp, #4]
while_0:
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #44]
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_0
    ldr r0, [sp, #36]
    str r0, [sp, #28]
    ldr r0, [sp, #48]
    str r0, [sp, #24]
    ldr r0, [sp, #40]
    str r0, [sp, #20]
    mov r0, #0
    str r0, [sp, #16]
while_1:
    ldr r0, [sp, #24]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_1
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #28]
    add r0, r1, r0
    str r0, [sp, #16]
while_2:
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_2
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    sub r0, r1, r0
    str r0, [sp, #16]
    b while_2
end_while_2:
while_3:
    ldr r0, [sp, #16]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_3
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    add r0, r1, r0
    str r0, [sp, #16]
    b while_3
end_while_3:
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    mov r0, #0
    str r0, [sp, #16]
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #24]
    mov r1, r0
    mov r0, #1
    sub r0, r1, r0
    str r0, [sp, #24]
    b while_1
end_while_1:
    ldr r0, [sp, #16]
    str r0, [sp, #36]
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    b while_0
end_while_0:
    ldr r0, [sp, #36]
    str r0, [sp, #60]
    ldr r0, [sp, #64]
    str r0, [sp, #48]
    ldr r0, [sp, #72]
    str r0, [sp, #44]
    ldr r0, [sp, #84]
    str r0, [sp, #40]
    mov r0, #1
    str r0, [sp, #36]
    mov r0, #0
    str r0, [sp, #4]
while_5:
    ldr r0, [sp, #4]
    mov r1, r0
    ldr r0, [sp, #44]
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_5
    ldr r0, [sp, #36]
    str r0, [sp, #28]
    ldr r0, [sp, #48]
    str r0, [sp, #24]
    ldr r0, [sp, #40]
    str r0, [sp, #20]
    mov r0, #0
    str r0, [sp, #16]
while_6:
    ldr r0, [sp, #24]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_6
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #28]
    add r0, r1, r0
    str r0, [sp, #16]
while_7:
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_7
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    sub r0, r1, r0
    str r0, [sp, #16]
    b while_7
end_while_7:
while_8:
    ldr r0, [sp, #16]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_8
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    add r0, r1, r0
    str r0, [sp, #16]
    b while_8
end_while_8:
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_9
    mov r0, #0
    str r0, [sp, #16]
    b endif_9
else_9:
endif_9:
    ldr r0, [sp, #24]
    mov r1, r0
    mov r0, #1
    sub r0, r1, r0
    str r0, [sp, #24]
    b while_6
end_while_6:
    ldr r0, [sp, #16]
    str r0, [sp, #36]
    ldr r0, [sp, #4]
    mov r1, r0
    mov r0, #1
    add r0, r1, r0
    str r0, [sp, #4]
    b while_5
end_while_5:
    ldr r0, [sp, #36]
    str r0, [sp, #56]
    ldr r0, [sp, #60]
    mov r1, r0
    ldr r0, [sp, #56]
    sub r0, r1, r0
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    str r0, [sp, #28]
    ldr r0, [sp, #80]
    str r0, [sp, #24]
    ldr r0, [sp, #88]
    str r0, [sp, #20]
    mov r0, #0
    str r0, [sp, #16]
while_10:
    ldr r0, [sp, #24]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_10
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #28]
    add r0, r1, r0
    str r0, [sp, #16]
while_11:
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it gt
    movgt r0, #1
    cmp r0, #0
    beq end_while_11
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    sub r0, r1, r0
    str r0, [sp, #16]
    b while_11
end_while_11:
while_12:
    ldr r0, [sp, #16]
    mov r1, r0
    mov r0, #0
    cmp r1, r0
    mov r0, #0
    it lt
    movlt r0, #1
    cmp r0, #0
    beq end_while_12
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    add r0, r1, r0
    str r0, [sp, #16]
    b while_12
end_while_12:
    ldr r0, [sp, #16]
    mov r1, r0
    ldr r0, [sp, #20]
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_13
    mov r0, #0
    str r0, [sp, #16]
    b endif_13
else_13:
endif_13:
    ldr r0, [sp, #24]
    mov r1, r0
    mov r0, #1
    sub r0, r1, r0
    str r0, [sp, #24]
    b while_10
end_while_10:
    ldr r0, [sp, #16]
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    mov r1, r0
    ldr r0, [sp, #84]
    mul r0, r1, r0
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    mov r1, r0
    ldr r0, [sp, #56]
    add r0, r1, r0
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    str r0, [sp, #68]
    ldr r0, [sp, #68]
    mov r7, #1
    svc #0

.size _start, .-_start
