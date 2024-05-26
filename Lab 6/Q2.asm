.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	array db 1,200, 10, 251, 22, 202, 12, 209, 14, 199
	neg_arr db 5 dup (0)

.code
main PROC
	mov esi, offset array
	mov ecx, 5
	mov edi, offset neg_arr
	L1:
		mov al, [esi]
		mov bl, [esi]
		and al, 10000000b  ; zero flag will be 0 as MSB will be 0
		inc esi
		mov al, [esi]
		mov bl, [esi]
		and al, 10000000b  ; zero flag will be 1 as MSB will be 1
		mov [edi], bl
		inc edi
		inc esi
		loop L1


	INVOKE ExitProcess,0
main ENDP
END main
