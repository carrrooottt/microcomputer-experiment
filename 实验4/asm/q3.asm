DATA SEGMENT
  porta      equ     288H               ;74LS138的/Y1地址:288h
  portb      equ     289H
  portc      equ     28AH
  portcon    equ     28BH
;六个灯可能的状态
; 24h-NS绿灯&EW红灯
; 44h-NS黄灯亮&EW红灯
; 04h-NS黄灯灭&EW红灯
; 81h-NS红灯&EW绿灯
; 82h-NS红灯&EW黄灯亮
; 80h-NS红灯&EW黄灯灭
STATUS  DB   24h  ;南北方向绿灯
  DB         44h,04h,44h,04h,44h,04h    ;南北方向黄灯闪烁三次
  DB         81h                        ;东西方向绿灯
  DB         82h,80h,82h,80h,82h,80h    ;东西方向绿灯闪烁三次
  DB         0ffh                       ;用于检测是否走完一个循环                  
DATA ENDS
CODE SEGMENT
  ASSUME     CS:CODE,DS:DATA 
START:
  MOV        AX,DATA
  MOV        DS,AX
	 ;设置8255为C口输出
  MOV        DX,portcon
  MOV        AL,10000000B
  OUT        DX,AL	      
RE_ON: 
  MOV        BX,0
ON: 
  MOV        AL,STATUS[BX]
  CMP        AL,0FFH                    ;确定状态是否重新开始
  JZ         RE_ON
  OUT        DX,AL                      ;点亮相应的灯
  INC        BX
  MOV        CX,20                      ;参数赋初值
    ;判断是长延时还是短延时，绿灯亮为长延时，否则短延时
  TEST       AL,21H       
  JZ         DEL1                       ;短延时
  MOV        CX,2000                    ;长延时
DEL1: 
  MOV        DI,9000                    ;DI赋初值9000
DEL2: 
  DEC        DI                         ;减1计数
  JNZ        DEL2                       ;DI不为0
  LOOP       DEL1
	
      ;按键检测
  MOV        AH,1 
  INT        16h                        ;看ZF，若ZF=1，无按键，若ZF=0，有按键
  JE         ON                         ;无按键，程序跳转到标号ON处的语句
  JNE        EXIT                       ;有按键，程序跳转到标号EXIT处的语句
	

EXIT: MOV AH,4CH       ;返回
INT 21H
CODE ENDS
  END        START
