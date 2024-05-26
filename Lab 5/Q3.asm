; Jawad Ahmad Khan
; 22I-0791

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	r db 1001b
	s db 0010

.code
main PROC
	mov ax, 0
	mov bx, 0
	
	mov al, r
	mov bl, s
	div bl

	mov al, r
	inc al

	mov al, r
	dec al

	mov ax, 0
	mov al, r
	mov bl, s
	add al, bl

	mov al, r
	mov bl, s
	sub al, bl

	INVOKE ExitProcess,0
main ENDP
END main
