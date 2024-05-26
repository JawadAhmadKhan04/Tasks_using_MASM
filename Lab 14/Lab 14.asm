; Jawad Ahmad Khan
;; 22I-0791
; C

; All 3 questions are working fine

include Irvine32.inc
INCLUDE macros.inc
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
.data

   promptQ2 DB "Enter number: ", 0
    prime_number DB "Prime Number ", 0
    composite_number DB "Composite Number ", 0
    number1 DD 1 Dup(?)

    StudentRecord STRUCT
        id DB "aaaaaaaaaaaa"
        names DB "aaaaaaaaaaaaaaaa"
        age db "aaaaaaaaaaaaa"
        grade db "aaaaaaaaaaaa"
    StudentRecord ENDS

    S1 StudentRecord <>

    temp db 0

.CODE
main Proc

  mWrite "Enter your ID : "
   mov edx , offset S1.id
   mov ecx , 255
   call readString

   mWrite "Enter your name : "
   mov edx , offset S1.names
   mov ecx , 255
   call readString

   mWrite "Enter your age : "
   mov edx , offset S1.age
   mov ecx , 255
   call readString

   mWrite "Enter your Grade : "
   mov edx , offset S1.grade
   mov ecx , 255
   call readString


   call crlf

    mWrite "Your ID is : "
   mov edx , offset S1.id
   call writeString


   call crlf

   mWrite "Your NAME is : "
   mov edx , offset S1.names
   call writeString

   call crlf

   mWrite "Your AGE is : "
   mov edx , offset S1.age
   call writeString

   call crlf

   mWrite "Your GRADE is : "
   mov edx , offset S1.grade
   call writeString

   call crlf


     call q2
       call crlf

     call q3


call crlf




main ENDP

q3 proc
        mov ecx, 100  
    mov eax, 1      

    fizzBuzzLoop:
        
        cmp eax, 101
        je endLoop
        
        mov ecx, eax    

        mov bx, 3
        mov dx, 0
        div bx
        cmp dx, 0
        je printFizz

        mov eax, ecx
        mov dx, 0
        mov bx, 5
        div bx
        cmp dx, 0
        je printBuzz

        mov eax, ecx
        jmp printNumber

    printFizz:
        mov bx, 5
        div bx
        cmp dx, 0
        je printFizzBuzz
        mWrite"FIZZ", 0
        jmp continueLoop

    printBuzz:
        mWrite "BUZZ", 0
        jmp continueLoop

    printFizzBuzz:
        mWrite "FIZZBUZZ", 0
        jmp continueLoop

    printNumber:
        call writedec
        

    continueLoop:
        call crlf 
        mov eax, ecx
        inc eax           
        jmp fizzBuzzLoop  

    endLoop:
    ret
q3 endp




q2 Proc

mov edx, offset promptQ2   
    call writestring    

mov eax , 0
    call readint   
    mov number1, eax


mov al , byte ptr number1

cmp al ,1
je composite_hai_yaar

cmp al , 3
jnle checkprime
jmp prime_hai_yaar

checkprime:
mov ecx , number1
dec ecx
mov eax , number1
mov ebx , 0
L1:
mov bl , cl
div bl
cmp ah ,0
je composite_hai_yaar
mov eax , number1

cmp cl,2
je prime_hai_yaar
loop l1

jmp khatam

prime_hai_yaar:
mov edx, offset prime_number   
    call writestring    
jmp khatam

composite_hai_yaar:
mov edx, offset composite_number  
    call writestring   


khatam:
ret
q2 ENDP

END main