.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC
    ; TASK 2
    mov ax, 91; last 2 digits of my roll number
    mov bx, 1; to be added
    mov cx, 3; to be subtracted
    mov dx, ax; ax is copied to dx

    add ax, bx; ax = ax + bx -> ax = 92
    sub dx, cx; dx = dx - cx -> dx = 88
    
    

	INVOKE ExitProcess,0
main ENDP
END main