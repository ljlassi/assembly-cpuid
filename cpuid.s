.section .data
line_change:
	.ascii "\n"
cpu_vendor:
	.ascii "The processor vendor ID is: 'xxxxxxxxxxx'"
cpu_highest_calling_message:
	.ascii "The highest calling value is: "
cpu_highest_calling_value:
	.int 0x0

.section .text
.globl _start
_start:
	movl $0, %eax
	cpuid
	movl $cpu_vendor, %edi
	movl %eax, cpu_highest_calling_value
	movl %ebx, 28(%edi)
	movl %edx, 32(%edi)
	movl %ecx, 36(%edi)
	movl $4, %eax
	movl $1, %ebx
	movl $cpu_vendor, %ecx
	movl $40, %edx
	int $0x80

	add $8, %rsp
	call PRINT_LINE_CHANGE

	movl $4, %eax
	movl $1, %ebx
	movl $cpu_highest_calling_message, %ecx
	movl $30, %edx
	int $0x80

	add $8, %rsp
	call PRINT_LINE_CHANGE

	movl $4, %eax
	movl $1, %ebx
	movl $cpu_highest_calling_value, %ecx
	movl $2, %edx
	int $0x80

	add $8, %rsp
	call PRINT_LINE_CHANGE

	jmp EXIT

	PRINT_LINE_CHANGE:
		push %rbp
		mov %rsp, %rbp
		movl $4, %eax
		movl $1, %ebx
		movl $line_change, %ecx
		movl $1, %edx
		int $0x80
		mov %rbp, %rsp
		pop %rbp
		ret

	EXIT:
		movl $42, %edx
		movl $1, %eax
		movl $0, %ebx
		int $0x80
