DATA   SEGMENT
  org  2000h
  num  dw 23333
  org  2010h
  res  db 5 dup(?),'$'
DATA   ENDS

STACK  SEGMENT PARA STACK 'STACK'
  DB 100 DUP (?)
STACK  ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
; 初始赋值
        LEA SI,res
        ADD SI,4H
        MOV CX,4H
        MOV AX,[num]
        MOV BX,0AH
NEXT:   XOR DX,DX       ; 将DX和CF清零
        DIV BX          ; 除10取余
        ADD DL,30H      ; 将结果修改为对应的ASCII码
        MOV [SI],DL     ; 把结果保存到res
        DEC SI
        LOOP NEXT
; 处理剩余一位，也就是AL
        ADD AL,30H
        MOV [SI],AL
        LEA DX,res
        MOV AH,09H      ; 输出结果到屏幕
        INT 21H
CODE    ENDS
        END START
