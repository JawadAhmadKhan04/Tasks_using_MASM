.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
	arr1 db 1,2,3,4,5
	length_arr1 db ($ - arr1)
	size_arr1 db sizeof arr1

	arr2 dw 11, 12, 13,14,15
	length_arr2 db ($ - arr2)
	size_arr2 db sizeof arr1


	arr3 dd 21,22,23,24,25
	length_arr3 db ($ - arr3)
	size_arr3 db sizeof arr1

	
	type_arr1 db 0
	type_arr2 db 0
	type_arr3 db 0

	off_arr1 dd 0
	off_arr2 dd 0
	off_arr3 dd 0


.code
main proc
	mov type_arr1, type arr1
	mov type_arr2, type arr2
	mov type_arr3, type arr3

	mov esi, offset arr1
	mov off_arr1, esi

	mov esi, offset arr2
	mov off_arr2, esi

	mov esi, offset arr3
	mov off_arr3, esi
	

main endp
END main