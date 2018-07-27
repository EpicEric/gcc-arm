volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000;

void print_uart0(const char *s) {
	 while(*s != '\0') { /* Loop until end of string */
		  *UART0DR = (unsigned int)(*s); /* Transmit char */
		   s++; /* Next char */
		    }
}

void c_entry() {
	while(1) {
		print_uart0(" ");
	}
}

void print_handler() {
	print_uart0("#");
}
