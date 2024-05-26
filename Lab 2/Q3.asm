.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC
    ; TASK 3

    mov ax, 5; saving 5 in ax
    mov bx, 3; saving 3 in bx
    add ax, bx; ax = ax+bx -> 8
    

	INVOKE ExitProcess,0
main ENDP
END main