; Declare multibot constants
MBALIGN		equ 1 << 0
MEMINFO		equ 1 << 1
FLAGS		equ MBALIGN | MEMINFO
MAGIC		equ 0x1BADB002
CHECKSUM	equ -(MAGIC + FLAGS)

section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

section .data
%include "arch/i386/gdt.asm"

; Declare the stack
section .bss
align 16
stack_bottom:
resb 16384
stack_top:

section .text

global _start:function (_start.end - _start)
_start:
	
	; Set the stack pointer register to the top of the stack
	mov esp, stack_top

	extern _init
	call _init

	lgdt [gdt_descriptor]
	mov eax, cr0 ; copy cr0 register to eax
	or eax, 0x1 ; set the first bit
	mov cr0, eax ; update cr0 with eax

	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	; set the idt
	extern idt_init
	call idt_init

	extern pit_init
	call pit_init

	; Call the main kernel
	extern kmain
	call kmain
	
	; Hang the os once it's done doing everything
	cli
.hang	hlt
	jmp .hang
.end:
