# IR48与IR48\*

## IR48

```asm
NOP            ; Do nothing

ADD   Ri,Rj    ; Ri←Ri+Rj
SUB   Ri,Rj    ; Ri←Ri-Rj
MOV   Ri,Rj    ; Ri←Rj
MVI   Ri,X     ; Ri←X

LDA   Ri,X     ; Ri←[R7//X]
STA   Ri,X     ; [R7//X]←Ri 

JMP   X        ; PC←[R7//X]
JZ    Ri,X     ; If(Ri=0); Then PC←[R7//X]

IN    Ri,PORT  ; Ri←[PORT]
OUT   Ri,PORT  ; [PORT]←Ri
```

> **说明**  
> 影响标志是在IR48\*中引入的特性。

| 助记符 | 机器码 | 影响标志    | 说明                 |
| :---: | :----: |:-------: | :----------------    |
|  NOP  |  00000 |          | CPU空跳 |
|  ADD  |  00110 | OF,ZF    | |
|  SUB  |  00100 | OF,ZF    | |
|  MOV  |  01010 |          | |
|  MVI  |  01000 |          | |
|  STA  |  01100 |          | |
|  LDA  |  01110 |          | |
|  OUT  |  10000 |          | |
|  IN   |  10010 |          | |

## IR48\*

IR48\*在IR48的基础上扩充了几条8086指令，并优化了内存布局。IR48\*指令主要分布在0x1XXXX区域（详见[指令分布表](#指令分布表)，IR48\*指令的语义如下：

```asm
CMP   Ri,Rj    ; FLAG←Ri-Rj

JNE   X        ; if(FLAG.ZF≠1); Then PC←CS+[00H//X]
JE    X        ; if(FLAG.ZF=1); Then PC←CS+[00H//X]
JFR   X        ; PC←PC+[00H//X]
JBR   X        ; PC←PC-[00H//X]

INC   Ri       ; Ri←Ri+1
DEC   Ri       ; Ri←Ri-1

CALL  X        ; M(SP)←PC+1 then PC←CS+[00H//X]
RET   Ri       ; PC←M(SP) then SP←SP-1

PUSH  Ri       ; SP←SP+1 then M(SP)←Ri
POP   Ri       ; Ri←M(SP) then SP←SP-1

;; 通常用于在函数调用时取得参数
AMOV  Ri, X    ; Ri←M(BP+X)

;; 特殊寄存器压栈，Rs的取值范围为{PC, FLAG}
SPSH  Rs       ; SP←SP+1 then M(SP)←Rs
SPOP  Rs       ; Rs←M(SP) then SP←SP-1

;; 引入IR48*后，IR48的部分指令语义改变
;; LDA和STA在IR48*语义下只能操作运行时栈（局部变量空间）
LDA   Ri,X     ; Ri←[BP-00H//X]
STA   Ri,X     ; [BP-00H//X]←Ri 

JMP   X        ; PC←[CS+00H//X]
JZ    Ri,X     ; If(Ri=0); Then PC←[CS+00H//X]
```

| 助记符 | 机器码 | 影响标志  | 说明                                        |
| :---: | :----: |:-------: | :------------------------------------------ |
|  AMOV |  10001 |          | 通常用于获得参数，`AMOV R0,2` 将第一个参数送R0 |
|  CMP  |  10110 | OF,ZF    |  CMP不回写运算结果至Ri                       |
|  JNE  |  11100 | OF,ZF    |                                             |
|  JE   |  11010 |          |                                             |
|  JFR  |  10100 |          | 前进相对跳转，`JFR 1`跳转至下一条指令          |
|  JBR  |  11101 |          | 后退相对跳转, `JBR 1`跳转至前一条指令          |
|  PUSH |  11001 |          |                                             |
|  POP  |  11110 |          |                                             |
|  SPSH |  11011 |          |                                             |
|  SPOP |  10011 |          |                                             |
|  CALL |  11000 |          |                                             |
|  RET  |  11111 |          |                                             |
|  INC  |  10101 | OF,ZF    |                                             |
|  DEC  |  10111 | OF,ZF    |                                             |

## 指令分布表

由于CPME48的操作码仅占5位，故至多可有2^5=32条指令，下图描述了IR48与IR48*的所有指令分布：

|       | 00000 | 00001 | 00010 | 00011 | 00100 | 00101 | 00110 | 00111 |
|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| 00000 |  NOP  |       |       |       |  SUB  |       |  ADD  |       |
| 01000 |  MVI  |       |  MOV  |       |  STA  |       |  LDA  |       |
| 10000 |  OUT  |  AMOV |   IN  |  SPOP |  JFR  |  INC  |  CMP  |  DEC  |
| 11000 |  CALL |  PUSH |   JE  |  SPSH |  JNE  |  JBR  |  POP  |  RET  |