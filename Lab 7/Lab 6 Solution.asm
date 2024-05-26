.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	; QUESTION1
	odd_arr db 50 dup(0)

	; QUESTION 2
	prime_checker_num db 7

	; QUESTION 3
	arr db 20, 12, 32, 1, 4, 22, 11, 33, 22, 1       ; largest is 32
	largest db 0

	; QUESTION 4
	arr1 db 20, 12, 32, 1, 4, 22, 11, 33, 22, 1, 20, 121, 32, 10, 14, 22, 11, 33, 20, 11  
	odd_arr1 db 8 dup (0)
	even_arr1 db 12 dup(0)

	; QUESTION5
	arr2 db 20, 12, 32, 1, 4, 22, 11, 33, 22, 2       ; smallest is 1
	smallest db 100

	; QUESTION 6
	arr4 db 20, 12, 32, 4, 2, 22, 11, 33, 22, 1       ; second largest is 32, second smallest is 2
	sec_smallest db 200
	sec_largest db 0


	; QUESTION7
	arr3 db 100, -2, -6, 12, 22, -10, 2, 5, 2, 4    
	arr_neg_num db 3 dup(0)

.code
main PROC
	; QUESTION1
	mov esi, offset odd_arr ; storing the offset
	mov al, 1 ; used as a counter
	L1:
		mov bl, al  ; so that value of al is not lost
		and bl, 1   ; turning all bits to 0 other than last
		cmp bl, 0   ; comparing if last bit is 0 or not
		JZ L2       ; only work if odd
			mov [esi], al   ; saving value in memory
			inc esi         ; going to next location address
		L2:
	inc al           ; next number
	cmp al, 100      ; see if number is 100 or not
	JNZ L1           ; back to start if previous condition is false

	; QUESTION2
	mov cl, 0                   ; count the divisors
	mov bl, prime_checker_num   ; will be the divisors
	dec bl                      ; no need to check with itself
	mov ax, 0                   ; used for dividing
	L10:
		movzx ax, prime_checker_num     ; saving the number to ax as it is the dividend
		div bl                          ; divinding, ah would have remainder
		cmp ah, 0                       
		jne L11                         
			inc cl                      ; if remainder is 0 meaning divided, then increase the counter

		L11:
		dec bl                ; decrement the divisor
		cmp bl, 1             ; we know 1 will always divide so no need to check
		jne L10

	cmp cl, 0            ; if cl is 0 then not divided by any between 1 and number itself excluding 1 and number
	jne	L12
		; prime

	L12:

	; QUESTION3
	mov esi, offset arr ; storing offset
	mov al, 0           ; initial val of loop
	mov cl, lengthof arr   ; storing size of arr i.e 10
	
	L3:
		mov bl, [esi]      ; transferring values from arr to bl
		cmp largest, bl    ; comparing the largest and value of arr
		ja L4        
			mov largest, bl    ; transferring value

		L4:
		inc al              ; to next location index record
		inc esi             ; to get next index of array
		cmp al, cl          ; comparing the index number with total length
		jne L3              ; if not equal go to start of loop

	; QUESTION4
	mov esi, offset arr1       ; storing offfset of normal array
	mov edi, offset odd_arr1   ; storing offfset of odd array
	mov ecx, offset even_arr1  ; storing offfset of even array
	mov al, 0                  ; initial val of loop

	L5:
		mov bl, [esi]         ; storing value of normal array to bl
		mov dl, bl            ; copying value to dl so value dont get lost
		and dl, 1             ; and with 1 so all bits become 0 except last bit which remains unchanged
		cmp dl, 0             ; comaring to see number is even or not
		JZ L6                 ; if its odd
			mov [ecx], bl     ; mov to odd array
			inc ecx           ; increment the index of oddarray
		L6:                   ; if it was even
			cmp dl, 0         
			JNZ L7            ;comparing if it wasnt odd cuz L6 would run even if number was even
				mov [edi], bl       ; copyng to even array
				inc edi             ; incrementing value of even index

		L7:
		inc esi               ; incrementing index of normal array
		inc al                ; incrementing index value
		cmp al, lengthof arr  ; comparing if it isnt equal P.S: we are starting from 0 not 1
		jnz L5                ; go to start if false


	; QUESTION5
	mov esi, offset arr2 ; storing offset
	mov al, 0           ; initial val of loop
	mov cl, lengthof arr2   ; storing size of arr i.e 10
	
	L8:
		mov bl, [esi]      ; transferring values from arr to bl
		cmp smallest, bl   ; comparing the smallest and value of arr
		jna L9             ; if not above meaning smaller 
			mov smallest, bl    ; transferring value

		L9:
		inc al              ; to next location index record
		inc esi             ; to get next index of array
		cmp al, cl          ; comparing the index number with total length
		jne L8              ; if not equal go to start of loop


	; QUESTION6
	mov esi, offset arr4  ; storing offset
	mov al, 0             ; initial val of loop
	mov cl, 0             ; for largest
	mov ch, 200           ; for smallest

	L20:
		mov bl, [esi]     ; storing val of arr in bl
		cmp bl, cl      
		jna L21           ; if not above then skip
			mov sec_largest, cl      ; secondlargest will get largest
			mov cl, bl               ; largest will get new largest

		L21:
			cmp bl, sec_smallest    ; if below then skip
			ja L22
				mov sec_smallest, ch      ; storing smallest in sec_smallest
				mov ch, bl                ; updating smallest
		L22:
		inc al                 ; increment the index
		inc esi                ; increment the memory
		cmp al, lengthof arr4       ; compare with size
		jne L20

		cmp sec_smallest, ch      ; chance that sec_smallest is smaller than smallest
		ja L30
			mov sec_smallest, ch      ; change it
		L30:

	; QUESTION7
	mov esi, offset arr3          ; storing offset
	mov edi, offset arr_neg_num    ; storing offset of the negative numbers array
	mov al, 0

	L13:
		mov bl, [esi]           ; storing array value in bl
		mov cl, bl              ; make a copy in cl 
		and cl, 10000000b       ; MSB remains same, remaining becomes 0
		cmp cl, 0               ; comparing with 0
		je L14                
			mov [edi], bl       ; if MSB is still 1 it means negative and stored in neg arr
			inc edi             ; next location 

		L14:

		inc esi                 ; original array next address
		inc al                  ; index number increment
		cmp al, lengthof arr3   ; length and al value compare if arent equal, then go to start
		jne L13

		mov ax,0
	INVOKE ExitProcess,0
main ENDP
END main
