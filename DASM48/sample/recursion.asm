;; Example for recursive function call
;; Author: DeathKing<dk@hit.edu.cn>
;; Date:   7/2014

.IR48*
.MODEL SIMPLE

.DATA

.CODE

    MVI     BX,1
    PUSH    BX
    CALL    RECUR
    DEC     SP
    JMP     Over

RECUR:
    PUSH    BP
    MOV     BP,SP
    MVI     AX,22H
    AMOV    AX,1
    MVI     BX,0
    CMP     AX,BX
    JE      Finish
    DEC     AX
    PUSH    AX
    CALL    RECUR
    DEC     SP
Finish:
    MOV     SP,BP
    POP     BP
    RET
Over:
    NOP

.END