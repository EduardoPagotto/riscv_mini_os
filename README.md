# RISCV MINI OS

<b>WARNNING:<i>Just a simple test in risc-v, work in progress !!!!</i> <p>

Goal´s:
- Clang as compiler (asm and c)
- VSCode as IDE
- Text Format code with clang-format
- CMake for build system
- LLDB to debug in vscode
<p>

## Install deps and sets in Fedora 43:
```bash
# CMake
sudo dnf install cmake cmake-data cmake-rpm-macros

# CLANG/LLVM
sudo dnf install clang clang-tools-extra llvm lld libstdc++-static llvm-static llvm-devel llvm-test

# QEMU/LLDB
sudo dnf install lldb qemu-system-riscv qemu-system-riscv-core

# Change default Linker to LLVM (ld.lld)
# List all alternativer
update-alternatives --list

# List alternativer of linker
update-alternatives --config ld

# Set linker to ld.lld
sudo update-alternatives --config ld
```

## Test toolchain default clang/llvm install
```bash
llvm-objdump --version | grep riscv

riscv32    - 32-bit RISC-V
riscv64    - 64-bit RISC-V
```

## Build all manual
```bash
cmake -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE \
      -DCMAKE_TOOLCHAIN_FILE=./toolchains/riscv_simple.cmake \
      -B./build \
      -G "Unix Makefiles"

cd build

make
```

## Debug test code example
1. VSCODE, Install extension: CodeLLDB (by Vadim Chugunov)

2. Manual compilation (optional)
      ```bash
      clang --target=riscv32 -march=rv32i -mabi=ilp32 -g -O0 teste_code.c -o teste_code.elf
      ```
3. Start QEMU deamon:
      ```bash
      # -s: Shortcut to -gdb tcp::1234.
      # -S: Freezes the CPU at startup.

      qemu-system-riscv32 -machine virt -nographic -kernel teste_code.elf -s -S
      `

4. Setting up VS Code for Debug <p>
      <i>.vscode/launch.json (or in workspace)</i>
      ```json
      {
      "version": "0.2.0",
      "configurations": [
            {
                  "name": "BareMetal LLDB-DAP",
                  "type": "lldb-dap",
                  "request": "attach",
                  "program": "${workspaceRoot}/bin/baremetal.elf",
                  "preLaunchTask": "RunQEMUBareMetal",
                  "attachCommands": [
                        "target create ${workspaceRoot}/bin/teste_code.elf",
                        "gdb-remote localhost:1234"
                  ]
            }
      ]
      }
      ```

      <i>.vscode/tasks.json (or in workspace)</i>
      ```json
      "tasks": {
            "version": "2.0.0",
            "tasks": [
                  {
                        "label": "RunQEMUBareMetal",
                        "type": "shell",
                        "command": "qemu-system-riscv32 -machine virt -cpu rv32 -smp 1 -nographic -bios none -kernel ${workspaceRoot}/bin/baremetal.elf -s -S",
                        "detail": "Dispara QEMU para baremetal.elf",
                        "isBackground": true,
                        // "dependsOn":["Build"],
                        "problemMatcher": [
                              {
                                    "pattern": [
                                          {
                                                "regexp": ".",
                                                "file": 1,
                                                "location": 2,
                                                "message": 3
                                          }
                                    ],
                                    "background": {
                                          "activeOnStart": true,
                                          "beginsPattern": ".",
                                          "endsPattern": "QEMU Started",
                                    }
                              }
                        ]
                  }
            ]
            }
      ```


5. LLDB commands (alternative) to run outside of VS Code
      ```bash
      lldb teste_code.elf
      (lldb) gdb-remote 1234
      (lldb) c
      ```

Important notes for Fedora:

- If LLDB cannot read the symbols, check if the binary was compiled with debug symbols (-g in GCC/Clang).
- Permissions: Root access is generally not required for QEMU, but check for firewall restrictions on port 1234.
- Registers: LLDB may show 64-bit registers if the tool is not properly configured. Use register read to confirm.
- Versions: Fedora is updated. If "qemu-system-riscv32" doesn't work, try "qemu-system-riscv64" with a 32-bit architecture (the 64-bit qemu can run 32-bit).
- To monitor the boot progress, you can use the "monitor info registers" command in the LLDB console (Debug Console tab).

## Examples of apps to test
- [Hello](./samples/hello/README.md)
- [App0](./samples/app0/README.md)
- [App1](./samples/app1/README.md)
- [Kernel](./samples/kernel/README.md)


## Refs:
- https://wiki.osdev.org/RISC-V_Bare_Bones
- https://llvm.org/docs/RISCVUsage.html
- https://github.com/schoeberl/cae-lab
- https://github.com/riscv-collab/riscv-gnu-toolchain/tree/master
- https://stackoverflow.com/questions/55189463/how-to-debug-cross-compiled-qemu-program-with-gdb
- https://github.com/riscv-non-isa/riscv-asm-manual/blob/main/riscv-asm.md
