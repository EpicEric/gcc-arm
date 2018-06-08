    .text
    .globl main
main:
    LDR r3, =0
    LDR r4, =1
    LDR r1, =12
    CMP r1, #1          /* Caso n = 1 */
    MOVEQ r0, #1
    BEQ end
    CMP r1, #0          /* Caso n = 0 */
    MOVEQ r0, #0
    BEQ end
    BL loop
end:
    MOV r2, #0x18
    LDR r0, =0x20026
    SWI 0x123456
loop:
    ADD r0, r4, r3
    MOV r3, r4
    MOV r4, r0
    SUB r1, r1, #1
    CMP r1, #1
    BNE loop
    MOV pc, lr
