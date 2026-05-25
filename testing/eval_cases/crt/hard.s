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
    sub sp, sp, #4
    mov r0, #53
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #53
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3233
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #3233
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #17
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #17
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #65
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #65
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
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #68]
    ldr r1, [sp, #64]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #68]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #28]
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    ldr r0, [sp, #64]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #60]
    ldr r1, [sp, #56]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #60]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    ldr r0, [sp, #56]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #48]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #36]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    ldr r0, [sp, #40]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #32]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #32]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #48]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #7
    bne countermeasure
    ldr r0, [sp, #40]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
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
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    mov r0, #1
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    mov r0, #1
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #10
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #60]
    ldr r1, [sp, #56]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #60]
    ldr r1, [sp, #56]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #60]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #64]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #11
    bne countermeasure
    ldr r0, [sp, #56]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #60]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #12
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r1, [sp, #32]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #36]
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #13
    bne countermeasure
    ldr r0, [sp, #32]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #14
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
while_0:
    mov r9, #0
    mov r10, #1
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    ldr r0, [sp, #4]
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
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
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
    cmp r9, #2
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    b endif_1
else_1:
endif_1:
    mov r9, #4
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #100]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #7
    bne countermeasure
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #8
    bne countermeasure
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    b while_0
end_while_0:
    mov r9, #14
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
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    mov r0, #1
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #15
    bne countermeasure
    mov r0, #1
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #16
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #84]
    ldr r1, [sp, #80]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #84]
    ldr r1, [sp, #80]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #108]
    ldr r1, [sp, #104]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #108]
    ldr r1, [sp, #104]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #84]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #88]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #17
    bne countermeasure
    ldr r0, [sp, #80]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #84]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #112]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #112]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #18
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #52]
    ldr r1, [sp, #48]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #52]
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #19
    bne countermeasure
    ldr r0, [sp, #48]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #20
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
while_2:
    mov r9, #0
    mov r10, #1
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    ldr r0, [sp, #4]
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
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
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
    cmp r9, #2
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #108]
    ldr r1, [sp, #104]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #108]
    ldr r1, [sp, #104]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #112]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #112]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    b endif_3
else_3:
endif_3:
    mov r9, #4
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    ldr r0, [sp, #0]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #2
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #108]
    ldr r1, [sp, #104]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #108]
    ldr r1, [sp, #104]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #116]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #7
    bne countermeasure
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #112]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #112]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #8
    bne countermeasure
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    b while_2
end_while_2:
    mov r9, #20
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
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    mov r0, #0
    str r0, [sp, #44]
    add r9, r9, #1
    cmp r9, #21
    bne countermeasure
    mov r0, #0
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, #22
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r1, [sp, #32]
    cmp r1, r0
    bne countermeasure
    mov r0, #1
    str r0, [sp, #36]
    add r9, r9, #1
    cmp r9, #23
    bne countermeasure
    mov r0, #1
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, #24
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #172]
    ldr r1, [sp, #168]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #172]
    str r0, [sp, #28]
    add r9, r9, #1
    cmp r9, #25
    bne countermeasure
    ldr r0, [sp, #168]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #26
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #164]
    ldr r1, [sp, #160]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #164]
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    ldr r0, [sp, #160]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
while_4:
    mov r9, #0
    mov r10, #1
    add r9, r9, #1
    cmp r9, #1
    bne countermeasure
    ldr r0, [sp, #20]
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
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #2
    bne countermeasure
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #3
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r1, [sp, #32]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #44]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #4
    bne countermeasure
    ldr r0, [sp, #40]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #40]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #5
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r1, [sp, #32]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #36]
    str r0, [sp, #44]
    add r9, r9, #1
    cmp r9, #6
    bne countermeasure
    ldr r0, [sp, #32]
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, #7
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r1, [sp, #32]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    str r0, [sp, #36]
    add r9, r9, #1
    cmp r9, #8
    bne countermeasure
    ldr r0, [sp, #0]
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, #9
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #16]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #28]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #10
    bne countermeasure
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #11
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    str r0, [sp, #28]
    add r9, r9, #1
    cmp r9, #12
    bne countermeasure
    ldr r0, [sp, #16]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #13
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #14
    bne countermeasure
    ldr r0, [sp, #0]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #15
    bne countermeasure
    add r9, r9, #1
    cmp r9, #16
    bne countermeasure
    b while_4
end_while_4:
    mov r9, #28
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
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
    cmp r9, #29
    bne countermeasure
    ldr r0, [sp, #52]
    ldr r1, [sp, #48]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #172]
    ldr r1, [sp, #168]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #176]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #52]
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    ldr r0, [sp, #40]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #172]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #31
    bne countermeasure
    b endif_5
else_5:
    ldr r0, [sp, #52]
    ldr r1, [sp, #48]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    str r0, [sp, #52]
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    ldr r0, [sp, #40]
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    mov r9, #31
endif_5:
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
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #116]
    ldr r1, [sp, #112]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #116]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #32
    bne countermeasure
    ldr r0, [sp, #112]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #92]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #33
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #68]
    ldr r1, [sp, #64]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #68]
    ldr r1, [sp, #64]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #188]
    ldr r1, [sp, #184]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #188]
    ldr r1, [sp, #184]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #68]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #72]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #12]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #196]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #196]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #34
    bne countermeasure
    ldr r0, [sp, #64]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #68]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #8]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #192]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #192]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #35
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
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
    cmp r9, #36
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #188]
    ldr r1, [sp, #184]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #192]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #37
    bne countermeasure
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #188]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #38
    bne countermeasure
    b endif_6
else_6:
endif_6:
    mov r9, #38
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #0
    str r0, [sp]
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #100]
    ldr r1, [sp, #96]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #188]
    ldr r1, [sp, #184]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #100]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #196]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #39
    bne countermeasure
    ldr r0, [sp, #96]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #192]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #40
    bne countermeasure
    ldr r0, [sp, #4]
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
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
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
    .word 0xb+5
    .word 0x0 @ [r0]
    .word 0x00000001 @ p
    .word 0x10000000 @ 1
    .word 0xa+6
    .word 0xb+8
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_dup
    .word 0x10000000 @ 2
    .word 0xa+9
    .word 0xb+11
    .word 0x0 @ [r0]
    .word 0x00000001 @ q
    .word 0x10000000 @ 3
    .word 0xa+12
    .word 0xb+14
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_dup
    .word 0x10000000 @ 4
    .word 0xa+15
    .word 0xb+17
    .word 0x0 @ [r0]
    .word 0x00000001 @ n
    .word 0x10000000 @ 5
    .word 0xa+18
    .word 0xb+20
    .word 0x0 @ [r0]
    .word 0x00000001 @ n_dup
    .word 0x10000000 @ 6
    .word 0xa+21
    .word 0xb+23
    .word 0x0 @ [r0]
    .word 0x00000001 @ e
    .word 0x10000000 @ 7
    .word 0xa+24
    .word 0xb+26
    .word 0x0 @ [r0]
    .word 0x00000001 @ e_dup
    .word 0x10000000 @ 8
    .word 0xa+27
    .word 0xb+29
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
    .word 0x10000000 @ 9
    .word 0xa+30
    .word 0xb+32
    .word 0x0 @ [r0]
    .word 0x00000001 @ m_dup
    .word 0x10000000 @ 10
    .word 0xa+33
    .word 0xb+35
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1
    .word 0x10000000 @ 11
    .word 0xa+36
    .word 0xb+38
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1_dup
    .word 0x10000000 @ 12
    .word 0xa+39
    .word 0xb+41
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1
    .word 0x10000000 @ 13
    .word 0xa+42
    .word 0xb+44
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1_dup
    .word 0x10000000 @ 14
    .word 0xa+45
    .word 0xb+47
    .word 0x0 @ [r0]
    .word 0x00000001 @ ep
    .word 0x10000000 @ 15
    .word 0xa+48
    .word 0xb+50
    .word 0x0 @ [r0]
    .word 0x00000001 @ ep_dup
    .word 0x10000000 @ 16
    .word 0xa+51
    .word 0xb+53
    .word 0x0 @ [r0]
    .word 0x00000001 @ eq
    .word 0x10000000 @ 17
    .word 0xa+54
    .word 0xb+56
    .word 0x0 @ [r0]
    .word 0x00000001 @ eq_dup
    .word 0x10000000 @ 18
    .word 0xa+65
    .word 0xb+75
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1
    .word 0x10000000 @ 19
    .word 0xa+76
    .word 0xb+86
    .word 0x0 @ [r0]
    .word 0x00000001 @ p_minus_1_dup
    .word 0x10000000 @ 20
    .word 0xa+95
    .word 0xb+105
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1
    .word 0x10000000 @ 21
    .word 0xa+106
    .word 0xb+116
    .word 0x0 @ [r0]
    .word 0x00000001 @ q_minus_1_dup
    .word 0x10000000 @ 22
    .word 0xa+137
    .word 0xb+159
    .word 0x0 @ [r0]
    .word 0x00000001 @ ep
    .word 0x10000000 @ 23
    .word 0xa+160
    .word 0xb+182
    .word 0x0 @ [r0]
    .word 0x00000001 @ ep_dup
    .word 0x10000000 @ 24
    .word 0xa+203
    .word 0xb+225
    .word 0x0 @ [r0]
    .word 0x00000001 @ eq
    .word 0x10000000 @ 25
    .word 0xa+226
    .word 0xb+248
    .word 0x0 @ [r0]
    .word 0x00000001 @ eq_dup
    .word 0x10000000 @ 26
    .word 0xa+249
    .word 0xb+251
    .word 0x0 @ [r0]
    .word 0x00000001 @ c1
    .word 0x10000000 @ 27
    .word 0xa+252
    .word 0xb+254
    .word 0x0 @ [r0]
    .word 0x00000001 @ c1_dup
    .word 0x10000000 @ 28
    .word 0xa+255
    .word 0xb+257
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x10000000 @ 29
    .word 0xa+258
    .word 0xb+260
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1_dup
    .word 0x10000000 @ 30
    .word 0xa+261
    .word 0xb+263
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x10000000 @ 31
    .word 0xa+264
    .word 0xb+266
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1_dup
    .word 0x10000000 @ 32
    .word 0xa+271
    .word 0xb+275
    .word 0x0 @ [r0]
    .word 0x00000001 @ c1
    .word 0x10000000 @ 33
    .word 0xa+276
    .word 0xb+280
    .word 0x0 @ [r0]
    .word 0x00000001 @ c1_dup
    .word 0x10000000 @ 34
    .word 0xa+301
    .word 0xb+323
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x10000000 @ 35
    .word 0xa+324
    .word 0xb+346
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1_dup
    .word 0x10000000 @ 36
    .word 0xa+355
    .word 0xb+359
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x10000000 @ 37
    .word 0xa+360
    .word 0xb+364
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1_dup
    .word 0x10000000 @ 38
    .word 0xa+456
    .word 0xb+490
    .word 0x0 @ [r0]
    .word 0x00000001 @ c1
    .word 0x10000000 @ 39
    .word 0xa+491
    .word 0xb+525
    .word 0x0 @ [r0]
    .word 0x00000001 @ c1_dup
    .word 0x10000000 @ 40
    .word 0xa+538
    .word 0xb+548
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1
    .word 0x10000000 @ 41
    .word 0xa+549
    .word 0xb+559
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp1_dup
    .word 0x10000000 @ 42
    .word 0xa+588
    .word 0xb+622
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1
    .word 0x10000000 @ 43
    .word 0xa+623
    .word 0xb+657
    .word 0x0 @ [r0]
    .word 0x00000001 @ base1_dup
    .word 0x10000000 @ 44
    .word 0xa+664
    .word 0xb+666
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2
    .word 0x10000000 @ 45
    .word 0xa+667
    .word 0xb+669
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2_dup
    .word 0x10000000 @ 46
    .word 0xa+670
    .word 0xb+672
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 47
    .word 0xa+673
    .word 0xb+675
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 48
    .word 0xa+676
    .word 0xb+678
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 49
    .word 0xa+679
    .word 0xb+681
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 50
    .word 0xa+686
    .word 0xb+690
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2
    .word 0x10000000 @ 51
    .word 0xa+691
    .word 0xb+695
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2_dup
    .word 0x10000000 @ 52
    .word 0xa+716
    .word 0xb+738
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 53
    .word 0xa+739
    .word 0xb+761
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 54
    .word 0xa+770
    .word 0xb+774
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 55
    .word 0xa+775
    .word 0xb+779
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 56
    .word 0xa+871
    .word 0xb+905
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2
    .word 0x10000000 @ 57
    .word 0xa+906
    .word 0xb+940
    .word 0x0 @ [r0]
    .word 0x00000001 @ c2_dup
    .word 0x10000000 @ 58
    .word 0xa+953
    .word 0xb+963
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 59
    .word 0xa+964
    .word 0xb+974
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 60
    .word 0xa+1003
    .word 0xb+1037
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 61
    .word 0xa+1038
    .word 0xb+1072
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 62
    .word 0xa+1079
    .word 0xb+1081
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 63
    .word 0xa+1082
    .word 0xb+1084
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 64
    .word 0xa+1085
    .word 0xb+1087
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 65
    .word 0xa+1088
    .word 0xb+1090
    .word 0x0 @ [r0]
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 66
    .word 0xa+1091
    .word 0xb+1093
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 67
    .word 0xa+1094
    .word 0xb+1096
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 68
    .word 0xa+1097
    .word 0xb+1099
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 69
    .word 0xa+1100
    .word 0xb+1102
    .word 0x0 @ [r0]
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 70
    .word 0xa+1103
    .word 0xb+1105
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 71
    .word 0xa+1106
    .word 0xb+1108
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 72
    .word 0xa+1109
    .word 0xb+1111
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x10000000 @ 73
    .word 0xa+1112
    .word 0xb+1114
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient_dup
    .word 0x10000000 @ 74
    .word 0xa+1115
    .word 0xb+1117
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 75
    .word 0xa+1118
    .word 0xb+1120
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 76
    .word 0xa+1125
    .word 0xb+1129
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 77
    .word 0xa+1130
    .word 0xb+1134
    .word 0x0 @ [r0]
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 78
    .word 0xa+1139
    .word 0xb+1143
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 79
    .word 0xa+1144
    .word 0xb+1148
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 80
    .word 0xa+1157
    .word 0xb+1161
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 81
    .word 0xa+1162
    .word 0xb+1166
    .word 0x0 @ [r0]
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 82
    .word 0xa+1175
    .word 0xb+1179
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 83
    .word 0xa+1180
    .word 0xb+1184
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 84
    .word 0xa+1219
    .word 0xb+1229
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x10000000 @ 85
    .word 0xa+1230
    .word 0xb+1240
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient_dup
    .word 0x10000000 @ 86
    .word 0xa+1257
    .word 0xb+1273
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 87
    .word 0xa+1274
    .word 0xb+1290
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 88
    .word 0xa+1299
    .word 0xb+1303
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 89
    .word 0xa+1304
    .word 0xb+1308
    .word 0x0 @ [r0]
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 90
    .word 0xa+1317
    .word 0xb+1321
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 91
    .word 0xa+1322
    .word 0xb+1326
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 92
    .word 0xa+1343
    .word 0xb+1359
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 93
    .word 0xa+1360
    .word 0xb+1376
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 94
    .word 0xa+1385
    .word 0xb+1389
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 95
    .word 0xa+1390
    .word 0xb+1394
    .word 0x0 @ [r0]
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 96
    .word 0xa+1403
    .word 0xb+1407
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 97
    .word 0xa+1408
    .word 0xb+1412
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 98
    .word 0xa+1450
    .word 0xb+1460
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 99
    .word 0xa+1461
    .word 0xb+1471
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 100
    .word 0xa+1482
    .word 0xb+1486
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 101
    .word 0xa+1487
    .word 0xb+1491
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 102
    .word 0xa+1494
    .word 0xb+1496
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 103
    .word 0xa+1497
    .word 0xb+1499
    .word 0x0 @ [r0]
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 104
    .word 0xa+1500
    .word 0xb+1502
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x10000000 @ 105
    .word 0xa+1503
    .word 0xb+1505
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff_dup
    .word 0x10000000 @ 106
    .word 0xa+1518
    .word 0xb+1528
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x10000000 @ 107
    .word 0xa+1529
    .word 0xb+1539
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff_dup
    .word 0x10000000 @ 108
    .word 0xa+1568
    .word 0xb+1602
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 109
    .word 0xa+1603
    .word 0xb+1637
    .word 0x0 @ [r0]
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 110
    .word 0xa+1669
    .word 0xb+1679
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 111
    .word 0xa+1680
    .word 0xb+1690
    .word 0x0 @ [r0]
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 112
    .word 0xa+1695
    .word 0xb+1697
    .word 0x0 @ [r0]
    .word 0x00000001 @ c
    .word 0x10000000 @ 113
    .word 0xa+1698
    .word 0xb+1700
    .word 0x0 @ [r0]
    .word 0x00000001 @ c_dup
    .word 0x10000000 @ 114
    .word 0xa+1717
    .word 0xb+1733
    .word 0x0 @ [r0]
    .word 0x00000001 @ c
    .word 0x10000000 @ 115
    .word 0xa+1734
    .word 0xb+1750
    .word 0x0 @ [r0]
    .word 0x00000001 @ c_dup
