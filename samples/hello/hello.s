.align 2
.equ UART_REG_TXFIFO, 0
.equ UART_BASE, 0x10013000

.section .text
.globl _start

_start:
            csrr t0, mhartid // if more than 1 thread halt id > 0
            bnez t0, halt

            la sp, stack_top // set stack position
            la a0, msg       // first character of string
            jal puts

puts:
            li t0, UART_BASE    // address of hardware serial

.puts_loop:
            lbu t1, (a0)        // read a character is not 0 continue
            beqz t1, .puts_leave // if zero end of caracter

.put_waits:
            lw t2, UART_REG_TXFIFO(t0) // wait hardware is ready
            bltz t2, .put_waits

            sw  t1, UART_REG_TXFIFO(t0) // storage t1 to harware
            add a0, a0, 1
            j .puts_loop

.puts_leave:
            ret

halt:
            j halt

.section   .rodata
msg:       .string "QEMU hello World 100% assembler, sifive_e emulator\n."
