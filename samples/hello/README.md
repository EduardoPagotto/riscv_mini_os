# Project Hello
- 100% assembler
- Machine sifive_e

```bash
# compile manual step-to-step
clang --target=riscv32 \
       -march=rv32g \
       -nostdlib  \
       -mabi=ilp32 \
       -static  \
       -nostartfiles \
       -Thello.ld \
       hello.s \
       -o hello

# HEX to board (change '. = 0x20400000;' in hello.ld to '. = 0x20010000;')

## Conver from ELF
llvm-objdump -D hello > hello.s # dissasembler
llvm-objdump -t -r hello # show type exec
llvm-objcopy -O ihex hello hello.hex # hex file
llvm-objcopy -O binary hello hello.bin # binary final !!!!!

# test qemu
qemu-system-riscv32 -machine sifive_e -nographic -bios none -kernel ./bin/hello.elf

# executa debug remoto
qemu-system-riscv32 -machine sifive_e -nographic -bios none -kernel ./bin/hello.elf -s -S
# Importante:
# para se rodar o debug necessario extenção LLDB-dap
gdb./bin/hello.elf  -q -ex 'target remote :1234'
```

ref:
- https://www.youtube.com/watch?v=n8g_XKSSqRo&t=247s
