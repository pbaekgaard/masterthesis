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
    mov r0, #2753
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2753
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2790
    str r0, [sp]
    sub sp, sp, #4
    mov r0, #2790
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
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #4]
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
    cmp r9, #15
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #28]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #28]
    add r9, r9, #1
    cmp r9, #16
    bne countermeasure
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    mov r0, #1
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #17
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    mov r0, #1
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #18
    bne countermeasure
    mov r0, #1
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #19
    bne countermeasure
    b endif_2
else_2:
endif_2:
    mov r9, #19
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
    cmp r9, #20
    bne countermeasure
    mov r0, #1
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #21
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
    ldr r0, [sp, #116]
    ldr r1, [sp, #112]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #116]
    ldr r1, [sp, #112]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #22
    bne countermeasure
    ldr r0, [sp, #88]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #92]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #120]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #120]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #23
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #60]
    ldr r1, [sp, #56]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #60]
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #24
    bne countermeasure
    ldr r0, [sp, #56]
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #25
    bne countermeasure
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    cmp r1, r0
    bne countermeasure
while_3:
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
    beq end_while_3
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
    beq else_4
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
    ldr r0, [sp, #116]
    ldr r1, [sp, #112]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #116]
    ldr r1, [sp, #112]
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
    ldr r0, [sp, #124]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
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
    ldr r0, [sp, #120]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #120]
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
    b endif_4
else_4:
endif_4:
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
    ldr r0, [sp, #116]
    ldr r1, [sp, #112]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #116]
    ldr r1, [sp, #112]
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
    ldr r0, [sp, #124]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #124]
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
    ldr r0, [sp, #120]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #120]
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
    b while_3
end_while_3:
    mov r9, #25
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
    cmp r9, #26
    bne countermeasure
    mov r0, #0
    str r0, [sp, #40]
    add r9, r9, #1
    cmp r9, #27
    bne countermeasure
    ldr r0, [sp, #36]
    ldr r1, [sp, #32]
    cmp r1, r0
    bne countermeasure
    mov r0, #1
    str r0, [sp, #36]
    add r9, r9, #1
    cmp r9, #28
    bne countermeasure
    mov r0, #1
    str r0, [sp, #32]
    add r9, r9, #1
    cmp r9, #29
    bne countermeasure
    ldr r0, [sp, #28]
    ldr r1, [sp, #24]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #180]
    ldr r1, [sp, #176]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #180]
    str r0, [sp, #28]
    add r9, r9, #1
    cmp r9, #30
    bne countermeasure
    ldr r0, [sp, #176]
    str r0, [sp, #24]
    add r9, r9, #1
    cmp r9, #31
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #172]
    ldr r1, [sp, #168]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #172]
    str r0, [sp, #20]
    add r9, r9, #1
    cmp r9, #32
    bne countermeasure
    ldr r0, [sp, #168]
    str r0, [sp, #16]
    add r9, r9, #1
    cmp r9, #33
    bne countermeasure
    ldr r0, [sp, #20]
    ldr r1, [sp, #16]
    cmp r1, r0
    bne countermeasure
while_5:
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
    beq end_while_5
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
    b while_5
end_while_5:
    mov r9, #33
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
    beq else_6
    add r9, r9, #1
    cmp r9, #34
    bne countermeasure
    ldr r0, [sp, #52]
    ldr r1, [sp, #48]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    ldr r1, [sp, #40]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #180]
    ldr r1, [sp, #176]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #44]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #184]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #52]
    add r9, r9, #1
    cmp r9, #35
    bne countermeasure
    ldr r0, [sp, #40]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #180]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #36
    bne countermeasure
    b endif_6
else_6:
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
    cmp r9, #34
    bne countermeasure
    ldr r0, [sp, #40]
    str r0, [sp, #48]
    add r9, r9, #1
    cmp r9, #35
    bne countermeasure
    mov r9, #36
endif_6:
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
    ldr r0, [sp, #124]
    ldr r1, [sp, #120]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #92]
    ldr r1, [sp, #88]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #124]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #96]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #37
    bne countermeasure
    ldr r0, [sp, #120]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #92]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #38
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
    ldr r0, [sp, #196]
    ldr r1, [sp, #192]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #196]
    ldr r1, [sp, #192]
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
    ldr r0, [sp, #204]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #204]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #39
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
    ldr r0, [sp, #200]
    ldr r1, [sp, #0]
    add sp, sp, #4
    sdiv r0, r1, r0
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #200]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    sub r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #40
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
    beq else_7
    add r9, r9, #1
    cmp r9, #41
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    ldr r1, [sp, #8]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #196]
    ldr r1, [sp, #192]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #12]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #200]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #12]
    add r9, r9, #1
    cmp r9, #42
    bne countermeasure
    ldr r0, [sp, #8]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #196]
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #8]
    add r9, r9, #1
    cmp r9, #43
    bne countermeasure
    b endif_7
else_7:
endif_7:
    mov r9, #43
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
    ldr r0, [sp, #196]
    ldr r1, [sp, #192]
    cmp r1, r0
    bne countermeasure
    ldr r0, [sp, #100]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #24]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #204]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp, #4]
    add r9, r9, #1
    cmp r9, #44
    bne countermeasure
    ldr r0, [sp, #96]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #20]
    sub sp, sp, #4
    str r0, [sp, #0]
    ldr r0, [sp, #200]
    ldr r1, [sp, #0]
    add sp, sp, #4
    mul r0, r1, r0
    ldr r1, [sp, #0]
    add sp, sp, #4
    add r0, r1, r0
    str r0, [sp]
    add r9, r9, #1
    cmp r9, #45
    bne countermeasure
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
    .word 0x00000001 @ d
    .word 0x10000000 @ 7
    .word 0xa+24
    .word 0xb+26
    .word 0x0 @ [r0]
    .word 0x00000001 @ d_dup
    .word 0x10000000 @ 8
    .word 0xa+27
    .word 0xb+29
    .word 0x0 @ [r0]
    .word 0x00000001 @ c
    .word 0x10000000 @ 9
    .word 0xa+30
    .word 0xb+32
    .word 0x0 @ [r0]
    .word 0x00000001 @ c_dup
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
    .word 0x00000001 @ dp
    .word 0x10000000 @ 15
    .word 0xa+48
    .word 0xb+50
    .word 0x0 @ [r0]
    .word 0x00000001 @ dp_dup
    .word 0x10000000 @ 16
    .word 0xa+51
    .word 0xb+53
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq
    .word 0x10000000 @ 17
    .word 0xa+54
    .word 0xb+56
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq_dup
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
    .word 0x00000001 @ dp
    .word 0x10000000 @ 23
    .word 0xa+160
    .word 0xb+182
    .word 0x0 @ [r0]
    .word 0x00000001 @ dp_dup
    .word 0x10000000 @ 24
    .word 0xa+203
    .word 0xb+225
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq
    .word 0x10000000 @ 25
    .word 0xa+226
    .word 0xb+248
    .word 0x0 @ [r0]
    .word 0x00000001 @ dq_dup
    .word 0x10000000 @ 26
    .word 0xa+249
    .word 0xb+251
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x10000000 @ 27
    .word 0xa+252
    .word 0xb+254
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1_dup
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
    .word 0x00000001 @ m1
    .word 0x10000000 @ 33
    .word 0xa+276
    .word 0xb+280
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1_dup
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
    .word 0x00000001 @ m1
    .word 0x10000000 @ 39
    .word 0xa+491
    .word 0xb+525
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1_dup
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
    .word 0x00000001 @ fault_triggered
    .word 0x10000000 @ 45
    .word 0xa+667
    .word 0xb+669
    .word 0x0 @ [r0]
    .word 0x00000001 @ fault_triggered_dup
    .word 0x10000000 @ 46
    .word 0xa+697
    .word 0xb+707
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1
    .word 0x10000000 @ 47
    .word 0xa+708
    .word 0xb+718
    .word 0x0 @ [r0]
    .word 0x00000001 @ m1_dup
    .word 0x10000000 @ 48
    .word 0xa+723
    .word 0xb+727
    .word 0x0 @ [r0]
    .word 0x00000001 @ fault_triggered
    .word 0x10000000 @ 49
    .word 0xa+728
    .word 0xb+732
    .word 0x0 @ [r0]
    .word 0x00000001 @ fault_triggered_dup
    .word 0x10000000 @ 50
    .word 0xa+737
    .word 0xb+739
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x10000000 @ 51
    .word 0xa+740
    .word 0xb+742
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2_dup
    .word 0x10000000 @ 52
    .word 0xa+743
    .word 0xb+745
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 53
    .word 0xa+746
    .word 0xb+748
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 54
    .word 0xa+749
    .word 0xb+751
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 55
    .word 0xa+752
    .word 0xb+754
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 56
    .word 0xa+759
    .word 0xb+763
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x10000000 @ 57
    .word 0xa+764
    .word 0xb+768
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2_dup
    .word 0x10000000 @ 58
    .word 0xa+789
    .word 0xb+811
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 59
    .word 0xa+812
    .word 0xb+834
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 60
    .word 0xa+843
    .word 0xb+847
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 61
    .word 0xa+848
    .word 0xb+852
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 62
    .word 0xa+944
    .word 0xb+978
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2
    .word 0x10000000 @ 63
    .word 0xa+979
    .word 0xb+1013
    .word 0x0 @ [r0]
    .word 0x00000001 @ m2_dup
    .word 0x10000000 @ 64
    .word 0xa+1026
    .word 0xb+1036
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2
    .word 0x10000000 @ 65
    .word 0xa+1037
    .word 0xb+1047
    .word 0x0 @ [r0]
    .word 0x00000001 @ exp2_dup
    .word 0x10000000 @ 66
    .word 0xa+1076
    .word 0xb+1110
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2
    .word 0x10000000 @ 67
    .word 0xa+1111
    .word 0xb+1145
    .word 0x0 @ [r0]
    .word 0x00000001 @ base2_dup
    .word 0x10000000 @ 68
    .word 0xa+1152
    .word 0xb+1154
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 69
    .word 0xa+1155
    .word 0xb+1157
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 70
    .word 0xa+1158
    .word 0xb+1160
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 71
    .word 0xa+1161
    .word 0xb+1163
    .word 0x0 @ [r0]
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 72
    .word 0xa+1164
    .word 0xb+1166
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 73
    .word 0xa+1167
    .word 0xb+1169
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 74
    .word 0xa+1170
    .word 0xb+1172
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 75
    .word 0xa+1173
    .word 0xb+1175
    .word 0x0 @ [r0]
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 76
    .word 0xa+1176
    .word 0xb+1178
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 77
    .word 0xa+1179
    .word 0xb+1181
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 78
    .word 0xa+1182
    .word 0xb+1184
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x10000000 @ 79
    .word 0xa+1185
    .word 0xb+1187
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient_dup
    .word 0x10000000 @ 80
    .word 0xa+1188
    .word 0xb+1190
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 81
    .word 0xa+1191
    .word 0xb+1193
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 82
    .word 0xa+1198
    .word 0xb+1202
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 83
    .word 0xa+1203
    .word 0xb+1207
    .word 0x0 @ [r0]
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 84
    .word 0xa+1212
    .word 0xb+1216
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 85
    .word 0xa+1217
    .word 0xb+1221
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 86
    .word 0xa+1230
    .word 0xb+1234
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 87
    .word 0xa+1235
    .word 0xb+1239
    .word 0x0 @ [r0]
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 88
    .word 0xa+1248
    .word 0xb+1252
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 89
    .word 0xa+1253
    .word 0xb+1257
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 90
    .word 0xa+1292
    .word 0xb+1302
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient
    .word 0x10000000 @ 91
    .word 0xa+1303
    .word 0xb+1313
    .word 0x0 @ [r0]
    .word 0x00000001 @ quotient_dup
    .word 0x10000000 @ 92
    .word 0xa+1330
    .word 0xb+1346
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 93
    .word 0xa+1347
    .word 0xb+1363
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 94
    .word 0xa+1372
    .word 0xb+1376
    .word 0x0 @ [r0]
    .word 0x00000001 @ t
    .word 0x10000000 @ 95
    .word 0xa+1377
    .word 0xb+1381
    .word 0x0 @ [r0]
    .word 0x00000001 @ t_dup
    .word 0x10000000 @ 96
    .word 0xa+1390
    .word 0xb+1394
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt
    .word 0x10000000 @ 97
    .word 0xa+1395
    .word 0xb+1399
    .word 0x0 @ [r0]
    .word 0x00000001 @ newt_dup
    .word 0x10000000 @ 98
    .word 0xa+1416
    .word 0xb+1432
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp
    .word 0x10000000 @ 99
    .word 0xa+1433
    .word 0xb+1449
    .word 0x0 @ [r0]
    .word 0x00000001 @ tmp_dup
    .word 0x10000000 @ 100
    .word 0xa+1458
    .word 0xb+1462
    .word 0x0 @ [r0]
    .word 0x00000001 @ r
    .word 0x10000000 @ 101
    .word 0xa+1463
    .word 0xb+1467
    .word 0x0 @ [r0]
    .word 0x00000001 @ r_dup
    .word 0x10000000 @ 102
    .word 0xa+1476
    .word 0xb+1480
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr
    .word 0x10000000 @ 103
    .word 0xa+1481
    .word 0xb+1485
    .word 0x0 @ [r0]
    .word 0x00000001 @ newr_dup
    .word 0x10000000 @ 104
    .word 0xa+1523
    .word 0xb+1533
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 105
    .word 0xa+1534
    .word 0xb+1544
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 106
    .word 0xa+1555
    .word 0xb+1559
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv
    .word 0x10000000 @ 107
    .word 0xa+1560
    .word 0xb+1564
    .word 0x0 @ [r0]
    .word 0x00000001 @ qinv_dup
    .word 0x10000000 @ 108
    .word 0xa+1567
    .word 0xb+1569
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 109
    .word 0xa+1570
    .word 0xb+1572
    .word 0x0 @ [r0]
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 110
    .word 0xa+1573
    .word 0xb+1575
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x10000000 @ 111
    .word 0xa+1576
    .word 0xb+1578
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff_dup
    .word 0x10000000 @ 112
    .word 0xa+1591
    .word 0xb+1601
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff
    .word 0x10000000 @ 113
    .word 0xa+1602
    .word 0xb+1612
    .word 0x0 @ [r0]
    .word 0x00000001 @ diff_dup
    .word 0x10000000 @ 114
    .word 0xa+1641
    .word 0xb+1675
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 115
    .word 0xa+1676
    .word 0xb+1710
    .word 0x0 @ [r0]
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 116
    .word 0xa+1742
    .word 0xb+1752
    .word 0x0 @ [r0]
    .word 0x00000001 @ h
    .word 0x10000000 @ 117
    .word 0xa+1753
    .word 0xb+1763
    .word 0x0 @ [r0]
    .word 0x00000001 @ h_dup
    .word 0x10000000 @ 118
    .word 0xa+1768
    .word 0xb+1770
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
    .word 0x10000000 @ 119
    .word 0xa+1771
    .word 0xb+1773
    .word 0x0 @ [r0]
    .word 0x00000001 @ m_dup
    .word 0x10000000 @ 120
    .word 0xa+1790
    .word 0xb+1806
    .word 0x0 @ [r0]
    .word 0x00000001 @ m
    .word 0x10000000 @ 121
    .word 0xa+1807
    .word 0xb+1823
    .word 0x0 @ [r0]
    .word 0x00000001 @ m_dup
