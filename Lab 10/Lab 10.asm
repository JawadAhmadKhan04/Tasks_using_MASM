; Jawad Ahmad Khan
; 22I-0791
; C
; LAB 10

; Q1, Q2, Q3, Q4, Q5, Q6 working perfectly
; Q7 works only till 7, and stars formulae used is 2*n instead of 2*n+1, talked to sir previously in class
Include irvine32.inc
.data
	Q1_prompt BYTE "Enter Character, if you enter more, only 1 will be outputted: ",0
	Q1_result BYTE "Smaller is: ", 0
	upper db 255 dup(?)

	Q2_prompt BYTE "Enter an index: ",0
    Q2_outputLabel BYTE "Data at that index: ",0
    q2_data byte 9, 2,1,3,7,6,4,3,2,0
	index_entered byte ?
	
	q3_prompt BYTE "Enter a number: ", 0
	q3_output_label BYTE "Sum is: ", 0
	sum dd 0
	
	Q4_prompt BYTE "Enter Character, if you enter more, only 1 will be outputted: ",0
	Q4_result BYTE "Previous character is: ", 0
	char db 255 dup(?)

	Q5_prompt1 BYTE "Enter a number: ", 0
	Q5_prompt2 BYTE "Enter power: ", 0
	Q5_output_label BYTE "Answer is: ", 0

	Q6_prompt BYTE "Enter marks: ",0
    Q6_outputLabel BYTE "Your grade: ",0
	Q6_grade BYTE ?

	Q7a_prompt BYTE "Enter a number: ",0
    new_line db 10
    starbuffer db "*"
    count db 1

.code
main PROC	

	;call Q1_PROC
	;call Q2_PROC
	;call Q3_PROC
	;call Q4_PROC
	;call Q5_PROC
	;call Q6_PROC
	;call Q7a_PROC
	;call Q7b_PROC
	call Q7c_PROC

exit
main endp


Q7c_PROC
	ret

Q7c_PROC ENDP



Q7b_PROC proc
	mov edx, offset Q7a_prompt
	call writestring

	call readint

	mov edx, offset starbuffer

	mov ecx, eax
	outer2:
		mov ebx, ecx
		inner2:
			call writestring
			dec ebx
			cmp ebx, 0
			jne inner2
		dec ecx
		call crlf
		cmp ecx, 0
		jne outer2

	ret
Q7b_PROC ENDP

Q7a_PROC proc
	mov edx, offset Q7a_prompt
	call writestring

	call readint

				mov edx, offset starbuffer

	 mov bh, al
    mov al, 1
    outer:
        mov bl, 0
        inner:
			call writestring
            inc bl
        cmp bl, count
        jne inner
        inc count
        dec bh
    call crlf

    cmp bh, 0
    jne outer

	ret
Q7a_PROC ENDP

Q6_PROC proc
	mov edx, offset Q6_prompt
	call writestring

	call readint

	 cmp eax, 5
    jge L6
       mov Q6_grade, "D"
       jmp endok
    L6:
        cmp eax, 7
        jge L7
        mov Q6_grade, "C"
        jmp endok

    L7:
            cmp eax, 9
        jge L8
        mov Q6_grade, "B"
        jmp endok
    L8:
        mov Q6_grade, "A"
    endok:
	
	mov edx, offset Q6_outputLabel
	call writestring

	mov edx, offset Q6_grade
	call writestring

	ret
Q6_PROC ENDP

Q5_PROC proc
	mov edx, offset Q5_prompt1
	call writestring

	call readint
	mov bl, al

	mov edx, offset Q5_prompt2
	call writestring

	call readint
	mov ecx, eax

	mov eax, 1

	LOOP5:
		mul bl
		LOOP LOOP5

	mov edx, offset Q5_output_label
	call writestring
	call writeint

	ret
Q5_PROC ENDP

Q4_PROC proc
	mov edx, offset Q4_prompt
	call writestring

	mov edx, offset char
	mov ecx, 255
	call readstring

	sub char, 1
	
	mov edx, offset Q4_result
	call writestring

	mov edx, offset char
	call writestring

	ret
Q4_PROC ENDP

Q3_PROC proc
	
	mov ecx, 5
	LOOP3:
		mov edx, offset q3_prompt
		call writestring
		
		call readint
		add sum, eax
		LOOP LOOP3

	mov edx, offset q3_output_label
	call writestring

	mov eax, sum
	call writeint

	ret
Q3_PROC ENDP




Q2_PROC proc
	mov edx, offset Q2_prompt
	call writestring

	call readint

	mov edx, offset Q2_outputLabel
	call writestring

	mov ecx, eax
	mov esi, offset q2_data
	Loop1:
		inc esi
	LOOP Loop1
	mov bl, [esi]
	mov eax, 0
	mov al, bl

	
	call writeint


	ret
Q2_PROC ENDP

Q1_PROC proc
	mov edx, offset Q1_prompt
	call writestring

	mov edx, offset upper
	mov ecx, 255
	call readstring

	or upper, 32

	mov edx, offset Q1_result
	call writestring

	mov edx, offset upper
	call writestring
	ret
Q1_proc ENDP


end main







; Jawad Ahmad Khan
; 22I-0791
; C
; LAB 10

; Q1, Q2, Q3, Q4, Q5, Q6 working perfectly
; Q7 works only till 7, and stars formulae used is 2*n instead of 2*n+1, talked to sir previously in class
Include irvine32.inc
.data
	Q1_prompt BYTE "Enter a number: ",0
	Q1_output_prime BYTE "The number is prime.", 0
	Q1_output_notprime BYTE "The number is not prime.", 0

.code
main PROC	
	call Q1_proc
	
exit
main endp

Q1_proc PROC
	mov edx, offset Q1_prompt
	call writestring
	call readint
	mov dl, 0
	mov cx, ax
	dec cx
	cmp cx, 0
	je L3
	loops:
		mov ebx, eax
		div cl
		cmp ah, 0
		jne L1
			inc dl
		L1:
		mov eax, ebx
		dec cx
		cmp cx, 1
		jne loops

	cmp dl, 1
	jne L2
		mov edx, offset Q1_output_notprime
		jmp L3

	L2:
		mov edx, offset Q1_output_prime
	L3:
		call writestring

	ret
Q1_proc endp


end main
