; Jawad Ahmad Khan
; 22I-0791

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	x db 1110b
	y db 0101b

.code
main PROC
	mov ax, 0
	mov bx, 0
	
	mov al, x
	mov bl, y
	mul bl

	mov al, x
	dec al

	mov al, x
	mov bl, y
	add al, bl

	mov al, x
	mov bl, y
	sub al, bl

	mov al, x
	inc al

	


	INVOKE ExitProcess,0
main ENDP
END main
