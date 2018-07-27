.global _start
.global handler_timer
.text
_start:
  b _Reset                        @posicao 0x00 - Reset
  ldr pc, _undefined_instruction  @posicao 0x04 - Instrucao nao-definida
  ldr pc, _software_interrupt     @posicao 0x08 - Interrupcao de Software
  ldr pc, _prefetch_abort         @posicao 0x0C - Prefetch Abort
  ldr pc, _data_abort             @posicao 0x10 - Data Abort
  ldr pc, _not_used               @posicao 0x14 - Nao Utilizado
  ldr pc, _irq                    @posicao 0x18 - Interrupcao(IRQ)
  ldr pc, _fiq                    @posicao 0x1C - Interrupcao(FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq

INTPND:   .word 0x10140000 @Interrupt status register
INTSEL:   .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN:    .word 0x10140010 @interrupt enable register
TIMER0L:  .word 0x101E2000 @Timer 0 load register
TIMER0V:  .word 0x101E2004 @Timer 0 value registers
TIMER0C:  .word 0x101E2008 @timer 0 control register
TIMER0X:  .word 0x101E200c @timer 0 interrupt clear register

_Reset:
  ldr sp, =stack_top
  mrs r0, cpsr
  msr cpsr_ctl, #0b11010010
  ldr sp, =irq_stack_top
  msr cpsr, r0
  bl main
  b .

undefined_instruction:
  b .

software_interrupt:
  b do_software_interrupt @vai para o handler de interrupcoes de Software

prefetch_abort:
  b .

data_abort:
  b .

not_used:
  b .

irq:
  b do_irq_interrupt @vai para o handler de interrupcoes IRQ

fiq:
  b .

do_software_interrupt:  @Rotina de interrupcao de Software
  add r1, r2, r3        @r1 = r2 + r3
  mov pc, r14           @volta p/ o endereco armazenado em r14

do_irq_interrupt:
  sub   lr, lr, #4
  stmfd sp!, {r0-r3,lr} @Empilha os registradores
  ldr   r0, INTPND      @Carrega o registrador de status de interrupcao
  ldr   r0, [r0]
  tst   r0, #0x0010     @Verifica se é uma interrupcao de timer
  blne  handler_timer   @vai para a rotina de tratamento da interrupcao de timer
  ldmfd sp!,{r0-r3,pc}^

timer_init:
  LDR r0, INTEN
  LDR r1,=0x10      @bit 4 for timer 0 interrupt enable
  STR r1,[r0]
  LDR r0, TIMER0L
  LDR r1, =0xff @setting timer value
  STR r1,[r0]
  LDR r0, TIMER0C
  MOV r1, #0xE0     @enable timer module
  STR r1, [r0]
  mrs r0, cpsr
  bic r0,r0,#0x80
  msr cpsr_c,r0     @enabling interrupts in the cpsr
  mov pc, lr

main:
  bl timer_init   @Initialize interrupts and timer 0
  bl c_entry
stop:
  b stop
