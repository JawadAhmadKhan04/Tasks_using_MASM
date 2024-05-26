; Jawad Ahmad Khan
; 22I-0791

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	factorial word 1

.code
main PROC
	mov ax, factorial
	mov ecx, 8d ; roll number is 0791, taking 8 as 9! wouldnt fit

	L1:
		mul ecx

	loop L1

	INVOKE ExitProcess,0
main ENDP
END main
