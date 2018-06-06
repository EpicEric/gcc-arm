	.text
	.globl main
main:
	LDR r1, =0x0000001E
	LDR r2, =0x0
	BIC r2, r1, #0x000000C0
	MOV r2, r2, LSL #14
	BIC r0, r1, #0x000000C0
	MOV r0, r0, LSR #6
	ADD r0, r0, #0x00000004
	ADD r2, r2, r0
	BIC r0, r1, #0x00000030
	MOV r0, r0, LSL #13
	ADD r2, r2, r0
	BIC r0, r1, #0x00000030
	MOV r0, r0, LSR #1
	ADD r0, r0, #0x00000020
	ADD r2, r2, r0
	BIC r0, r1, #0x0000000C
	MOV r0, r0, LSL #12
	ADD r2, r2, r0
	BIC r0, r1, #0x00000003
	MOV r0, r0, LSL #11
	ADD r2, r2, r0
