.section INTERRUPT_VECTOR, "x"
.global _Reset
_Reset:
  B Reset_Handler /* Reset */
  B Undefined_Handler /* Undefined */
  B . /* SWI */
  B . /* Prefetch Abort */
  B . /* Data Abort */
  B . /* reserved */
  B . /* IRQ */
  B . /* FIQ */

Reset_Handler:
  LDR sp, =stack_top
  /* item 12.2.5 */
  MRS r0, cpsr
  MSR cpsr_ctl, #0b11011011
  LDR sp, =undefined_stack_top
  MSR cpsr, r0
  MRS r0, cpsr
  /* item 12.2.7 mudando para o modo usuario */
  MSR cpsr_ctl, #0b11010000
  MSR cpsr, r0
  BL c_entry
  .word 0xffffffff
  B .
Undefined_Handler:
  /* item  12.2.6 */
  STMFD sp!, {R0-R12, lr}
  BL  undefined
  LDMFD sp!, {R0-R12, pc}^
  B   .
