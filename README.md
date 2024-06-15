# RISCV MINI OS

<b>WARNNING:</b>
<i>Just a simple test in risc-v, work in progress !!!!<i> <p>

Install dependencies 
```bash
# fedora
# sudo dnf install llvm lldb qemu-system-riscv32 qemu-system-riscv64

# Ubuntu
sudo apt install qemu-system-misc
```

Compiling with cmake
```bash
mkdir builld
cd build
cmake ../ -DCMAKE_TOOLCHAIN_FILE=../toolchains/riscv64.cmake
```

## Kernel
### Compiling direct
```bash
cd kernel
clang --target=riscv64 -march=rv64i -nostdlib  -static -Wall -Wextra -c -mcmodel=medany -c -o ../bin/kernel.o kernel.c
#riscv64-elf-gcc -Wall -Wextra -c -mcmodel=medany .c -o kernel.o -ffreestanding

clang --target=riscv64 -march=rv64i -nostdlib  -static -c -o ../bin/entry.o entry.s
# riscv64-elf-as -c entry.S -o entry.o

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
### Compile direct
```bash
# clean
mkdir -p ./build

# Compile
clang --target=riscv32 -march=rv32i -nostdlib -mabi=ilp32 -static -c -o ./build/app01.o app01.s

# Link
clang --target=riscv32 -march=rv32i -nostdlib -mabi=ilp32 -L. -Wl,-T,mem_cfg.ld -o ./build/app01 ./build/app01.o 

## Utils from ELF
llvm-objdump -D ./build/app01  > ./build/app01_dump.s # dissasembler

#llvm-objcopy -O ihex ./build/app01  ./build/app01.hex # hex file
llvm-objcopy -O binary ./build/app01  ./build/app01.bin # binary final !!!!!

llvm-objdump -t -r ./build/app01  # show type exec
```

## Simples
```bash
mkdir -p ./build

# Compile
clang --target=riscv32 -march=rv32ia -nostdlib -mabi=ilp32 -static -c -o ./build/app01.o app01.s

# Link
clang --target=riscv32 -march=rv32ia -nostdlib -mabi=ilp32 -L. -Wl,-T,mem_cfg.ld -o ./build/app01 ./build/app01.o 

## Utils from ELF
llvm-objdump -D ./build/app01  > ./build/app01_dump.s # dissasembler

#llvm-objcopy -O ihex ./build/app01  ./build/app01.hex # hex file
llvm-objcopy -O binary ./build/app01  ./build/app01.bin # binary final !!!!!

llvm-objdump -t -r ./build/app01  # show type exec
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