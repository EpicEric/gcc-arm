
	.text
	.globl main
main:
	LDR	r0, =0x7000003F
	BL	absolute
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x123456
absolute:
	MOV	r2, #0
	MOVS	r1, r0
	SUBMI	r1, r2, r1
	MOV	pc, lr
