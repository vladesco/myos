STACK_SIZE equ 1024*1024
MAGIC equ 0x1badb002
FLAGS equ ((1<<0) | (1<<1))
CHECKSUM equ -(MAGIC + FLAGS)

section .multiboot
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

section .text
global _loader
extern kernelMain
_loader:
    mov esp, stack_pointer
    push ebx
    push eax
    call kernelMain
    add esp, 8

    loop:
        hlt
        jmp loop

section .bss
stack resd STACK_SIZE
stack_pointer:





