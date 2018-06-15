  .text
  .globl main
main:
  BL    factorial
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456
factorial:
  MOV   r6, #0xA        /* n */
  MOV   r4, r6
loop:
  SUBS  r4, r4, #1
  MULNE r1, r6, r4      /* (n x n - 1) */
  MOVNE r6, r1          /* resultado em r6 */
  BNE loop
  MOV pc, lr
