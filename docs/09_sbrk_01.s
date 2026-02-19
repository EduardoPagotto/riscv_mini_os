# Store a 4 bytes in the heap in a loop

.text
.globl _start
_start:
    addi t0, zero, 0
    addi t1, zero, 101
loop:
    addi a0, zero, 9
    addi a1, zero, 4
    ecall

    sw t0, 0(a0) # t0 in heap
    addi t0, t0 ,1
    bne t0, t1, loop

    addi a0, zero, 10 # end program
    ecall
