    .text
    .globl main
main:
    LDR r0, =0
    LDR r1, =1
    LDR r3, =0x4000
    LDR r4, =0x400C
    STRB r0, [r3], #0x0001
    STRB r1, [r3], #0x0001
    BL loop
    MOV r2, #0x18
    LDR r0, =0x20026
    SWI 0x123456
loop:
    ADD r2, r1, r0
    STRB r2, [r3], #0x0001
    MOV r0, r1
    MOV r1, r2
    CMP r3, r4
    BNE loop
    MOV pc, lr
