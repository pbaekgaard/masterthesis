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
    mov r0, #17
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #17
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    sub sp, sp, #4
    mov r0, #65
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #65
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
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #21
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #22
    bne countermeasure
    mov r0, #1
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #23
    bne countermeasure
    ldr r0, [sp, #84]
    ldr r2, [sp, #80]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #88]
    ldr r2, [sp, #84]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r2, [sp, #112]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r2, [sp, #112]
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
    cmp r9, #24
    bne countermeasure
    ldr r0, [sp, #52]
    ldr r2, [sp, #48]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #4]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #25
    bne countermeasure
    mov r10, #26
while_2:
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
    beq end_while_2
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
    beq else_3
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
    ldr r0, [sp, #116]
    ldr r2, [sp, #112]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r2, [sp, #112]
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
    b endif_3
else_3:
endif_3:
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
    ldr r0, [sp, #116]
    ldr r2, [sp, #112]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r2, [sp, #112]
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
    b while_2
end_while_2:
    mov r9, #25
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #26
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
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
    mov r0, #0
    str r0, [sp, #44]
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, #33
    bne countermeasure
    mov r0, #1
    str r0, [sp, #36]
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, #34
    bne countermeasure
    ldr r0, [sp, #172]
    ldr r2, [sp, #168]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #28]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #35
    bne countermeasure
    ldr r0, [sp, #164]
    ldr r2, [sp, #160]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #20]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #36
    bne countermeasure
    mov r10, #37
while_4:
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
    beq end_while_4
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
    b while_4
end_while_4:
    mov r9, #36
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
    beq else_5
    add r9, r9, #1
    cmp r9, #37
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #176]
    ldr r2, [sp, #172]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #52]
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #38
    bne countermeasure
    b endif_5
else_5:
    ldr r0, [sp, #44]
    ldr r2, [sp, #40]
    cmp r0, r2
    bne countermeasure
    str r0, [sp, #52]
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #37
    bne countermeasure
    mov r9, #38
endif_5:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #39
    bne countermeasure
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #40
    bne countermeasure
    ldr r0, [sp, #116]
    ldr r2, [sp, #112]
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
    cmp r9, #41
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
    ldr r0, [sp, #196]
    ldr r2, [sp, #192]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #196]
    ldr r2, [sp, #192]
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
    cmp r9, #42
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
    beq else_6
    add r9, r9, #1
    cmp r9, #43
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r2, [sp, #8]
    cmp r0, r2
    bne countermeasure
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #192]
    ldr r2, [sp, #188]
    cmp r0, r2
    bne countermeasure
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #12]
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #44
    bne countermeasure
    b endif_6
else_6:
endif_6:
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #45
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
    ldr r0, [sp, #196]
    ldr r2, [sp, #192]
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
    cmp r9, #46
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r2, [sp, #0]
    cmp r0, r2
    bne countermeasure
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
    .word 0x00000001 @ e
    .word 0x00000002 @ e_dup
    .word 0x10000000 @ 4
    .word 0xa+39
    .word 0xb+47
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
    .word 0x00000002 @ m_dup
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
    .word 0x00000001 @ ep
    .word 0x00000002 @ ep_dup
    .word 0x10000000 @ 8
    .word 0xa+75
    .word 0xb+83
    .word 0x0 @ [r0]
    .word 0x00000001 @ eq
    .word 0x00000002 @ eq_dup
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
    .word 0x00000001 @ ep
    .word 0x00000001 @ ep_dup
    .word 0x10000000 @ 12
    .word 0xa+150
    .word 0xb+185
    .word 0x0 @ [r0]
    .word 0x00000001 @ eq
    .word 0x00000001 @ eq_dup
    .word 0x10000000 @ 13
    .word 0xa+186
    .word 0xb+194
    .word 0x0 @ [r0]
    .word 0x00000001 @ c1
    .word 0x00000002 @ c1_dup
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
    .word 0x00000001 @ c1
    .word 0x00000001 @ c1_dup
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
    .word 0x00000001 @ c1
    .word 0x00000001 @ c1_dup
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
    .word 0x00000001 @ c2
    .word 0x00000002 @ c2_dup
    .word 0x10000000 @ 23
    .word 0xa+470
    .word 0xb+478
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x00000002 @ base2_dup
    .word 0x10000000 @ 24
    .word 0xa+479
    .word 0xb+487
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x00000002 @ exp2_dup
    .word 0x10000000 @ 25
    .word 0xa+488
    .word 0xb+493
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2
    .word 0x00000001 @ c2_dup
    .word 0x10000000 @ 26
    .word 0xa+494
    .word 0xb+529
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 27
    .word 0xa+530
    .word 0xb+538
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 28
    .word 0xa+600
    .word 0xb+654
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2
    .word 0x00000001 @ c2_dup
    .word 0x10000000 @ 29
    .word 0xa+658
    .word 0xb+673
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 30
    .word 0xa+674
    .word 0xb+728
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 31
    .word 0xa+736
    .word 0xb+744
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x00000002 @ qinv_dup
    .word 0x10000000 @ 32
    .word 0xa+745
    .word 0xb+753
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x00000002 @ t_dup
    .word 0x10000000 @ 33
    .word 0xa+754
    .word 0xb+762
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x00000002 @ newt_dup
    .word 0x10000000 @ 34
    .word 0xa+763
    .word 0xb+771
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x00000002 @ r_dup
    .word 0x10000000 @ 35
    .word 0xa+772
    .word 0xb+780
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x00000002 @ newr_dup
    .word 0x10000000 @ 36
    .word 0xa+781
    .word 0xb+789
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x00000002 @ quotient_dup
    .word 0x10000000 @ 37
    .word 0xa+790
    .word 0xb+798
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x00000002 @ tmp_dup
    .word 0x10000000 @ 38
    .word 0xa+799
    .word 0xb+804
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 39
    .word 0xa+805
    .word 0xb+810
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 40
    .word 0xa+811
    .word 0xb+819
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 41
    .word 0xa+820
    .word 0xb+828
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 42
    .word 0xa+850
    .word 0xb+868
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x00000001 @ quotient_dup
    .word 0x10000000 @ 43
    .word 0xa+869
    .word 0xb+896
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 44
    .word 0xa+897
    .word 0xb+906
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 45
    .word 0xa+907
    .word 0xb+916
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 46
    .word 0xa+917
    .word 0xb+944
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 47
    .word 0xa+945
    .word 0xb+954
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 48
    .word 0xa+955
    .word 0xb+964
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 49
    .word 0xa+990
    .word 0xb+1007
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 50
    .word 0xa+1010
    .word 0xb+1018
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 51
    .word 0xa+1021
    .word 0xb+1029
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000002 @ h_dup
    .word 0x10000000 @ 52
    .word 0xa+1030
    .word 0xb+1038
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x00000002 @ diff_dup
    .word 0x10000000 @ 53
    .word 0xa+1039
    .word 0xb+1056
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x00000001 @ diff_dup
    .word 0x10000000 @ 54
    .word 0xa+1057
    .word 0xb+1110
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 55
    .word 0xa+1129
    .word 0xb+1146
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 56
    .word 0xa+1150
    .word 0xb+1158
    .word 0x0 @ [r0]
    .word 0x00000001 @ c
    .word 0x00000002 @ c_dup
    .word 0x10000000 @ 57
    .word 0xa+1159
    .word 0xb+1185
    .word 0x0 @ [r0]
    .word 0x00000001 @ c
    .word 0x00000001 @ c_dup
