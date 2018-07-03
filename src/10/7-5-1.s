	.text
	.globl main
main:
  LDR   r1, =0x3FF5000
  LDR   r2, =0x3FF5008
  BL    display_hex_digits
termina:
	LDR		r1, =0x20026
	SWI		0x123456

display_hex_digits:
  STMFD sp!, {lr}
  LDR   r3, =0xF0
  STR   r3, [r1]
loop_leds:
  LDR   r4, =0
loop_increment:
  ADD   r4, r4, #1
  MOV   r5, r4, LSL #4
  STR   r4, [r2]
  BL    delay
  CMP   r4, #15
  BNE   loop_increment
loop_decrement:
  MOV   r5, r4, LSL #4
  STR   r4, [r2]
  BL    delay
  SUBS  r4, r4, #1
  BNE   loop_decrement
  B     loop_leds
  LDMFD sp!, {lr}
  MOV   pc, lr

delay:
  LDR   r0, =0xFFFFF
loop_delay:
  SUBS  r0, r0, #1
  BNE   loop_delay
  MOV   pc, lr
