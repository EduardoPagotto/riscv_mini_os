# RISCV MINI OS

<b>WARNNING:<i>Just a simple test in risc-v, work in progress !!!!</i> <p>

Features:
- Clang as compiler (asm and c)
- vscode as IDE
- clang-format
<p>

### Install deps Fedora 40: 
```bash
# CMake
sudo dnf install cmake cmake-data cmake-rpm-macros

# CLANG and LLVM
sudo dnf install clang clang-tools-extra llvm lld libstdc++-static llvm-static llvm-devel llvm-test

# QEMU
sudo dnf install qemu-system-riscv
```

### Install deps Ubuntu 24.04(incomplete): 
```bash
sudo apt install qemu-system-misc llvm lld  llvm lldm clang clang-format
```

### Test install
```bash
llvm-objdump --version | grep riscv

riscv32    - 32-bit RISC-V
riscv64    - 64-bit RISC-V
```

### Build all
```bash
mkdir builld
cd build
cmake ../ -DCMAKE_TOOLCHAIN_FILE=../toolchains/riscv64.cmake
```

## Kernel 
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
# not working :(
qemu-system-riscv64 -machine virt -m 512 -bios none -kernel kernel.elf -serial mon:stdio 
#qemu-system-riscv64 -cpu rv64 -kernel kernel.elf
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

## Simples
### Simple build
```bash
mkdir -p ./build

# Compile
clang --target=riscv32 -march=rv32ia -nostdlib -mabi=ilp32 -static -c -o app01.o app01.s

# Link
clang --target=riscv32 -march=rv32ia -nostdlib -mabi=ilp32 -L. -Wl,-T,mem_cfg.ld -o app01 app01.o 

## Utils from ELF
llvm-objdump -D app01  > app01_dump.s # dissasembler

#llvm-objcopy -O ihex app01  app01.hex # hex file
llvm-objcopy -O binary app01  app01.bin # binary final !!!!!

llvm-objdump -t -r app01  # show type exec
```
## Test new apps
```bash
# Compile
clang --target=riscv32 -march=rv32i -nostdlib -mabi=ilp32 -static -c -o pgm.o teste.s

# Linker
clang --target=riscv32 -march=rv32i -nostdlib -mabi=ilp32 -L. -Wl,-T,teste.ld pgm.o  

# OR Compile and Linker
clang --target=riscv32 -march=rv32i -nostdlib -mabi=ilp32 -static -L. -Wl,-T,teste.ld,-Map=pgm.map -o pgm.o teste.s

## Conver from ELF
llvm-objdump -D pgm.o > pgm.s # dissasembler
llvm-objdump -t -r pgm.o # show type exec
llvm-objcopy -O ihex pgm.o pgm.hex # hex file
llvm-objcopy -O binary pgm.o pgm.bin # binary final !!!!!

```

<!-- ## compilar codigo e emular no qemu
riscv64-unknow-elf-gcc -march=rv32g -mabi=ilp32 -static -mcmodel=medany -fvisibitity=hiddem -nostdlib -nostartfiles -Tteste.ld teste.s -o teste.o
riscv64-unknow-elf-objcopy -O ihex hello hello.hex

qemu-system-riscv32 -machine help
qemu-system-riscv32 -machine sifive_e -nographic -bios none -kenel teste -->

## refs:
- https://wiki.osdev.org/RISC-V_Bare_Bones
- https://llvm.org/docs/RISCVUsage.html
- https://github.com/schoeberl/cae-lab
- https://github.com/riscv-collab/riscv-gnu-toolchain/tree/master
- https://stackoverflow.com/questions/55189463/how-to-debug-cross-compiled-qemu-program-with-gdb