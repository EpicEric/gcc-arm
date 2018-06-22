    .text
    .globl main
main:
    BL  func1
    LDMIA r0!, {r1-r3}
    MLA r4, r1, r2, r3
    B main
func1:
    ADR r0, dados
    MOV pc, lr
dados:
.word   0x1, 0x2, 0x3
