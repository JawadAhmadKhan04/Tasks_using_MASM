.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	arr1 db 1, 2, 3, 5, 6

.code
main proc
	mov esi, offset arr1
	mov al, 10

	mov [esi+1], al


main endp
END main