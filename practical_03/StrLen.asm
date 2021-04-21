; ==============================
; Vector Initialization
; ==============================

            org         $4

Vector_011  dc.l        Main

; ==============================
; Main Program
; ==============================

            org         $500

Main        movea.l     #String1,a0
            jsr         StrLen

            movea.l     #String2,a0
            jsr         StrLen

            illegal

; ==============================
; Subroutines
; ==============================

StrLen      move.l      a0,-(a7)

            clr.l       d0

\loop       tst.b       (a0)+
            beq         \quit

            addq.l      #1,d0
            bra         \loop

\quit       movea.l     (a7)+,a0
            rts

; ==============================
; Data
; ==============================

String1     dc.b        "This string is made up of 40 characters.",0
String2     dc.b        "This one is made up of 26.",0
