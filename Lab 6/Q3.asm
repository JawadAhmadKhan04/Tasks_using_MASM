.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	data word 8575h

.code
main PROC
	mov esi, offset data
	;mov ax, [esi]
	mov al, [esi] ; putting 75 in al
	mov ah, [esi] ; putting 75 in ah
	and al, 00001111b ; we want the last digit, so we force the first 4 by taking AND with 0000 and dont change the last digit by taking the last 4 bits AND with 1111
	and ah, 11111111b ; we want all the digits as it is so we take AND with 11111111b

	mov bx, [esi]
	and bx, 0000111111111111b ; we want the last 3 digits so we take uts AND with 111111111111 but want to discard the first so we take its AND with 0000

	mov cx, [esi]
	and cx, 1111111100001111b ; we dont want the 3rd digit so we take its AND with 0 while taking the remaining digits AND with 1111


	INVOKE ExitProcess,0
main ENDP
END main
