
	.text
	.globl main
main:
	LDR	r1, =0xF000000F
	BL	firstfunc
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x123456
firstfunc:
 	MOVS r0, r1, LSL #5
	MOV	pc, lr
