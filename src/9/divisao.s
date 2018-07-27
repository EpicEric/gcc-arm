
	.text
	.globl main
main:
	LDR		r1, =9345404				/* dividendo */
	LDR		r2, =2							/* divisor */
	BL		divide
termina:
	LDR		r1, =0x20026
	SWI		0x123456

divide:
	LDR		r3, =0					/* resultado */
	MOV		r4, r2					/* divisor atual */
	LDR		r5, =0
alinha_divisor:
	CMP		r4, r1
	BGE		loop_divisao
	MOV		r4, r4, LSL #1
	ADD		r5, r5, #1
	B			alinha_divisor
loop_divisao:
	CMP		r4, r1
	BGT		divisor_maior
	SUB		r1, r1, r4
	MOV		r3, r3, LSL #1
	ADD		r3, r3, #1
	B			ajusta_divisor
divisor_maior:
	MOV		r3, r3, LSL #1
ajusta_divisor:
	CMP		r1, r2
	MOVGE	r4, r4, LSR #1
	SUBGE	r5, r5, #1
	BGE		loop_divisao
fim_divisao:
	MOV		r3, r3, LSL r5
	MOV		r5, r1
	MOV 	pc, lr

