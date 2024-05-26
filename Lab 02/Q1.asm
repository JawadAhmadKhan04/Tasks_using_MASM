.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC
    ; TASK 1
	mov ax, 2 ; 2 is saved in ax by immediate addressing
    mov bx, 5 ; 5 is saved in bx by immediate addressing
    mov cx, 1 ; 1 is saved in cx by immediate addressing
    mov dx, 3 ; 3 is saved in dx by immediate addressing
    add ax, cx    ; ax = ax + cx -> 3
    sub bx, dx    ; bx = bx - dx -> 2
    

	INVOKE ExitProcess,0
main ENDP
END main