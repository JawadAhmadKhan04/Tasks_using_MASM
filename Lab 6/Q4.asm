.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	array db 1,2,3,4,5,6,7,8,9,10

.code
main PROC
    mov ecx, lengthof array
	mov esi, offset array
	mov ax, 100

	L1:
		mov bx, [esi]
		and ax, bx;   it would not give us 1 as the lowest value because when we do and of 1 and 2, it gives us 0 because performing
					; bitwise AND of 0001 and 0010, last 2 digits both becomes 0
		inc esi

	INVOKE ExitProcess,0
main ENDP
END main
