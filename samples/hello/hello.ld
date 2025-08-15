OUTPUT_ARCH("riscv")
OUTPUT_FORMAT("elf32-littleriscv")

ENTRY( _start )
SECTIONS
{
    . = 0x20400000;                           /* . IS A CURRENT LOCATION OF MEMORY PROGRAM qemu */
    .text : { *(.text) }                      /* code starts here */
    .gnu_build_id : { *(.note.gnu.build-id) } /* sure that the ELF is sane, put a hash of ELF*/
    .rodata : { * (.rodata) }                  /* static initializade data MSG */

    . = 0x80000000;                           /* RAM start here */
    .data : { *(.data) }                      /* Dynimic memory ram*/
    .sdata : { *(.sdata) }                    /* Static Data */
    .debug : { *(.debug) }                    /* Debug information */
    . += 0x1000;                              /* location add 0x1000 positions here */
    stack_top = .;                            /* top of stackpointer */

    _end = .;                                 /* shows end of binary */
}
