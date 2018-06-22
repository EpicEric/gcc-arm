    .text
    .globl main
main:
    BL  func1
    B main
func1:  /* Inicializa os valores no stack - Push*/
    ADR r0, dados
    LDMIA r0!, {r1-r3}
    STMFD r13!, {r1-r3, r14}
    MOV r1, #0
    MOV r2, #0
    MOV r3, #0
    BL  func2
func2: /* Remove os valores do stack - Pop */
    LDMFD r13!, {r1-r3, r14}
    MLA r4, r1, r2, r3
    MOV pc, lr
dados:
.word   0x1, 0x2, 0x3
