# store the number 5 in the global data segment
.data

.global x # x is now global
x: .word 5
y: .word 6
my_var: .byte 5

.globl _start # start is now a global
.text
_start:
    la t0, x # load from memory global x to t0
    la t1, y # load from memory global y to t1

    lw t0, 0,(t0)
    lw t1, 0,(t1)

    add s0, t0, t1

    # using gp
    lw s0, 0(gp)
    lw s1, 4(gp)

    ecall
