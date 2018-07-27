  .text
  .globl main
main:
  LDR r1, =0xB6000001         /* X */
  LDR r2, =0                  /* Z */
  LDR r8, =11                 /* Y */
  LDR r9, =4                  /* tamY(tamanho de Y em bits) */
  BL  compara
termina:
  MOV r2, #0x18
  LDR r0, =0x20026
  SWI 0x123456
compara:
  LDR r3, =0                  /* offset */
loop:
  ADD r4, r3, r9
  CMP r4, #32
  MOVGT pc, lr                /* fim: tamY + offset > 32(tamanho max) */
  MOV r4, r1, LSL r3
  RSB r5, r9, #32
  CMP r8, r4, LSR r5
  BNE ajusta
  MOV r6, #1
  SUB r5, r5, r3
  ADD r2, r2, r6, LSL r5
ajusta:
  ADD r3, r3, #1
  B   loop
