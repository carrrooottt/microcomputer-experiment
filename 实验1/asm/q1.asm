DATA   SEGMENT
BUFF   DB 79H,98H,23H,67H,0A8H
MAX    DB ?
DATA   ENDS

STACK  SEGMENT PARA STACK 'STACK'
       DB 100 DUP (?)
STACK  ENDS

CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA,SS:STACK
START: MOV AX,DATA
       MOV DS,AX
       MOV   CX,5           ; CX作为计数器
       LEA   SI,BUFF        ; 取BUFF地址给SI
       MOV   AL,[SI]        ; 将第一个（79H)赋值给AL
       DEC   CX             
       INC   SI             ; SI加1
LP:    CMP   AL,[SI]        ; 比较AL和偏移地址SI对应的的数值
       JGE   G1             ; 判断SF异或OF是否为0，如果为0，即[SI]<=AL,则转移到G1
       MOV   AL,[SI]        ; 在[SI]大于AL的情况下把[SI]的值给AL
G1:    INC   SI             ;      
       LOOP  LP             ; 当CX≠0的时候转移到LP，直至CX=0
       MOV   MAX,AL         
       MOV   AH,4CH
       INT   21H
 CODE  ENDS
       END START



