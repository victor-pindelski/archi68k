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

                move.l      #String4,a0
                jsr         IsMaxError

                move.l      #String5,a0
                jsr         IsMaxError

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

StrLen          movem.l      a0/d1,-(a7)
                clr.l       d0

\loop           move.b      (a0)+,d1
                beq         \quit

                add.l       #1,d0
                bra         \loop

\quit           movem.l     (a7)+,a0/d1
                rts

IsMaxError      movem.l     a0/d0,-(a7)

                ; comparing the lengths
                jsr         StrLen
                cmp.l       #5,d0
                beq         \equal
                bhi         \greater

\smaller        and.b       #%11111011,ccr
                bra         \quit

\greater        or.b        #%00000100,ccr
                bra         \quit

\equal          cmp.b       #'3',(a0)+
                bhi         \greater
                blo         \smaller

                cmp.b       #'2',(a0)+
                bhi         \greater
                blo         \smaller                

                cmp.b       #'7',(a0)+
                bhi         \greater
                blo         \smaller

                cmp.b       #'6',(a0)+
                bhi         \greater
                blo         \smaller

                cmp.b       #'7',(a0)
                bhi         \greater
                blo         \smaller

                ; if values are really equal
                bra         \smaller

\quit           movem.l     (a7)+,a0/d0
                rts

; ===========================
; Data
; ===========================

String1         dc.b        "24    + 10",0
String2         dc.b        "90+ 46   +   2",0
String3         dc.b        "145b67",0
String4         dc.b        "32766",0
String5         dc.b        "32768",0
