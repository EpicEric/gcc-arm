  .text
  .globl main
main:
  LDR   r9, =9345404
  ADR   r0, vetor_valor_final
  BL    converte_base
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456

vetor_valor_final:
  .space 120

converte_base:
  STMFD sp!, {lr}
  MOV   r7, r9
  LDR   r6, =0
loop_converte_base:
  CMP   r7, #13
  BLT   fim_converte_base
  MOV   r1, r7
  MOV   r2, #13
  BL    divide
  MOV   r7, r3
  BL    desloca_valores
  ADD   r6, r6, #1
  B     loop_converte_base
fim_converte_base:
  MOV   r5, r7
  BL    desloca_valores
  LDMFD sp!, {lr}
  MOV   pc, lr

desloca_valores:
  MOV   r8, r6
  MOV   r2, r0
loop_desloca_valores:
  SUBS  r8, r8, #1
  BLT   fim_desloca_valores
  LDR   r1, [r2, #-4]
  STR   r1, [r2]
  SUB   r2, r2, #4
  B     loop_desloca_valores
fim_desloca_valores:
  STR   r5, [r2]
  ADD   r0, r0, #4
  MOV   pc, lr

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
