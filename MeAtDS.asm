IDEAL
MODEL small
STACK 256


DATASEG
MyName 49h,64h,6Fh,20h,41h,6Ch,62h,65h,63h,6Bh,20h,8h
CODESEG
    ORG 100h
	
start:
	 mov ax, @data
	 mov ds,ax
	 
    ; here your code
	mov bx,9
	mov al,MyName
	mov [bx], al
	
EXIT:
    
	mov ax, 4C00h ; returns control to dos
  	int 21h
  
  
;---------------------------
; Procudures area
;---------------------------
 

END start