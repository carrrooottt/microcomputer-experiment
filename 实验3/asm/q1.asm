DATA   SEGMENT
        org  2000h
        num  db 23H
        org  2010h
        res  db 8 dup(?),'$'
DATA   ENDS

STACK  SEGMENT PARA STACK 'STACK'
  DB 100 DUP (?)
STACK  ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
;初始赋值
        LEA SI,res
        MOV AL,[num]
        MOV AH,0H
        MOV CL,10H
        DIV CL          ; 将79H分成7H和9H
        XCHG AH,AL      ; 交换AL和AH，使得AX为7H和9H
; 处理AH
        MOV CX,4H
        ADD SI,3
HEIGHT: XOR BX,BX
        SHR AH,1        ; 右移
        ADC BH,30H      ; 将结果修改为ASCII码
        MOV [SI],BH     ; 保存结果
        DEC SI
        LOOP HEIGHT
; 处理AL
        MOV CX,4H
        ADD SI,8
LOWER:  XOR BX,BX
        SHR AL,1        ; 右移
        ADC BH,30H      ; 将结果修改为ASCII码
        MOV [SI],BH     ; 保存结果
        DEC SI
        LOOP LOWER
; 在屏幕上显示结果
        LEA DX,res
        MOV AH,09H
        INT 21H
CODE    ENDS
        END START











