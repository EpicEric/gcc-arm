    .text
    .globl main
main:
    BL func1
    MLA r1, r2, r3, r4
    B main
func1:
    LDR r2, =0x2 /* load b */
    LDR r3, =0x3 /* load c */
    LDR r4, =0x4 /* load d */
    MOV pc, lr
