_start:
# Immediate in 12 bits, 2' complement
# Calc 6 - 3 + 21
    addi  s0, zero, 6  # 5 in s0
    addi  s1, zero, 3  # 3 in s1
    sub   t0, s0, s1 # t0 has 6 - 3

    addi  s2, zero, 21 # 21 in s2
    add   s3, s2, t0
    ecall
