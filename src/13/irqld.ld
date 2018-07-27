ENTRY(_start)
SECTIONS
{
  .
  = 0x0;
  .text : { * (.text); }
  . = ALIGN(8);
  . = . + 0x1000;
  stack_top = .;
  . = . + 0x1000;
  irq_stack_top = .;
}
