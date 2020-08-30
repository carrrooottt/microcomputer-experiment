DATA   SEGMENT
  org  2000h
  num  dw 78CDh
  org  2010h
  res  db 4 dup(?),'$'
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
        ADD SI,3H
        MOV AX,[num]
        MOV BX,10H
        MOV CX,3H
NEXT:   XOR DX,DX       ; 将dx和cf清零
        DIV BX          ; 除16取余数
        CMP DL,0AH      ; 判断是数字还是字母
        JAE LETTER
        ADD DL,30H      ; 数字加30H
        JMP SAVE
LETTER: ADD DL,37H      ; 字母加37H
SAVE:   MOV [SI],DL     ; 将修改后的ASCII码存到res
        DEC SI
        LOOP NEXT
; 处理剩余的一位，也就是AL对应的内容
        XOR DX,DX
        CMP AL,0AH
        JAE LETTERA
        ADD AL,30H
        JMP SAVEA
LETTERA:ADD AL,37H
SAVEA:  MOV [SI],AL
        LEA DX,res
        MOV AH,09H      ; 输出结果
        INT 21H
CODE    ENDS
        END START
