  .text
  .globl main
main:
  BL    factorial
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456
factorial:
  MOV   r6, #0xA
  MOV   r4, r6
loop:
  SUBS  r4, r4, #1
  MULNE r1, r6, r4
  MOVNE r6, r1
  BNE loop
  MOV pc, lr
