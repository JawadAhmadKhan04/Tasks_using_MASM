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
		or ax, bx;   it would not give us 10 as the largest value because when we do OR of 9 and 10, it gives us 11 because performing
					; bitwise OR of 1001 and 1011, the end result would be 1011
		inc esi

	INVOKE ExitProcess,0
main ENDP
END main
