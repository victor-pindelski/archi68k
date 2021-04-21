; ===========================
; Vector Initialization
; ===========================

                org         $4

Vector_001      dc.l        Main

; ===========================
; Main Program
; ===========================

                org         $500

Main            move.l      #String1,a0
                jsr         RemoveSpace

                move.l      #String2,a0
                jsr         RemoveSpace2

                move.l      #String3,a0
                jsr         IsCharError

                illegal

; ===========================
; Subroutines
; ===========================

RemoveSpace     movem.l     d0/a0/a1,-(a7)

                move.l      a0,a1

\loop           move.b      (a0)+,d0
                beq         \quit

                cmp.b       #' ',d0
                beq         \loop

                move.b      d0,(a1)+
                bra         \loop

\quit           move.b      #0,(a1)
                movem.l     (a7)+,d0/a0/a1
                rts

; ===========================

RemoveSpace2    movem.l     d0/a0/a1,-(a7)

                move.l      a0,a1

\loop           move.b      (a0)+,d0

                cmp.b       #' ',d0
                beq         \loop

                move.b      d0,(a1)+
                bne         \loop

                movem.l     (a7)+,d0/a0/a1
                rts

; ===========================

IsCharError     movem.l      a0/d0,-(a7)
                
\loop           move.b      (a0)+,d0
                beq         \false

                cmp.b       #'0',d0
                blo         \true

                cmp.b       #'9',d0
                bhi         \true

                bra         \loop         

\true           or.b        #%00000100,ccr
                bra         \quit

\false          and.b       #%11111011,ccr

\quit           movem.l     (a7)+,a0/d0
                rts

; ===========================
; Data
; ===========================

String1         dc.b        "24    + 10",0
String2         dc.b        "90+ 46   +   2",0
String3         dc.b        "145b67",0
