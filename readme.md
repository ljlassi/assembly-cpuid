Attempt to obtain all CPU information with cpuid instruction in assembly language. Currently is able to get and print out the processor vendor and highest calling value.


COMPILATION INSTRUCTIONS (program only works for 64-bit Linux):
nasm -felf64 -g -F dwarf cpuid.asm -o cpuid.o && gcc -no-pie -o cpuid cpuid.o

Work in progress...
