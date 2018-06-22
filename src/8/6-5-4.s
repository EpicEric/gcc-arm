  .text
  .globl main
main:
  LDR   r0, =2
  LDR   r1, =0xA000000B
  BL    push_data
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456

push_data:
  STR   lr, [sp, #-4]!
  CMP   r0, #1
  BLEQ  push_byte
  CMP   r0, #2
  BLEQ  push_half_word
  CMP   r0, #4
  BLEQ  push_word
  LDR   lr, [sp, #4]
  MOV   pc, lr

push_byte:
  STRB  r1, [sp, #-4]!
  MOV   pc, lr

push_half_word:
  STRH  r1, [sp, #-4]!
  MOV   pc, lr

push_word:
  STR   r1, [sp, #-4]!
  MOV   pc, lr
