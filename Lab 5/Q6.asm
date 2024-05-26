; Jawad Ahmad Khan
; 22I-0791

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	array db 26 dup (0)
.code
main PROC
	mov ecx, 26
	mov esi, offset array
	mov al, 'a'
	mov ecx, 26

	L1:
		mov [esi], al
		inc al
		inc esi

	loop L1

	INVOKE ExitProcess,0
main ENDP
END main
