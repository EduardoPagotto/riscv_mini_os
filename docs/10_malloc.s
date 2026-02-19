# store 5 in heap
.text
.globl _start
_start:
    addi s0, zero, 5

    addi a0, zero, 0x3cc # vlib. malloc
    addi a1, zero, 4     # 4 bytes
    addi a6, zero, 1     # do a malloc
    ecall                # request data

    sw s0, 0(a0) # store data

    add a1, zero, a0
    addi a0, zero, 0x3cc # vlib. free
    addi a6, zero, 4     # do a free
    ecall                # release data

    addi a0, zero, 10    # end app
    ecall
