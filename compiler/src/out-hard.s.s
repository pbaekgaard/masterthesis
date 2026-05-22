.syntax unified
.thumb

.section .text
.global _start
.type _start, %function

_start:
    mov r9, #0
    mov r10, #1
    sub sp, sp, #4
    mov r0, #61
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #61
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    sub sp, sp, #4
    mov r0, #53
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #53
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    sub sp, sp, #4
    mov r0, #3233
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3233
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    sub sp, sp, #4
    mov r0, #2753
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2753
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    sub sp, sp, #4
    mov r0, #2790
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2790
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
    ldr r0, [sp, #68]
    ldr r2, [sp, #64]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #28]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #10
    bne countermeasure
    ldr r0, [sp, #60]
    ldr r2, [sp, #56]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #11
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #48]
    ldr r2, [sp, #44]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #12
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #48]
    ldr r2, [sp, #44]
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
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #13
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #14
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #15
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #16
    bne countermeasure
    mov r0, #1
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #17
    bne countermeasure
    ldr r0, [sp, #60]
    ldr r2, [sp, #56]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    ldr r2, [sp, #60]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r2, [sp, #96]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r2, [sp, #96]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #18
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r2, [sp, #32]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #19
    bne countermeasure
    mov r10, #20
while_0:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
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
    beq end_while_0
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r2, [sp, #4]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_1
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r2, [sp, #12]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r2, [sp, #20]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r2, [sp, #96]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r2, [sp, #96]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    b endif_1
else_1:
endif_1:
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
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
    ldr r0, [sp, #16]
    ldr r2, [sp, #12]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r2, [sp, #12]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r2, [sp, #96]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r2, [sp, #96]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
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
    b while_0
end_while_0:
    mov r9, #19
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #20
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
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
    beq else_2
    add r9, r9, #1
    cmp r9, #21
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r2, [sp, #24]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #28]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #22
    bne countermeasure
    mov r0, #1
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #23
    bne countermeasure
    b endif_2
else_2:
endif_2:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #24
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #25
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #26
    bne countermeasure
    mov r0, #1
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r2, [sp, #88]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r2, [sp, #92]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r2, [sp, #120]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r2, [sp, #120]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    ldr r0, [sp, #60]
    ldr r2, [sp, #56]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    mov r10, #30
while_3:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
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
    beq end_while_3
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r2, [sp, #4]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it eq
    moveq r0, #1
    cmp r0, #0
    beq else_4
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r2, [sp, #12]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r2, [sp, #20]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r2, [sp, #120]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r2, [sp, #120]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    b endif_4
else_4:
endif_4:
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
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
    ldr r0, [sp, #16]
    ldr r2, [sp, #12]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r2, [sp, #12]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r2, [sp, #120]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r2, [sp, #120]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
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
    b while_3
end_while_3:
    mov r9, #29
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #31
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #32
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #33
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #34
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #35
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #36
    bne countermeasure
    mov r0, #0
    str r0, [sp, #44]
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, #37
    bne countermeasure
    mov r0, #1
    str r0, [sp, #36]
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, #38
    bne countermeasure
    ldr r0, [sp, #180]
    ldr r2, [sp, #176]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #28]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #39
    bne countermeasure
    ldr r0, [sp, #172]
    ldr r2, [sp, #168]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #40
    bne countermeasure
    mov r10, #41
while_5:
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #0
    ldr r1, [sp, #0]
    add sp, sp, #4
    cmp r1, r0
    mov r0, #0
    it ne
    movne r0, #1
    cmp r0, #0
    beq end_while_5
    ldr r0, [sp, #28]
    ldr r2, [sp, #24]
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
    sdiv r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
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
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
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
    str r0, [sp, #44]
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #36]
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #28]
    ldr r2, [sp, #24]
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
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #20]
    ldr r2, [sp, #16]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #28]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    add r9, r9, #1
    cmp r9, r10
    bne countermeasure
    add r10, r10, #1
    b while_5
end_while_5:
    mov r9, #40
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
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
    beq else_6
    add r9, r9, #1
    cmp r9, #41
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #184]
    ldr r2, [sp, #180]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #52]
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #42
    bne countermeasure
    b endif_6
else_6:
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #52]
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #41
    bne countermeasure
    mov r9, #42
endif_6:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #43
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #44
    bne countermeasure
    ldr r0, [sp, #124]
    ldr r2, [sp, #120]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r2, [sp, #92]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #45
    bne countermeasure
    ldr r0, [sp, #68]
    ldr r2, [sp, #64]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r2, [sp, #4]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #72]
    ldr r2, [sp, #68]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #204]
    ldr r2, [sp, #200]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #204]
    ldr r2, [sp, #200]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #46
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
    it lt
    movlt r0, #1
    cmp r0, #0
    beq else_7
    add r9, r9, #1
    cmp r9, #47
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #200]
    ldr r2, [sp, #196]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #48
    bne countermeasure
    b endif_7
else_7:
endif_7:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #49
    bne countermeasure
    ldr r0, [sp, #100]
    ldr r2, [sp, #96]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r2, [sp, #20]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #204]
    ldr r2, [sp, #200]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #50
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
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
    .word 0x00000001 @ p
    .word 0x00000002 @ p_dup
    .word 0x10000000 @ 1
    .word 0xa+12
    .word 0xb+20
    .word 0x0 @ [r0]
    .word 0x00000001 @ q
    .word 0x00000002 @ q_dup
    .word 0x10000000 @ 2
    .word 0xa+21
    .word 0xb+29
    .word 0x0 @ [r0]
    .word 0x00000001 @ n
    .word 0x00000002 @ n_dup
    .word 0x10000000 @ 3
    .word 0xa+30
    .word 0xb+38
    .word 0x0 @ [r0]
    .word 0x00000001 @ d
    .word 0x00000002 @ d_dup
    .word 0x10000000 @ 4
    .word 0xa+39
    .word 0xb+47
    .word 0x0 @ [r0]
    .word 0x00000001 @ c
    .word 0x00000002 @ c_dup
    .word 0x10000000 @ 5
    .word 0xa+48
    .word 0xb+56
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1
    .word 0x00000002 @ p_minus_1_dup
    .word 0x10000000 @ 6
    .word 0xa+57
    .word 0xb+65
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1
    .word 0x00000002 @ q_minus_1_dup
    .word 0x10000000 @ 7
    .word 0xa+66
    .word 0xb+74
    .word 0x0 @ [r0]
    .word 0x00000001 @ dp
    .word 0x00000002 @ dp_dup
    .word 0x10000000 @ 8
    .word 0xa+75
    .word 0xb+83
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq
    .word 0x00000002 @ dq_dup
    .word 0x10000000 @ 9
    .word 0xa+84
    .word 0xb+98
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1
    .word 0x00000001 @ p_minus_1_dup
    .word 0x10000000 @ 10
    .word 0xa+99
    .word 0xb+113
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1
    .word 0x00000001 @ q_minus_1_dup
    .word 0x10000000 @ 11
    .word 0xa+114
    .word 0xb+149
    .word 0x0 @ [r0]
    .word 0x00000001 @ dp
    .word 0x00000001 @ dp_dup
    .word 0x10000000 @ 12
    .word 0xa+150
    .word 0xb+185
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq
    .word 0x00000001 @ dq_dup
    .word 0x10000000 @ 13
    .word 0xa+186
    .word 0xb+194
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x00000002 @ m1_dup
    .word 0x10000000 @ 14
    .word 0xa+195
    .word 0xb+203
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x00000002 @ base1_dup
    .word 0x10000000 @ 15
    .word 0xa+204
    .word 0xb+212
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x00000002 @ exp1_dup
    .word 0x10000000 @ 16
    .word 0xa+213
    .word 0xb+218
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x00000001 @ m1_dup
    .word 0x10000000 @ 17
    .word 0xa+219
    .word 0xb+254
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x00000001 @ base1_dup
    .word 0x10000000 @ 18
    .word 0xa+255
    .word 0xb+263
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x00000001 @ exp1_dup
    .word 0x10000000 @ 19
    .word 0xa+325
    .word 0xb+379
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x00000001 @ m1_dup
    .word 0x10000000 @ 20
    .word 0xa+383
    .word 0xb+398
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x00000001 @ exp1_dup
    .word 0x10000000 @ 21
    .word 0xa+399
    .word 0xb+453
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x00000001 @ base1_dup
    .word 0x10000000 @ 22
    .word 0xa+461
    .word 0xb+469
    .word 0x0 @ [r0]
    .word 0x00000001 @ fault_triggered
    .word 0x00000002 @ fault_triggered_dup
    .word 0x10000000 @ 23
    .word 0xa+488
    .word 0xb+502
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x00000001 @ m1_dup
    .word 0x10000000 @ 24
    .word 0xa+503
    .word 0xb+508
    .word 0x0 @ [r0]
    .word 0x00000001 @ fault_triggered
    .word 0x00000001 @ fault_triggered_dup
    .word 0x10000000 @ 25
    .word 0xa+512
    .word 0xb+520
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x00000002 @ m2_dup
    .word 0x10000000 @ 26
    .word 0xa+521
    .word 0xb+529
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x00000002 @ base2_dup
    .word 0x10000000 @ 27
    .word 0xa+530
    .word 0xb+538
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x00000002 @ exp2_dup
    .word 0x10000000 @ 28
    .word 0xa+539
    .word 0xb+544
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x00000001 @ m2_dup
    .word 0x10000000 @ 29
    .word 0xa+545
    .word 0xb+580
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 30
    .word 0xa+581
    .word 0xb+589
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 31
    .word 0xa+651
    .word 0xb+705
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x00000001 @ m2_dup
    .word 0x10000000 @ 32
    .word 0xa+709
    .word 0xb+724
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 33
    .word 0xa+725
    .word 0xb+779
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 34
    .word 0xa+787
    .word 0xb+795
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x00000002 @ qinv_dup
    .word 0x10000000 @ 35
    .word 0xa+796
    .word 0xb+804
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x00000002 @ t_dup
    .word 0x10000000 @ 36
    .word 0xa+805
    .word 0xb+813
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x00000002 @ newt_dup
    .word 0x10000000 @ 37
    .word 0xa+814
    .word 0xb+822
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x00000002 @ r_dup
    .word 0x10000000 @ 38
    .word 0xa+823
    .word 0xb+831
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x00000002 @ newr_dup
    .word 0x10000000 @ 39
    .word 0xa+832
    .word 0xb+840
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x00000002 @ quotient_dup
    .word 0x10000000 @ 40
    .word 0xa+841
    .word 0xb+849
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x00000002 @ tmp_dup
    .word 0x10000000 @ 41
    .word 0xa+850
    .word 0xb+855
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 42
    .word 0xa+856
    .word 0xb+861
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 43
    .word 0xa+862
    .word 0xb+870
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 44
    .word 0xa+871
    .word 0xb+879
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 45
    .word 0xa+901
    .word 0xb+919
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x00000001 @ quotient_dup
    .word 0x10000000 @ 46
    .word 0xa+920
    .word 0xb+947
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 47
    .word 0xa+948
    .word 0xb+957
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 48
    .word 0xa+958
    .word 0xb+967
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 49
    .word 0xa+968
    .word 0xb+995
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 50
    .word 0xa+996
    .word 0xb+1005
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 51
    .word 0xa+1006
    .word 0xb+1015
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 52
    .word 0xa+1041
    .word 0xb+1058
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 53
    .word 0xa+1061
    .word 0xb+1069
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 54
    .word 0xa+1072
    .word 0xb+1080
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000002 @ h_dup
    .word 0x10000000 @ 55
    .word 0xa+1081
    .word 0xb+1089
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x00000002 @ diff_dup
    .word 0x10000000 @ 56
    .word 0xa+1090
    .word 0xb+1107
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x00000001 @ diff_dup
    .word 0x10000000 @ 57
    .word 0xa+1108
    .word 0xb+1161
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 58
    .word 0xa+1180
    .word 0xb+1197
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 59
    .word 0xa+1201
    .word 0xb+1209
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
    .word 0x00000002 @ m_dup
    .word 0x10000000 @ 60
    .word 0xa+1210
    .word 0xb+1236
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
    .word 0x00000001 @ m_dup
