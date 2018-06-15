	.text
	.globl main
main:
	LDR r5, =12
	LDR r0, =dados 	/* coloca o endereco inicial da lista em r0 */
	LDR r1, =dados	/* coloca o endereco de saida em r1 */
	LDR r6, =0
loop:
	CMP r6, r5
	BEQ fim
	LDR r2, [r0, #4]!	/* carrega em r2 o valor atual na lista, contido no endereco de r0 */
	LDR r3, [r1]	/* carrega em r3 o maior valor atual, contido em r1 */
	ADD r6, r6, #1	/* incrementa o valor em r6 */
	CMP r2, r3	/* compara os dois valores */
	STRGT r2, [r1]	/* se r2 > r3, o valor de r2 eh salvo em 0x5000 */
	B loop
fim:	
	SWI 0x123456

dados:
.word 0x0, 0x13, 0x15, 0x123, 0x15, 0x16, 0x1, 0x10, 0x567, 0x123, 0x12, 0x31, 0x41
