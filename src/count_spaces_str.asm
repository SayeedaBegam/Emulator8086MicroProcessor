;macro for printing a string
print macro m
mov ah,09h
mov dx,offset m
int 21h
endm
.model small
; Data Segment
.data
empty db 10,13, " $"
str1 db 25,?,25 dup('$')
mstring db 10,13, "Enter the string: $"
mscount db 10,13, "Number of spaces: $"
mlength db 10,13, "Length is: $"
scount db ?
; Code Segment
.code
start:
mov ax,@data
mov ds,ax
print mstring
call accept_string
mov si,offset str1+2 ;position si to start of the string
mov cl,str1+1 ; copy length in cl
mov dh,00 ;counter to store number of spaces
cmpagain1: mov al,[si] ;copy content at memory location "si" in "al"
cmp al,' ' ;compare "al" with space
jne below ;if not equal jump to label "below"
inc dh
below: inc si ;move to next character
dec cl ;decrement string length counter
jnz cmpagain1 ;if not zero check again
mov scount,dh ;save the count in memory location "scount"
mov bl,scount ;copy count to "bl" for printing
print mscount
call display1
exit:
mov ah,4ch ;exit the program
int 21h
;accept procedure
accept proc near
mov ah,01
int 21h
ret
accept endp
display1 proc near
mov al,bl
mov bl,al
and al,0f0h
mov cl,04
rol al,cl
cmp al,09
jbe number
add al,07
number: add al,30h
mov dl,al
mov ah,02
int 21h
mov al,bl
and al,00fh
cmp al,09
jbe number2
add al,07
number2: add al,30h
mov dl,al
mov ah,02
int 21h
ret
display1 endp
accept_string proc near
mov ah,0ah ;accept string from user function
mov dx,offset str1 ; store the string in memory pointed by "DX"
int 21h
ret
accept_string endp
end start
end