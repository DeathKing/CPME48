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

IR48\*在IR48的基础上扩充了几条8086指令，并优化了内存布局。：

```asm
CMP   Ri,Rj    ; EFLAG←Ri-Rj

JNE   X        ; if(EFLAG.ZF≠0); Then PC←[DX//X]
JE    X        ; if(EFLAG.ZF=0); Then PC←[DX//X]
JFR   X        ; PC←PC+X
JBR   X        ; PC←PC-X

INC   Ri       ; Ri←Ri+1
DEC   Ri       ; Ri←Ri-1

RET   Ri       ; EAX←Ri

PUSH  Ri       ; M(ESP)←Ri, ESP←ESP-1
POP   Ri       ; ESP←ESP+1, Ri←M(ESP)

CLF            ; FLAG←00000000
PSHF           ; M(ESP)←FLAG, ESP←ESP-1
POPF           ; ESP←ESP+1, FLAG←M(ESP)

;; 引入IR48*后，IR48的部分指令语义改变
LDA   Ri,X     ; Ri←[EBP - DX//X]
STA   Ri,X     ; [EBP - DX//X]←Ri 

JMP   X        ; PC←[CS + DX//X]
JZ    Ri,X     ; If(Ri=0); Then PC←[CS + DX//X]
```

| 助记符 | 机器码 | 影响标志  | 说明                 |
| :---: | :----: |:-------: | :----------------    |
|  CMP  |  10110 | OF,ZF    |  CMP不回写运算结果至Ri |
|  JNE  |  11100 | OF,ZF    | |
|  JE   |  11010 |          | |
|  JFR  |  11100 |          | 前进相对跳转，JFR 1跳转至下一条指令 |
|  JBR  |  11101 |          | 后退相对跳转, JBR 1跳转至前一条指令 |
|  PUSH |  10001 |          | |
|  POP  |  11110 |          | |
|  PSHF |  11011 |          | |
|  POPF |  10011 | OF,ZF    | |
|  RET  |  11111 |          | |
|  CLF  |  11000 | OF,ZF    | 清除状态位FLAGS       |
|  INC  |  10101 | OF,ZF    |  |
|  DEC  |  10111 | OF,ZF    |  |