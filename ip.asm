IDEAL
MODEL small
STACK 256


DATASEG

CODESEG
    ORG 100h
start:
	 mov ax, @data
	 mov ds,ax
	 
    ; here your code
	mov ax , 1234h
	mov bx , 0
	mov bl , 34h
	mov cx , 0
	mov ch , 12h
	
EXIT:
    
	mov ax, 4C00h ; returns control to dos
  	int 21h
  
  
;---------------------------
; Procudures area
;---------------------------
 

END start