// Endereço fictício (ex: QEMU Virt UART)
#define UART_ADDR 0x10000000

void uart_put_char_direct(int ch) {
    volatile char* uart = (volatile char*)UART_ADDR;
    *uart = (char)ch;
}

void put_char(char c) {
    // a7=1 (nosso ID), a0=caractere
    __asm__ volatile("li a7, 1\n"
                     "mv a0, %0\n"
                     "ecall"
                     :
                     : "r"(c)
                     : "a0", "a7");
}
