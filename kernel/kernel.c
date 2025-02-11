#include <stddef.h>
#include <stdint.h>

#define UART0_BASE 0x10000000
// 16550 UART
#define REG(base, offset) ((*((volatile unsigned char*)(base + offset))))
#define UART0_DR REG(UART0_BASE, 0x00)
#define UART0_FCR REG(UART0_BASE, 0x02)
#define UART0_LSR REG(UART0_BASE, 0x05)

#define UARTFCR_FFENA 0x01 // UART FIFO Control Register enable bit
#define UARTLSR_THRE 0x20  // UART Line Status Register Transmit Hold Register Empty bit
#define UART0_FF_THR_EMPTY (UART0_LSR & UARTLSR_THRE)

void uart_putc(char c) {
    while (!UART0_FF_THR_EMPTY)
        ;         // Wait until the FIFO holding register is empty
    UART0_DR = c; // Write character to transmitter register
}

void uart_puts(const char* str) {
    while (*str) {         // Loop until value at string pointer is zero
        uart_putc(*str++); // Write the character and increment pointer
    }
}

int kmain() {

    UART0_FCR = UARTFCR_FFENA;     // Set the fifo for polled operation
    uart_puts("Ola mundo!!!!!\n"); // Write the string to the UART
    while (1)                      // Loop forever, prevent program from ending
        ;

    return 0;
}
