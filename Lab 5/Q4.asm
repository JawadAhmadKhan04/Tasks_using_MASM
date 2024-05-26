; Jawad Ahmad Khan
; 22I-0791

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	array qword 5 dup(0)

.code
main PROC
	mov ecx, 10d
	mov esi, offset array

	L1:
		mov [esi], ecx
		inc esi
		dec ecx

	loop L1

	INVOKE ExitProcess,0
main ENDP
END main
