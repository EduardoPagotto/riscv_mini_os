/* OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv") */
OUTPUT_ARCH(riscv)

MEMORY
{
   RAM (rwx)  : ORIGIN = 0x80000000, LENGTH = 128M
}
ENTRY(start);

SECTIONS {
	/* Include entry point at start of binary */
	.text : ALIGN(4K) {
		PROVIDE(start = ORIGIN(RAM));
		*(.init);
		*(.text);
	}
	.rodata : ALIGN(4K) {
		*(.rodata);
	}
	. = ALIGN (CONSTANT (COMMONPAGESIZE));
	.bss : ALIGN(4K) {
		PROVIDE(bss_start = .);
		*(.bss);
		. += 4096;
		PROVIDE(stack_top = .);
		. += 4096;
		PROVIDE(global_pointer = .);
		PROVIDE(bss_end = .);
	}
	.data : ALIGN(4K) {
		*(.data);
	}
}
