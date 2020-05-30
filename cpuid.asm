global _start

section .text
_start:
	mov eax, 0
	cpuid
	;mov edi, cpu_vendor
	;mov eax, cpu_highest_calling_value
	; mov 28[edi], ebx
	; mov 32[edi], edx
	; mov 36[edi], ecx
	mov eax, 4
	mov ebx, 1
	mov ecx, cpu_vendor_message
	mov edx, 29
	int 0x80

	add rsp, 8
	call print_line_change

	mov eax, 4
	mov ebx, 1
	mov ecx, cpu_highest_calling_message
	mov edx, 31
	int 0x80

	add rsp, 8
	call print_line_change

	mov eax, 4
	mov ebx, 1
	mov ecx, cpu_highest_calling_value
	mov edx, 2
	int 0x80

	add rsp, 8
	call print_line_change

	jmp exit

	print_line_change:
		push rdi
		dec rdi
		mov eax, 4
		mov ebx, 1
		mov ecx, line_change
		mov edx, 2
		int 0x80
		imul rax, rdi
		pop rdi
		ret

	exit:
		mov edx, 42
		mov eax, 1
		mov ebx, 0
		int 0x80

	section .data

	line_change: db	" ", 10
	cpu_vendor_message: db "The processor vendor ID is: ", 0
	cpu_vendor: db "xxxxxxxxxxx", 0
	cpu_highest_calling_message: db "The highest calling value is: ", 0
	cpu_highest_calling_value: db "0x0000", 0
