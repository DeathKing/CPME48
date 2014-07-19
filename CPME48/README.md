# CPME48

CPME48是一个简易CPU的VHDL实现，它仅支持少量自定义的RISC指令（IR48）。

## 技术规格

+ CPME48 具有8个8位通用寄存器（从R0到R7），即使R7有时作为地址高字节使用，但对汇编语言的程序员来说，R0到R7都是可存取的。
+ CPME48的指令寄存器（IR）是十六位的。
+ CPME48的数据总线是十六位的，仅在读取IR时处理十六位数据，在读取其它数据时，按照八位总线使用。
+ CPME48的地址总线是十六位的。
+ CPME48的外设端口设置了8个，但在目前的版本中，这八个端口实则同一个端口。

## 配套软件

+ cheme：为CPME48设计的高级语言，Scheme的变种子集，拥有S-表达式的语法，但是语义是基于副作用的。cheme语言提供的`chemec`可以将cheme程序编译为CPME48的汇编指令IR48。
+ dasm: 为CPME48设计的汇编器，能将IR48指令编写的文件汇编为CPME48的机器指令。也能将CPME48的二进制程序反编译。

## 指令集

```asm
ADD   Ri,Rj    ; Ri←Ri+Rj
SUB   Ri,Rj    ; Ri←Ri-Rj
MOV   Ri,Rj    ; Ri←Rj
MVI   Ri,X     ; Ri←X

LDA   Ri,X     ; Ri←[R7//X]
STA   Ri,X     ; [R7//X]←Ri 

JMP   X        ; PC←X
JZ    Ri,X     ; If(Ri=0); Then PC←X

IN    Ri,PORT  ; Ri←[PORT]
OUT   Ri,PORT  ; [PORT]←Ri
```