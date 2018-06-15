  .text
  .globl main
main:
  LDR   r0, =10
  LDR   r1, =0
  LDR   r2, =0
  BL    loop
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456
loop:
  MOVS  r0, r0, LSR #1
  ADDCS r1, r1, #1
  ADD   r2, r2, #1
  CMP   r2, #32
  BLE   loop
  AND   r1, r1, #1
  MOV   pc, lr
