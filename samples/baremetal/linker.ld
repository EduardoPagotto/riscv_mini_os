OUTPUT_ARCH(riscv)

MEMORY {
    RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS {
    .text : {
        *(.text.init)
        *(.text .text.*)
    } > RAM

    /* Global Pointer configurado no meio dos dados pequenos */
    .sdata : {
        __global_pointer$ = . + 0x800;
        *(.sdata .sdata.*)
    } > RAM

    .data : { *(.data .data.*) } > RAM
    .bss : { *(.bss .bss.*) } > RAM

    .heap (NOLOAD) : {
        . = ALIGN(16);
        _heap_start = .;
        . += 0x10000; /* 64KB Heap */
    } > RAM

    .stack (NOLOAD) : {
        . = ALIGN(16);
        . += 0x4000; /* 16KB Stack */
        _stack_top = .;
    } > RAM
}
