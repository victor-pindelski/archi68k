; ===========================
; Vector Initialization
; ===========================

            org         $4

Vector_001  dc.l        Main

; ===========================
; Main Program
; ===========================

            org         $500

Main        movea.l     #String1,a0
            jsr         LowerCount

            movea.l     #String2,a0
            jsr         LowerCount

            illegal

; ===========================
; Subroutines
; ===========================

LowerCount  clr.l       d0

            movem.l     d1/a0,-(a7)

\loop       move.b      (a0)+,d1
            beq         \quit

            cmp.b       #'a',d1
            blo         \loop

            cmp.b       #'z',d1
            bhi         \loop

            addq.l      #1,d0
            bra         \loop

\quit       movem.l     (a7)+,d1/a0
            rts

; ===========================
; Data
; ===========================

String1     dc.b        "This string contains 29 small letters.",0
String2     dc.b        "This one only 10.",0
