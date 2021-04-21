; =======================
; Vector Initialization
; =======================

            org         $4

Vector_001  dc.l        Main

; =======================
; Main Program
; =======================

            org         $500

Main        movea.l     #String1,a0
            jsr         SpaceCount

            movea.l     #String2,a0
            jsr         SpaceCount

            illegal

; =======================
; Subroutines
; =======================

SpaceCount  movem.l     d1/a0,-(a7)

            clr.l       d0

\loop       move.b      (a0)+,d1
            beq         \quit

            cmp.b       #' ',d1
            bne         \loop

            addq.b      #1,d0
            bra         \loop

\quit       movem.l     (a7)+,d1/a0
            rts

; =======================
; Data
; =======================

String1     dc.b        "This string contains 4 spaces.",0
String2     dc.b        "This one only 3.",0
