  .text
  .globl main
main:
  ADR   r0, magic_square
  LDR   r1, =4
  BL    test_magic_square
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456

magic_square:
  .word 0x10, 0x03, 0x02, 0x0D
  .word 0x05, 0x0A, 0x0B, 0x08
  .word 0x09, 0x06, 0x07, 0x0C
  .word 0x04, 0x0F, 0x0E, 0x01

test_magic_square:
  STMFD sp!, {lr}
  LDR   r9, =0
  BL    calculate_magic_number
  BL    test_row_column
  BL    test_diagonal
  LDMFD sp!, {lr}
  MOV   pc, lr

calculate_magic_number:
  MUL   r2, r1, r1
  ADD   r2, r2, #1
  MUL   r2, r1, r2
  MOV   r2, r2, LSR #1
  MOV   pc, lr

test_row_column:
  STMFD sp!, {lr}
  MOV   r3, r1
loop_row_column:
  SUBS  r3, r3, #1
  CMP   r3, #0
  BLT   return_test_row_column
  MOV   r4, #4
  MOV   r5, r3, LSL #2
  MUL   r5, r1, r5
  BL    n_sum
  CMP   r2, r6
  LDRNE r9, =1
  MOV   r4, r1, LSL #2
  MOV   r5, r3, LSL #2
  BL    n_sum
  CMP   r2, r6
  LDRNE r9, =1
  B     loop_row_column
return_test_row_column:
  LDMFD sp!, {lr}
  MOV   pc, lr


test_diagonal:
  STMFD sp!, {lr}
  ADD   r4, r1, #1
  MOV   r4, r4, LSL #2
  LDR   r5, =0
  BL    n_sum
  CMP   r2, r6
  LDRNE r9, =1
  SUB   r4, r1, #1
  MOV   r4, r4, LSL #2
  MOV   r5, r4
  BL    n_sum
  CMP   r2, r6
  LDRNE r9, =1
  LDMFD sp!, {lr}
  MOV   pc, lr

n_sum:
  ADD   r5, r0, r5
  LDR   r6, =0
  MOV   r8, r1
loop:
  SUBS  r8, r8, #1
  LDRPL r7, [r5], r4
  ADDPL r6, r6, r7
  BPL   loop
  MOV   pc, lr
