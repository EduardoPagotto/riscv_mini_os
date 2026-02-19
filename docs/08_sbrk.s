# store a 4 byte word in the heap
.text
.globl _start
_start:
    addi s0, zero, 0xff
    addi a0, zero, 9 # sbrk
    addi a1, zero, 4 # num of bytes
    ecall

    sw s0, 0(a0)

    addi a0, zero, 10
    ecall
