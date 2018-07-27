	.text
	.globl main
main:
  ADR   r9, valor_dip
  BL    dip_to_memory
termina:
	LDR		r1, =0x20026
	SWI		0x123456

valor_dip:
  .space 4

dip_to_memory:
	LDR	r0, =0x3ff5000
	LDR	r1, =0xf0
	STR	r1, [r0]
leDIP:
	LDR	r0, =0x3ff5008
	LDR	r1, [r0]
	AND	r2, r1, #0xF
	STR	r2, [r9]
	B	leDIP
  MOV pc, lr
