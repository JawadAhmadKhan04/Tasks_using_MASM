.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	array db 1,2,3,4,5,6,7,8,9,10
	even_arr db 5 dup (0)
	odd_arr db 5 dup (0)

.code
main PROC
	mov ecx, 5
	mov esi, offset array
	mov edi, offset even_arr
	mov edx, offset odd_arr
	;mov , offset odd_arr
	L1:
		mov al, [esi]
		mov bl, [esi]
		and al, 00000001b  ; zero flag will be 0 as LSB will be 0
		mov [edi], bl
		inc edi
		inc esi
		mov al, [esi]
		mov bl, [esi]
		and al, 00000001b  ; zero flag will be 1 as LSB will be 1
		mov [edx], bl
		inc edx
		inc esi
		loop L1


	INVOKE ExitProcess,0
main ENDP
END main
