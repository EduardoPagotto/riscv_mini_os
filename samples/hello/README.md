# HELLO Test

ref: https://www.youtube.com/watch?v=n8g_XKSSqRo&t=247s


Manual step-to-step
```bash
# compile
clang --target=riscv32 \
       -march=rv32g \
       -nostdlib  \
       -mabi=ilp32 \
       -static  \
       -nostartfiles \
       -Thello.ld \
       hello.s \
       -o hello

# HEX to board
llvm-objcopy -O ihex hello hello.hex

# test qemu
qemu-system-riscv32 -machine sifive_e -nographic -bios none -kernel ../../bin/hello.elf
qemu-system-riscv32 -machine sifive_e -nographic -bios none -kernel ./hello.elf
```


mkdir build
cd build

cmake -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
      -DCMAKE_TOOLCHAIN_FILE=./toolchains/riscv_simple.cmake \
      -B/home/pagotto/Projetos/pessoal/riscv_mini_os/build \
      -G "Unix Makefiles"
make

cmake -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
      -DCMAKE_TOOLCHAIN_FILE=./toolchains/riscv_simple.cmake \
      -B./build \
      -G "Unix Makefiles"
make
