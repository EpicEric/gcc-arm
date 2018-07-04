	.text
	.globl main
main:
	LDR	r0, =0x3ff5000
	LDR	r1, =0xf0
	STR	r1, [r0]	/* seta os LEDs como output e os DIP Switches como input */
leDIP:
	LDR	r0, =0x3ff5008	/* r0 = ponteiro para o IOPDATA */
	LDR	r1, [r0]	/* r1 = conteudo de IOPDATA */
	AND	r2, r1, #0xF	/* r2 = DIP[3:0] */
	MOV	r3, r2, LSL #4
	STR	r3, [r0]
	B	leDIP
