;; Example for recursive function call
;; Author: DeathKing<dk@hit.edu.cn>
;; Date:   7/2014

.IR48*
.MODEL SIMPLE

.DATA

.CODE

RECUR PROC
    AMOV    AX,2
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
RECUR ENDP

    MVI     BX,2
    PUSH    BX
    CALL    RECUR

END