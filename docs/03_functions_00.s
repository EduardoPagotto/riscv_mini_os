_start:
    jal function # jal ra, function
    nop
    ecall

function:
    nop
    # do something
    jr ra # return can be RET as "jr ra"
    nop
