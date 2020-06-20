global _start

section .text
_start:

nop
        ; get the address of the data segment
         ; store the address in the data segment register
;-----------------------
    mov eax,0FFFFFFFFh  ; 32 bit value (0 - FFFFFFFF) for example
;-----------------------
; convert the value in EAX to hexadecimal ASCIIs
;-----------------------
     ; get the offset address
    mov cl,9            ; number of ASCII
P1: rol eax,4           ; 1 Nibble (start with highest byte)
    mov bl,al
    and bl,0Fh          ; only low-Nibble
    add bl,30h          ; convert to ASCII
    cmp bl,39h          ; above 9?
    jna short P2
    add bl,7            ; "A" to "F"
P2: add [buffer],bl         ; store ASCII in buffer
    dec cl              ; decrease loop counter
    jnz P1              ; jump if cl is not equal 0 (zeroflag is not set)
;-----------------------
; Print string
;-----------------------
mov ecx, buffer
mov eax, 4
mov ebx, 1
mov edx, 11
int 0x80

mov edx, 42
mov eax, 1
mov ebx, 0
int 0x80

  ; terminate program...

section .data
HEX_OUT: db ' xxxxxxxxx',0

section .bss
buffer: resb 20

; Padding and magic number
