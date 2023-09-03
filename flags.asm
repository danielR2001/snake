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
	mov ax , 0D905h
	mov bx , 0EF37h
	mov cx , ax
	mov ax , bx
	mov bx , cx
	
EXIT:
    
	mov ax, 4C00h ; returns control to dos
  	int 21h
  
  
;---------------------------
; Procudures area
;---------------------------
 

END start