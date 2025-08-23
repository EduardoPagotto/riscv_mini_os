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
cmake -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
      -DCMAKE_TOOLCHAIN_FILE=./toolchains/riscv_simple.cmake \
      -B./build \
      -G "Unix Makefiles"

cd build

make
```

### Projects
- [Hello](./samples/hello/README.md)
- [App0](./samples/app0/README.md)
- [Kernel](./kernel/README.md)


## refs:
- https://wiki.osdev.org/RISC-V_Bare_Bones
- https://llvm.org/docs/RISCVUsage.html
- https://github.com/schoeberl/cae-lab
- https://github.com/riscv-collab/riscv-gnu-toolchain/tree/master
- https://stackoverflow.com/questions/55189463/how-to-debug-cross-compiled-qemu-program-with-gdb
- https://github.com/riscv-non-isa/riscv-asm-manual/blob/main/riscv-asm.md
