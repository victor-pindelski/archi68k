; ===========================
; Vector Initialization
; ===========================

            org     $4

Vector_001  dc.l    Main

; ===========================
; Main Program
; ===========================

            org     $500

Main        move.l  #String1,a0
            jsr     AlphaCount

            move.l  #String2,a0
            jsr     AlphaCount

            illegal

; ===========================
; Subroutines
; ===========================

LowerCount  clr.l   d0

            movem.l d1/a0,-(a7)

\loop       move.b  (a0)+,d1

            cmp.b   #0,d1
            beq     \quit

            cmp.b   #'a',d1
            blo     \loop

            cmp.b   #'z',d1
            bhi     \loop

            add.l   #1,d0
            bra     \loop

\quit       movem.l (a7)+,d1/a0
            rts

; =================================

UpperCount  clr.l   d0

            movem.l d1/a0,-(a7)

\loop       move.b  (a0)+,d1

            cmp.b   #0,d1
            beq     \quit

            cmp.b   #'A',d1
            blo     \loop

            cmp.b   #'Z',d1
            bhi     \loop

            add.l   #1,d0
            bra     \loop

\quit       movem.l (a7)+,d1/a0
            rts

; =================================

DigitCount  clr.l   d0
            movem.l d1/a0,-(a7)

\loop       move.b  (a0)+,d1
            cmp.b   #0,d1
            beq     \quit

            cmp.b   #'0',d1
            blo     \loop

            cmp.b   #'9',d1
            bhi     \loop

            add.l   #1,d0
            bra     \loop

\quit       movem.l (a7)+,d1/a0
            rts

; =================================

AlphaCount  clr.l   d0
            move.l  d1,-(a7)

            jsr     LowerCount
            move.l  d0,d1

            jsr     UpperCount
            add.l   d0,d1

            jsr     DigitCount
            add.l   d0,d1

            move.l  d1,d0
            move.l  (a7)+,d1
            rts

; ===========================
; Data
; ===========================

String1     dc.b        "This string contains 42 alphanumeric characters.",0
String2     dc.b        "This one only 13.",0
