;按键控制;
porta   equ 288H              ;74LS138的/Y1地址:288h
portb   equ 289H
portc   equ 28AH
portcon equ 28BH

CODE SEGMENT
ASSUME CS:CODE
START:
;设8255为C口输入,A口输出
MOV DX,portcon            
MOV AL,10001011B
OUT DX,AL
NEXT:
MOV DX,portc            ;从C口输入一数据
IN AL,DX
MOV DX,porta          ;从A口输出刚才自C口所输入的数据
OUT DX,AL  
            
MOV AH,1
INT 16h 	      ;看ZF，若ZF=1，无按键，若ZF=0，有按键
JE	NEXT		;无按键，程序跳转到标号NEXT处的语句
JNE	EXIT		;有按键，程序跳转到标号EXIT处的语句

EXIT:
            MOV     AH,4CH    
            INT     21H
CODE   ENDS
END START
