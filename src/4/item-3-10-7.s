
	.text
	.globl main
main:
	LDR	r1, =100
	LDR	r2, =9
	MOV r5, r2
	MOV	r3, #0
	MOV	r4, #1
	CMP	r5, #0
	BNE	align_divisor
	LDR	r3, =0xFFFFFFFF
	LDR r5, =0xFFFFFFFF
	BAL	end
align_divisor:
	MOV	r5, r5, LSL #1
	CMP	r5, r1
	ADD	r4, r4, #1
	BLT	align_divisor
repeat:	/* Loop para o calculo da divisao */
	CMP	r1, r5
	BGE	subtract_shift
	MOV	r3, r3, LSL #1
	BAL	shift_compare
subtract_shift:	/* Caso a parte do dividendo sobre o divisor seja >= que o divisor */
	SUB	r1, r1, r5
	MOV r3, r3, LSL #1
	ADD	r3, r3, #1
shift_compare:	/* Shift no divisor para a esquerda e condicao de saida */
	MOV	r5, r5, LSR #1
	SUB	r4, r4, #1
	CMP	r1, r2
	BGE repeat
	MOV	r3, r3, LSL r4
	MOV	r5, r1
end:
	LDR	r1, =0x20026
	SWI	0x123456
