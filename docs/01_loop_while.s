_start:
    addi s0, zero, 64    # s0 = 5
    addi t0, zero, 1    # t0 = 1
    addi s1, zero, 0

while:                  # loop while
    and t1, t0, s0      # t0 & s0

    beq t0, t1, done    # if t0=t1, brach
    addi s1, s1, 1      # add 1 every time we divide

    sra s0, s0, t0      # divide by 2 (shift right arithnetic)
    j while

done:
    nop
