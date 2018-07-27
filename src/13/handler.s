handler_timer:
  ldr   r0, TIMER0X
  mov   r1, #0x0
  str   r1, [r0]    @Escreve no registrador TIMER0X para limpar o pedido de interrupcao
  @Inserir codigo que sera executado na interrupcao de timer aqui
  @(chaveamento de processos ou alternar LED, por exemplo)
  mov   pc, lr
