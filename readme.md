Attempt to obtain all CPU information with cpuid instruction in assembly language. Currently is able to get and print out the processor vendor and highest calling value.

<<<<<<< HEAD
Currently compiles and is able to get the CPU vendor, but is unable to print the CPU highest calling value since it is a hexadecimal number.

PLEASE IGNORE other files than cpuid.asm, the other files are stuff I'm experimenting with.

Print_hex and print_string files use modified code orignally from: https://gist.github.com/kthompson/957c635d84b7813945aa9bb649f039b9

It does not work yet because the original code is 32-bit and used BIOS interrupts, which I cannot use in 64-bit Linux.

COMPILATION INSTRUCTIONS (program only works for 64-bit Linux):
nasm -felf64 cpuid.asm && ld -o cpuid cpuid.o
=======

COMPILATION INSTRUCTIONS (program only works for 64-bit Linux):
nasm -felf64 cpuid.asm -o cpuid.o && gcc -no-pie -o cpuid cpuid.o
>>>>>>> feature/print-hex

Work in progress.
