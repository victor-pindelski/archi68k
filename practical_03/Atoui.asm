; ==========================
; Vector Initialization
; ==========================

            org         $4

vector_001  dc.l        Main

; ==========================
; Main Program
; ==========================

            org         $500

Main        move.l      #String1,a0
            jsr         Atoui

            move.l      #String2,a0
            jsr         Atoui

            move.l      #String3,a0
            jsr         Atoui

            illegal

; ==========================
; Subroutines
; ==========================

Atoui       clr.l       d0
            movem.l     d1/a0,-(a7)

\loop       move.b      (a0)+,d1
            beq         \quit

            sub.b       #'0',d1
            mulu.w      #10,d0
            add.l       d1,d0

            bra         \loop

\quit       movem.l     (a7)+,d1/a0
            rts

; ==========================
; Data
; ==========================

String1     dc.b        "52146",0
String2     dc.b        "209",0
String3     dc.b        "2570",0
