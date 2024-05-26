.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	arr1 db 1,2,3,4,5


.code
main proc
	mov bl, 2
	mov esi, offset arr1
	mov al, [esi]
	add al, bl

	mov [esi], al

	mov al, [esi+2]
	add al, bl

	mov [esi+2], al	
	
	mov al, [esi+4]
	add al, bl

	mov [esi+4], al

main endp
END main