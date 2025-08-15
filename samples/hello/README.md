# HELLO Test

ref: https://www.youtube.com/watch?v=n8g_XKSSqRo&t=247s

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
llvm-objcopy -O ihex hello hello.hex

# or
cmake -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
      -DCMAKE_TOOLCHAIN_FILE=./toolchains/riscv_simple.cmake \
      -B./build \
      -G "Unix Makefiles"
cd build
make

# test qemu
qemu-system-riscv32 -machine sifive_e -nographic -bios none -kernel ./bin/hello.elf
```
