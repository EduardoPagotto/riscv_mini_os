# store "hello World!"
.data
hello_world: .asciiz "Hello World!!\n"

# print to console
.text
.globl _start
_start:
    addi a0, zero, 4
    la a1, hello_world
    ecall

    addi a0, zero, 10
    ecall
