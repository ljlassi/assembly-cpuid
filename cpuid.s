.section .data
cpu_vendor:
	.ascii "The processor vendor ID is: 'xxxxxxxxxxx' \n"
.section .text
.globl _start
_start:
	movl $0, %eax
	cpuid
	movl $cpu_vendor, %edi
	movl %ebx, 28(%edi)
	movl %edx, 32(%edi)
	movl %ecx, 36(%edi)
	movl $4, %eax
	movl $1, %ebx
	movl $cpu_vendor, %ecx
	movl $42, %edx
	int $0x80
	movl $42, %edx
	movl $1, %eax
	movl $0, %ebx
	int $0x80
