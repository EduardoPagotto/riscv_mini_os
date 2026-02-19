_start:
    jal A
    addi a0, zero, 0
    ecall

A:
    addi sp, sp, -16 # allocate 16 bytes to stack
    sw ra, 16(sp)

    jal B
    addi a0, zero, 1

    lw ra, 16,(sp)
    addi sp, sp, 16 # deallocate 16 bytes from stack

    jr ra

B:
    addi a0, zero, 2
    jr ra
