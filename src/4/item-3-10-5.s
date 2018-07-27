.text
.globl	main
main:
  LDR   r0, =0
  LDR   r1, =0
  LDR   r2, =-4
  LDR   r3, =-2
  MOVS  r2, r2
  ADDMI r1, r1, #1
  SUBMI r2, r0, r2
  MOVS  r3, r3
  SUBMI r1, r1, #1
  SUBMI r3, r0, r3
  UMULL r4, r5, r2, r3
  CMP   r1, #1
  SUBEQ r4, r0, r4
  SUBEQ r5, r0, r5
  SWI	0x123456
