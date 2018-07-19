char *mensagem = "numero = %d\n";

void imprime(int numero) {
  __asm__(
    "mov	ip, sp\n\t"
	  "stmfd	sp!, {fp, ip, lr, pc}\n\t"
	  "sub	fp, ip, #4\n\t"
	  "sub	sp, sp, #4\n\t"
	  "str	r0, [fp, #-16]\n\t"
	  "ldr	r3, referencia\n\t"
	  "ldr	r0, [r3, #0]\n\t"
	  "ldr	r1, [fp, #-16]\n\t"
	  "bl	printf\n\t"
	  "ldmfd	sp, {r3, fp, sp, pc}\n\t"
    "referencia: .word mensagem\n\t"
  );
}
