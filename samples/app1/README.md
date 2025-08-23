# Project APP1
Minimal c, assembler code running machine virt

File [MakeFile](./Makefile) test build local

Rum
```bash
qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios ./bin/app1.elf
```
