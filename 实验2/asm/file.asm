;sample 顺序结构 查0~9平方表
        DATA   SEGMENT		;数据段定义
        TABLE 	DB 	0,1,4,9,16,25,36,49,64,81	;平方表定义
        XX     	DB 	5
        YY     DB 	?						;存放查表结果
        DATA   ENDS
        
        STACK  SEGMENT PARA STACK 'STACK'	;堆栈段定义
               DB 100 DUP (?)
        STACK  ENDS
        
        CODE   SEGMENT		;代码段定义
               ASSUME CS:CODE,DS:DATA
        START: MOV AX,DATA
               MOV DS,AX 		;装载段地址
               MOV AL,XX
               MOV BX,OFFSET TABLE
               XLAT
              MOV YY,AL
               MOV AH,4CH
               INT 21H         	;结束程序并返回dos
CODE   ENDS
                 END START

