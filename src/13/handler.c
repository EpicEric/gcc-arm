#include "c_entry.c"

volatile unsigned int * const TIMER0X = (unsigned int *)0x101E200c;

void print_handler() {
  *TIMER0X = (unsigned int)(0);
  bla();
}
