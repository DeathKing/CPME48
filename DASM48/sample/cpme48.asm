; Example for cpme48.asm
; Author: DeathKing<dk@hit.edu.cn>
; Date:   7/2014

.IR48
.MODEL SIMPLE

.DATA

.CODE
start:
    IN      R0,0H
    IN      R1,0H
    ADD     R0,R1
    STA     R0,0H
    IN      R0,0H
    LDA     R1,0H
    SUB     R0,R1
    JZ      R0,goback
    OUT     R1,0
goback:
    JMP     start
    
END