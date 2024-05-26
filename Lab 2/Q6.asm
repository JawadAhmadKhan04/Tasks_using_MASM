.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC
    ; TASK 6

    mov ax, 2023; saving current year in ax
    mov bx, 2003; saving DOB in bx
    sub ax, bx; ax = ax-bx -> 20 -> my present age
    

	INVOKE ExitProcess,0
main ENDP
END main