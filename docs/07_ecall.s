# print 5 to the console
.text
.globl _start
_start:
    addi a0, zero, 1
    addi a1, zero, 5
    ecall
    addi a0, zero, 10
    ecall
