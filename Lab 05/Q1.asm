; Jawad Ahmad Khan
; 22I-0791

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	a db 1011b
	b db 1101b

.code
main PROC
	mov al, a
	mov bl, b
	add al, bl

	mov cl, a
	mov dl, b
	sub cl, dl

	mov al, a
	mov bl, b
	mul bl

	mov al, a
	mov bl, b
	div bl


	INVOKE ExitProcess,0
main ENDP
END main
