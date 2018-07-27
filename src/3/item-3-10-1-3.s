        .text
        .globl main
main:   
        LDR     r0, =0x67654321
        LDR     r1, =0x23110000
        BL      firstfunc
        MOV     r0, #0x18
        LDR     r1, =0x20026
        SWI     0x123456
firstfunc:
        ADDS    r0, r0, r1
        MOV     pc, lr