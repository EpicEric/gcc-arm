	.file	"imprime.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\000"
	.global	mensagem
	.data
	.align	2
	.type	mensagem, %object
	.size	mensagem, 4
mensagem:
	.word	.LC0
	.text
	.align	2
	.global	imprime
	.type	imprime, %function
imprime:
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	str	r0, [fp, #-16]
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	str	r0, [fp, #-16]
	ldr	r3, referencia
	ldr	r0, [r3, #0]
	ldr	r1, [fp, #-16]
	bl	printf
	ldmfd	sp, {r3, fp, sp, pc}
	referencia: .word mensagem
	
	ldmfd	sp, {r3, fp, sp, pc}
	.size	imprime, .-imprime
	.ident	"GCC: (GNU) 3.4.3"
