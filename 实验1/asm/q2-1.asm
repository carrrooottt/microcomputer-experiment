DATA   SEGMENT
  org    2000H
  NUM1   db     12H,95H,0f1H,0c2H,82H,2H,10H,34H
  COUNT  equ    $-num1
  org    2010H
  NUM2   db     23H,0dfH,023H,3fH,3cH,0b3H,57H,3H
  org    2020H
  res    dw COUNT dup(0)
DATA   ENDS

STACK  SEGMENT PARA STACK 'STACK'
  DB 100 DUP (?)
STACK  ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
        MOV CX,COUNT            
        MOV SI,0
        MOV DI,0
P1:     XOR AX,AX                 ;将AX,BX清零
        XOR BX,BX
        MOV BL,[2010H][SI]        ;取NUM2第SI个元素
        MOV AL,[2000H][SI]        ;取NUM1第SI个元素
        ADD AX,BX                 ;相加
        MOV [2020H][DI],AX        ;把相加之后的结果给res第SI个
        INC SI                    ;SI+1
        ADD DI,2
        LOOP P1        
        MOV AH,4CH
        INT 21H
CODE    ENDS
        END START











