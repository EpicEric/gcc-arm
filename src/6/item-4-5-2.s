  .text
  .globl main
main:
  ADR r2, array
  LDR r1, =0x9F
  BL  pos_indexado
  LDR r0, =0xb
  STR r0, [r2]
  ADR r2, array
  LDR r0, =0
  BL  pre_indexado
  MOV r2, #0x18
  LDR r0, =0x20026
  SWI 0x123456
array:
  .word 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa
  .word 0xb, 0xc, 0xd, 0xe, 0xf, 0x10, 0x11, 0x12, 0x13, 0x14
  .word 0x15, 0x16, 0x17, 0x18, 0x19
pos_indexado:
  LDR r3, [r2], #20
  LDR r3, [r2], #20
  ADD r0, r3, r1      /* array[5] + y */
  STR r0, [r2]        /* array[10] = array[5] + y */
  MOV pc, lr
pre_indexado:
  LDR r3, [r2, #20]
  ADD r0, r3, r1      /* array[5] + y */
  STR r0, [r2, #40]   /* array[10] = array[5] + y */
  MOV pc, lr
