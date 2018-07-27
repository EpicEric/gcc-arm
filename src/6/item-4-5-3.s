  .text
  .globl main
main:
  LDR r4, =4        /* c = 4 */
  LDR r3, =0        /* i = 0 */
  ADR r2, array_b   /* r2 recebe inicio do array b */
  ADR r1, array_a   /* r1 recebe inicio do array a */
loop:
  LDR r5, [r2, r3]  /* r5 = b[i] */
  ADD r5, r5, r4    /* r5 = b[i] + c */
  STR r5, [r1, r3]  /* a[i] = b[i] + c */
  ADD r3, r3, #4    /* i++ */
  CMP r3, #40       /* i <= 10? */
  BLT loop          /* loop */
  SWI 0x123456
array_b:
  .word 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa
array_a:
  .word 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
