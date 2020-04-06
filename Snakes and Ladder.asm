[org 0x100]
jmp start
score:dw 0
time:dw 0
timesecond:dw 59
timeminute:dw 3
count_lives:dw 3
oldkb:dd 0
string:db 'Lives:'
string1:db'Game Over'
string2:db'You Won!!'
string3:db 'Press 1 : Easy'
string4:db 'Press 2 : Normal'
string5:db'Press 3 : Difficult'
string6:db'SNAKE GAME'
flag_easy:db 0
flag_normal:db 0
flag_difficult:db 0
flag_up:dw 0
flag_down:dw 0
flag_left:dw 1
flag_right:dw 0
universal_timer:dw 0
tick_count:dw 0
speedup:dw 9

fruit:dw 0x0523,0x1124,0x0528,0x0626
fruit_index:dw 0
fruit_di:dw 0
eaten:dw 0
eaten_size:dw 0
flag_fruit:dw 0
random:dw 500
snake: dw 20
snake_size :dw 1982,1984,1986,1988,1990,1992,1994,1996,1998,2000,2002,2004,2006,2008,2010,2012,2014,2016,2018,2020
snake_size1:times 220 dw 0

;________________________________________________________
;________________________________________________________
;________________________________________________________
;decrements a life and resets screen and size
reset:

	push cs
	pop ds
	push cx
	push si
	push bx
	push ax
	dec word[count_lives]
	cmp word[count_lives],0	;decrements life
	jg move_on
	call end_screen	;if life is zero then display endscreen and end game
	call eot

;if life is not zero then clears and resets screen

move_on:

	call clrsreen	;clears screen and print lives
	call print_lives
	mov ax,1982
	mov word[snake],20	;reset size of snake to zero
	mov cx,[snake]
	mov bx,snake_size
	mov si,0

loops:

	mov word[bx+si],ax	;prints snake at start position
	add ax,2
	add si,2
	loop loops
	mov bx,snake_size1
	mov si,0
	mov cx,220

loops1:

	mov word[bx+si],0	;clears previous snake position
	add si,2
	loop loops1
	mov word[flag_up],0		;resets direction keys flags
	mov word[flag_down],0
	mov word[flag_right],0
	mov word[flag_left],0
	pop ax
	pop bx
	pop si
	pop cx
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;this function print lives on the top left corner of screen
print_lives:

	push cs
	pop ds
	push cx
	push si
	push es
	push ax
	push di
	mov cx,10
	push 0xb800
	pop es
	mov di,2

label3:		;this loop first clears that print space
	
	mov ax,0x0720		
	mov word[es:si],ax
	add si,2
	loop label3
	mov cx,6
	mov si,string

label1:		;this loop prints LIVES

	mov ah,0x04
	cld
	lodsb
	cld
	stosw
	loop label1
	mov cx,[count_lives]
	cmp cx,0
	je eop
	mov si,14

label2:		;this loop prints hearts

	mov ax,0x0403
	mov word[es:si],ax
	add si,2
	loop label2
	jmp eop

eop:

	pop di
	pop ax
	pop es
	pop si
	pop cx
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;this function print boundary along with hurdles
print_boundry_colour:

	push es
	push si
	push ax
	mov ax,0xc020
	push 0xb800
	pop es
	mov si,320

again1:
	
	mov word[es:si],ax
	add si,2
	cmp si,480
	jne again1
	mov si,478

again2:

	mov word[es:si],ax
	add si,160
	cmp si,3998
	jne again2
	mov si,3840

again3:
	
	mov word[es:si],ax
	add si,2
	cmp si,4000
	jne again3
	mov si,320

again4:

	mov word[es:si],ax
	add si,160
	cmp si,3840
	jne again4
	cmp word[flag_easy],1		;this check checks if player wants to play easy
	jne ck1
	jmp end_print_boundary

ck1:

	cmp word[flag_normal],1		;this check checks if player wants to play normal
	jne ck2
	mov ax,0x3020;hurdles
	mov word[es:1300],ax
	mov word[es:1460],ax
	mov word[es:1620],ax
	mov word[es:1410],ax
	mov word[es:1570],ax
	mov word[es:1730],ax
	mov word[es:2370],ax
	mov word[es:2530],ax
	mov word[es:2690],ax
	mov word[es:2260],ax
	mov word[es:2420],ax
	mov word[es:2580],ax
	jmp end_print_boundary

ck2:		;else player have to play difficult

	mov ax,0x3020;hurdles
	mov word[es:1340],ax
	mov word[es:1342],ax
	mov word[es:1344],ax
	mov word[es:1346],ax
	mov word[es:1348],ax
	mov word[es:1350],ax
	mov word[es:1352],ax
	mov word[es:1354],ax
	mov word[es:1356],ax
	mov word[es:1358],ax
	mov word[es:1360],ax
	mov word[es:1362],ax
	mov word[es:1364],ax
	mov word[es:1366],ax
	mov word[es:1368],ax
	mov word[es:1370],ax

	mov word[es:2620],ax
	mov word[es:2622],ax
	mov word[es:2624],ax
	mov word[es:2626],ax
	mov word[es:2628],ax
	mov word[es:2630],ax
	mov word[es:2632],ax
	mov word[es:2634],ax
	mov word[es:2636],ax
	mov word[es:2638],ax
	mov word[es:2640],ax
	mov word[es:2642],ax
	mov word[es:2644],ax
	mov word[es:2646],ax
	mov word[es:2648],ax
	mov word[es:2650],ax

	mov word[es:1300],ax
	mov word[es:1460],ax
	mov word[es:1620],ax
	mov word[es:1780],ax
	mov word[es:1940],ax
	mov word[es:2100],ax
	mov word[es:2260],ax
	mov word[es:2420],ax
	mov word[es:2580],ax

	mov word[es:1410],ax
	mov word[es:1570],ax
	mov word[es:1730],ax
	mov word[es:1890],ax
	mov word[es:2050],ax
	mov word[es:2210],ax
	mov word[es:2370],ax
	mov word[es:2530],ax
	mov word[es:2690],ax

end_print_boundary:

	pop ax
	pop si
	pop es
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;this check makes sure if snake hits its own body then one live goes
own_check:
	
	push cs
	pop ds
	push cx
	push si
	push bx
	push dx
	mov si,0
	mov dx,[snake_size+si]
	mov cx,[snake]
	dec cx
	mov bx,snake_size
	mov si,2

loops2:
	
	cmp dx,[bx+si]
	je match_found
	add si,2
	loop loops2
	jmp eooc

match_found:
	
	call reset

eooc: ;end of own check

	pop dx
	pop bx
	pop si
	pop cx
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;this function makes sure if snake hits boundary then one live is gone
boundry_check:
		
	push cs
	pop ds
	push ax
	push dx
	push si
	push bx
	mov si,0
	mov dx,[snake_size+si]
	mov ax,dx
	mov bl,160
	div bl
	cmp ah,0
	jne first_cmp
	call reset
	jmp eobc1

first_cmp:

	cmp ah,158
	jne second_cmp
	call reset
	jmp eobc1

second_cmp:

	cmp dx,320
	jg cmp1
	jmp third_cmp

cmp1:
	
	cmp dx,478
	jnl third_cmp
	call reset
	jmp eobc1

third_cmp:
	
	cmp dx,3840
	jg cmp2
	jmp next_chk

cmp2:

	cmp dx,3998
	jnl next_chk
	call reset
	jmp eobc1

;-------------------------
next_chk:

	cmp word[flag_easy],1
	jne nxt
	pop bx
	pop si
	pop dx
	pop ax
	ret

nxt:

	cmp word[flag_normal],1
	je compare3
	jmp last_check

compare3:
	
	cmp dx,1300
	jne compare4
	call reset
	jmp eobc1

compare4:

	cmp dx,1460
	jne compare5
	call reset
	jmp eobc1

compare5:

	cmp dx,1620
	jne compare6
	call reset
	jmp eobc1

compare6:

	cmp dx,1410
	jne compare7
	call reset
	jmp eobc1

compare7:
	
	cmp dx,1570
	jne compare8
	call reset
	jmp eobc1

compare8:

	cmp dx,1730
	jne compare9
	call reset
	jmp eobc1

compare9:

	cmp dx,2370
	jne compare10
	call reset
	jmp eobc1

compare10:

	cmp dx,2530
	jne compare11
	call reset
	jmp eobc1

compare11:

	cmp dx,2690
	jne compare12
	call reset
	jmp eobc1

compare12:

	cmp dx,2260
	jne compare13
	call reset
	jmp eobc1

compare13:

	cmp dx,2420
	jne compare14
	call reset
	jmp eobc1

compare14:

	cmp dx,2580
	jne eobc1
	call reset

eobc1:
	
	pop bx
	pop si
	pop dx
	pop ax
	ret
;----------

last_check:

cmp3:

	cmp dx,1300
	jne cmp4
	call reset
	jmp eobc

cmp4:

	cmp dx,1460
	jne cmp5
	call reset
	jmp eobc

cmp5:
	
	cmp dx,1620	
	jne cmp6
	call reset
	jmp eobc

cmp6:
	
	cmp dx,1780
	jne cmp7
	call reset
	jmp eobc

cmp7:
	
	cmp dx,1940
	jne cmp8
	call reset
	jmp eobc

cmp8:
	
	cmp dx,2100
	jne cmp9
	call reset
	jmp eobc

cmp9:

	cmp dx,2260
	jne cmp10
	call reset
	jmp eobc

cmp10:

	cmp dx,2420
	jne cmp011
	call reset
	jmp eobc

cmp011:
	
	cmp dx,2580
	jne cmp11
	call reset
	jmp eobc

cmp11:
	
	cmp dx,1410
	jne cmp12
	call reset
	jmp eobc

cmp12:
	
	cmp dx,1570
	jne cmp13
	call reset
	jmp eobc

cmp13:
	
	cmp dx,1730
	jne cmp14
	call reset
	jmp eobc

cmp14:
	
	cmp dx,1890
	jne cmp15
	call reset
	jmp eobc

cmp15:
	
	cmp dx,2050
	jne cmp16
	call reset
	jmp eobc

cmp16:
	
	cmp dx,2210
	jne cmp17
	call reset
	jmp eobc

cmp17:
	
	cmp dx,2370
	jne cmp18
	call reset
	jmp eobc

cmp18:
	
	cmp dx,2530
	jne cmp19
	call reset
	jmp eobc

cmp19:

	cmp dx,2690
	jne cmp20
	call reset
	jmp eobc

cmp20:
	
	cmp dx,2620
	jl cmp21
	cmp dx,2650
	jg cmp21
	call reset
	jmp eobc

cmp21:
	
	cmp dx,1340
	jl eobc
	cmp dx,1370
	jg eobc
	call reset
	jmp eobc

eobc:
	
	pop bx
	pop si
	pop dx
	pop ax
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
; clears the snake on screen 
clrsreen:
	
	push cx
	push si
	push es
	push di
	push 0xb800
	pop es
	mov si,0
	mov cx,word[snake]

ch_next:
	
	mov di,word[snake_size+si] 
	mov word[es:di],0x0720
	add si,2
	loop ch_next
	call print_boundry_colour
	pop di
	pop es
	pop si
	pop cx
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;this function prints the snake
printSnake:
	
	push bp
	mov bp,sp
	push es
	push di
	push bx
	push si
	push cx
	push cs
	pop ds
	push 500
	call Beep
	push 0xb800
	pop es
	mov bx,snake_size
	mov di,0 
	mov cx,[cs:snake]
	dec cx
	mov si,[bx+di]
	mov word[es:si],0x0425
	add di,2

ch1_next:
	
	mov si,[bx+di]
	mov word[es:si],0x0978
	add di,2
	loop ch1_next
	mov di,word[bp+4]
	mov word[es:di],0x0720
	pop cx
	pop si
	pop bx
	pop di
	pop es
	pop bp
	ret 2
;________________________________________________________
;________________________________________________________
;________________________________________________________
;function that moves right
move_right:
	
	push ax
	push dx
	push cx
	push bx
	push di
	push cs
	pop ds
	call fruiteaten
	mov cx,[snake]
	dec cx
	mov bx,snake_size
	mov di,cx
	shl di,1
	sub di,2
	mov ax,word[bx+di+2]

ch2_next:
	
	mov dx,word[bx+di]
	mov word[bx+di+2],dx
	sub di,2
	loop ch2_next
	add di,2
	mov dx,word[bx+di+2]
	add dx,2
	mov word[bx+di],dx
	push ax
	call printSnake

	pop di
	pop bx
	pop cx
	pop dx
	pop ax
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;function that moves up
move_up:
	
	push ax
	push dx
	push cx
	push bx
	push di
	push cs 
	pop ds
	call fruiteaten
	mov cx,[snake]
	dec cx
	mov bx,snake_size
	mov di,cx
	shl di,1
	sub di,2
	mov ax,word[bx+di+2]

ch4_next:
	
	mov dx,word[bx+di]
	mov word[bx+di+2],dx
	sub di,2
	loop ch4_next
	add di,2
	mov dx,word[bx+di+2]
	sub dx,160
	mov word[bx+di],dx
	push ax
	call printSnake

	pop di
	pop bx
	pop cx
	pop dx
	pop ax
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;function that moves down
move_down:

	push ax
	push dx
	push cx
	push bx
	push di
	push cs 
	pop ds
	call fruiteaten
	mov cx,[snake]
	dec cx
	mov bx,snake_size
	mov di,cx
	shl di,1
	sub di,2
	mov ax,word[bx+di+2]

ch5_next:
	
	mov dx,word[bx+di]
	mov word[bx+di+2],dx
	sub di,2
	loop ch5_next
	add di,2
	mov dx,word[bx+di+2]
	add dx,160
	mov word[bx+di],dx
	push ax
	call printSnake

	pop di
	pop bx
	pop cx
	pop dx
	pop ax
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;function that moves left
move_left:
	
	push ax
	push dx
	push cx
	push bx
	push di
	push cs
	pop ds
	call fruiteaten
	mov cx,[snake]
	dec cx
	mov bx,snake_size
	mov di,cx
	shl di,1
	sub di,2
	mov ax,word[bx+di+2]

ch6_next:
	
	mov dx,word[bx+di]
	mov word[bx+di+2],dx
	sub di,2
	loop ch6_next
	add di,2
	mov dx,word[bx+di+2]
	sub dx,2
	mov word[bx+di],dx
	push ax
	call printSnake
	pop di
	pop bx
	pop cx
	pop dx
	pop ax
	ret

;________________________________________________________
;________________________________________________________
;________________________________________________________
;check if fruit is eaten by snake
fruiteaten:
	
	push ax
	mov ax,word[snake_size]
	cmp ax,word[fruit_di]	;check location of face and fruit
	jne exitfruiteaten	; if same then fruit eaten by snake
	inc word[snake]	;else increment snake's size
	cmp word[snake],240
	jne s_k_i_p		;compares snake size with maximum if equal then end game
	call win_screen
	call eot

s_k_i_p:	;resets fruit flag and sets eaten flag

	mov word[flag_fruit],0
	mov word[eaten],1

exitfruiteaten:
	
	pop ax
	ret

;________________________________________________________
;________________________________________________________
;________________________________________________________
	
kbisr:
	
	push cs
	pop ds
	push ax
	in al,0x60
	cmp al,0x48	;check for up key
	jne next1
	mov word[flag_up],1
	mov word[flag_down],0
	mov word[flag_right],0
	mov word[flag_left],0
	jmp nomatch

next1:
	
	cmp al,0x50		;check for down key
	jne next2
	mov word[flag_up],0
	mov word[flag_down],1
	mov word[flag_right],0
	mov word[flag_left],0
	jmp nomatch
	
next2:
	
	cmp al,0x4b		;check for left key
	jne next3
	mov word[flag_up],0
	mov word[flag_down],0
	mov word[flag_right],0
	mov word[flag_left],1
	jmp nomatch

next3:
	
	cmp al,0x4d		;check for right key
	jne nomatch
	mov word[flag_up],0
	mov word[flag_down],0
	mov word[flag_right],1
	mov word[flag_left],0
	jmp nomatch

nomatch:
	
	pop ax
	jmp far[oldkb]	;jumps to original keyboard isr

;________________________________________________________
;________________________________________________________
;________________________________________________________
;checks for appropriate position of fruit
checkrandom:
	
	push ax
	push bx
	mov ax,word[random]
	mov bl,160
	div bl
	cmp ah,0
	jne checkrandom1
	mov word[random],500
	jmp checkrandom20

checkrandom1:	;below are all boundary and hurdles checks
	
	cmp ah,158
	jne checkrandom2
	mov word[random],500
	jmp checkrandom20

checkrandom2:
	
	cmp word[random],3600
	jg sk
	jmp exitrandom
	sk:
	mov word[random],660
	jmp checkrandom20

checkrandom3:
	
	cmp word[random],1300
	jne checkrandom4
	mov word[random],660
	jmp checkrandom20

checkrandom4:
	
	cmp word[random],1460
	jne checkrandom5
	mov word[random],660
	jmp checkrandom20
	
checkrandom5:
	
	cmp word[random],1620
	jne checkrandom6
	mov word[random],660
	jmp checkrandom20

checkrandom6:

	cmp word[random],1780
	jne checkrandom7
	mov word[random],660
	jmp checkrandom20

checkrandom7:
	
	cmp word[random],1940
	jne checkrandom8
	mov word[random],660
	jmp checkrandom20

checkrandom8:
	
	cmp word[random],2100
	jne checkrandom9
	mov word[random],660
	jmp checkrandom20

checkrandom9:
	
	cmp word[random],2260
	jne checkrandom10
	mov word[random],660
	jmp checkrandom20

checkrandom10:
	
	cmp word[random],2420
	jne checkrandom011
	mov word[random],660
	jmp checkrandom20

checkrandom011:
	
	cmp word[random],2580
	jne checkrandom11
	mov word[random],660
	jmp checkrandom20

checkrandom11:
	
	cmp word[random],1410
	jne checkrandom12
	mov word[random],660
	jmp checkrandom20

checkrandom12:
	
	cmp word[random],1570
	jne checkrandom13
	mov word[random],660
	jmp checkrandom20

checkrandom13:
	
	cmp word[random],1730
	jne checkrandom14
	mov word[random],660
	jmp checkrandom20

checkrandom14:
	
	cmp word[random],1890
	jne checkrandom15
	mov word[random],660
	jmp checkrandom20

checkrandom15:
	
	cmp word[random],2050
	jne checkrandom16
	mov word[random],660
	jmp checkrandom20

checkrandom16:
	
	cmp word[random],2210
	jne checkrandom17
	mov word[random],660
	jmp checkrandom20

checkrandom17:

	cmp word[random],2370
	jne checkrandom18
	mov word[random],660
	jmp checkrandom20

checkrandom18:
	
	cmp word[random],2530
	jne checkrandom19
	mov word[random],660
	jmp checkrandom20
	
checkrandom19:
	
	cmp word[random],2690
	jne checkrandom20
	mov word[random],660

checkrandom20:
	
	mov bx,0
	mov cx,word[snake]
	mov dx,word[random]

selfcheck:
	
	cmp word[snake_size+bx],dx
	je self
	loop selfcheck
	jmp checkrandom21

self:
	
	mov word[random],1800
	jmp exitrandom

checkrandom21:
	
	cmp word[random],2620
	jl checkrandom22
	cmp word[random],2650
	jg checkrandom22
	mov word[random],1800
	jmp exitrandom
	
checkrandom22:

	cmp word[random],1340
	jl exitrandom
	cmp word[random],1370
	jg exitrandom
	mov word[random],1800
	jmp exitrandom

exitrandom:

	pop bx
	pop ax
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;prints fruit at appropriate location
fruitprint:

	push di
	push si
	push ax
	push es
	mov di,word[random]
	mov word[fruit_di],di
	mov si,[fruit_index]
	mov ax,0xb800
	mov es,ax
	mov ax,word[fruit+si]
	mov word[es:di],ax
	inc word[fruit_index]	;displays three kinds of fruits
	cmp word[fruit_index],4
	jne exitfruitprint
	mov word[fruit_index],0

exitfruitprint:
	
	pop es
	pop ax
	pop si
	pop di
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;clear screen code from book
clrscr:
	
	pusha
	push es
	mov ax, 0xb800
	mov es, ax
	xor di,di
	mov ax,0x0720
	mov cx,2000
	cld
	rep stosw
	pop es
	popa
	ret

;________________________________________________________
;________________________________________________________
;________________________________________________________
;printnum code from book with few changes for displaying
;score on the screen
printscore:
	
	push cs
	pop ds 
	push es              
	push ax             
	push bx             
	push cx             
	push dx             
	push di 
	push si
    mov  ax, 0xb800     
	mov  es, ax             ; point es to video base   
	mov  bx, 10             ; use base 10 for division   
	mov  cx, 0              ; initialize count of digits 
	mov di,70
	mov ah,0x07
	mov al,'S'
	mov word[es:di],ax
	add di,2
	mov al,'C'
	mov word[es:di],ax
	add di,2
	mov al,'O'
	mov word[es:di],ax
	add di,2
	mov al,'R'
	mov word[es:di],ax
	add di,2
	mov al,'E'
	mov word[es:di],ax
	add di,2
	mov al,':'
	mov word[es:di],ax
	add di,2
	mov ax,word[score]
	
nextdigitscore:  
	
	mov  dx, 0              ; zero upper half of dividend       
	div  bx                 ; divide by 10            
	add  dl, 0x30           ; convert digit into ascii value     
	push dx                 ; save ascii value on stack          
	inc  cx                 ; increment count of values          
	cmp  ax, 0              ; is the quotient zero             
	jnz  nextdigitscore          ; if no divide it again 
 
nextposscore:      
	
	pop  dx                 ; remove a digit from the stack   
    mov  dh, 0x07           ; use normal attribute      
	mov  [es:di], dx        ; print char on screen      
	add  di, 2              ; move to next screen location     
	loop nextposscore  	; repeat for all digits on stack 
	
 exitdigitscore:
 
	pop si
    pop  di           
	pop  dx           
	pop  cx           
	pop  bx           
	pop  ax 
	pop  es  
	ret  
;________________________________________________________
;________________________________________________________
;________________________________________________________
; printnum code from book to print time
 printnum: 
	
	push cs
	pop ds 
	push es              
	push ax             
	push bx             
	push cx             
	push dx             
	push di 
	push si
    mov  ax, 0xb800     
	mov  es, ax             ; point es to video base   
	mov  bx, 10             ; use base 10 for division   
	mov  cx, 0              ; initialize count of digits 
	mov ax,word[timeminute]
	mov di,140
	mov si,0
	cmp ax,9
	jg nextdigit
	
nextdigit:  

	mov  dx, 0              ; zero upper half of dividend       
	div  bx                 ; divide by 10            
	add  dl, 0x30           ; convert digit into ascii value     
	push dx                 ; save ascii value on stack          
	inc  cx                 ; increment count of values          
	cmp  ax, 0              ; is the quotient zero             
	jnz  nextdigit          ; if no divide it again 
 
nextpos:      

	pop  dx                 ; remove a digit from the stack   
    mov  dh, 0x07           ; use normal attribute      
	mov  [es:di], dx        ; print char on screen      
	add  di, 2              ; move to next screen location     
	loop nextpos  	; repeat for all digits on stack 
	inc si
	cmp si,2
	je exitdigit
	mov ah,0x07
	mov al,':'
	mov word[es:di],ax
	add di,2
	mov ax,word[timesecond]
	jmp nextdigit

exitdigit:
 
	pop si
    pop  di           
	pop  dx           
	pop  cx           
	pop  bx           
	pop  ax 
	pop  es  
	ret  

;________________________________________________________
;________________________________________________________
;________________________________________________________
;displays timer on the screen
displaytime:
	
	push es
	push ax
	inc word[time]
	cmp word[time],18
	jne no
	mov word[time],0
	dec word[timesecond]
	cmp word[timesecond],0
	jne no
	mov word[timesecond],59
	dec word[timeminute]
	cmp word[timeminute],0
	jge no
	call reset
	call print_lives
	mov word[timeminute],3

no:
	
	cmp word[timesecond],9
	jg printnum1
	mov ax,0xb800
	mov es,ax
	mov word[es:146],0x0720

printnum1:
	
	call printscore
	call printnum
	pop ax
	pop es
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________

timer:
	
	push cs
	pop ds
	inc word[score]	;keeps incrementing score

notend:
	
	add word[random],4	;random generator
	cmp word[flag_fruit],1
	je nofruitprint		;if fruit eaten then print new fruit 
	call checkrandom
	call fruitprint
	add word[score],100	;if fruit eaten increment score by 100
	mov word[flag_fruit],1

nofruitprint:
	call displaytime
	inc word[universal_timer]		;universal counter for speed increase
	cmp word[universal_timer],1092		;364 for 20seconds_ 1092 for 1 minute
	jne timer1
	mov word[universal_timer],0
	mov ax,word[speedup]
	mov bx,2
	div bl
	mov ah,0
	mov word[speedup],ax	;speed up for increasing amount of speed

timer1:
	
	inc word[tick_count]	;tick count for allowing program to execute
	mov ax,word[speedup]	;after every speedup time
	cmp word[tick_count],ax
	jge skip
	mov al,0x20;eoi
	out 0x20,al
	iret

skip:
		;checks if fruit eaten or not and increases snake's size
	mov word[tick_count],0
	cmp word[eaten],1
	jne nofruitprint1
	inc word[snake]
	inc word[eaten_size]
	cmp word[eaten_size],3
	jne nofruitprint1
	mov word[eaten_size],0
	mov word[eaten],0

nofruitprint1:
	
	cmp word[flag_up],1
	jne check_next

	call move_up
	call boundry_check
	call own_check
	push 0
	call printSnake
	jmp eot;end of timer

check_next:
	
	cmp word[flag_down],1
	jne check_next1

	call move_down	
	call boundry_check
	call own_check
	push 0
	call printSnake
	jmp eot;end of timer

check_next1:
	
	cmp word[flag_left],1
	jne check_next2
	call move_left	
	call boundry_check
	call own_check
	push 0
	call printSnake
	jmp eot;end of timer

check_next2:
	
	cmp word[flag_right],1
	jne eot
	call move_right
	call boundry_check
	call own_check
	push 0
	call printSnake
	jmp eot;end of timer

eot:		;end of timer
	
	mov al,0x20;eoi
	out 0x20,al
	iret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;creates beep with each movement of snake
Beep:
	
	push bp
	mov bp,sp
	push cs
	pop ds
	push dx
	push ax
	push bx
	push cx
	mov dx,[bp+4]
	mov bx,1
	mov al, 10110110B   
	out 43H, al         

frequency:          
	
	mov ax, bx           
	out 42H, al          
	mov al, ah             
	out 42H, al          
	in al, 61H          
	or al, 00000011B    
	out 61H, al         
	mov cx, 100        

delay:              
	
	loop delay       
	inc bx               
	dec dx               
	cmp dx, 0            
	jnz frequency  
	in al,61H          
	and al,11111100B     
	out 61H,al          
	pop cx
	pop bx
	pop ax
	pop dx
	pop bp
	ret 2
;________________________________________________________
;________________________________________________________
;________________________________________________________
;prints end screen
end_screen:
	
	pusha
	push es
	mov ax, 0xb800
	mov es, ax
	xor di,di
	mov ax,0x6020
	mov cx,2000
	cld
	rep stosw
	mov cx,9
	mov di,1990
	mov bx,string1
	mov si,0
	mov ah,0x60

label4:
	
	mov al,[bx+si]
	mov word[es:di],ax
	add di,2
	add si,1
	loop label4
	pop es
	popa
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;prints win screen
win_screen:
	
	pusha
	push es
	mov ax, 0xb800
	mov es, ax
	xor di,di
	mov ax,0x6020
	mov cx,2000
	cld
	rep stosw
	mov cx,9
	mov di,1990
	mov bx,string2
	mov si,0
	mov ah,0x60

label5:
	
	mov al,[bx+si]
	mov word[es:di],ax
	add di,2
	add si,1
	loop label5
	pop es
	popa
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;prints start screen
start_screen:
	
	pusha
	push es
	mov ax, 0xb800
	mov es, ax
	xor di,di
	mov ax,0x0720
	mov cx,2000
	cld
	rep stosw
	mov cx,14
	mov di,1826
	mov bx,string3
	mov si,0
	mov ah,0x06

label6:
	
	mov al,[bx+si]
	mov word[es:di],ax
	add di,2
	add si,1
	loop label6
	mov cx,16
	mov di,1984
	mov bx,string4
	mov si,0
	mov ah,0x06

label7:
	
	mov al,[bx+si]
	mov word[es:di],ax
	add di,2
	add si,1
	loop label7
	mov cx,19
	mov di,2142
	mov bx,string5
	mov si,0
	mov ah,0x06

label8:
	
	mov al,[bx+si]
	mov word[es:di],ax
	add di,2
	add si,1
	loop label8
	mov cx,10
	mov di,1668
	mov bx,string6
	mov si,0
	mov ah,0x02

label9:
	
	mov al,[bx+si]
	mov word[es:di],ax
	add di,2
	add si,1
	loop label9
	mov ah,0x02
	mov al,'('
	mov word[es:2128],ax
	mov al,0x07
	mov word[es:2130],ax
	mov al,' '
	mov word[es:2132],ax
	mov al,' '
	mov word[es:2134],ax
	mov al,0x07
	mov word[es:2136],ax
	mov al,')'
	mov word[es:2138],ax
	mov al,'\'
	mov word[es:2290],ax
	mov al,'/'
	mov word[es:2296],ax
	mov al,'\'
	mov word[es:2452],ax
	mov al,'/'
	mov word[es:2454],ax
	mov al,'|'
	mov word[es:2612],ax
	mov al,'^'
	mov word[es:2772],ax
	mov al,'|'
	mov word[es:1968],ax
	mov al,'|'
	mov word[es:1978],ax
	mov al,'/'
	mov word[es:1808],ax
	mov al,'|'
	mov word[es:1818],ax
	mov al,'/'
	mov word[es:1648],ax
	mov al,'/'
	mov word[es:1658],ax
	mov al,'_'
	mov word[es:1490],ax
	mov al,'_'
	mov word[es:1492],ax
	mov al,'_'
	mov word[es:1494],ax
	mov al,'_'
	mov word[es:1496],ax
	pop es
	popa
	ret
;________________________________________________________
;________________________________________________________
;________________________________________________________
;our main
start:
	
	call start_screen
	mov ah,0
	int 0x16		;this is to check which stage he want to play
	cmp al,49
	jne next_ck
	mov word[flag_easy],1
	jmp real_start

next_ck:
	
	cmp al,50
	jne next_ck1
	mov word[flag_normal],1
	jmp real_start

next_ck1:
	
	jne real_start
	mov word[flag_difficult],1

real_start:
	
	call clrscr
	call print_lives
	call print_boundry_colour
	xor ax,ax
	mov es,ax
	mov ax,[es:0x9*4]
	mov word[oldkb],ax
	mov ax,[es:0x9*4+2]
	mov word[oldkb+2],ax
	cli
	mov word[es:9*4],kbisr
	mov word[es:9*4+2],cs
	mov word[es:8*4],timer
	mov word[es:8*4+2],cs
	sti
;________________________________________________________
;________________________________________________________
;________________________________________________________
;exit timer and game
exit:

	mov ax,0x4c00
	int 21h
;________________________________________________________
;________________________________________________________
;________________________________________________________