MOV SI,1100H
MOV DI,1200H
MOV DL,[DI]
MOV BL,01H
MOV AL,[SI]
AGAIN:
CMP AL,DL
JZ AVAIL
INC SI
INC BL
MOV AL,[SI]
CMP AL,00H
JNZ AGAIN
NODATA:
MOV CX,00H
MOV [DI + 1],CX
MOV [DI + 3],CX
JMP OVER
AVAIL:
MOV BH, 0FFH
MOV [DI+1],BH
MOV [DI+2],BL
MOV [DI+3],SI
OVER:
HLT