.section .text
.align 4
.global trap_handler
trap_handler:
    csrr t0, mcause
    li t1, 11             # Código para 'Environment call from M-mode'
    bne t0, t1, other_trap

    # Syscall: a7=ID, a0=char. Chamamos função C do driver
    call uart_put_char_direct

    csrr t0, mepc
    addi t0, t0, 4        # Pular a instrução ecall
    csrw mepc, t0
    mret

other_trap: j other_trap
