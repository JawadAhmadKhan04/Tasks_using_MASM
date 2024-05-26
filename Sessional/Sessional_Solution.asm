; Jawad Ahmad Khan 22I-0791 

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	; QUESTION 1
	arr1 db 13, 5, 3, 7, 9, 44, 11, 12, 20, 10

	; QUESTION 2
	power db 16
	number dd 2
.code
main PROC
    
	; QUESTION 1
	
	mov cl, 0
	mov dl, 0
	mov esi, offset arr1

	OUTER:
		mov al, [esi]
		mov edi, offset arr1
		POS:
			mov bl, -1
			inc bl
			inc edi
			cmp bl, cl
			jne POS

		mov dl, bl

		INNER:
			mov bl, [edi]
			cmp al, bl
			jb L4
				mov [edi], al
				mov [esi], bl

			L4:
			inc dl
			inc edi
			cmp dl, 10
			jb INNER
		inc cl
		inc esi
	jne OUTER

	

	; QUESTION 2
	cmp power, 0
	je L1
	
	mov eax, number
	mov cl, 1
	L2:
		mul number
		inc cl
		cmp cl, power
		jne L2
		mov number, eax
		jp L3

	
	L1:	
		mov number, 1

	L3:


	; QUESTION 3
	; WHEN IS IT SET?
	; It is set when dividing a smaller number with a larger number usually
	; It is also set when we take the XOR of the carry bit and the carry/borrow BIT of the MSB
	; EXAMPLE
	; if we add 2 numbers, 1000 0000b and 1000 0000b, the carry would be 1 as well and the carry bit of the MSB would be 0. it would take XOR of them
	; the answer would be 1 so overfow flag set
	
	; HOW NEG NUMBERS WORK IN ASSEMBLY
	; they are stored in 2's compliment form
	; example
	; if we write -1 in al it would be stored as FFFFFFFE the computer would take the 2's complement and store it

	INVOKE ExitProcess,0
main ENDP
END main
