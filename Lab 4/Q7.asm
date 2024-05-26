.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	data1 dd 12345678h
	

.code
main proc
	mov esi, offset data1
	mov al, [esi+2]
	mov ah, [esi+3]

	mov bl, [esi]
	;and bl, 00001111b

	div bl
	
main endp
END main