  .text
  .globl main
main:
  LDR r3, =0        /* i = 0 */
  LDR r2, =40       /* s = 10 */
  ADR r1, array   /* r1 recebe inicio do array a */
loop:
  LDR r5, =0        /* r5 = 0 */
  STR r5, [r1, r3]  /* a[i] = 0 */
  ADD r3, r3, #4    /* i++ */
  CMP r3, r2        /* i <= 10? */
  BLT loop          /* loop */
  SWI 0x123456
array:
  .word 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa
