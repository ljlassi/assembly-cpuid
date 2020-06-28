global _start

section .text
_start:

call hexdd

call exit

hexdd:
        push rdi
        dec rdi
        push    rax
        mov eax, 0xFFF
        shr     eax,16          ;do high word first
        call    hexdw
        pop     rax
        pop rdi
hexdw:
        push rdi
        dec rdi
        push    rax
        shr     eax,8           ;do high byte first
        call    hexdb
        pop     rax
        pop rdi
hexdb:  push    rax
        push rdi
        dec rdi
        shr     eax,4           ;do high nibble first
        call    hexdn
        pop     rax
        pop rdi
hexdn:
        push rdi
        dec rdi
        and     eax,0fh         ;isolate nibble
        add     al,'0'          ;convert to ascii
        cmp     al,'9'          ;valid digit?
        jbe     hexdn1          ;yes
        add     al,7            ;use alpha range
        pop rdi
hexdn1:
        push rdi
        dec rdi
        mov     [esi],al        ;store result
        inc     esi             ;next position
        pop rdi
        ret

exit:
	mov edx, 42
	mov eax, 1
	mov ebx, 0
	int 0x80

	section .data
