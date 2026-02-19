_start:
    addi s0, zero, 1

    addi t0, zero, 0     # index value
    addi t1, zero, 10    # end for value

for:
    beq t0, t1, done

    add s0, s0, s0 # logic we want

    addi t0, t0, 1 # increment of for
    j for
done:
    nop
