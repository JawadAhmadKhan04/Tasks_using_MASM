; JAWAD AHMAD KHAN
; 22I-0791
; C
; All 3 questions are working perfectly
Include irvine32.inc
Include macros.inc
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
    factorail_answer dword 1
    name_user BYTE 50 dup(?)
    roll_no BYTE 50 dup(?)
    hometown BYTE 50 dup(?)
    vowels db 0
    consonant db 0
    fileHandle dword 0
    buffersize = 5000
    data_length dword 0
    file_name_prompt BYTE "Enter File name: ", 0
    file_name BYTE 255 dup(?)
    file_data BYTE "Hello my name is Jawad. My hometown is Islamabad. My roll Number is 0791. I love assembly language and I dont mind repeating it", 0

.code
main PROC

  mov edx, offset file_name_prompt
  call writestring

  mov edx, offset file_name
  mov ecx, buffersize
  call readstring

  mov eax, lengthof file_data
  mov data_length, eax

  call CreateOutputFile
  mov fileHandle, eax

  mov eax, fileHandle
  mov edx, offset file_data
  mov ecx, data_length
  call WriteToFile

  mov edx, offset file_name
  call OpenInputFile
  mov fileHandle, eax
  mov edx, offset file_data
  mov ecx, buffersize
  call ReadFromFile

  mov ebx, lengthof file_data
  mov data_length, ebx

  mov esi, offset file_data
  mov ecx, 0
  
  loop1:
      cmp ecx, data_length
      je loop3
      mov dl, [esi]
      
      cmp dl, 'a'
      je vowel_stop

      cmp dl, 'e'
      je vowel_stop

      cmp dl, 'i'
      je vowel_stop

      cmp dl, 'o'
      je vowel_stop

      cmp dl, 'u'
      je vowel_stop

      cmp dl, ' '
      je loop2

      consonant_stop:
          inc consonant
          jmp loop2

      vowel_stop:
          inc vowels
          

     


      loop2:
          inc esi
          inc ecx
          jmp loop1

  loop3:

  mov eax, 0

  mWrite "Vowel count: "
  mov al, vowels
  call writeint
  call crlf
  mWrite "Consonant count: "
  mov al, consonant
  call writeint

  mov esi, offset name_user
  mov ebx, 0
  mov bl, 17
  mov bh, 22

  mov edi, offset file_data
  mov cl, 0
  loop6:
      cmp cl, bl
      je loop5
      inc edi
      inc cl
      jmp loop6

  loop5:
      mov al, [edi]
      mov [esi], al
      inc bl
      inc edi
      inc esi
      cmp bl, bh
      jne loop5

  call crlf
  mWrite "NAME: "
  mov edx, offset name_user
  call writestring
  call crlf

  mov esi, offset roll_no

   mov bl, 68
  mov bh, 72

  mov edi, offset file_data
  mov cl, 0
  loop7:
      cmp cl, bl
      je loop8
      inc edi
      inc cl
      jmp loop7

  loop8:
      mov al, [edi]
      mov [esi], al
      inc bl
      inc edi
      inc esi
      cmp bl, bh
      jne loop8

  mWrite "ROLL NO: "
  mov edx, offset roll_no
  call writestring
  call crlf

   mov esi, offset hometown

   mov bl, 39
  mov bh, 48

  mov edi, offset file_data
  mov cl, 0
  loop9:
      cmp cl, bl
      je loop10
      inc edi
      inc cl
      jmp loop9

  loop10:
      mov al, [edi]
      mov [esi], al
      inc bl
      inc edi
      inc esi
      cmp bl, bh
      jne loop10

  mWrite "Hometown: "
  mov edx, offset hometown
  call writestring
  call crlf

  mov eax, fileHandle
  call CloseFile

    mWrite "Enter a name greater than 0: "    
    call readint
    inc eax
    
    call factorial

    call crlf
    mov factorail_answer, ebx
    mWrite "The factorail is: "
    mov eax, factorail_answer
    call writeint

    exit
main ENDP

factorial PROC
    
    cmp eax, 1
    jbe baseCase

    dec eax
    push eax 
    call factorial
    pop eax 

    
    imul ebx, eax

    ret

    baseCase:
    mov ebx, 1 
    ret

factorial ENDP

END main



