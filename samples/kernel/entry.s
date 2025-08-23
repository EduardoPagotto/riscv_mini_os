# ref directiver: https://sourceware.org/binutils/docs-2.31/as/RISC_002dV_002dDirectives.html#RISC_002dV_002dDirectives

.section .init

.option norvc                 # Disable compact instructions

.type start, @function        # define simbolo start como function
.global start
start:
	.cfi_startproc             # entrada em .debug_frame

.option push                   # Salva parametros do compilador
.option norelax                # muda para norelax
	la gp, global_pointer
.option pop                    # volta parametros compilador
	;
	csrw satp, zero            # Reset satp
	;
	la sp, stack_top           # Setup stack
	;
	add s0, sp, zero           # Set the frame pointer
	;
# 	la t5, bss_start           # Clear the BSS section
# 	la t6, bss_end
# bss_clear:
# 	sd zero, (t5)
# 	addi t5, t5, 8
# 	bltu t5, t6, bss_clear

	la t0, kmain
	csrw mepc, t0
	tail kmain 					# Jump to kernel!
	;
	.cfi_endproc                # finalizacao do .debug_frame
	;
.end                            # sinaliza fim do modulo
