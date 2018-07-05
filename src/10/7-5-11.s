  .text
  .globl main
main:
  ADR   r9, display_numbers
  BL    dip_state_count
termina:
  LDR    r1, =0x20026
  SWI    0x123456

display_numbers:
  .word 0x5F, 0x06, 0x3B, 0x2F, 0x66, 0x6D, 0x7D, 0x87, 0x7F, 0x6F, 0x77, 0x7C, 0x59, 0x3E, 0x79, 0x71

dip_state_count:
  STMFD sp!, {lr}
  BL    setup
count_state_change:
  BL    delay
  BL    get_dip
  CMP   r3, r4
  BEQ   count_state_change
  MOV   r4, r3
  BL    set_display
  CMP   r9, r6
  BEQ   end_display_state_count
  B     count_state_change
end_display_state_count:
  LDMFD sp!, {lr}
  MOV   pc, lr

setup:
  STMFD sp!, {lr}
  LDR   r0, =0x3ff5000
  LDR   r1, =0x1fcf0
  STR   r1, [r0]
  LDR   r2, =0x3ff5008
  BL    get_dip
  MOV   r4, r3
  ADD   r6, r9, #64
  BL    set_display
  LDMFD sp!, {lr}
  MOV   pc, lr

get_dip:
  LDR   r3, [r2]
  AND   r3, r3, #0x8
  MOV   pc, lr

set_display:
  LDR   r8, [r9], #4
  MOV   r8, r8, LSL #10
  STR   r8, [r2]
  MOV   pc, lr

delay:
  LDR   r0, =0xFFFFF
loop_delay:
  SUBS  r0, r0, #1
  BNE   loop_delay
  MOV   pc, lr
