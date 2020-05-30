.section .data
  HEX_OUT:
    .int 0

    .section .text
     .globl _start
    _start:

movw $0x1fb7, %dx    # Set the value we want to print to dx
call print_hex    # Print the hex value

.include "print_string.s"

# Prints the value of DX as hex.
print_hex:
push %rax
push %rcx
push %rdx
push %rbx
push %rbp
push %rsi
push %rdi            # save the register values to the stack for later

movw $4, %cx          # Start the counter: we want to print 4 characters
                  # 4 bits per char, so were printing a total of 16 bits

char_loop:
dec %cx            # Decrement the counter

movw %dx, %ax         # copy bx into ax so we can mask it for the last chars
shr $4, %dx          # shift bx 4 bits to the right
and $0xf, %ax        # mask ah to get the last 4 bits

movw HEX_OUT, %bx   # set bx to the memory address of our string
add $2, %bx         # skip the '0x'
add %cx, %bx        # add the current counter to the address

cmp $0xa, %ax        # Check to see if its a letter or number
jl set_letter     # If its a number, go straight to setting the value
add $7, %bx   # If its a letter, add 7
                  # Why this magic number? ASCII letters start 17
                  # characters after decimal numbers. We need to cover that
                  # distance. If our value is a letter its already
                  # over 10, so we need to add 7 more.
jl set_letter

set_letter:
add %ax, %bx  # Add the value of the byte to the char at bx

cmp $0, %cx        #   check the counter, compare with 0
je print_hex_done # if the counter is 0, finish
jmp char_loop     # otherwise, loop again

print_hex_done:
movb HEX_OUT, %bl   # print the string pointed to by bx
call print_string

pop %rdi
pop %rsi
pop %rbp
pop %rbx
pop %rdx
pop %rcx
pop %rax              # pop the initial register values back from the stack
ret               # return the function

# global variables
