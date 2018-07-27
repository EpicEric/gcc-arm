  .text
  .globl main
main:
  BL    bubble_sort
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456
lista:
  .byte 0x7, 0x3, 0xFA, 0x54, 0x67, 0xD9, 0xA0, 0x1
bubble_sort:
  ADR   r0, lista
  LDRB  r2, [r0], #1
  SUB   r2, r2, #1
reordena:
  LDR   r1, =0
  LDR   r3, =0
loop:
  LDRB  r4, [r0, r3]
  ADD   r5, r3, #1
  LDRB  r6, [r0, r5]
  CMP   r4, r6
  BLE   continua
  STRB  r4, [r0, r5]
  STRB  r6, [r0, r3]
continua:
  MOVGT r1, #1
  MOV   r3, r5
  CMP   r3, r2
  BLT   loop
  CMP   r1, #1
  BEQ   reordena
  MOV   pc, lr
