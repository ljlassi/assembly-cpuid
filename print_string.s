print_string:     # Push registers onto the stack
push %rax
push %rcx
push %rdx
push %rbx
push %rbp
push %rsi
push %rdi

string_loop:
  movb %bl, %al    # Set al to the value at bx
  cmp $0, %al       # Compare the value in al to 0 (check for null terminator)
  jne print_char  # If its not null, print the character at al
                  # Otherwise the string is done, and the function is ending
  pop %rdi
  pop %rsi
  pop %rbp
  pop %rbx
  pop %rdx
  pop %rcx
  pop %rax
  ret             # return execution to where we were

print_char:
  movb $0x0e, %ah    # Linefeed printing
  int $0x10        # Print character
  add $1, %bx       # Shift bx to the next character
  jmp string_loop # go back to the beginning of our loop
