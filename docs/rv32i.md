# RISCV (R32I)

## Register file

Reg   |Mnemo |Used to
------|------|---------------------------------------
x0    |zero  |always zero
x1    |ra    |return address
x2    |sp    |stack pointer
x3    |gp    |global pointer
x4    |tp    |thread pointer
x5    |t0    |temporary (alternative link register)
x6    |t1    |temporary register
x7    |t2    |temporary register
x8    |s0/fp |saved register / frame pointer
x9    |s1    |saved register
x10   |a0    |function arguments and return value
x11   |a1    |function arguments and return value
x12   |a2    |function arguments
x13   |a3    |function arguments
x14   |a4    |function arguments
x15   |a5    |function arguments
x16   |a6    |function arguments
x17   |a7    |function arguments
x18   |s2    |saved register
x19   |s3    |saved register
x20   |s4    |saved register
x21   |s5    |saved register
x22   |s6    |saved register
x23   |s7    |saved register
x24   |s8    |saved register
x25   |s9    |saved register
x26   |s10   |saved register
x27   |s11   |saved register
x28   |t3    |temporary register
x29   |t4    |temporary register
x30   |t5    |temporary register
x31   |t6    |temporary register


## Register Opp

Mnemo | name                   | opp
------|------------------------|-------------
add   | add                    | a + b
sub   | subtract               | a - b
sll   | shift left logical     | a << b
slt   | set less than          | a < b
sltu  | set less than (uns)    | a < b
xor   | xo                     | a ^ b
srl   | shift right logical    | a >> b
sra   | shift right arithnetic | a >>> B
or    | or                     | a || b
and   | and                    | a & b


### Memory map venus
Address    | Memory
-----------|---------------
0x80000008 | STACK
0x10008018 | HEAP
0x10000018 | DATA
0x00000018 | TEXT

### Memory SO example
Address                   | Memory             | Func
--------------------------|--------------------|-----
0xC0000000 -> 0xFFFFFFFC  | SO & I/O           |
0x10008000 -> 0xBFFFFFF0  | Dynamic Data       | Heap and Stack
0x10000000 -> 0x10000FFC  | Global Data        | GP Register
0x00010000 -> ??????????  | Text               | Program (PC)
0x00000000 -> ??????????  | Exception handlers | Firmware



store register in memory -> Store word -> sw
load register with memory -> Load worod -> lw


## Branch

Mnemo | opp
------|--------------------
beq   | branch if ==
bne   | branch if !=
blt   | branch if <
bge   | branch if >=
bltu  | branch if <  (uns)
bgeu  | branch if >= (uns)


# Functions
 Function Caller -> Function calle

## Nonleaf
```
addi sp, sp, -x
sw ra, x(sp)
...
...
...
lw ra, x(sp)
addi sp, sp, x
```


Assembler directive

Directive  | Effect
-----------|-----------------------------------------------------------------------
.data      | Store subsequent items in static segment at next avaible address
.text      | Store subsequent instructions in text segment at next avaible address
.byte      | Store listed values as 8-bit bytes
.asciiz    | Store subsequent string in data segment and add null-terminator
.word      | Store listed values as unaligned 32 bits words
.globl     | Makes the given label global
.float     | Store listed value as 32-bit float
.double    | Store listed value as 64-bit double
.aling     | Align subsequent item to a power 2


### ecall's

id   | Name           | Description
-----|----------------|---------------------------------------------------------------------------------
1    |print_int       | prints integer in a1
4    |print_string    | print the null terminate string whose address is in a1
9    |sbrk            | allocates a1 bytes on the heap, return pointer to start in a0
10   |exit            | ends the program
11   |print_character | prints the ascii character in a1
13   |openFile        | Open the file in the VFS where a pointer to the path in a1.<p> Permission bits are in a2 <p>Returns to a0 an integer representing the file descriptor
14   |readFile        | Takes in:a1=Filedescriptor.<p> a2: Where to store data(an array)<p> a3: the mount you want to read from the file<p> Resturn a0: Number of items whitch were read and put to the given array<p> if it is less than a3 it is either an error or EOF.<p> You will have to use another call to determine what was the cause
15   |writeFile       | Takes in:a1=Filedescriptor.<p> a2:Buffer to read data from<p> a3: amount of the buffer you want to read<p> a4: Size of eache item<p> Returns a0: Number of itenswritten<p> If less than a3, it ist either an error or EOF.<p> You will have yo use another call to determine  what was the cause<p> Also, you need to flush or close the file for change to be written on the VFS
16   |closeFile       | Takes in:a1=Filedescriptor.<p> Return 0 on sucess and EOF(-1) otherwise. will flush the data as well
17   |exit2           | Ends the program with return code in a1
18   |fflush          | Takes in:a1=Filedescriptor.<p> Will return 0 on sucess otherwise EOF on an error
19   |feof            | Takes in:a1=FileDescriptor.<p> Returns a nonzero value when the end of file is reached otherwise, it returns 0
20   |ferror          | Takes in:a1=FileDescriptor.<p> Returns a nonzero value if the stream has errors ocurred, 0 otherwise
34   |printHex        | prints hex in a1
0xcc |vlib            | Checkout the vlib page to see what functions you can use!


id(a6) | Name             | Description
-------|------------------|--------------------------------------------------------------------------------------------
1      | malloc           | Allocate exacle a1 bytes to the heap.<p> Returns the pointer to that block in a0
2      | calloc           | Takes in A1 nintens and a2 size of each item. Zeros out the allocated memory.<p> Returns apointer to that block in a0
3      | realloc          | Takes in a pointer to the block to realloc in a1 and the new size you want to reallocate to in a2.<p> Returnd a ponter in a0 to the newly allocate data.<p> Note: if you request a size smaller than the pointer, it will create a new block and copy only zise bytes to the new alocation
4      | free             | Frees the pointer given in a1. it will merge other free blocks araund it if any exist. Does not return anything
5      | num_alloc_blocks | Returns to a0 the number of not free blocks or -1 if an error occured. <p> Errors may involve a modification of the backend structure so a link was not able to be read property

ecall
0xcc a0 to 0x3cc
