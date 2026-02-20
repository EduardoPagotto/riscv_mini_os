SECTIONS {
    . = 0x80000000;                         /* QEMU default load address to run bios */
    .text : {
        KEEP(*(.text._start));             /* Ensure _start is place first */
        *(.text*);                         /* Program code here */
    }
    . = ALIGN (CONSTANT (COMMONPAGESIZE)); /* Make sure linker does not ja, data into text section, making text writable */
    .data : {
        *(.data*);                          /* stack goes here */
    }
}
