; 要求：有一个带符号字节型数组，求最大值、最小值、总和和平均值。

DATA   SEGMENT
  org  2000h
  num   db    12h,95h,0f1h,0c2h,82h,2h,10h,34h
  count equ   $-num
  org  2010h
  sum   dw    ?
  res   db    3 dup(?)          ;最大值、最小值和平均值
DATA   ENDS

STACK  SEGMENT PARA STACK 'STACK'
  DB 100 DUP (?)
STACK  ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
;求最大最小值
        LEA SI,num
        MOV CX,count
        MOV BH,[SI]     
        MOV BL,[SI]     
        INC SI
        DEC CX    
CIR:    CMP BH,[SI]     
        JGE NEXT1
        MOV BH,[SI]
NEXT1:  CMP BL,[SI]
        JLE NEXT2
        MOV BL,[SI]
NEXT2:  INC SI
        LOOP CIR
        ;循环完毕，存储最大最小值
        LEA DI,res
        MOV [DI],BH     
        INC DI  
        MOV [DI],BL     
;求总数
        LEA SI,num
        XOR DI,DI
        XOR BX,BX
        MOV CX,count
SUMLP:  MOV AL,[SI]
        CBW
        CWD
        ADD BX,AX
        ADC DI,DX
        INC SI
        LOOP SUMLP      ;求总数
        LEA SI,sum
        MOV [SI],BX     ;存储总数sum
        MOV AX,BX
        MOV DX,DI
        MOV CX,count
        IDIV CX         ;带符号数除法
        LEA DI,res              
        MOV [DI][2],AL  ;存储平均数          
        MOV AH,4CH
        INT 21H
CODE    ENDS
        END START









