.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC
    ; TASK 4

    mov ax, 0791; saving my roll number in ax
    mov bx, 1212; saving friends roll no in bx
    add ax, bx; ax = ax+bx -> 2003
    

	INVOKE ExitProcess,0
main ENDP
END main