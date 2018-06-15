  .text
  .globl main
main:
  LDR r3, =0          /* i */
  ADR r2, array_b
  ADR r1, array_a
  BL  for
termina:
  MOV r2, #0x18
  LDR r0, =0x20026
  SWI 0x123456
array_b:
  .word 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8
array_a:
  .word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
for:
  RSB r4, r3, #28      /* 7 - i */
  LDR r5, [r2, r4]
  STR r5, [r1, r3]
  ADD r3, r3, #4       /* i++ */
  CMP r3, #32
  BLT for
  MOV pc, lr
