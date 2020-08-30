DATA   SEGMENT
	ORG 2000H
        STU db 60,82,53,92,77,35,69,95,74,88
        LEN equ 10
        ORG 2010H
        RES dw ?
        ORG 2020H
        AVE db ?
DATA ENDS

STACK  SEGMENT PARA STACK 'STACK'
  DB 100 DUP (?)
STACK  ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
        MOV CX,LEN
        LEA SI,[STU]
        XOR AX,AX                 ;AX=0,CF=0
MY:     XOR BX,BX                 ;BX=0,CF=0
        MOV BL,[SI]               ;把[SI]对应的数值赋值给BL        
        ADD AX,BX                 
        INC SI                    
        LOOP MY
        MOV RES,AX                ;总成绩RES
        MOV BL,LEN
        DIV BL                    ;求平均分
        MOV AVE,AL
        MOV AH,4CH
        INT 21H
CODE    ENDS
        END START









