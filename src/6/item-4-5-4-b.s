  .text
  .globl main
main:
  LDR r2, =8        /* s = 10 */
  ADR r1, array     /* r1 recebe inicio do array a */
  ADR r6, array+32
  ADR r3, array        /* p = &array[0] */
loop:
  LDR r5, =0        /* r5 = 0 */
  STR r5, [r3], #4  /* *p = 0 */
  CMP r3, r6
  BLT loop          /* loop */
  SWI 0x123456
array:
  .word 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8
