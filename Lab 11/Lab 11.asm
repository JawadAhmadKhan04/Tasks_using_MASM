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
