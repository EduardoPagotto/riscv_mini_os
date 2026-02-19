_start:
    addi a0, zero, 50 # input
    jal sum_integers
    add s0, zero, a0 # output
    ecall


# Calculate the sum of integers below
sum_integers:
    addi sp, sp, -16 #alocate memory on the stack
    sw ra, 16(sp) # store ra

    sw a0, 12(sp) # store input

    beq a0, zero, base_case # Check whre inut os 0

    addi a0, a0 -1
    jal sum_integers

base_case:
    lw t0, 12(sp) #load input

    add a0, a0, t0 # add input + sum_integers(input-1)

    lw ra, 16(sp) # load ra
    addi sp, sp, 16 # deallocate memory
    jr ra # return
