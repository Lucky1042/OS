; isr.asm
; ISR functions are defined here. Most code is done in isr-handlers.c

; TODO: there must be a better way to do this...
global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

isr0:
	pushad
	popad
	iret

isr1:
	pushad
	popad
	iret

isr2:
	pushad
	popad
	iret

isr3:
	pushad
	popad
	iret

isr4:
	pushad
	popad
	iret

isr5:
	pushad
	popad
	iret

isr6:
	pushad
	mov ebx, 8
	call exception_stub
	popad
	iret

isr7:
	pushad
	popad
	iret

isr8:
	pushad
	mov ebx, 8
	call exception_stub
	popad
	iret

isr9:
	pushad
	popad
	iret

isr10:
	pushad
	popad
	iret

isr11:
	pushad
	mov ebx, 11
	call exception_stub
	popad
	iret

isr12:
	pushad
	popad
	iret

isr13:
	pushad
	mov ebx, 13
	call exception_stub
	popad
	iret

isr14:
	pushad
	mov ebx, 14
	call exception_stub
	popad
	iret

isr15:
	pushad
	popad
	iret

isr16:
	pushad
	popad
	iret

isr17:
	pushad
	popad
	iret

isr18:
	pushad
	popad
	iret

isr19:
	pushad
	popad
	iret

isr20:
	pushad
	popad
	iret

isr21:
	pushad
	popad
	iret

isr22:
	pushad
	popad
	iret

isr23:
	pushad
	popad
	iret

isr24:
	pushad
	popad
	iret

isr25:
	pushad
	popad
	iret

isr26:
	pushad
	popad
	iret

isr27:
	pushad
	popad
	iret
isr28:
	pushad
	popad
	iret

isr29:
	pushad
	popad
	iret

isr30:
	pushad
	popad
	iret

isr31:
	pushad
	popad
	iret

exception_stub:
	push ebp
	mov ebp, esp

	push ebx
	extern exception_handler
	call exception_handler
	pop ebx
	
	mov esp, ebp
	pop ebp
	ret
