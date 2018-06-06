        .text
        .globl main
main:   
        LDR     r0, =0xFFFF0000
        LDR     r1, =0x87654321
        BL      firstfunc
        MOV     r0, #0x18
        LDR     r1, =0x20026
        SWI     0x123456
firstfunc:
        ADDS    r0, r0, r1
        MOV     pc, lr