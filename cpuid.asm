
global  main
extern  printf

section .text

main:

	mov eax, 0
	cpuid
	mov [cpu_vendor], ebx
	mov [cpu_vendor+4], edx
	mov [cpu_vendor+8], ecx
	mov [cpu_highest_calling_value], eax
	mov eax, 4
	mov ebx, 1
	mov ecx, cpu_vendor_message
	mov edx, 29
	int 0x80

	mov ecx, 0
	mov eax, 4
	mov ebx, 1
	mov ecx, cpu_vendor
	mov edx, 12
	int 0x80

	call print_line_change

	mov eax, 4
	mov ebx, 1
	mov ecx, cpu_highest_calling_message
	mov edx, 31
	int 0x80

	call print_highest_calling_value

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

		print_highest_calling_value:
        ; We will use printf C-function for priting the hex.

        push    rax                     ; caller-save register
        push    rcx                     ; caller-save register

        mov     rdi, format             ; set 1st parameter (format)
        mov     rsi, cpu_highest_calling_value                ; set 2nd parameter (current_number)
        xor     rax, rax                ; because printf is varargs

        ; Stack is already aligned because we pushed three 8 byte registers
        call    printf                  ; printf(format, current_number)

        pop     rcx                     ; restore caller-save register
        pop     rax                     ; restore caller-save register

        pop     rbx                     ; restore rbx before returning
        ret

	exit:
		mov edx, 42
		mov eax, 1
		mov ebx, 0
		int 0x80

section .data

	line_change: db	" ", 10
	cpu_vendor_message: db "The processor vendor ID is: ", 0
	cpu_vendor: db "xxxxxxxxxxxx"
	cpu_highest_calling_message: db "The highest calling value is: ", 0
	cpu_highest_calling_value: dq 0xFFFFFFFF, 0
	format: db  "%20ld", 10, 0
