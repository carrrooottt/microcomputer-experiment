DATA SEGMENT
  porta      equ     288H                                   ;74LS138的/Y1地址:288h
  portb      equ     289H
  portc      equ     28AH
  portcon    equ     28BH
  LED        DB  3fH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH    ;段码
  org        3000h
  BUFFER     DB  0,0                                        ;存放要显示的个位和十位	
DATA  ENDS  

CODE  SEGMENT
  ASSUME     CS:CODE,DS:DATA
START:
  MOV        AX,DATA
  MOV        DS,AX
  MOV        DX,portcon                                     ;设8255A为C口输出,A口输出
  MOV        AL,10000000B
  OUT        DX,AL
	;存储单元初始化，可以改造为键盘输入              
  MOV        BUFFER[1],5
  MOV        BUFFER[0],6    
SHOW:
      ;选择个位数
  MOV        AH,0
  MOV        DX,portc       
  MOV        AL,01H
  OUT        DX,AL
	;找出数字的段码
  MOV        AL,BUFFER[0]
  MOV        SI,AX
  MOV        AL,LED[SI]
  MOV        DX,porta 
  OUT        DX,AL
	;延时
  PUSH       CX
  MOV        CX,1000                 
DELAY1:    
  LOOP       DELAY1                
  POP        CX

 	;找出数字的段码
  MOV        AL,BUFFER[1]
  MOV        SI,AX
  MOV        AL,LED[SI]
  MOV        DX,porta  
  OUT        DX,AL
     ;选择十位数
  MOV        AH,0
  MOV        DX,portc
  MOV        AL,02H
  OUT        DX,AL

      ;延时
  PUSH       CX
  MOV        CX,1000                 
DELAY2:    
  LOOP       DELAY2               
  POP        CX
	
      ;按键检测
  MOV        AH,1 
  INT        16h                                            ;看ZF，若ZF=1，无按键，若ZF=0，有按键
  JE         SHOW                                           ;无按键，程序跳转到标号SHOW处的语句
  JNE        EXIT                                           ;有按键，程序跳转到标号EXIT处的语句
	
EXIT:
  MOV        DX,portc                                       ;关闭显示
  MOV        AL,00H
  OUT        DX,AL      
	
  MOV        AH,4CH                                         ;否则返回
  INT        21H
CODE ENDS
  END        START
