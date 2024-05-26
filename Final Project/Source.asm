Include irvine32.inc
Include macros.inc
Includelib Winmm.lib
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD



PlaySound PROTO,
    pszsound: PTR BYTE,
    hmod: DWORD,
    fdwSound:DWORD

BUFFER_SIZE = 10000

.data

    file_name BYTE "scores.txt", 0
    fileHandle HANDLE ?
    read_buf BYTE BUFFER_SIZE DUP(?)
    newfile_data BYTE 10000 DUP(?)
    new_data BYTE 50 DUP(?)
    score_string BYTE 5 DUP(?)
    file_playername BYTE 20 DUP(?)
    file_playerscore BYTE 5 DUP(?)
    file_playerlevel BYTE 3 DUP(?)

    maze_level3    BYTE "########################################################################################",0
                   BYTE "# ....................................................................................M#",0
                   BYTE "#.###############0###########.###############################################.##########",0
                   BYTE "#.###############.###########.##########################################################",0
                   BYTE "#.########M.........................#........................................M.........#",0
                   BYTE "#.########.###################.####################.#########################.########0#",0
                   BYTE "#.########.###################.........M#M..........#########################.########.#",0
                   BYTE "#..........###################.####################.###################................#",0
                   BYTE "#.########..........................................###################.#####.########.#",0
                   BYTE "#.#################################################.################....#####.########.#",0
                   BYTE "#0########...........................................................########.########.#",0
                   BYTE "#.........M########################################.################............######.#",0
                   BYTE "##########.#######....................0.......#####.###########################..#####.#",0
                   BYTE "##########.......................................................................#####M#",0
                   BYTE "##########.###########.############################.############################.#######",0
                   BYTE "#......................############################.############################.#####.#",0
                   BYTE "#.########0###########M######################............#########.....................#",0
                   BYTE "#.................................................................M#####################",0
                   BYTE "########################################################################################",0

    maze_level2    BYTE "########################################################################################", 0
                   BYTE "# ####################################################################################.#", 0
                   BYTE "#.#.################################################################################.#.#", 0
                   BYTE "#......................................................................................#", 0
                   BYTE "#.#.#####################0##################.########################.##############.#.#", 0
                   BYTE "#.#.#..............................................................................#.#.#", 0
                   BYTE "#.#.#.#.#################.###########################################.############.#.#.#", 0
                   BYTE "#.#.#.#..........................................................................#.#.#.#", 0
                   BYTE "#.#.#.#.#.###############.##################.########################.########.#.#.#.#.#", 0
                   BYTE "#.#.#.#.#.###############0##################.########################.########.#.#.#0#.#", 0
                   BYTE "#.#.#.#.#.###############.##################.########################.##########.#.#.#.#", 0
                   BYTE "#.#.#0#..........................................................................#.#.#.#", 0
                   BYTE "#.#.#.###################.###########################################.############.#.#.#", 0
                   BYTE "#.#.#................................................................................#.#", 0
                   BYTE "#.#.#####################.##################.########################0############.#.#.#", 0
                   BYTE "#......................................................................................#", 0
                   BYTE "#.#.##################################################################################.#", 0
                   BYTE "#..0##################################################################################0#", 0
                   BYTE "########################################################################################", 0

    maze_level1    BYTE "########################################################################################", 0
                   BYTE "# .....................................................................................#", 0
                   BYTE "#......................................................................................#", 0
                   BYTE "#......................................................................................#", 0
                   BYTE "####................................................................................####", 0
                   BYTE "####................................................................................####", 0
                   BYTE "####..###################################..#######################################..####", 0
                   BYTE "####..###################################..#######################################..####", 0
                   BYTE "####..###################################..#######################################..####", 0
                   BYTE "####..###################################..#######################################..####", 0
                   BYTE "####..###################################..#######################################..####", 0
                   BYTE "####..###################################..#######################################..####", 0
                   BYTE "####..###################################..#######################################..####", 0
                   BYTE "####................................................................................####", 0
                   BYTE "####................................................................................####", 0
                   BYTE "#......................................................................................#", 0
                   BYTE "#......................................................................................#", 0
                   BYTE "#......................................................................................#", 0
                   BYTE "########################################################################################", 0




; Title ->
    title1 BYTE "  _____               _____   __      __              __    _  ", 0
    title2 BYTE " |  __ \     /\      / ____| |  \    /  |     /\     |  \  | | ", 0
    title3 BYTE " | |__) |   /  \    | |      |   \  /   |    /  \    |   \ | | ", 0
    title4 BYTE " |  ___/   / _  \   | |      | |\ \/ /| |   / _  \   | |\ \| | ", 0
    title5 BYTE " | |      / ___  \  | |____  | | \__/ | |  / ___  \  | | \   | ", 0
    title6 BYTE " |_|     /_/   \__\  \_____| |_|      |_| /_/   \__\ |_|  \__| ", 0
;<- Title
    title_row db 0
    title_col db 0

    play1 BYTE "  _____    _                  __     __", 0
    play2 BYTE " |  __ \  | |           /\    \ \   / /", 0
    play3 BYTE " | |__) | | |          /  \    \ \ / / ", 0
    play4 BYTE " |  ___/  | |         / _  \    \ / /  ", 0
    play5 BYTE " | |      | |_____   / ___  \    / /   ", 0
    play6 BYTE " |_|      |_______| /_/   \__\  /_/    ", 0

    rules1 BYTE " ______    _    _    _         _______   _______ ", 0
    rules2 BYTE "|  __  \  | |  | |  | |       |  _____| |   ____|", 0 
    rules3 BYTE "| |__|  | | |  | |  | |       | |_____  |  |____ ", 0
    rules4 BYTE "|  _  _/  | |  | |  | |       |  _____| |_____  |", 0
    rules5 BYTE "| | \ \   |  \_/ |  | |_____  | |_____   _____| |", 0
    rules6 BYTE "|_|  \_\   \____/   |_______| |_______| |_______|", 0

    score1 BYTE  " _______    _______    _______    ______     _______ ", 0
    score2 BYTE  "|   ____|  |  _____|  |  ___  |  |  __  \   |  _____|", 0
    score3 BYTE  "|  |____   | |        | |   | |  | |__|  |  | |_____ ", 0
    score4 BYTE  "|_____  |  | |        | |   | |  |  _  _/   |  _____|", 0
    score5 BYTE  " _____| |  | |_____   | |___| |  | | \ \    | |_____ ", 0
    score6 BYTE  "|_______|  |_______|  |_______|  |_|  \_\   |_______|", 0

    house1  BYTE"==================================================.", 0
    house2  BYTE"       .-.   .-.     .--.                         |", 0
    house3  BYTE"      | OO| | OO|   / _.-' .-.   .-.  .-.   .''.  |", 0
    house4  BYTE"      |   | |   |   \  '-. '-'   '-'  '-'   '..'  |", 0
    house5  BYTE"      '^^^' '^^^'    '--'                         |", 0
    house6  BYTE"================.  .-.  .=================.  .-.  |", 0
    house7  BYTE"                | |   | |                 |  '-'  |", 0
    house8  BYTE"                | |   | |                 |       |", 0
    house9  BYTE"                | ':-:' |                 |  .-.  |", 0
    house10 BYTE"                |  '-'  |                 |  '-'  |", 0
    house11 BYTE"================'       '================='       |", 0
    house12 BYTE"                           .-.   .-.  .-.   .''.  |", 0
    house13 BYTE"                           '-'   '-'  '-'   '..'  |", 0
    house14 BYTE"==================================================.", 0

    seperator_vertical BYTE "||", 0
    seperator_horizontal BYTE "=", 0

    walls_levels_dl_value db 1100 dup(?)
    walls_levels_dh_value db 1100 dup(?)
    walls_count dd 0

    food_levels_dl_value db 1100 dup(?)
    food_levels_dh_value db 1100 dup(?)
    food_count dd 0
    food_left dd 0

    fruit_levels_dl_value db 20 dup(?)
    fruit_levels_dh_value db 20 dup(?)
    fruit_count dd 0

    teleportation_dl_value db 20 dup(?)
    teleportation_dh_value db 20 dup(?)
    teleportation_count dd 0
    
    game_level db 3
    game_level_change db 1

    diamond1 BYTE "*     * ****** *****         ***                                  ", 0
             BYTE "*     * *      *       *   *******                                ", 0 
             BYTE "*     * *****  ***     *     ***                                  ", 0
             BYTE "***** * *      *****          *                                   ", 0

    diamond2 BYTE "*     * ****** *****         ***     ***                          ", 0
             BYTE "*     * *      *       *   ******* *******                        ", 0 
             BYTE "*     * *****  ***     *     ***     ***                          ", 0
             BYTE "***** * *      *****          *       *                           ", 0

    diamond3 BYTE "*     * ****** *****         ***     ***     ***                  ", 0
             BYTE "*     * *      *       *   ******* ******* *******                ", 0 
             BYTE "*     * *****  ***     *     ***     ***     ***                  ", 0
             BYTE "***** * *      *****          *       *       *                   ", 0

    diamond4 BYTE "*     * ****** *****         ***     ***     ***     ***          ", 0
             BYTE "*     * *      *       *   ******* ******* ******* *******        ", 0 
             BYTE "*     * *****  ***     *     ***     ***     ***     ***          ", 0
             BYTE "***** * *      *****          *       *       *       *           ", 0

    diamond5 BYTE "*     * ****** *****         ***     ***     ***     ***     ***  ", 0
             BYTE "*     * *      *       *   ******* ******* ******* ******* *******", 0 
             BYTE "*     * *****  ***     *     ***     ***     ***     ***     ***  ", 0
             BYTE "***** * *      *****          *       *       *       *       *   ", 0

    x_pos db 31 
    y_pos db 4

    count dword 0

choose_instruction_option BYTE 255 dup(?)
previous_instruction_option BYTE 255 dup(?)

user_name BYTE 255 dup(?)

score dword 0

lives db 5

ghost_direction db 2 dup(?)
ghost_normal_dl db 2 dup(?) 
ghost_normal_dh db 2 dup(?)

ghost_semis_dl db 2 dup(?)
ghost_semis_dh db 2 dup(?)
ghost_direction_semis db 2 dup(?)

pacman_death db "./pacman_death", 0
pacman_eat_fruit db "./pacman_eatfruit", 0
game_start db "./pacman_beginning.wav", 0
game_end db "./game_end.wav", 0
teleportation_sound db "./teleport_sound.wav", 0

.code

file_reading_scores proc

mov dl, 10
mov dh, 10
call Gotoxy

    mov eax, red
    call setTextColor

    mWrite"NAME"

    mov dl, 60
    mov dh, 10
    call Gotoxy
    mWrite"SCORE"
    
    mov dl, 85
    mov dh, 10
    call Gotoxy
    mWrite"LEVEL"

    call crlf

    mov edx,OFFSET file_name
	call OpenInputFile
	mov fileHandle, eax



    letsOpenFile:

    mov dl, 10
    mov dh, 10
    call Gotoxy
		mov edx, OFFSET read_buf	; Read the file into a buffer
		mov ecx, BUFFER_SIZE
        call ReadFromFile
		;call Writestring
        mov ah, 0
        mov edx, offset read_buf
        mov edi, offset file_playername
        mov esi, offset file_playerscore
        mov ebx, offset file_playerlevel

        A1_begin:
            mov ecx, 15
            mov esi, offset file_playername
            mov al, ' '
            part1:
                mov [esi], al
                inc esi
                loop part1

            mov ecx, 4
            mov esi, offset file_playerscore
            part2:    
                mov [esi], al
                inc esi
                loop part2

            mov ecx, 2
            mov esi, offset file_playerlevel
            part3:    
                mov [esi], al
                inc esi
                loop part3

       ; mov edx, offset read_buf
        mov edi, offset file_playername
        mov esi, offset file_playerscore
        mov ebx, offset file_playerlevel



        A1:
            mov al, [edx]
            cmp al, ','
            je A2before
            cmp al, '+'
            je finish
            inc edx
            mov [esi], al
            inc esi
            jmp A1

        A2before:
            inc edx
        A2:
            mov al, [edx]
            cmp al, ','
            je A3before
            inc edx
            mov [edi], al
            inc edi
            jmp A2
        A3before:
            inc edx
        A3:
            mov al, [edx]
            cmp al, '-'
            je print_data
            inc edx
            mov [ebx], al
            inc ebx
            jmp A3

        print_data:
        inc ah
        inc edx
        push edx
        mov dl, 10
        mov dh, 10
        add dh, ah
        call Gotoxy
        mov edx, offset file_playername
        call writestring

        mov dl, 60
        mov dh, 10
        add dh, ah
        call Gotoxy
        mov edx, offset file_playerscore
        call writestring

        mov dl, 85
        mov dh, 10
        add dh, ah
        call Gotoxy
        mov edx, offset file_playerlevel
        call writestring
        pop edx
	jmp A1_begin
	
    finish:
	mov edx,OFFSET read_buf
	
	call Crlf
	close_file:
		mov eax,fileHandle
		call CloseFile


    ret
file_reading_scores endp

main PROC
  call start_screen
   starting:
    mov game_level, 1
    mov game_level_change, 1
    mov score, 0
   INVOKE PlaySound, offset game_start, NULL, 11h
  call menu_screen

 cmp choose_instruction_option, 'e'
   jne P1
    call thank_you_screen
    ret

    P1:
    call user_name_screen
    call clrscr

    ;jmp exitGame

    mov choose_instruction_option, 'q'
    gameloop:
        cmp game_level_change, 1
        jne no_need_for_updating_walls
        mov game_level_change, 0
        mov x_pos, 31
        mov y_pos, 4
        mov choose_instruction_option, 'q'
        mov lives, 5
        call transferring_walls
        call initializing_ghost

        no_need_for_updating_walls:
            call displaying_walls

        call displaying_data

        call displaying_player

        call display_ghost

        mov al, choose_instruction_option
        mov previous_instruction_option, al

        mov eax, 20
        call Delay
        call ReadKey
        jz not_key_available

        key_available:
        mov choose_instruction_option, al
       
        
        not_key_available:
        mov bl, x_pos
        mov bh, y_pos
        mov dl, x_pos
        mov dh, y_pos
        call Gotoxy
        mWrite" ",0

        cmp choose_instruction_option, 'p'
        je pause_the_game
        
        cmp choose_instruction_option, 'd'
        je check_move_right

        cmp choose_instruction_option, 'w'
        je check_move_up

        cmp choose_instruction_option, 'a'
        je check_move_left

        cmp choose_instruction_option, 's'
        je check_move_down

        mov al, previous_instruction_option
        mov choose_instruction_option, al
        jmp all_instructions_completed

        pause_the_game:
            call pause_menu
            cmp choose_instruction_option, 'r'
            je restart_again

            cmp choose_instruction_option, 'e'
            je exitGame

            mov al, previous_instruction_option
            mov choose_instruction_option, al
            jmp all_instructions_completed

            restart_again:
                mov game_level, 1
                mov game_level_change, 1
                mov score, 0
                jmp gameloop

        check_move_right:
            inc bl
            jmp wall_checker

        check_move_left:
            dec bl
            jmp wall_checker

        check_move_up:
            dec bh
            jmp wall_checker

        check_move_down:
            inc bh
            jmp wall_checker

                wall_checker:


        call ghost_collision
        cmp lives, 0
        je exitGame

            call check_wall_collision
            cmp cl, 0
            jne all_instructions_completed
                mov x_pos, bl
                mov y_pos, bh
        fruit_checker:
            call check_fruit_collision
            cmp cl, 1
            jne teleportation_checker
            INVOKE PlaySound, offset pacman_eat_fruit, NULL, 11h
            add score, 5
            jmp all_instructions_completed

        teleportation_checker:
            call teleportation_collision
            cmp cl, 1
            jne food_checker
            jmp all_instructions_completed

        food_checker:
            call food_collision
            cmp cl, 1
            jne all_instructions_completed
            inc score
            dec food_left
            cmp food_left, 0
            jne all_instructions_completed
            inc game_level
            mov game_level_change, 1
        all_instructions_completed:
      ;  call clrscr
      call ghost_movement

        jmp gameloop


    exitGame:
        INVOKE PlaySound, offset pacman_death, NULL, 11h
        call file_updation
        call end_game
        cmp choose_instruction_option, 'r'
        je starting

        call thank_you_screen
        ret

    exit
main ENDP

file_updation proc
call clrscr
    mov edx,OFFSET file_name
	call OpenInputFile
	mov fileHandle, eax

    

    letsOpenFile:
		mov edx, OFFSET read_buf	; Read the file into a buffer.
		mov ecx, BUFFER_SIZE
		call ReadFromFile
	
	
	close_file1:
		mov eax,fileHandle
		call CloseFile

     mov ah, 0
     mov edx, offset read_buf
     mov edi, offset newfile_data 

     mov ecx, 990
     mov al, ' '
     loopy1:
        mov [edi],al
        inc edi
        loop loopy1

    


     mov edi, offset newfile_data 

     okayyy1:
        mov al, [edx]
        cmp al, '+'
        je outofhere
        mov [edi], al
        inc edi
        inc edx
        jmp okayyy1
    outofhere:

    mov ebx, offset new_data 
    push ebx

     mov ecx, 45
     mov al, ' '
     loopy2:
        mov [ebx],al
        inc ebx
        loop loopy2
    pop ebx

    push ebx
    push ecx
    push edx
    mov edx, 0
    mov cx, 10
    mov bx, 10
    mov eax, score
    mov esi, offset new_data
    add esi, 3
    mov count, 3
    okkaaa:
        mov edx, 0
        div bx
        dec count
        add dx, 30h
        mov [esi], dl
        dec esi
       ; imul bx, cx
        cmp ax, 9
        jg okkaaa

    add al, 30h
    mov [esi], al
    add esi, 4
    sub esi, count
    mov al, ','
    mov [esi], al
    inc esi
    mov edx, offset user_name
    okkkkk:
        cmp al, ' '
        je outtt
        mov al, [edx]
        mov [esi], al
        inc esi
        inc edx
        jmp okkkkk

    outtt:
        mov al, ','
        mov [esi], al
        inc esi
        mov al, game_level
        add al, 30h
        mov [esi], al
        inc esi
        mov al, '-'
        mov [esi], al
        inc esi
        mov al, '+'
        mov [esi], al
    


    pop edx
    pop ecx
    pop ebx

    mov ebx, offset new_data
    add ebx, count

    okayyy2:
        mov al, [ebx]
        mov [edi], al
        inc edi
        inc ebx
        cmp al, '+'
        je outtahere2
        jmp okayyy2

    outtahere2:

	call Crlf
	close_file2:
		mov eax,fileHandle
		call CloseFile

    mov edx, offset file_name
    call CreateOutputFile

    mov fileHandle, eax
    mov edx, offset newfile_data

    mov eax, filehandle
    mov edx, offset newfile_data
    mov ecx, BUFFER_SIZE
    call WriteToFile


    ret
file_updation endp



scoring_menu proc
    call clrscr
    mov eax, white
    call setTextColor
    mov dl, 30
    mov dh, 1
    call Gotoxy
    mWrite"######### ######### ########### ######### ##########", 0
    inc dh
    call Gotoxy
    mWrite"##        ##        ##       ## ##     ## ##        ", 0
    inc dh
    call Gotoxy
    mWrite"##        ##        ##       ## ##     ## ##        ", 0
    inc dh
    call Gotoxy
    mWrite"######### ##        ##       ## ######### ##########", 0
    inc dh
    call Gotoxy
    mWrite"       ## ##        ##       ## ## ##     ##        ", 0
    inc dh
    call Gotoxy
    mWrite"       ## ##        ##       ## ##   ##   ##        ", 0
    inc dh
    call Gotoxy
    mWrite"######### ######### ########### ##     ## ##########", 0

    mov eax, yellow
    call setTextColor

    call file_reading_scores


    mov eax, white
    call setTextColor


    mov edx, offset choose_instruction_option
    mov ecx, 255
    call readstring

    ret
scoring_menu endp

initializing_ghost proc
    
    cmp game_level, 3
    je level3_initialize
    mov [ghost_normal_dl], 31
    mov [ghost_normal_dl + 1], 116

    mov [ghost_normal_dh], 6
    mov [ghost_normal_dh + 1], 18
    
    mov [ghost_direction], 1
    mov [ghost_direction + 1], -1

    cmp game_level, 2
    je level2_initializiation
    ret

    level2_initializiation:
    mov [ghost_semis_dl], 55
    mov [ghost_semis_dl + 1], 99

    mov [ghost_semis_dh], 6
    mov [ghost_semis_dh + 1], 6

    mov [ghost_direction_semis], 1
    mov [ghost_direction_semis + 1], -1

    ret

    level3_initialize:

    ret
initializing_ghost endp

display_ghost proc

    cmp game_level, 3
    je level3_display
    push dx
    push cx
    mov ecx, 2
    mov esi, offset ghost_normal_dl
    mov edi, offset ghost_normal_dh
    loop_display_ghost:
        mov dl, [esi]
        mov dh, [edi]
        call Gotoxy
        mWrite"G"
        inc esi
        inc edi
    loop loop_display_ghost
    pop cx
    pop dx

    cmp game_level, 2
    je level2_display
    ret

    level2_display:
        push dx
    push cx
    mov ecx, 2
    mov esi, offset ghost_semis_dl
    mov edi, offset ghost_semis_dh
    loop_display_ghost2:
        mov dl, [esi]
        mov dh, [edi]
        call Gotoxy
        mWrite"G"
        inc esi
        inc edi
    loop loop_display_ghost2
    pop cx
    pop dx
        

    ret
    level3_display:
    ret
display_ghost endp

ghost_movement proc
    cmp game_level, 3
    je ghost_movement_level3

    push ebx
    push eax
    mov ebx, 0
    mov eax, 0
    mov esi, offset ghost_normal_dl
    mov edi, offset ghost_direction
    mov ebx, offset ghost_normal_dh
    mov ecx, 2

    

    ghost_movement_loop:
        
        mov dl, [esi]
        mov dh, [ebx]
        call Gotoxy
        mWrite" ", 0

        mov al, [esi]
        mov ah, [edi]


        add al, ah
        cmp al, 30
        je reverse_movement
        cmp al, 117
        je reverse_movement
        mov [esi], al

        jmp end_reverse_movement

        reverse_movement:
        cmp ah, 1
        jne reverse_movement2
        mov ah, -1
        mov [edi], ah
        jmp end_reverse_movement
        
        reverse_movement2:
        mov ah, 1
        mov [edi], ah

        end_reverse_movement:
        inc esi
        inc edi
        inc ebx
    loop ghost_movement_loop

    cmp game_level, 2
    je ghost_movement_level2
    pop eax
    pop ebx
    ret

    ghost_movement_level2:
    mov ebx, 0
    mov eax, 0
    mov esi, offset ghost_semis_dh
    mov edi, offset ghost_direction_semis
    mov ebx, offset ghost_semis_dl
    mov ecx, 2

    

    ghost_movement_loop2:
        
        mov dl, [ebx]
        mov dh, [esi]
        call Gotoxy
        mWrite" ", 0

        mov al, [esi]
        mov ah, [edi]


        add al, ah
        cmp al, 5
        je reverse_movement11
        cmp al, 19
        je reverse_movement11
        mov [esi], al

        jmp end_reverse_movement11

        reverse_movement11:
        cmp ah, 1
        jne reverse_movement12
        mov ah, -1
        mov [edi], ah
        jmp end_reverse_movement11
        
        reverse_movement12:
        mov ah, 1
        mov [edi], ah

        end_reverse_movement11:
        inc esi
        inc edi
        inc ebx
    loop ghost_movement_loop2

    pop eax
    pop ebx
    ret

    ghost_movement_level3:

    ret
ghost_movement endp

ghost_collision proc

    cmp game_level, 3
    je ghost_collision_level3

    mov esi, offset ghost_normal_dl
    mov edi, offset ghost_normal_dh
    mov ecx,2
    loop_ghost_collision:
        mov dl, [esi]
        cmp dl, x_pos
        jne check2
        mov dh, [edi]
        cmp dh, y_pos
        jne check2
        dec lives
        ret
        check2:
        inc esi
        inc edi
    loop loop_ghost_collision 
    
    cmp game_level, 2
    je ghost_collision_level2
    ret

    ghost_collision_level2:
    mov esi, offset ghost_semis_dl
    mov edi, offset ghost_semis_dh
    mov ecx,2
    loop_ghost_collision1:
        mov dl, [esi]
        cmp dl, x_pos
        jne check12
        mov dh, [edi]
        cmp dh, y_pos
        jne check12
        dec lives
        ret
        check12:
        inc esi
        inc edi
    loop loop_ghost_collision1 
    ret
    ghost_collision_level3:

    ret
ghost_collision endp

teleportation_collision proc
    cmp teleportation_count, 0
    je end_teleportation
    mov eax, teleportation_count
    mov ecx, teleportation_count
    mov esi, offset teleportation_dl_value
    mov edi, offset teleportation_dh_value
    loop_teleportation:
        cmp [esi], bl
        jne not_same_4
        cmp [edi], bh
        jne not_same_4
        call Randomrange
        mov esi, offset teleportation_dl_value
        mov edi, offset teleportation_dh_value
        inside_teleportation:
            cmp eax, 0
            je outside_teleportation
            inc esi
            inc edi
            dec eax
            jmp inside_teleportation
        outside_teleportation:
        INVOKE PlaySound, offset teleportation_sound, NULL, 11h

        mov cl, [esi]
        mov ch, [edi]
        mov x_pos, cl
        mov y_pos, ch
        mov cl, 1
        ret
        not_same_4:
            inc esi
            inc edi
    loop loop_teleportation
    end_teleportation:
    mov cl, 0
    ret
teleportation_collision endp

check_fruit_collision proc
    cmp fruit_count, 0
    jne ok
    mov cl, 0
    ret
    ok:
    mov bl, x_pos
    mov bh, y_pos
    mov ecx, fruit_count
    mov esi, offset fruit_levels_dl_value  
    mov edi, offset fruit_levels_dh_value
    loop_fruit_checker:
        cmp [esi], bl
        jne not_same_3
        cmp [edi], bh
        jne not_same_3
        mov cl, 1
        mov [esi], cl
        mov [edi], cl
        ret
        not_same_3:
            inc esi
            inc edi
    loop loop_fruit_checker
    mov cl, 0
    ret
check_fruit_collision endp

food_collision proc
    mov bl, x_pos
    mov bh, y_pos
    mov ecx, food_count
    mov esi, offset food_levels_dl_value  
    mov edi, offset food_levels_dh_value
    loop_food_checker:
        cmp [esi], bl
        jne not_same_2
        cmp [edi], bh
        jne not_same_2
        mov cl, 1
        mov [esi], cl
        mov [edi], cl
        ret
        not_same_2:
            inc esi
            inc edi
    loop loop_food_checker
    mov cl, 0
    
    ret
food_collision endp

end_game proc
    mov eax, white
    call setTextColor
    call clrscr
    mov dh, 2
    mov dl, 20
    call Gotoxy
    mWrite"******* ******* *           * *******       ******** *           * ******** *******", 0
    inc dh
    call Gotoxy
    mWrite"*       *     * * *       * * *             *      *  *         *  *        *     *", 0
    inc dh
    call Gotoxy
    mWrite"*       *     * *   *   *   * *             *      *   *       *   *        *     *", 0
    inc dh
    call Gotoxy
    mWrite"*  **** ******* *     *     * ******* ----- *      *    *     *    ******** *******", 0
    inc dh
    call Gotoxy
    mWrite"*     * *     * *           * *             *      *     *   *     *        * *    ", 0
    inc dh
    call Gotoxy
    mWrite"*     * *     * *           * *             *      *      * *      *        *   *  ", 0
    inc dh
    call Gotoxy
    mWrite"******* *     * *           * *******       ********       *       ******** *     *", 0

    mov dh, 15
    mov dl, 40
    call Gotoxy
    mWrite"Player Name: ", 0
    mov eax, red
    call setTextColor
    mov edx, offset user_name
    call writestring
    mov dh, 17
    mov dl, 40
    call Gotoxy
    mov eax, white
    call setTextColor
    mWrite"Your Score : ", 0
    mov eax, red
    call setTextColor
    mov eax, score
    call writedec

    mov eax, white
    call setTextColor
    mov dh, 19
    mov dl, 40
    call Gotoxy
    mWrite"Press 'R' to play again.", 0
    inc dh
    call Gotoxy
    mWrite"Press any other key to continue.", 0
    inc dh
    call Gotoxy
    mWrite"Enter your option: ", 0
    mov edx, offset choose_instruction_option
    mov ecx, 255
    call readstring

    call clrscr

    ret
end_game endp

check_wall_collision proc
    mov ecx, walls_count
    mov esi, offset walls_levels_dl_value
    mov edi, offset walls_levels_dh_value
    loop_wall_collision:
        cmp [esi], bl
        jne not_same
        cmp [edi], bh
        jne not_same
        mov cl, 1
        ret
        not_same:
            inc esi
            inc edi
    loop loop_wall_collision
    mov cl, 0

    ret
check_wall_collision endp

pause_menu proc
    pause_menu_loop:
    call clrscr
    mov eax, white(16*black)
    call setTextColor
    mov dl, 30
    mov dh, 1
    call Gotoxy
    mWrite"##########  ###########  ##      ##  ##########  ##########", 0
    inc dh
    call Gotoxy
    mWrite"##      ##  ##       ##  ##      ##  ##          ##        ", 0
    inc dh
    call Gotoxy
    mWrite"##      ##  ##       ##  ##      ##  ##          ##        ", 0
    inc dh
    call Gotoxy
    mWrite"##########  ###########  ##      ##  ##########  ##########", 0
    inc dh
    call Gotoxy
    mWrite"##          ##       ##  ##      ##          ##  ##        ", 0
    inc dh
    call Gotoxy
    mWrite"##          ##       ##  ##      ##          ##  ##        ", 0
    inc dh
    call Gotoxy
    mWrite"##          ##       ##  ##########  ##########  ##########", 0
    mov eax, blue
    call SetTextColor
    mov dl, 2
    mov dh, 9
    call Gotoxy
    mWrite"***** ****** ****** *      * *        * ******", 0
    inc dh
    call Gotoxy
    mWrite"*   * *      *      *      * * *    * * *     ", 0
    inc dh
    call Gotoxy
    mWrite"***** *      *      *      * *  *  *  * *     ", 0
    inc dh
    call Gotoxy
    mWrite"**    ****** ****** *      * *    *   * ******", 0
    inc dh
    call Gotoxy
    mWrite"* *   *           * *      * *        * *     ", 0
    inc dh
    call Gotoxy
    mWrite"*  *  *           * *      * *        * *     ", 0
    inc dh
    call Gotoxy
    mWrite"*   * ****** ****** ******** *        * ******", 0

    mov dl, 65
    mov dh, 9
    call Gotoxy
    mWrite"***** ****** ****** ********* ******** ***** *********", 0
    inc dh
    call Gotoxy
    mWrite"*   * *      *          *     *      * *   *     *    ", 0
    inc dh
    call Gotoxy
    mWrite"***** *      *          *     *      * *****     *    ", 0
    inc dh
    call Gotoxy
    mWrite"**    ****** ******     *     ******** **        *    ", 0
    inc dh
    call Gotoxy
    mWrite"* *   *           *     *     *      * * *       *    ", 0
    inc dh
    call Gotoxy
    mWrite"*  *  *           *     *     *      * *  *      *    ", 0
    inc dh
    call Gotoxy
    mWrite"*   * ****** ******     *     *      * *   *     *    ", 0

    mov dl, 2
    mov dh, 21
    call Gotoxy
    mWrite"****** ******* ******** ***** ******", 0
    inc dh
    call Gotoxy
    mWrite"*      *       *      * *   * *     ", 0
    inc dh
    call Gotoxy
    mWrite"*      *       *      * ***** *     ", 0
    inc dh
    call Gotoxy
    mWrite"****** *       *      * **    ******", 0
    inc dh
    call Gotoxy
    mWrite"     * *       *      * * *   *     ", 0
    inc dh
    call Gotoxy
    mWrite"     * *       *      * *  *  *     ", 0
    inc dh
    call Gotoxy
    mWrite"****** ******* ******** *   * ******", 0
    
    mov dl, 93
    mov dh, 21
    call Gotoxy
    mWrite"****** *     * * *********", 0
    inc dh
    call Gotoxy
    mWrite"*       *   *  *     *    ", 0
    inc dh
    call Gotoxy
    mWrite"*        * *   *     *    ", 0
    inc dh
    call Gotoxy
    mWrite"******    *    *     *    ", 0
    inc dh
    call Gotoxy
    mWrite"*        * *   *     *    ", 0
    inc dh
    call Gotoxy
    mWrite"*       *   *  *     *    ", 0
    inc dh
    call Gotoxy
    mWrite"****** *     * *     *    ", 0
    
    mov eax, white(16*black)
    call SetTextColor

    mov dl, 40
    mov dh, 19
    call Gotoxy
    mWrite"Press 'P' to Resume."
    inc dh
    call Gotoxy
    mWrite"Press 'R' to Restart."
    inc dh
    call Gotoxy
    mWrite"Press 'E' to Save & Exit."
    inc dh
    call Gotoxy
    mWrite"Press 'S' to see Scores."
    inc dh
    call Gotoxy
    mWrite"Choose any of the above: "

    mov ecx, 255
    mov edx, offset choose_instruction_option
    call readstring
    
    cmp choose_instruction_option, 's'
    je score_show

    cmp choose_instruction_option, 'e'
    je end_pause

    cmp choose_instruction_option, 'p'
    je end_pause

    cmp choose_instruction_option, 'r'
    je end_pause

    score_show:
        call scoring_menu


    jmp pause_menu_loop

    end_pause:
    call clrscr

    ret
pause_menu endp

displaying_player proc
    mov dl, x_pos
    mov dh, y_pos
    call Gotoxy
    mov eax, white
    call setTextColor
    mov al, 'X'
    call writechar

    ret
displaying_player endp

displaying_data proc
    mov eax, 6
    call SetTextColor
    mov dl, 4
    mov dh, 7
    call Gotoxy
    mWrite"Name: "
    mov edx, offset user_name
    mov eax, 14
    call SetTextColor
    call writestring

    mov eax, 6
    call SetTextColor
    mov dl, 4
    mov dh, 9
    call Gotoxy
    mWrite"Score:    "
    mov eax, 14
    call SetTextColor
    mov dl, 10
    mov dh, 9
    call Gotoxy
    mov eax, score
    call writedec
    mov eax, 6
    call SetTextColor
    mov dl, 4
    mov dh, 11
    call Gotoxy
    mWrite"Level:  "
    mov dl, 10
    mov dh, 11
    call Gotoxy
    mov eax, 14
    call SetTextColor
    mov al, game_level
    call writedec
    
    cmp lives, 1
    jne No2
        mov esi, offset diamond1
        jmp print_diamond
    No2:
    cmp lives, 2
    jne No3
        mov esi, offset diamond2
        jmp print_diamond
    No3:
    cmp lives, 3
    jne No4
        mov esi, offset diamond3
        jmp print_diamond
    No4:
    cmp lives, 4
    jne No5
        mov esi, offset diamond4
        jmp print_diamond
    No5:
    mov esi, offset diamond5
    
    print_diamond:
    mov ecx, 4
    mov bl, 40
    mov bh, 24
    diamond_loop:
        mov eax, 11
        call SetTextColor
        mov dl, bl
        mov dh, bh
        call Gotoxy
        mov edx, esi
        call writestring
        add esi, 67
        inc bh
        loop diamond_loop

    ret
displaying_data endp

transferring_walls proc
    
    cmp game_level, 1
    jne level2_walls
        mov ebx, offset maze_level1
        jmp transfers_start
        

    level2_walls:
    cmp game_level, 2
    jne level3_walls
        mov ebx, offset maze_level2
        jmp transfers_start

    level3_walls:
        mov ebx, offset maze_level3

    transfers_start:
        mov cl, 3
        mov esi, ebx
        mov edi, offset walls_levels_dl_value
        mov edx, offset walls_levels_dh_value
        mov walls_count, 0
        outer_transfer1:
            mov ch, 30
            inner_transfer1:
                mov al, [esi]
                cmp al, '#'
                jne not_hash1
                    mov [edi], ch
                    inc edi
                    mov [edx], cl
                    inc edx
                    inc walls_count
                not_hash1:
                inc esi
                inc ch
                cmp ch, 119
                jne inner_transfer1
            inc cl
         cmp cl, 22
         jne outer_transfer1

        mov cl, 3
        mov esi, ebx
        mov edi, offset food_levels_dl_value
        mov edx, offset food_levels_dh_value
        mov food_count, 0
        mov food_left, 0
        outer_transfer2:
            mov ch, 30
            inner_transfer2:
                mov al, [esi]
                cmp al, '.'
                jne not_hash2
                    mov [edi], ch
                    inc edi
                    mov [edx], cl
                    inc edx
                    inc food_count
                    inc food_left
                   
                not_hash2:
                inc esi
                inc ch
                cmp ch, 119
                jne inner_transfer2
            inc cl
         cmp cl, 22
         jne outer_transfer2

        mov cl, 3
        mov esi, ebx
        mov edi, offset fruit_levels_dl_value
        mov edx, offset fruit_levels_dh_value
        mov fruit_count, 0
        outer_transfer3:
            mov ch, 30
            inner_transfer3:
                mov al, [esi]
                cmp al, '0'
                jne not_hash3
                    mov [edi], ch
                    inc edi
                    mov [edx], cl
                    inc edx
                    inc fruit_count
                    
                not_hash3:
                inc esi
                inc ch
                cmp ch, 119
                jne inner_transfer3
            inc cl
         cmp cl, 22
         jne outer_transfer3

        mov cl, 3
        mov esi, ebx
        mov edi, offset teleportation_dl_value
        mov edx, offset teleportation_dh_value
        mov teleportation_count, 0
        outer_transfer4:
            mov ch, 30
            inner_transfer4:
                mov al, [esi]
                cmp al, 'M'
                jne not_hash4
                    mov [edi], ch
                    inc edi
                    mov [edx], cl
                    inc edx
                    inc teleportation_count
                    
                not_hash4:
                inc esi
                inc ch
                cmp ch, 119
                jne inner_transfer4
            inc cl
         cmp cl, 22
         jne outer_transfer4

    ret
transferring_walls endp

displaying_walls proc
   mov ecx, 0
   mov eax, red
   call SetTextColor
   mov esi, offset walls_levels_dl_value
   mov edi, offset walls_levels_dh_value
   printing_hashes:
       cmp ecx, walls_count
       je print_hashes_over
       mov dl, [esi]
       mov dh, [edi]
       call Gotoxy
       mWrite"#"
       inc esi
       inc edi
       inc ecx
       jmp printing_hashes

    print_hashes_over:
    
    mov ecx, 0
   mov eax, blue
   call SetTextColor
   mov esi, offset food_levels_dl_value
   mov edi, offset food_levels_dh_value
   printing_food:
       cmp ecx, food_count
       je print_food_over
       mov dl, [esi]
       mov dh, [edi]
       call Gotoxy
       mWrite"."
       inc esi
       inc edi
       inc ecx
       jmp printing_food
   print_food_over:
  
   cmp fruit_count, 0
   jne food
   jmp teleport
   food:
   mov ecx, 0
   mov eax, yellow
   call SetTextColor
   mov esi, offset fruit_levels_dl_value
   mov edi, offset fruit_levels_dh_value
   printing_fruit:
       cmp ecx, fruit_count
       je print_fruit_over
       mov dl, [esi]
       mov dh, [edi]
       call Gotoxy
       mWrite"0"
       inc esi
       inc edi
       inc ecx
       jmp printing_fruit
   print_fruit_over:

   teleport:
   cmp teleportation_count, 0
   jne teleport1
   ret
   teleport1:
   mov ecx, 0
   mov eax, yellow
   call SetTextColor
   mov esi, offset teleportation_dl_value
   mov edi, offset teleportation_dh_value
   printing_teleportation:
       cmp ecx, teleportation_count
       je print_teleportation_over
       mov dl, [esi]
       mov dh, [edi]
       call Gotoxy
       mWrite"M"
       inc esi
       inc edi
       inc ecx
       jmp printing_teleportation
   print_teleportation_over: 

    ret
displaying_walls endp





user_name_screen proc
    mov eax, white
    mov dl, 10
    mov dh, 7
    call Gotoxy
    call SetTextColor
    mWrite"***************************************************************************************************", 0
    inc dh
    call Gotoxy
    mWrite"*                                                                                                 *", 0
    inc dh
    call Gotoxy
    mWrite"*        #########  ##########  ##########        ##          ##  ##########  ##        ##        *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##     ##  ##      ##  ##                ####      ####  ##      ##  ####      ##        *", 0
    inc dh
    call Gotoxy
    mWrite"*        #########  ##########  ##                ##  ##  ##  ##  ##########  ##  ##    ##        *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##         ##      ##  ##          ####  ##    ##    ##  ##      ##  ##    ##  ##        *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##         ##      ##  ##                ##          ##  ##      ##  ##      ####        *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##         ##      ##  ##########        ##          ##  ##      ##  ##        ##        *", 0
    inc dh
    call Gotoxy
    mWrite"*                                                                                                 *", 0
    inc dh
    call Gotoxy
    mWrite"***************************************************************************************************", 0
    
    add dh, 2
    mov dl, 40
    call Gotoxy
    mWrite "Enter Your Name: ", 0

    mov eax, red
    call SetTextColor

    mov edx, offset user_name
    mov ecx, 255
    call readstring

    call clrscr
   

    ret
user_name_screen endp

thank_you_screen proc
        INVOKE PlaySound, offset game_end, NULL, 11h

    mov eax, white
    mov dl, 4
    mov dh, 9
    call Gotoxy
    call SetTextColor
    mWrite"**************************************************************************************************************", 0
    inc dh
    call Gotoxy
    mWrite"*                                                                                                            *", 0
    inc dh
    call Gotoxy
    mWrite"*    ########## ##      ##  #########  ##        ##  ##    ##          ##      ##  ##########  ##      ##    *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##     ##      ##  ##     ##  ####      ##  ##  ##            ##      ##  ##      ##  ##      ##    *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##     ##########  #########  ##  ##    ##  ####       ####   ##########  ##      ##  ##      ##    *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##     ##      ##  ##     ##  ##    ##  ##  ####       ####       ##      ##      ##  ##      ##    *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##     ##      ##  ##     ##  ##      ####  ##  ##                ##      ##      ##  ##      ##    *", 0
    inc dh
    call Gotoxy
    mWrite"*        ##     ##      ##  ##     ##  ##        ##  ##    ##              ##      ##########  ##########    *", 0
    inc dh
    call Gotoxy
    mWrite"*                                                                                                            *", 0
    inc dh
    call Gotoxy
    mWrite"**************************************************************************************************************", 0
    
     mov edx, offset choose_instruction_option
    mov ecx, 255
    call readstring

    ret
thank_you_screen endp

making_face proc
 mov eax, yellow(yellow*16)
    call SetTextColor
    mov al, "X"
    mov dl, 10
    mov dh, 3
    loop1:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 16
        jne loop1

    inc dh
    mov dl, 8
    loop2:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 18
        jne loop2

    inc dh
    mov dl, 6
    loop3:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 20
        jne loop3

    inc dh
    mov dl, 5
    loop4:
        call Gotoxy
        cmp dl, 16
        je loop41
            call Writechar
        loop41:
        inc dl
        cmp dl, 21
        jne loop4
    
    inc dh
    mov dl, 5
    loop15:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 21
        jne loop15

    inc dh
    mov dl, 4
    loop5:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 22
        jne loop5

    inc dh
    mov dl, 4
    loop6:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 22
        jne loop6

    inc dh
    mov dl, 3
    loop7:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 20
        jne loop7

    inc dh
    mov dl, 2
    loop8:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 17
        jne loop8
        
    inc dh
    mov dl, 2
    loop9:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 14
        jne loop9
     
    inc dh
    mov dl, 2
    loop10:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 14
        jne loop10

    inc dh
    mov dl, 2
    loop11:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 17
        jne loop11
        
    inc dh
    mov dl, 3
    loop12:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 20
        jne loop12

     inc dh
    mov dl, 4
    loop13:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 22
        jne loop13

    inc dh
    mov dl, 4
    loop14:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 22
        jne loop14
       
    inc dh
    mov dl, 5
    loop16:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 21
        jne loop16

    inc dh
    mov dl, 5
    loop17:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 21
        jne loop17

     inc dh
    mov dl, 6
    loop18:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 20
        jne loop18

     inc dh
    mov dl, 8
    loop19:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 18
        jne loop19

    mov dl, 10
    loop20:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 16
        jne loop20

    mov eax, green (green*16)
    call SetTextColor
    mov dh,10
    mov dl, 30
    loop21:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 32
        jne loop21

    inc dh
    mov dl, 28
    loop22:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 34
        jne loop22

    inc dh
    mov dl, 28
    loop23:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 34
        jne loop23

    inc dh
    mov dl, 30
    loop24:
        call Gotoxy
        call Writechar
        inc dl
        cmp dl, 32
        jne loop24

    ret
making_face endp

menu_screen proc
    MENU_LOOP1:    

    mov title_row, 0
    mov title_col, 30
    call writing_heading

    mov eax, 15
    call SetTextColor
    mov bh, 6
    mov bl, 58

    seperator1:
        mov dh, bh
        mov dl, bl
        call Gotoxy
        mov bh, dh
        mov bl, dl
        mov edx, offset seperator_vertical
        call writestring
        inc bh
        cmp bh, 30
        jne seperator1

    mov bh, 14
    mov bl, 0

    seperator2:
        mov dh, bh
        mov dl, bl
        call Gotoxy
        mov bh, dh
        mov bl, dl
        mov edx, offset seperator_horizontal
        call writestring
        inc bl
        cmp bl, 120
        jne seperator2

    call rest_text
    mov eax, 15
        call SetTextColor
        mov dl, 65
        mov dh, 24
        call Gotoxy
    
        mWrite "Press P for play"
        mov dl, 65
        mov dh, 25
        call Gotoxy
        mWrite "Press E for Exit"
        mov dl, 65
        mov dh, 26
        call Gotoxy
        mWrite "Press R for Rules"
        mov dl, 65
        mov dh, 27
        call Gotoxy
        mWrite "Press S for Scores"
        mov dl, 65
        mov dh, 28
        call Gotoxy
        mWrite "Choose Your Option: "

        mov ecx, 50
        mov edx, offset choose_instruction_option
        call readstring
    
        cmp choose_instruction_option, 'p'
        je end_menu

        cmp choose_instruction_option, 'e'
        je end_menu

        cmp choose_instruction_option, 's'
        je scoring


        cmp choose_instruction_option, 'r'
        je rules_screen_loop



        call clrscr

        jmp MENU_LOOP1

        scoring:
            call scoring_menu

        call clrscr
        jmp MENU_LOOP1

        rules_screen_loop:
            call rules_screen

        call clrscr
        jmp MENU_LOOP1

    end_menu:

    call clrscr


    ret
menu_screen endp


rules_screen proc
    call clrscr
    mov dl, 30
    mov dh, 1
    call Gotoxy
    mWrite"##########  ##     ##  ##         #########  #########", 0
    inc dh
    call Gotoxy
    mWrite"##      ##  ##     ##  ##         ##         ##       ", 0
    inc dh
    call Gotoxy
    mWrite"##########  ##     ##  ##         ##         ##       ", 0
    inc dh
    call Gotoxy
    mWrite"####        ##     ##  ##         #########  #########", 0
    inc dh
    call Gotoxy
    mWrite"##  ##      ##     ##  ##         ##                ##", 0
    inc dh
    call Gotoxy
    mWrite"##    ##    ##     ##  ##         ##                ##", 0
    inc dh
    call Gotoxy
    mWrite"##      ##  #########  #########  #########  #########", 0

    mov eax, yellow
    call setTextColor

    mov dl, 2
    mov dh, 10
    call Gotoxy
    mWrite "Objective: The main goal is to control Pac-Man, a yellow circular character, through a maze to consume all the     ", 0
    inc dh 
    call Gotoxy
    mWrite "pac-dots or pellets while avoiding ghosts.                                                                         ", 0
    inc dh 
    inc dh 
    call Gotoxy
    mWrite "Pac-Dots: Pac-Man must eat all the pac-dots scattered throughout the maze to complete each level. Eating larger    ", 0 
    inc dh 
    call Gotoxy
    mWrite "pellets (Power Pellets) allows Pac-Man to turn the tables and temporarily chase and eat ghosts.                    ", 0
    inc dh
    inc dh 
    call Gotoxy
    mWrite "Lives: Pac-Man starts with a set number of lives. Losing a life occurs when caught by a ghost. Extra lives can be ", 0
    inc dh 
    call Gotoxy
    mWrite "earned based on points scored.                                                                                    ", 0
    inc dh 
    inc dh 
    call Gotoxy
    mWrite "Ghosts: Ghosts patrol the maze and attempt to catch Pac-Man. If a ghost catches Pac-Man, he loses a life.         ", 0
    inc dh 
    inc dh 
    call Gotoxy
    mWrite "Fruit and Bonus Items: Occasionally, fruits or other bonus items appear in the maze, providing extra points when  ", 0
    inc dh 
    call Gotoxy
    mWrite "consumed.                                                                                                         ", 0
    inc dh 
    inc dh 
    call Gotoxy
    mWrite "Maze Levels: After completing one maze, players advance to the next level, where the maze becomes more complex,   ", 0
    inc dh 
    call Gotoxy
    mWrite "and the game's pace typically increases.                                                                          ", 0

    mov eax, white
    call setTextColor

    mov ecx, 255
    mov edx, offset choose_instruction_option
    call readstring

    ret
rules_screen endp


rest_text proc
;-> PLAY
    mov eax, 6
    call SetTextColor
    mov dl, 0
    mov dh, 7
    call Gotoxy
    mov edx, offset play1
    call writestring

    mov eax, 5
    call SetTextColor
    mov dl, 0
    mov dh, 8
    call Gotoxy
    mov edx, offset play2
    call writestring

    mov eax, 4
    call SetTextColor
    mov dl, 0
    mov dh, 9
    call Gotoxy
    mov edx, offset play3
    call writestring

    mov eax, 3
    call SetTextColor
    mov dl, 0
    mov dh, 10
    call Gotoxy
    mov edx, offset play4
    call writestring

    mov eax, 2
    call SetTextColor
    mov dl, 0
    mov dh, 11
    call Gotoxy
    mov edx, offset play5
    call writestring

    mov eax, 1
    call SetTextColor
    mov dl, 0
    mov dh, 12
    call Gotoxy
    mov edx, offset play6
    call writestring

; <- PLAY

; -> RULES
     mov eax, 6
    call SetTextColor
    mov dl, 63
    mov dh, 7
    call Gotoxy
    mov edx, offset rules1
    call writestring

    mov eax, 5
    call SetTextColor
    mov dl, 63
    mov dh, 8
    call Gotoxy
    mov edx, offset rules2
    call writestring

    mov eax, 4
    call SetTextColor
    mov dl, 63
    mov dh, 9
    call Gotoxy
    mov edx, offset rules3
    call writestring

    mov eax, 3
    call SetTextColor
    mov dl, 63
    mov dh, 10
    call Gotoxy
    mov edx, offset rules4
    call writestring

    mov eax, 2
    call SetTextColor
    mov dl, 63
    mov dh, 11
    call Gotoxy
    mov edx, offset rules5
    call writestring

    mov eax, 1
    call SetTextColor
    mov dl, 63
    mov dh, 12
    call Gotoxy
    mov edx, offset rules6
    call writestring

; <- RULES


; -> SCORES
     mov eax, 6
    call SetTextColor
    mov dl, 63
    mov dh, 16
    call Gotoxy
    mov edx, offset score1
    call writestring

    mov eax, 5
    call SetTextColor
    mov dl, 63
    mov dh, 17
    call Gotoxy
    mov edx, offset score2
    call writestring

    mov eax, 4
    call SetTextColor
    mov dl, 63
    mov dh, 18
    call Gotoxy
    mov edx, offset score3
    call writestring

    mov eax, 3
    call SetTextColor
    mov dl, 63
    mov dh, 19
    call Gotoxy
    mov edx, offset score4
    call writestring

    mov eax, 2
    call SetTextColor
    mov dl, 63
    mov dh, 20
    call Gotoxy
    mov edx, offset score5
    call writestring

    mov eax, 1
    call SetTextColor
    mov dl, 63
    mov dh, 21
    call Gotoxy
    mov edx, offset score6
    call writestring

; <- SCORES

    ; -> HOUSE
     mov eax, 11
    call SetTextColor
    mov dl, 0
    mov dh, 15
    call Gotoxy
    mov edx, offset house1
    call writestring

    mov dl, 0
    mov dh, 16
    call Gotoxy
    mov edx, offset house2
    call writestring

    mov dl, 0
    mov dh, 17
    call Gotoxy
    mov edx, offset house3
    call writestring

    mov dl, 0
    mov dh, 18
    call Gotoxy
    mov edx, offset house4
    call writestring

    mov dl, 0
    mov dh, 19
    call Gotoxy
    mov edx, offset house5
    call writestring

    mov dl, 0
    mov dh, 20
    call Gotoxy
    mov edx, offset house6
    call writestring

     mov dl, 0
    mov dh, 21
    call Gotoxy
    mov edx, offset house7
    call writestring

    mov dl, 0
    mov dh, 22
    call Gotoxy
    mov edx, offset house8
    call writestring

    mov dl, 0
    mov dh, 23
    call Gotoxy
    mov edx, offset house9
    call writestring

    mov dl, 0
    mov dh, 24
    call Gotoxy
    mov edx, offset house10
    call writestring

    mov dl, 0
    mov dh, 25
    call Gotoxy
    mov edx, offset house11
    call writestring

    mov dl, 0
    mov dh, 26
    call Gotoxy
    mov edx, offset house12
    call writestring

     mov dl, 0
    mov dh, 27
    call Gotoxy
    mov edx, offset house13
    call writestring

    mov dl, 0
    mov dh, 28
    call Gotoxy
    mov edx, offset house14
    call writestring


    ret
rest_text endp

writing_heading proc
    call crlf
    mov dh, title_row
    mov dl, title_col
    inc title_row
    call Gotoxy

    mov edx, offset title1

    mov eax, 1
    call SetTextColor
    call writestring
    call crlf

    mov dh, title_row
    mov dl, title_col 
    inc title_row
    call Gotoxy


    mov eax, 2
    call SetTextColor
    mov edx, offset title2
    call writestring
    call crlf

    mov dh, title_row
    mov dl, title_col
    inc title_row
    call Gotoxy

    mov eax, 3
    call SetTextColor
    mov edx, offset title3
    call writestring
    call crlf

    mov dh, title_row
    mov dl, title_col
    inc title_row
    call Gotoxy

    mov eax, 4
    call SetTextColor
    mov edx, offset title4
    call writestring
    call crlf

    mov dh, title_row
    mov dl, title_col
    inc title_row
    call Gotoxy

    mov eax, 5
    call SetTextColor
    mov edx, offset title5
    call writestring
    call crlf

    mov dh, title_row
    mov dl, title_col
    inc title_row
    call Gotoxy

    mov eax, 6
    call SetTextColor
    mov edx, offset title6
    call writestring

    call crlf
    ret
writing_heading endp


start_screen proc
   
; dl ->
; dh down

; ->
    call making_face

    mov title_row, 9
    mov title_col, 40
    call writing_heading
;->
 
   

    mov ecx, 50
    mov edx, offset user_name
    call readstring

    call clrscr
    ;<-
    ret
start_screen endp


END main