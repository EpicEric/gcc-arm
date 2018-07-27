
	.text
	.globl main
main:
	LDR	r0, =0x0000003F
	LDR	r1, =0x12341
	BL	shift
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x123456
shift:
	ADDS	r2, r0, r0
	ADC	r3, r1, r1
	MOV	pc, lr
