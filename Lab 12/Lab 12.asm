; JAWAD AHMAD KHAN
; 22I-0791
; C

; Q1, Q2 AND Q3 ARE WORKING PERFECTLY
; Q5 IS WORKING WEIRD, COINS ARE GENERATING RANDOMLY BUT SOMETIMES THEY ARE GENERATED OUT OF THE SCREEN SO IT DOESNT SHOW
;                       ISSUE WHEN PLAYER MOVES OUT OF THE SCREEN, OTHERWISE LOOKS FINE
; Q4 doesn't work, may ignored, can't figure out properly due to less time

Include irvine32.inc
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	Q1_prompt_row BYTE "Enter row number: ", 0
	Q1_prompt_col BYTE "Enter coloumn number: ", 0
	starbuffer db "*"
	Q2_prompt_general BYTE "Kindly view the color palet and choose one of them", 0dh, 0ah,
		"Enter 1: Yellow & Green", 0ah, 0dh,
		"Enter 2: Blue & Yellow", 0ah, 0dh,
		"Enter 3: Red & Gray", 0ah, 0dh,
		"Enter 4: Magenta & Brown", 0ah, 0dh,
		"Enter 5: LightCyan & Cyan:  ", 0
	Q2_final_prompt BYTE "Hello: Color changed"
	YellowTextOnGreen DD (yellow + (green *16))
	BlueTextOnYellow DD Blue+(yellow * 16)
	RedTextOnGrey DD red+(Gray*16)
	MagentaTextOnBrown DD Magenta + (brown* 16)
	lightCyanTextOnCyan DD lightCyan+ (Cyan*16)
	Q3_color BYTE "Enter a number for color: ", 0
	Q4_rectanglelength_prompt BYTE "Enter the length: ", 0
	Q4_rectanglewidth_prompt BYTE "Enter the width: ", 0
	Q4_color_border_prompt BYTE "Enter border color: ", 0
	Q4_color_rectangle_prompt BYTE "Enter rectangle color: ", 0
	Q4_rectangle_row_pos BYTE "Enter row of rectangle: ", 0
	Q4_rectangle_col_pos BYTE "Enter col of rectangle: ", 0
	buffer1 BYTE "-"
	length2 db ?
	width2 db ?
	row db ?
	col db ?

	ground BYTE "------------------------------------------------------------------------------------------------------------------------",0

	strScore BYTE "Your score is: ",0
	score BYTE 0

	xPos BYTE 20
	yPos BYTE 20

	xCoinPos BYTE ?
	yCoinPos BYTE ?

	inputChar BYTE ?


.code
main PROC
	call Q1_proc
	;call Q2_proc
	;call Q3_proc
	;call Q4_proc
	;call Q5_proc

exit
main endp

Q5_proc PROC
; draw ground at (0,29):
	mov dl,0
	mov dh,29
	call Gotoxy
	mov edx,OFFSET ground
	call WriteString

	call DrawPlayer

	call CreateRandomCoin
	call DrawCoin

	call Randomize

	; gravity logic:
		gravity:
		cmp yPos,27
		jg onGround
		; make player fall:
		call UpdatePlayer
		inc yPos
		call DrawPlayer
		mov eax,80
		call Delay
		jmp gravity

	gameLoop:

		; getting points:
		mov bl,xPos
		cmp bl,xCoinPos
		jne notCollecting
		mov bl,yPos
		cmp bl,yCoinPos
		jne notCollecting
		; player is intersecting coin:
		inc score
		call CreateRandomCoin
		call DrawCoin
		notCollecting:

		mov eax,white (black * 16)
		call SetTextColor

		; draw score:
		mov dl,0
		mov dh,0
		call Gotoxy
		mov edx,OFFSET strScore
		call WriteString
		mov al,score
		call WriteInt

		; gravity logic:

		onGround:

		; get user key input:
		call ReadChar
		mov inputChar,al

		; exit game if user types 'x':
		cmp inputChar,"x"
		je exitGame

		cmp inputChar,"w"
		je moveUp

		cmp inputChar,"s"
		je moveDown

		cmp inputChar,"a"
		je moveLeft

		cmp inputChar,"d"
		je moveRight

		moveUp:
		; allow player to jump:
		call UpdatePlayer
		dec yPos		
		call DrawPlayer
		jmp gameLoop

		moveDown:
		call UpdatePlayer
		inc yPos
		call DrawPlayer
		jmp gameLoop

		moveLeft:
		call UpdatePlayer
		dec xPos
		call DrawPlayer
		jmp gameLoop

		moveRight:
		call UpdatePlayer
		inc xPos
		call DrawPlayer
		jmp gameLoop

	jmp gameLoop

	exitGame:

	ret
Q5_proc endp

DrawPlayer PROC
	; draw player at (xPos,yPos):
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al,"X"
	call WriteChar
	ret
DrawPlayer ENDP

UpdatePlayer PROC
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al," "
	call WriteChar
	ret
UpdatePlayer ENDP

DrawCoin PROC
	mov eax,yellow (yellow * 16)
	call SetTextColor
	mov dl,xCoinPos
	mov dh,yCoinPos
	call Gotoxy
	mov al,"X"
	call WriteChar
	ret
DrawCoin ENDP

CreateRandomCoin PROC
	mov eax,55
	inc eax
	call RandomRange
	mov xCoinPos,al
	call RandomRange
	mov yCoinPos,al
	ret
CreateRandomCoin ENDP

Q4_proc PROC
	mov edx, offset Q4_rectanglelength_prompt
	call writestring

	call readint

	mov length2, al

	mov edx, offset Q4_rectanglewidth_prompt
	call writestring

	call readint
	mov width2, al

	mov edx, offset Q4_color_border_prompt
	call writestring

	call setTextColor

	call readint
	mov bl, al

	mov edx, offset Q4_color_rectangle_prompt
	call writestring
	call readint
	mov cl, al

	mov edx, offset Q4_rectangle_row_pos
	call writestring
	call readint
	mov row, al
	mov dl, al
	mov edx, offset Q4_rectangle_col_pos
	call writestring
	call readint
	mov col, al
	mov dh, al

	; first row
	mov edx, offset buffer1
	call Gotoxy
	mov cl, col
	L10:
		call writestring
		dec cl
		cmp cl, 0
		jne L10


	ret
Q4_proc endp


Q3_proc PROC

	mov edx, offset Q3_color
	call writestring
	call readint

	call SetTextColor

	mov edx, offset Q1_prompt_row
	call writestring

	call readint
	mov ecx, eax

	mov edx, offset Q1_prompt_col
	call writestring

	call readint

	mov dl, cl
	mov dh, al

	call clrscr
	
	call Gotoxy
		mov edx, offset Q2_final_prompt

	call writestring

	ret
Q3_proc endp

Q2_proc PROC
	
	mov edx, offset Q2_prompt_general
	call writestring

	call readint

	mov edx, offset Q2_final_prompt

	cmp al, 1
	jne L2
		mov eax, YellowTextOnGreen
		jmp L6

	L2:
	cmp al, 2
	jne L3
		mov  eax, BlueTextOnYellow 
		jmp L6

	L3:
	cmp al, 3
	jne L4
		mov eax, RedTextOnGrey 
		jmp L6

	L4:
	cmp al, 4
	jne L5
		mov eax, MagentaTextOnBrown 
		jmp L6

	L5:
	cmp al, 5
	jne L6
		mov eax, lightCyanTextOnCyan 
		jmp L6

	L6:
		call setTextColor
		call Clrscr
		call writestring

	ret
Q2_proc endp


Q1_proc PROC
	mov edx, offset Q1_prompt_row
	call writestring

	call readint
	mov ecx, eax

	mov edx, offset Q1_prompt_col
	call writestring

	call readint

	mov dl, cl
	mov dh, al

	call clrscr
	
	call Gotoxy
		mov edx, offset starbuffer

	call writestring
	


	ret
Q1_proc endp

end main