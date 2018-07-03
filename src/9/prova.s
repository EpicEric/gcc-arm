  .text
  .globl main
main:
  ADR   r9, nusp
  ADR   r0, S
  ADR   r7, nsec
  BL    codifica_sequencia
termina:
  MOV   r2, #0x18
  LDR   r0, =0x20026
  SWI   0x123456

nusp:
  .word 9345404
ndigitos:
  .word 0
nsec:
  .word 14
sequencia:
  .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
S:
  .space 100

codifica_sequencia:
  STMFD sp!, {lr}
  LDR   r6, [r7]
  LDR   r7, =0
  ADR   r10, sequencia
loop_nsec:
  SUBS  r6, r6, #1
  BLT   fim_codifica_sequencia
  LDR   r1, [r9]
loop_ndigitos:
  LDR   r2, =10
  BL    divide
  BL    putS
  CMP   r3, #0
  BEQ   loop_nsec
continua_loop_normal:
  MOV   r1, r3
  SUBS  r6, r6, #1
  BGE   loop_ndigitos
fim_codifica_sequencia:
  LDMFD sp!, {lr}
  MOV   pc, lr

putS:
  LDR   r1, [r10], #4
  UMULL r2, r12, r5, r1
  MOV   r8, r2
  LDR   r2, =10
  UMULL r1, r12, r7, r2
  ADD   r8, r8, r1
  STR   r8, [r0], #4
  LDR   r7, [r0, #-4]
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
