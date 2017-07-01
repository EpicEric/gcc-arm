	.text
	.globl	main
main:
	MOV	r0, #15
	MOV	r1, #20
	BL	firstfunc
	MOV	r0, #0x18
	LDR	r1, =0x20026
	SWI	0x0
firstfunc:
	ADD	r0, r0, r1
	MOV	pc, lr
