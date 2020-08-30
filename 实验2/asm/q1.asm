DATA   SEGMENT
  org  2000h
  str1  db   'AeHdc123!*sLdeDIO71ok',0AH,0DH,'$'
  count equ   $-str1
  org  2030h
  str2  db    count dup(?)      ;存放处理后的字符串
  num   db    ?                 ;存放大写字母的统计个数        
  
DATA   ENDS

STACK  SEGMENT PARA STACK 'STACK'
  DB 100 DUP (?)
STACK  ENDS

CODE   SEGMENT 
       ASSUME CS:CODE,DS:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
        MOV CX,count
        XOR DX,DX
        LEA SI,str1
        LEA DI,str2        
NEXT:   MOV AL,[SI]
        CMP AL,'A'      ;小于A的转跳
        JB WONTCG 
        CMP AL,'Z'      ;大于Z的转跳
        JA WONTCG       
        ADD AL,20H      ;在A-Z中的加上20H
        INC DL          ;统计大写字母数量
WONTCG: MOV [DI],AL
        INC SI
        INC DI               
        LOOP NEXT
        LEA DI,num      
        MOV [DI],DL     ;存储大写字母数量
        LEA DX,str1     ;输出原字符串
        MOV AH,09H
        INT 21H
        LEA DX,str2     ;输出修改后的字符串
        MOV AH,09H
        INT 21H
CODE    ENDS
        END START






