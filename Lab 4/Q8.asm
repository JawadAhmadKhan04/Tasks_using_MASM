.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	data1 dd 12345678h


.code
main proc
	mov esi, offset data1
	mov al, [esi+3]

	mov bl, [esi]

	mul bl


main endp
END main