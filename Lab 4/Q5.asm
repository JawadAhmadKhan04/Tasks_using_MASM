.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	data1 db 23


.code
main proc
	mov esi, offset data1
	mov al, [esi]

main endp
END main