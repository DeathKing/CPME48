# IR48与IR48\*

## IR48

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

## IR48\*

IR48\*在IR48的基础上扩充了几条8086指令：

```asm
CMP   Ri,Rj    ; EFLAG←Ri-Rj
JNE   X        ; if(EFLAG.ZF≠0); Then PC←X 
JE    X        ; if(EFLAG.ZF=0); Then PC←X 
INC   Ri       ; Ri←Ri+1
DEC   Ri       ; Ri←Ri-1
```