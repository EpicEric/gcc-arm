  .text
  .globl main
main:
  LDR   r9, =9345404
  ADR   r0, vetor_primos
  BL    trial_division
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456

vetor_primos:
  .space 120

trial_division:
  STMFD sp!, {lr}
  MOV   r7, r9
  LDR   r6, =2
loop_trial_division:
  CMP   r7, #1
  BLE   fim_trial_division
  MOV   r1, r7
  MOV   r2, r6
  BL    divide
  CMP   r5, #0
  STREQ r6, [r0], #4
  MOVEQ r7, r3
  ADDNE r6, r6, #1
  B     loop_trial_division
fim_trial_division:
  LDMFD sp!, {lr}
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
