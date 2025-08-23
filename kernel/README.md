## Projetc Kernel
- Boot assembler
- kernel C


### Compiling direct
```bash
cd kernel
# Compile C
clang --target=riscv64 -march=rv64i -nostdlib  -static -Wall -Wextra -c -mcmodel=medany -c -o ../bin/kernel.o kernel.c
#riscv64-elf-gcc -Wall -Wextra -c -mcmodel=medany .c -o kernel.o -ffreestanding

# Compile ASM
clang --target=riscv64 -march=rv64i -nostdlib  -static -c -o ../bin/entry.o entry.s
# riscv64-elf-as -c entry.S -o entry.o

# Link all
clang --target=riscv64 -march=rv64i -nostdlib  -static -T linker.ld -nostdlib ../bin/kernel.o ../bin/entry.o -o ../bin/kernel.elf
#riscv64-elf-ld -T linker.ld -lgcc -nostdlib kernel.o entry.o -o kernel.elf
```
### Runing
```bash
qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios ./bin/kernel.elf
```

## IRQ
### Simple build
```bash
# Compile
clang --target=riscv32 -march=rv32i -nostdlib -mabi=ilp32 -static -c -o app01.o app01.s
# Link
clang --target=riscv32 -march=rv32i -nostdlib -mabi=ilp32 -L. -Wl,-T,mem_cfg.ld -o app01 app01.o
## Utils from ELF
llvm-objdump -D app01  > app01_dump.s # dissasembler
#llvm-objcopy -O ihex app01  app01.hex # hex file
llvm-objcopy -O binary app01  app01.bin # binary final !!!!!
llvm-objdump -t -r app01  # show type exec
```
