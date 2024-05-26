.386
.model flat, stdcall
.stack 4096

; Windows API function prototypes
GetStdHandle PROTO, nStdHandle:DWORD
ReadConsoleA PROTO, hConsoleInput:DWORD, lpBuffer:PTR BYTE, nNumberOfCharsToRead:DWORD, lpNumberOfCharsRead:PTR DWORD, lpReserved:DWORD
WriteConsoleA PROTO, hConsoleOutput:DWORD, lpBuffer:PTR BYTE, nNumberOfCharsToWrite:DWORD, lpNumberOfCharsWritten:PTR DWORD, lpReserved:DWORD
ExitProcess PROTO, dwExitCode:DWORD

.data
    inputBuffer BYTE 255 DUP (?)  ; Buffer to store user input
    outputBuffer BYTE 255 DUP (?) ; Buffer to display output
    bytesRead DWORD ?
    bytesWritten DWORD ?
    Q1_prompt BYTE "Enter Character, if you enter more, only 1 will be outputted: ",0
    Q1_outputLabel BYTE "Character Entered: ",0
    Q2_prompt BYTE "Enter upper case Character, if you enter more, only 1 will be outputted: ",0
    Q2_outputLabel BYTE "Character Entered to lower case: ",0
    Q3_prompt BYTE "Enter an index: ",0
    Q3_outputLabel BYTE "Data at that index: ",0
    q3_data byte 1, 2,1,3,7,6,4,3,2,0
    Q4_prompt BYTE "Enter a number: ",0
    Q4_outputLabel_even BYTE "Number is even.",0
    Q4_outputLabel_odd BYTE "Number is odd.",0
    Q5_prompt BYTE "Enter Character, if you enter more, only 1 will be outputted: ",0
    Q5_outputLabel BYTE "1 previous character: ",0
    Q6_prompt BYTE "Enter marks: ",0
    Q6_outputLabel BYTE "Your grade: ",0
    Q7a_prompt BYTE "Enter a number: ",0
    new_line db 10
    starbuffer db "*"
    count db 1

.code
main PROC

    call Q1_proc
    ;call Q2_proc
    ;call Q3_proc
    ;call Q4_proc
    ;call Q5_proc
    ;call Q6_proc
    ;call Q7a_proc
    ;call Q7b_proc
    
    ; Exit the program
    invoke ExitProcess, 0

main ENDP

Q1_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q1_prompt, LENGTHOF Q1_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, 1, ADDR bytesRead, 0

    ; Display the input as output
    invoke WriteConsoleA, esi, ADDR Q1_outputLabel, LENGTHOF Q1_outputLabel - 1, ADDR bytesWritten, 0
    invoke WriteConsoleA, esi, ADDR inputBuffer, bytesRead, ADDR bytesWritten, 0
    ret

Q1_proc ENDP

Q2_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q1_prompt, LENGTHOF Q1_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, 1, ADDR bytesRead, 0

    ; converting to lowercase
    
    or inputBuffer, 000000000000000000100000b
    

    ; Display the input as output
    invoke WriteConsoleA, esi, ADDR Q2_outputLabel, LENGTHOF Q2_outputLabel - 1, ADDR bytesWritten, 0
    invoke WriteConsoleA, esi, ADDR inputBuffer, bytesRead, ADDR bytesWritten, 0
    ret

Q2_proc ENDP

Q3_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q3_prompt, LENGTHOF Q3_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, 1, ADDR bytesRead, 0

    ; finding index
    sub inputBuffer, "0"
    mov ecx, dword ptr inputBuffer
    mov al, [q3_data+ecx]
    add al ,30h
    mov byte ptr inputBuffer, al
    

    ; Display the input as output
    invoke WriteConsoleA, esi, ADDR Q3_outputLabel, LENGTHOF Q3_outputLabel - 1, ADDR bytesWritten, 0
    invoke WriteConsoleA, esi, ADDR inputBuffer, bytesRead, ADDR bytesWritten, 0
    ret

Q3_proc ENDP

Q4_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q4_prompt, LENGTHOF Q3_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, LENGTHOF inputBuffer, ADDR bytesRead, 0

    mov ax, 0
    mov al, inputBuffer
    sub al, "0"
    TEST al, 00000001b
    jnz L1
        invoke WriteConsoleA, esi, ADDR Q4_outputLabel_even, LENGTHOF Q4_outputLabel_even - 1, ADDR bytesWritten, 0    
        jmp L2

    L1:
        invoke WriteConsoleA, esi, ADDR Q4_outputLabel_odd, LENGTHOF Q4_outputLabel_odd - 1, ADDR bytesWritten, 0

    L2:  
    ret

Q4_proc ENDP


Q5_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q5_prompt, LENGTHOF Q5_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, 1, ADDR bytesRead, 0

    ; finding index
    sub inputBuffer, 1
    

    ; Display the input as output
    invoke WriteConsoleA, esi, ADDR Q5_outputLabel, LENGTHOF Q5_outputLabel - 1, ADDR bytesWritten, 0
    invoke WriteConsoleA, esi, ADDR inputBuffer, bytesRead, ADDR bytesWritten, 0
    ret

Q5_proc ENDP


Q6_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q6_prompt, LENGTHOF Q6_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, 1, ADDR bytesRead, 0

    invoke WriteConsoleA, esi, ADDR Q6_outputLabel, LENGTHOF Q6_outputLabel - 1, ADDR bytesWritten, 0

    sub inputBuffer, "0"
    cmp inputBuffer, 5
    jge L6
       mov inputBuffer, "D"
       jmp endok
    L6:
        cmp inputBuffer, 7
        jge L7
        mov inputBuffer, "C"
        jmp endok

    L7:
            cmp inputBuffer, 9
        jge L8
        mov inputBuffer, "B"
        jmp endok
    L8:
        mov inputBuffer, "A"
    endok:
        invoke WriteConsoleA, esi, ADDR inputBuffer, bytesRead, ADDR bytesWritten, 0
    ret

Q6_proc ENDP


Q7a_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q7a_prompt, LENGTHOF Q7a_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, 1, ADDR bytesRead, 0
    sub inputBuffer, "0"
    mov bh, inputBuffer
    outer:
        mov bl, 5
        inner:
            invoke WriteConsoleA, esi, ADDR starbuffer, bytesRead, ADDR bytesWritten, 0
            dec bl
        cmp bl, 0
        jne inner
        dec bh
    invoke WriteConsoleA, esi, ADDR new_line, LENGTHOF new_line, ADDR bytesWritten, 0

    cmp bh, 0
    jne outer
    

    ; Display the input as output
    ret

Q7a_proc ENDP


Q7b_proc proc
; Get standard input handle (keyboard)
    invoke GetStdHandle, -10
    mov edi, eax ; Store the handle in edi

    ; Get standard output handle (console screen)
    invoke GetStdHandle, -11
    mov esi, eax ; Store the handle in esi

    ; Display a prompt
    invoke WriteConsoleA, esi, ADDR Q7a_prompt, LENGTHOF Q7a_prompt - 1, ADDR bytesWritten, 0

    ; Read input from the user
    invoke ReadConsoleA, edi, ADDR inputBuffer, 1, ADDR bytesRead, 0
    sub inputBuffer, "0"
    mov bh, inputBuffer
    mov al, 1
    outer:
        mov bl, 0
        inner:
            invoke WriteConsoleA, esi, ADDR starbuffer, bytesRead, ADDR bytesWritten, 0
            inc bl
        cmp bl, count
        jne inner
        inc count
        dec bh
    invoke WriteConsoleA, esi, ADDR new_line, LENGTHOF new_line, ADDR bytesWritten, 0

    cmp bh, 0
    jne outer
    
    invoke WriteConsoleA, esi, ADDR new_line, LENGTHOF new_line, ADDR bytesWritten, 0


    mov bh, inputBuffer
    outer2:
        mov bl, 0
        inner2:
            invoke WriteConsoleA, esi, ADDR starbuffer, bytesRead, ADDR bytesWritten, 0
            inc bl
        cmp bl, bh
        jne inner2
        dec bh
    invoke WriteConsoleA, esi, ADDR new_line, LENGTHOF new_line, ADDR bytesWritten, 0

    cmp bh, 0
    jne outer2



    ret



Q7b_proc ENDP



END main

