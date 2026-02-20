.section .text
.global kernel_init
kernel_init:
    la t0, trap_handler
    csrw mtvec, t0        # Configura endereço do handler de trap
    call main             # Entra no código C
loop_wfi:
    wfi                   # Wait For Interrupt ao final
    j loop_wfi
