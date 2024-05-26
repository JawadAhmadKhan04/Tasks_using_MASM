; Jawad Ahmad Khan
; 22I-0791
; C
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    count1 db 0
    count2 db 0


.code
main PROC
    
    ; QUESTION1
    mov ax, 1
    L1:
        SHL ax, 1
        inc count1
        cmp ax, 0
        jne L1

    ; QUESTION 2
    mov ax, 65535
    L2:
        SHR ax, 1
        inc count2
        cmp ax, 1
        jne L2

    mov dx, 0
    mov eax, 0
    ; QUESTION 3
    mov ax, -22 ; ax would have 65514 after 2's complement
    mov bx, 63  ; bx would have 63
    imul ax, bx ; ax would have 64150 as 22 * 63 is 1386 and its 2's complement is 64150, dx would remain empty

    mov ax, -4 ; ax would have 65532 after 2's complement
    mov bx, 56 ; bx would be 56
    imul ax,bx ; ax would be 65312 as 4 * 56 is 224 and its 2's complement is 65312

    mov ax, -7896 ; ax would be 57640 after 2's complement
    mov bx, 2552 ; bx would be 2552
    imul ax,bx   ; ax would be 34496 as 2552 * 7896 is 20150592 and its 2's complement is 34496

    mov ax, -2554 ; ax would be 62982 after 2's complement
    mov bx, -1221 ; bx would be 64315 after 2's complement
    imul ax,bx ; ax would be 62982 

    ; QUESTION 4
    mov ax, -15 ; ax would 65521 as 2's complement taken
    mov bl, 3 ; bl would have 3
    idiv bl ; ah would have 0, al would have 251 as it's 2's complement of -5

    mov ax, -33 ; ax would have 65503 as 2's complement taken
    mov bl, 2 ; bl would have 2
    idiv bl ; ah would have 240 as 2's complement of 16, al would have 255 as 2's complement of 1

    mov ax, 101 ; ax would have 101
    mov bl, -2 ; bl would have 254 as 2's complement of 2
    idiv bl ; ah would have 1 as remainder, al would have 206 as 2's complement of 50

    mov ax, 151 ; ax would have 151
    mov bl, -14 ; bl would have 242 as 2' complement of 14
    idiv bl ; ah would have 11 as remainder and 246 as 2's complement of -10
    


    ; QUESTION 5
    ; SAR 1 WOULD MOVE ALL BITS RIGHT BY 1, THE PREVIOUS MSB BIT WOULD NOW BE THE NEW MSB BIT, LSB would be in carry
    ; SAL 1 WOULD MOVE ALL BITS LEFT  BY 1, NO BITS ARE PRESERVED, LSB BECOMES 0 AUTOMATICALLY
    mov ax, 100010001b
    mov bx, 100010001b
    SAR ax, 1   ; shift all bits right by 1: MSB was 1, so new MSB would also be 1. final answer should be: 00000000 10001000b
    SAL bx, 1   ; shift all bits left by 1: final answer should be: 00000010 00100010b

    mov ax, 0
    mov bx, 0
    mov al, 00011000b
    mov bl, 00011000b
    SAR al, 1  ; shift all bits right by 1: MSB was 0, so new MSB would also be 0. final answer should be: 00001100b
    SAL bl, 1  ; shift all bits left by 1: final answer should be: 00110000b

    mov al, 11111011b
    mov bl, 11111011b
    SAR al, 1  ; shift all bits right by 1: MSB was 1, so new MSB would also be 1. final answer should be: 11111101b
    SAL bl, 1  ; shift all bits left by 1:  final answer should be: 11111010b

    mov al, 00000010b
    mov bl, 00000010b
    SAR al, 1  ; shift all bits right by 1: MSB was 0, so new MSB would also be 0. final answer should be: 00000001b
    SAL bl, 1  ; shift all bits left by 1: LSB was 0, so new LSB would also be 0. final answer should be: 00000100b

    mov al, 10101010b
    mov bl, 10101010b
    SAR al, 1  ; shift all bits right by 1: MSB was 1, so new MSB would also be 1. final answer should be: 11010101b
    SAL bl, 1  ; shift all bits left by 1: final answer should be: 00000100b

    ; QUESTION 6
    ; ROR 1 would shift all bits right by 1 and would make the previous LSB the new MSB
    ; ROL 1 would shift all bits left by 1 and would make the previous MSB the new LSB
    mov al, 10101011b
    mov bl, 10101011b
    ROL al, 1 ; shift all bits  left by 1: previous MSB was 1, so new LSB would be 1: final answer: 01010111b
    ROR al, 1 ; shift all bits right by 1: previous LSB was 1, so new MSB would be 1: final answer: 11010101b

    mov al, 00110011b
    mov bl, 00110011b
    ROL al, 1 ; shift all bits  left by 1: previous MSB was 0, so new LSB would be 0: final answer: 01100110b
    ROR al, 1 ; shift all bits right by 1: previous LSB was 1, so new MSB would be 1: final answer: 10011001b

    mov al, 10001000b
    mov bl, 10001000b
    ROL al, 1 ; shift all bits  left by 1: previous MSB was 1, so new LSB would be 1: final answer: 00010001b
    ROR al, 1 ; shift all bits right by 1: previous LSB was 0, so new MSB would be 0: final answer: 01000100b

    mov al, 11110000b
    mov bl, 11110000b
    ROL al, 1 ; shift all bits  left by 1: previous MSB was 1, so new LSB would be 1: final answer: 11100001b
    ROR al, 1 ; shift all bits right by 1: previous LSB was 0, so new MSB would be 0: final answer: 01111000b

    mov al, 00101101b
    mov bl, 00101101b
    ROL al, 1 ; shift all bits  left by 1: previous MSB was 0, so new LSB would be 0: final answer: 01011010b
    ROR al, 1 ; shift all bits right by 1: previous LSB was 1, so new MSB would be 1: final answer: 10010110b

    ; QUESTION 7
    ; RCL PERFORMS ROTATION  LEFT WITH CARRY, CARRY WOULD BECOME THE LSB, MSB WOULD BECOME THE CARRY
    ; RCR PERFORMS ROTATION RIGHT WITH CARRY, CARRY WOULD BECOME THE MSB, LSB WOULD BECOME THE CARRY
    mov al, 01011110b
    mov bl, 01011110b
    RCL al, 1 ; shift all bits  left by 1: CARRY was 0, LSB becomes 0, Carry becomes MSB, i.e 0: final answer: 10111100b
    RCR bl, 1 ; shift all bits right by 1: CARRY was 0, MSB becomes 0, Carry becomes LSB, i.e 0: final answer: 00101111b

    mov al, 11100011b
    mov bl, 11100011b
    RCL al, 1 ; shift all bits  left by 1: CARRY was 0, LSB becomes 0, Carry becomes MSB, i.e 1: final answer: 11000110b
    RCR bl, 1 ; shift all bits right by 1: CARRY was 1, MSB becomes 1, Carry becomes LSB, i.e 1: final answer: 11110001b

    mov al, 10101000b
    mov bl, 10101000b
    RCL al, 1 ; shift all bits  left by 1: CARRY was 1, LSB becomes 1, Carry becomes MSB, i.e 1: final answer: 01010001b
    RCR bl, 1 ; shift all bits right by 1: CARRY was 1, MSB becomes 1, Carry becomes LSB, i.e 0: final answer: 11010100b

    mov al, 00110011b
    mov bl, 00110011b
    RCL al, 1 ; shift all bits  left by 1: CARRY was 0, LSB becomes 0, Carry becomes MSB, i.e 0: final answer: 01100110b
    RCR bl, 1 ; shift all bits right by 1: CARRY was 0, MSB becomes 0, Carry becomes LSB, i.e 1: final answer: 00011001b

    mov ax, 111001111b ; saved as 00000001 11001111b
    mov bx, 111001111b ; saved as 00000001 11001111b
    RCL ax, 1 ; shift all bits  left by 1: CARRY was 1, LSB becomes 1, Carry becomes MSB, i.e 0: final answer: 00000011 10011111b
    RCR bx, 1 ; shift all bits right by 1: CARRY was 0, MSB becomes 0, Carry becomes LSB, i.e 1: final answer: 00000000 11100111b

	INVOKE ExitProcess,0
main ENDP
END main
