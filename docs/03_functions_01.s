_start:
    addi s0, zero, 0
    addi t0, zero, 0
    addi t1, zero, 10

loop:
    add a0, zero, s0  # parameter0 of function
    addi a1, zero, 5  # parameter1 of functiom
    jal AddTwo
    addi t0, t0, 1

    add s0, zero, a0 # pega o valor de reotno da funcao
    bne t0, t1, loop

    addi a0, zero, 10  #?? add this if dosent work

    ecall


AddTwo:              # fucntion has 2 arguments a0 and a1 and ret as a0
    add a0, a0, a1  # add 2 to s0
    jr ra
