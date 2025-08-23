default: hello.elf

hello.o: hello.c
	clang --target=riscv32 -march=rv32ia -mabi=ilp32 -nostdlib -c -g -O0 -ffreestanding -o hello.o hello.c

start.o: start.s
	clang --target=riscv32 -march=rv32ia -mabi=ilp32 -nostdlib -c -g -o start.o start.s

hello.elf: hello.o start.o baremetal.ld
	clang --target=riscv32 -march=rv32ia -nostdlib -mabi=ilp32 -L. -Wl,-T,baremetal.ld  -o hello.elf hello.o start.o

run: hello.elf
	@echo "crt-a c for QEMU console, then to exit"
	qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios hello.elf

debug: hello.elf
	@echo "crt-a c for QEMU console, then to exit"
# gdb hello.elf -q -ex 'target remote :1234'
	qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios hello.elf -s -S

clean:
	rm -f hello.o hello.elf start.o
