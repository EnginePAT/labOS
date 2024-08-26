BITS 32

section .text
    align 4
    DD 0x1BADB002
    dd 0x0000000
    dd -(0x1BADB002 + 0x0000000)

global start
extern options

start:
    cli
    mov esp, stack_space
    call options
    hlt

HaltKernel:
    cli
    hlt
    jmp HaltKernel

section .bss
RESB 8192
stack_space:

section .note.GNU-stack