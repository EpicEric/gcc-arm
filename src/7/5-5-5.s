  .text
  .globl main
main:
  LDR   r0, =11           /* Valor a ser inspecionado */
  LDR   r1, =0            /* Resultado */
  BL    parity_checker
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456
parity_checker:
  LDR   r2, =0
loop:
  MOVS  r0, r0, LSR #1
  ADDCS r1, r1, #1
  ADD   r2, r2, #1
  CMP   r2, #32
  BLE   loop
  AND   r1, r1, #1        /* Retorna 1 se for impar */
  MOV   pc, lr
