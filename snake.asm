IDEAL
MODEL small
STACK 100h
DATASEG
;-----------------------------------------------------------------------------------------------------------
;===========================================================================================================
;                                                 variables
;===========================================================================================================
;-----------------------------------------------------------------------------------------------------------
X dw 500 dup (?)
Y dw 500 dup (?)
snakeColor db ?    ;0b 4 5
maxX dw ?
maxY dw ?
bodySize dw 6
bodyLoopTimes dw 4
whereToMove dw 0
firstNum dw 50
mult db 5

color2 db 0

color3 db 2
foodX dw ?
foodY dw ?
foodMaxX dw ?
foodMaxY dw ?

gameOver db 0
score dw 0
highScore dw ?
index dw ?
DelayLength dw ?
snakeDelayLength dw 32h
keyWasPressed db 0
difficulty db ?

pauseMaxX dw ?
pauseMaxY dw ?
color4 db 0Fh

note  dw  2394h 
note1 dw 1000h
note2 dw 1500h
note3 dw 2000h
note4 dw 500h

prG_Range_Result_LFSR dw 0, 2, 4  
prG16_range EQU   word offset prG_Range_Result_LFSR
prG16_result EQU  word offset prG_Range_Result_LFSR +2
prG16_LFSR  EQU   word offset prG_Range_Result_LFSR +4

msg1 db 13,10,'                                                                             '
     db 13,10,'                                                                             '
     db 13,10,'                                                                             '
     db 13,10,'    _         _         _                                       _             '
     db 13,10,'    \ \      / /  ___  | |   ___    ___    _ __ ___     ___    | |_    ___   '  
     db 13,10,'     \ \ /\ / /  / _ \ | |  / __|  / _ \  | ;_ ` _ \   / _ \   | __|  / _ \  ' 
     db 13,10,'      \ V  V /  |  __/ | | | (__  | (_) | | | | | | | |  __/   | |_  | (_) | '  
     db 13,10,'       \_/\_/    \___| |_|  \___|  \___/  |_| |_| |_|  \___|    \__|  \___/  '
	 db 13,10,'                                                                             '
	 db 13,10,'                         ___   _ __     __ _  | | __   ___                   '
     db 13,10,'                        / __| | ;_ \   / _` | | |/ /  / _ \                  '
     db 13,10,'                        \__ \ | | | | | (_| | |   <  |  __/                  '
     db 13,10,'                        |___/ |_| |_|  \__,_| |_|\_\  \___|                  '
     db 13,10,'                                                                             '
	 db 13,10,'                                                                             '
	 db 13,10,'                               Press Enter To Start                         '
	 db 13,10,'                               Press "h" For Help                           '
	 db 13,10,'                               Press Esc To Exit                           $'
	 
msg2 db 13,10,'         ____                                 ___                            '
     db 13,10,'        / ___|   __ _   _ __ ___     ___     / _ \  __   __   ___   _ __     '
	 db 13,10,'       | |  _   / _` | | |_ ` _ \   / _ \   | | | | \ \ / /  / _ \ | ;__|    '
	 db 13,10,'       | |_| | | (_| | | | | | | | |  __/   | |_| |  \ V /  |  __/ | |       '
	 db 13,10,'        \____|  \__,_| |_| |_| |_|  \___|    \___/    \_/    \___| |_|       '
	 db 13,10,'                                                                             '
	 db 13,10,'                                                                             '
	 db 13,10,'                               Your Score:$'
msg3 db 13,10,'                               High Score:$'
msg4 db 13,10,13,10,'                            Press Enter To Restart                     '
     db       13,10,'                            Press Esc To Exit                         $'
msg5 db 13,10,'  __  __                                        _                              '
     db 13,10,' |  \/  |   ___   __   __   ___               /_ |                             '
     db 13,10,' | |\/| |  / _ \  \ \ / /  / _ \    _____      | |                             '
     db 13,10,' | |  | | | (_) |  \ V /  |  __/   |_____|     | |                             '
     db 13,10,' |_|  |_|  \___/    \_/    \___|               |_|                             '
     db 13,10,'                             __            __                                  '
     db 13,10,'                            | _| __ __ __ |_ |                                 '
     db 13,10,'                            | |  \ V  V /  | |                                 '
     db 13,10,'                            | |   \_/\_/   | |                                 '
     db 13,10,'                            |__|          |__|                                 '
     db 13,10,'        __            __     __     ___    __     __       _    __             '
     db 13,10,'       | _|   __ _   |_ |   | _|   / __|  |_ |   | _|   __| |  |_ |            '
     db 13,10,'       | |   / _` |   | |   | |    \__ \   | |   | |   / _` |   | |            '
     db 13,10,'       | |   \__,_|   | |   | |    |___/   | |   | |   \__,_|   | |            '
     db 13,10,'       |__|          |__|   |__|          |__|   |__|          |__|            '
	 db 13,10,'  ___                            _    __                      __               ' 
     db 13,10,' | _ \  __ _   _  _   ___  ___  (_)  | _|  ___   ___    ___  |_ |              '
     db 13,10,' |  _/ / _` | | || | (_-< / -_)  _   | |  | __| / __|  / __|  | |              '
     db 13,10,' |_|   \__,_|  \_,_| /__/ \___| (_)  | |  | _|  \__ \ | (__   | |              '                           
	 db 13,10,'                                     |__| |___| |___/  \___| |__|              '
	 db 13,10,13,10,13,10,13,10,'                            Press Enter To Start                               '
	 db 13,10,'                                  Page 1/2                                    $'
msg6 db 13,10,' _                _    ___   __   ___  _  __  __ _         _ _        '
     db 13,10,'| |   __ _   _ __| |  / _ \ / _| |   \(_)/ _|/ _(_)__ _  _| | |_ _  _ '
     db 13,10,'| |__/ -_) V / -_) | | (_) |  _| | |) | |  _|  _| / _| || | |  _| || |'
     db 13,10,'|____\___|\_/\___|_|  \___/|_|   |___/|_|_| |_| |_\__|\_,_|_|\__|\_, |'
     db 13,10,'                                                                 |__/ '
     db 13,10,'   _                                                                  '
     db 13,10,'  / |  ___   ___ __ _ ____  _                                         '
     db 13,10,'  | | |___| / -_) _` (_-< || |                                        '
     db 13,10,'  |_|       \___\__,_/__/\_, |                                        '
     db 13,10,'                         |__/                                         '                                  
     db 13,10,'   ___                      _ _                                       '
     db 13,10,'  |_  )  ___   _ __  ___ __| (_)_  _ _ __                             '
     db 13,10,'   / /  |___| | ;  \/ -_) _` | | || | ;  \                            '
     db 13,10,'  /___|       |_|_|_\___\__,_|_|\_,_|_|_|_|                           ' 
     db 13,10,'                                                                      '	 
     db 13,10,'   ____        _                _                                     '      
     db 13,10,'  |__ /  ___  | |_  __ _ _ _ __| |                                    '       
     db 13,10,'   |_ \ |___| | ; \/ _` | ;_/ _` |                                    '        
     db 13,10,'  |___/       |_||_\__,_|_| \__,_| 	                                $' 
msg7 db       '  __  __                                      ____                             '
     db 13,10,' |  \/  |   ___   __   __   ___              |___ \                            '
     db 13,10,' | |\/| |  / _ \  \ \ / /  / _ \    _____      __) |                           '
     db 13,10,' | |  | | | (_) |  \ V /  |  __/   |_____|    / __/                            '
     db 13,10,' |_|  |_|  \___/    \_/    \___|             |_____|                           '
     db 13,10,'                             __           __                                   '
     db 13,10,'                            | _|   / \   |_ |                                  '
     db 13,10,'                            | |   /| |\   | |                                  ' 
     db 13,10,'                            | |    | |    | |                                  '
     db 13,10,'                            | |    | |    | |                                  '
     db 13,10,'                            |__|   | |   |__|                                  '  
     db 13,10,'         __           __     __           __     __           __               '
     db 13,10,'        | _|         |_ |   | _|   | |   |_ |   | _|         |_ |              '
     db 13,10,'        | |   /__ __  | |   | |    | |    | |   | |   __ __\  | |              '
     db 13,10,'        | |  < __ __  | |   | |    | |    | |   | |   __ __ > | |              '
     db 13,10,'        | |   \       | |   | |   \| |/   | |   | |        /  | |              '
     db 13,10,'        |__|         |__|   |__|   \ /   |__|   |__|         |__|              '
	 db 13,10,'  ___                            _    __                      __               ' 
     db 13,10,' | _ \  __ _   _  _   ___  ___  (_)  | _|  ___   ___    ___  |_ |              '
     db 13,10,' |  _/ / _` | | || | (_-< / -_)  _   | |  | __| / __|  / __|  | |              '
     db 13,10,' |_|   \__,_|  \_,_| /__/ \___| (_)  | |  | _|  \__ \ | (__   | |              '                           
	 db 13,10,'                                     |__| |___| |___/  \___| |__|              '
	 db 13,10,13,10,'                            Press Enter To Start                               '
	 db 13,10,'                                  Page 2/2                                    $'
msg8 db 'Score:$'
msg9 db 'High Score:$'
;-----------------------------------------------------------------------------------------------------------
;===========================================================================================================
;                                                  code start
;===========================================================================================================
;-----------------------------------------------------------------------------------------------------------
CODESEG

start1:
	mov ax, @data
	mov ds, ax	
;===========================================================================================================
;                                                     start 
;===========================================================================================================
jmp newProgram
restartProgram:
	mov bx,0
	mov cx,500
loopResetArrays:
	mov [X+bx],0 
	mov [Y+bx],0
	add bx,2
	loop loopResetArrays
	mov [score],0
	mov [gameOver],0
	mov [bodySize],6
	mov [bodyLoopTimes],4
	mov [whereToMove],0
	mov [snakeDelayLength],32h
newProgram:
	call EraseScreen

	lea dx,[msg1]  
	mov ah,09h
	int 21h
	
	mov cx,2607h    ;hide cursor
	mov ah,01h
	int 10h
checkKey1:
	mov ah,00h
	int 16h
enterKey1:
	cmp al,13
	je difficultyDecide
escpKey:
	cmp al,01bh  ;esc1
	jne h1Key
	call EraseScreen
	mov ax, 4c00h 
	int 21h	
h1Key:
	cmp al,68h
	je help
h2Key:
	cmp al,48h
	jne checkKey1
;===========================================================================================================
;                                              help message
;===========================================================================================================
help:
	call EraseScreen
	
	lea dx,[msg5]  
	mov ah,09h
	int 21h
	
	mov cx,2607h    ;hide cursor
	mov ah,01h
	int 10h
checkKey2:
	mov ah,00h
	int 16h
	
	cmp al,13
	je difficultyDecide
	cmp ah,04Dh
	jne checkKey2
	
	call EraseScreen
			
	lea dx,[msg7]  
	mov ah,09h
	int 21h
	
	mov cx,2607h    ;hide cursor
	mov ah,01h
	int 10h
checkKey3:
	mov ah,00h
	int 16h
	
	cmp al,13
	je difficultyDecide
	cmp ah,4bh
	jne checkKey3
	jmp help
;==========================================================================================================
;                                              Difficulty message
;==========================================================================================================
difficultyDecide:

	call EraseScreen
	
	mov cx,2607h    ;hide cursor
	mov ah,01h
	int 10h
	
	lea dx,[msg6]
	mov ah,09h
	int 21h
difficultyCheck:
	mov ah,00h
	int 16h
checkDifficulty1:	
	cmp al,31h
	jne checkDifficulty2
	mov [difficulty],1
	jmp startPrep
checkDifficulty2:
	cmp al,32h
	jne checkDifficulty3
	mov [difficulty],2
	jmp startPrep
checkDifficulty3:
	cmp al,33h
	jne difficultyCheck
	mov [difficulty],3 
;===========================================================================================================
;                                            preparations for start
;===========================================================================================================
startPrep:
	cmp [highScore],0 
	je returnPrep
	
	cmp [difficulty],1    ;if game difficulty changed -->change high sore to 0
	jne nextCheck1
	cmp [snakeColor],0bh
	je returnPrep
	jmp newHighScore
nextCheck1:
	cmp [difficulty],2
	jne nextCheck2
	cmp [snakeColor],4
	je returnPrep
	jmp newHighScore
nextCheck2:
	cmp [snakeColor],5
	je returnPrep
newHighScore:
	mov [highScore],0
	
returnPrep:
	mov ax, 13h 
	int 10h 
	
	call StartGameMelody
	call GetRandom
	call DrawFood
	
	mov bx,0
	mov cx,[bodyLoopTimes]
XFirstNumbersLoop:
	mov ax,[X+bx]
	mov ax,[firstNum]
	mov [X+bx],ax
	add bx,2
	sub [firstNum],5
	loop XFirstNumbersLoop
	
	mov [firstNum],50
	mov bx,0
	mov cx,[bodyLoopTimes]
YFirstNumbersLoop:
	mov ax,[Y+bx]
	mov ax,[firstNum]
	mov [Y+bx],ax
	add bx,2
	loop YFirstNumbersLoop
	
	mov bx,0
	mov cx,[bodyLoopTimes]
bodyDrawLoop:
	call DrawBody
	add bx,2
	loop bodyDrawLoop
;===========================================================================================================
;                                                  main loop
;===========================================================================================================
mainLoop:
	mov ah,01h
	int 16h
	jnz gotkey            ; get key
resumeMain:
	mov [keyWasPressed],0
	cmp [whereToMove],0   ;when not moving
	je mainLoop 
	mov bx,[bodySize]
	call RemoveLast
	call Arrange
	call HeadDir
	call CheckIfLost
	cmp [gameOver],1
	je exitGame
	mov bx,0
	call DrawBody
	push [snakeDelayLength]
	call Delay
	call CheckFood
	call LiveScore
	jmp mainLoop
gotkey:
	cmp [keyWasPressed],1 
	je resumeMain
	call GetKey
;===========================================================================================================
;                                                  pause
;===========================================================================================================
esc1:
	cmp al,01bh  ;esc1
	jne resume
	call PauseSign
	call PauseGameMelody
	push [whereToMove]
	mov [whereToMove],0
pause1:
	mov ah,0h
	int 16h
	cmp al,01bh  ;esc1
	jne pause1
	pop [whereToMove]
	call PauseGameMelody
	call RemovePauseSign
resume:
	jmp mainLoop
;===========================================================================================================
;                                                exit message
;===========================================================================================================
exitGame:
	call DrawBody   ;the head wasnt be drawn, DrawBody proc is after CheckIfLost 
	call EndGameMelody
	mov [DelayLength],500h 
	push [DelayLength]
	call Delay
	
	mov ax, 0002
	int 10h	

	lea dx,[msg2]
	mov ah,09h
	int 21h
	
	push [score]
	call ScoreShow
	
	lea dx,[msg3]
	mov ah,09h
	int 21h
	
	mov ax,[score]
	cmp ax,[highScore]
	jl highScoreNotChanged
	mov [highScore],ax
highScoreNotChanged:

	push [highScore]
	call ScoreShow
	
	lea dx,[msg4]
	mov ah,09h
	int 21h
	
	mov cx,2607h    ;hide cursor
	mov ah,01h
	int 10h
	
skipExitMessage:
	mov ah,00h
	int 16h
	cmp al,01bh
	je exitProgram
	cmp al,13
	jne skipExitMessage
	jmp restartProgram
exitProgram:
	mov ax, 13h   ;enter graphic mode then enter text mode to erase msg2
	int 10h  	
	mov ax, 0002
	int 10h	
;===========================================================================================================
;                                                 exit program
;===========================================================================================================
	mov ax, 4c00h 
	int 21h	
;===========================================================================================================
;                                                  procedures
;===========================================================================================================
proc GetKey
	mov ah,00h           ;get key press
	int 16h
	
CmpUp1:		             ; start checking what key was pressed and giving 'whereToMove' value 1-4 - 
	cmp ah,48h  ;UP=1    ;the number represent the direction in which the snake will contimue moving
	je CmpUp2
	cmp al,77h  ;UP=1
	jne CmpRight1
CmpUp2:	
	cmp [whereToMove],3
	je ret1
	cmp [whereToMove],1
	je ret1
	mov [whereToMove], 1
	jmp ret1
CmpRight1:
	cmp ah,04Dh  ;RIGHT=2
	je CmpRight2
	cmp al,64h  ;RIGHT=2
	jne CmpDown1
CmpRight2:
	cmp [whereToMove],4
	je ret1
	cmp [whereToMove],2
	je ret1
	mov [whereToMove], 2
	jmp ret1
CmpDown1:
	cmp ah,50h  ;DOWN=3
	je CmpDown2
	cmp al,73h  ;DOWN=3
	jne CmpLeft1
CmpDown2:
	cmp [whereToMove],1
	je ret1
	cmp [whereToMove],3
	je ret1
	mov [whereToMove], 3
	jmp ret1
CmpLeft1:
	cmp ah,04Bh  ;LEFT=4
	je CmpLeft2
	cmp al,61h  ;LEFT=4
	jne ret1
CmpLeft2:
	cmp [whereToMove],0
	je ret1
	cmp [whereToMove],2
	je ret1
	cmp [whereToMove],4
	je ret1
	mov [whereToMove], 4
ret1:
	mov [keyWasPressed],1       ;give key press value 1 (works like boolean var) - 
	ret                         ;this for not taking 2 key press checking straight(the key press down check is before the loop- so the snake wont draw it self before changing direction)
endp GetKey

proc Delay
	pop [index]
	pop bp
	mov si, bp
Delay1:
	dec bp
	nop
	jnz Delay1
	dec si
	cmp si,0    
	jnz Delay1
	push [index]
	ret
endp Delay
proc DrawFood
	mov cx,[foodX]  ;X
	mov dx,[foodY]  ;Y
	mov al,[color3]
	mov ah, 0ch ; put pixel
	push cx
	push dx
	add cx,5
	mov [foodMaxX],cx
	add dx,5
	mov [foodMaxY],dx
	pop dx
	pop cx
colcount4:
		inc cx
		int 10h
		cmp cx,[foodMaxX]
		JNE colcount4

		mov cx,[foodX] ; reset to start of col
		inc dx      ;next row
		cmp dx,[foodMaxY]
		JNE colcount4
	ret
endp DrawFood

proc Random		; like hi level language:  " prGrand16 ( dw prG16_range, dw prG16_result , dw prG16_LFSR)" 
	push BX
	pushF 
	CMP [prG16_range],0 
	JZ init_LFSR
	mov AX, [prG16_LFSR]
	mov DX, 0				; now ready to divide (DX:AX) by a 16 bit number
	mov CX, 17
prGrand16_loop1: 
	roR AX, 1           ; ROR rotates , also pushes the previous LSB to CF 
	jnc prGrand16_skip1
	xor AX, 3400h		; The Galois xor with 1 on 3 bits (13,12,10)
prGrand16_skip1 : 
	loop prGrand16_loop1    	
			; results handling:
	mov [prG16_LFSR], AX   ; keep new PRG value in memory !
	mov CX, [prG16_range]  ; WARNING - if your program messes with [prG16_range] - divide by ZERO  will "kill you"
	div CX
	mov  [prG16_result], DX ; push the remainder (holding a number between 0 to range-1) to memory
	jmp prGrand16_exit
		; "New-seed" code (put a new seed in the Pseudo-random generator):	
init_LFSR:               
		; Using the read-clock - (DH:DL) gets the (sec:fractions) 
	mov ah,2ch
	int 21h              ; int 21h,2ch contaminates CX & DX 
	mov [prG16_LFSR] , dx ; new random seed in place
	mov [prG16_result] , dx ; new random seed in place
		; read directly from clock: 0040:006ch
		; MOV CX , [0040h:006Ch]
		; MOV  [prG16_LFSR] , CX
		; MOV  [prG16_result] , CX
		; Default: returns an ALMOST full 16 bit pseudo number (0-65534)
	mov [prG16_range], 0ffffh 		     
		; exit code:	
prGrand16_exit:
		; restoring the registers to org condition before this call
	popF                ; restoring the registers to org condition before this call
	pop BX
	ret
endp Random
proc CheckFood
	push bx
	mov bx,0
	mov ax,[foodX]
	cmp ax,[X+bx]
	jne notEqual
	mov ax,[foodY]
	cmp ax,[Y+bx]
	jne notEqual
	
	call EatSound
Difficulty1:
	cmp [difficulty],1
	jne Difficulty2
	sub [snakeDelayLength],1
	add [bodySize],2
	add [bodyLoopTimes],1
	jmp scoreInc
Difficulty2:
	cmp [difficulty],2
	jne Difficulty3
	sub [snakeDelayLength],2
	add [bodySize],4
	add [bodyLoopTimes],2
	jmp scoreInc
Difficulty3:
	sub [snakeDelayLength],2
	add [bodySize],8
	add [bodyLoopTimes],4
scoreInc:	
	inc [score]
getrnd:
	call GetRandom
	mov ax,[foodY]
	mov dx,[foodX]
	mov bx,0
	mov cx,[bodyLoopTimes]
randomCheckLoop:
	cmp dx,[X+bx]
	je getrnd
	jmp contineLoop
checkX:
	cmp ax,[Y+bx]
	je getrnd
contineLoop:
	add bx,2
	loop randomCheckLoop
	call DrawFood
notEqual:
	pop bx
	ret
endp CheckFood
proc CheckIfLost
	mov bx,0
	mov ax,[X+bx] 
	mov dx,[Y+bx]
	cmp ax,5
	jl Lost
	cmp dx,20
	jl Lost
	cmp ax,310
	jg Lost
	cmp dx,190
	jg Lost
	
	mov bh,0h
	mov cx,[X+0]
	mov dx,[Y+0]
checkLost1:
	cmp [whereToMove],1 
	jne checkLost2
	add cx,1
	jmp check
checkLost2:
	cmp [whereToMove],2 
	jne checkLost3
	add cx,5
	jmp check
checkLost3:
	cmp [whereToMove],3 
	jne checkLost4
	add cx,1
	jmp check
checkLost4:
	cmp [whereToMove],4 
	jne check
	add cx,5
check:
	mov ah,0Dh
	int 10h ; return al the pixel value read
	
Snakecolor1Check:
	cmp [difficulty],1
	jne Snakecolor2Check
	cmp al,0bh
	je Lost
Snakecolor2Check:
	cmp [difficulty],2
	jne Snakecolor3Check	
	cmp al,4
	je Lost
Snakecolor3Check:	
	cmp al,5
	je Lost
	
	jmp NotLost
Lost:
	mov [whereToMove],0
	mov [gameOver],1
	call RemoveFood
NotLost:
ret
endp CheckIfLost
proc RemoveLast
	push cx
	push bx
remove1:
	mov cx,[X+bx]  ;X
	mov dx,[Y+bx]  ;Y
	mov al, [color2]
	mov bh,0
	mov ah, 0ch ; put pixel
	push cx
	push dx
	add cx,5
	mov [MaxX],cx
	add dx,5
	mov [MaxY],dx
	pop dx
	pop cx
colcount5:
		inc cx
		int 10h
		cmp cx,[maxX]
		JNE colcount5

		mov cx,[X+bx] ; reset to start of col
		inc dx      ;next row
		cmp dx,[maxY]
		JNE colcount5
		pop bx
		pop cx
ret
endp RemoveLast
proc Arrange
	push cx
	push bx
	
	mov bx,[bodySize]          ;copy the to the last var in array X the var one before him
	mov dx,[X+bx-2]
	mov [X+bx],dx
	sub bx,2
	
	mov cx,[bodyLoopTimes]
	sub cx,2
ArrangeLoop1:
	mov dx,[X+bx-2]
	mov [X+bx],dx
	sub bx,2
	loop ArrangeLoop1
	
	mov bx,[bodySize]         ;copy the to the last var in array Y the var one before him
	mov dx,[Y+bx-2]
	mov [Y+bx],dx
	sub bx,2
	
	mov cx,[bodyLoopTimes]
	sub cx,2
ArrangeLoop2:
	mov dx,[Y+bx-2]
	mov [Y+bx],dx
	sub bx,2
	loop ArrangeLoop2
	
	pop bx
	pop cx
ret
endp Arrange
proc HeadDir
	push bx
	push cx
	mov bx,0
	mov ax,[X+bx]
	mov cx,[Y+bx]
	
up:
	cmp [whereToMove],1
	jne right
	sub cx,5
	jmp refresh 
right:
	cmp [whereToMove],2
	jne down 
	add ax,5
	jmp refresh
down:
	cmp [whereToMove],3
	jne left
	add cx,5
	jmp refresh
left:
	cmp [whereToMove],4
	jne refresh
	sub ax,5
	jmp refresh
refresh:
	mov [X+bx],ax
	mov [Y+bx],cx
	pop cx
	pop bx
ret
endp HeadDir
proc DrawBody
	push bx
	push cx
DrawSnakecolor1:
	cmp [difficulty],1
	jne DrawSnakecolor2
	mov [snakeColor],0bh
	mov al,[snakeColor]
	jmp draw
DrawSnakecolor2:	
	cmp [difficulty],2
	jne DrawSnakecolor3
	mov [snakeColor],4
	mov al,[snakeColor]
	jmp draw
DrawSnakecolor3:	
	cmp [difficulty],3
	mov [snakeColor],5
	mov al,[snakeColor]
draw:
	mov cx,[X+bx]  ;x
	mov dx,[Y+bx]  ;y
	mov bh,0
	mov ah, 0ch ; put pixel
	push cx
	push dx
	add cx,5
	mov [maxX],cx
	add dx,5	
	mov [maxY],dx
	pop dx
	pop cx
colcount6:
	inc cx
	int 10h
	cmp cx, [maxX]
	JNE colcount6

	mov cx, [X+bx] ; reset to start of col
	inc dx      ;next row
	cmp dx, [maxY]
	JNE colcount6
notChanged:
	pop cx
	pop bx
ret
endp DrawBody
proc RemoveFood
remove2:
		mov cx,[foodX]  ;x
		mov dx,[foodY]  ;y
		mov bh,0
		mov al,[color2]
		mov ah, 0ch ; put pixel
		push cx
		push dx
		add cx,5
		mov [foodMaxX],cx
		add dx,5
		mov [foodMaxY],dx
		pop dx
		pop cx
colcount7:
		inc cx
		int 10h
		cmp cx, [foodMaxX]
		JNE colcount7

		mov cx, [foodX] ; reset to start of col
		inc dx      ;next row
		cmp dx, [foodMaxY]
		JNE colcount7
ret
endp RemoveFood
proc ScoreShow
	pop [index]
	mov ax,0
	pop ax
	mov bx, 10     
	mov dx, 0    
	mov cx, 0    
dloop1:  
	mov dx, 0    ;clears dx during jump
	div bx      
	push dx     ;pushes dx(remainder) to stack
	inc cx      ;increments counter to track the number of digits
	cmp ax, 0     
	jne dloop1     
 
dloop2:
	pop dx      
	add dx, 30h     
	mov ah, 02h     
	int 21h      
	loop dloop2   
	push [index]	
ret
endp ScoreShow
proc EatSound
	; open speaker 
	in  al, 61h    
	or  al, 00000011b  
	out  61h, al    
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte 
	mov [DelayLength],35h
	push [DelayLength]
	call Delay
	; close the speaker 
	in  al, 61h    
	and al, 11111100b  
	out  61h, al 
ret
endp EatSound
proc EndGameMelody
; open speaker 
	in  al, 61h    
	or  al, 00000011b  
	out  61h, al    
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note1] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte 
	mov [DelayLength],50h
	push [DelayLength]
	call Delay
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note2] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte 
	mov [DelayLength],50h
	push [DelayLength]
	call Delay
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note3] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte 
	mov [DelayLength],115h
	push [DelayLength]
	call Delay
	; close the speaker 
	in  al, 61h    
	and al, 11111100b  
	out  61h, al 
ret
endp EndGameMelody
proc StartGameMelody
; open speaker 
	in  al, 61h    
	or  al, 00000011b  
	out  61h, al    
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note3] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte 
	mov [DelayLength],35h
	push [DelayLength]
	call Delay
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note2] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte 
	mov [DelayLength],35h
	push [DelayLength]
	call Delay
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note1] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte 
	mov [DelayLength],35h
	push [DelayLength]
	call Delay
	; close the speaker 
	in  al, 61h    
	and al, 11111100b  
	out  61h, al 
ret
endp StartGameMelody
proc PauseGameMelody
; open speaker 
	in  al, 61h    
	or  al, 00000011b  
	out  61h, al    
	; send control word to change frequency 
	mov  al, 0B6h 
	out 43h, al 
	; play frequency 131Hz 
	mov ax, [note4] 
	out  42h, al   ; Sending lower byte  
	mov  al, ah 
	out 42h, al  ; Sending upper byte
	mov [DelayLength],35h
	push [DelayLength]	
	call Delay
	; close the speaker 
	in  al, 61h    
	and al, 11111100b  
	out  61h, al 
ret
endp PauseGameMelody
proc PauseSign
drawFirstPause:
		mov cx,130  ;x
		mov dx,70  ;y
		mov bh,0
		mov al,[color4]
		mov ah, 0ch ; put pixel
		push cx
		push dx
		add cx,10
		mov [pauseMaxX],cx
		add dx,60
		mov [pauseMaxY],dx
		pop dx
		pop cx
colcount8:
		inc cx
		int 10h
		cmp cx, [pauseMaxX]
		JNE colcount8

		mov cx, 130 ; reset to start of col
		inc dx      ;next row
		cmp dx, [pauseMaxY]
		JNE colcount8
		
drawSecondPause:
		mov cx,180  ;x
		mov dx,70  ;y
		mov bh,0
		mov al,[color4]
		mov ah, 0ch ; put pixel
		push cx
		push dx
		add cx,10
		mov [pauseMaxX],cx
		add dx,60
		mov [pauseMaxY],dx
		pop dx
		pop cx
colcount9:
		inc cx
		int 10h
		cmp cx, [pauseMaxX]
		JNE colcount9

		mov cx, 180 ; reset to start of col
		inc dx      ;next row
		cmp dx, [pauseMaxY]
		JNE colcount9
ret
endp PauseSign
proc RemovePauseSign
removeFirstPause:
		mov cx,130  ;x
		mov dx,70  ;y
		mov bh,0
		mov al,[color2]
		mov ah, 0ch ; put pixel
		push cx
		push dx
		add cx,10
		mov [pauseMaxX],cx
		add dx,60
		mov [pauseMaxY],dx
		pop dx
		pop cx
colcount10:
		inc cx
		int 10h
		cmp cx, [pauseMaxX]
		JNE colcount10

		mov cx, 130 ; reset to start of col
		inc dx      ;next row
		cmp dx, [pauseMaxY]
		JNE colcount10
		
removeSecondPause:
		mov cx,180  ;x
		mov dx,70  ;y
		mov bh,0
		mov al,[color2]
		mov ah, 0ch ; put pixel
		push cx
		push dx
		add cx,10
		mov [pauseMaxX],cx
		add dx,60
		mov [pauseMaxY],dx
		pop dx
		pop cx
colcount11:
		inc cx
		int 10h
		cmp cx, [pauseMaxX]
		JNE colcount11

		mov cx, 180 ; reset to start of col
		inc dx      ;next row
		cmp dx, [pauseMaxY]
		JNE colcount11
ret
endp RemovePauseSign
proc DrawBoard
 ; draw upper line:

    mov cx, 0  ; column
    mov dx, 14     ; row
    mov al, 14     ; white
u1: mov ah, 0ch    ; put pixel
    int 10h
   
    inc cx
    cmp cx, 320
    jl u1	
ret
endp DrawBoard
proc LiveScore
	call DrawBoard
	mov ah,02h
	mov dl,5
	mov dh,0
	int 10h
	lea dx,[msg8] 
	mov ah,09h
	int 21h
	push [score]
	call ScoreShow
	mov ah,02h
	mov dl,20
	mov dh,0
	int 10h
	lea dx,[msg9]  
	mov ah,09h
	int 21h
	push [highScore]
	call ScoreShow
	mov ah,02h
	mov dl,0
	mov dh,0
	int 10h
ret 
endp LiveScore
proc GetRandom
randomX:
	mov [prG16_range], 0       ;random X 0-320
	call Random
	mov [prG16_range], 63
	call Random
	cmp [prG16_result],0 
	je RandomX
	mov ax,[prG16_result]
	mul [mult]
	mov [foodX],ax
randomY:
	mov [prG16_range], 0     ; random Y 0-200
	call Random
	mov [prG16_range], 39
	call Random
	cmp [prG16_result],4 
	jl randomY
	mov ax,[prG16_result]
	mul [mult]
	mov [foodY],ax
ret
endp GetRandom
proc EraseScreen
	mov ax, 13h  
	int 10h  	
	mov ax, 0002
	int 10h	      ;erase dosbox  screen
ret
endp EraseScreen
;-----------------------------------------------------------------------------------------------------------
;===========================================================================================================
;                                                  code end
;===========================================================================================================
;-----------------------------------------------------------------------------------------------------------
END start1



