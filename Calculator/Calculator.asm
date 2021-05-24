; ===========================
; Vector Initialization
; ===========================

                org         $0

vector_000      dc.l        $ffb500
vector_001      dc.l        Main

; ===========================
; Main Program
; ===========================

                org         $500

Main            ;move.l      #String1,a0
                ;jsr         RemoveSpace

                ;move.l      #String2,a0
                ;jsr         RemoveSpace2

                ;move.l      #String3,a0
                ;jsr         IsCharError

                ;move.l      #String4,a0
                ;jsr         IsMaxError

                ;move.l      #String5,a0
                ;jsr         IsMaxError

                ;move.l      #String4,a0
                ;jsr         Convert

                ;move.l      #String5,a0
                ;jsr         Convert

                ;lea         sTest,a0
                ;move.b      #24,d1
                ;move.b      #20,d2
                ;jsr         Print

                ;move.l      #String1,a0
                ;jsr         NextOp2

                ;move.l      #String6,a0
                ;jsr         GetNum

                move.l      #String6,a0
                jsr         GetExpr

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

Atoui           movem.l     a0/d1,-(a7)
                clr.l       d0
                clr.l       d1

\loop           move.b      (a0)+,d1
                beq         \quit

                sub.b       #'0',d1
                mulu.w      #10,d0
                add.l       d1,d0

                bra         \loop

\quit           movem.l     (a7)+,a0/d1
                rts

Convert         ; empty string
                tst.b       (a0)
                beq         \false

                ; sets Z=1 when error
                ; beq branches if Z=1
                jsr         IsCharError
                beq         \false

                jsr         IsMaxError
                beq         \false

                jsr         Atoui

\true           or.b        #%00000100,ccr
                rts

\false          and.b       #%11111011,ccr
                rts

; ===========================

Print           movem.l     d0/d1/d2/a0,-(a7)

\loop           move.b      (a0)+,d0
                beq         \quit

                jsr         PrintChar
                add.b       #1,d1

                bra         \loop

\quit           movem.l     (a7)+,d0/d1/d2/a0
                rts

PrintChar       incbin      "PrintChar.bin"

; ===========================

NextOp          move.l     d0,-(a7)

\loop           move.b      (a0)+,d0
                beq         \quit

                cmp.b       #'+',d0
                beq         \quit

                cmp.b       #'-',d0
                beq         \quit

                cmp.b       #'/',d0
                beq         \quit

                cmp.b       #'*',d0
                beq         \quit

                bra         \loop

\notFound       move.l     (a7)+,d0
                rts

\quit           suba.w      #$1,a0
                move.l     (a7)+,d0
                rts

NextOp2         tst.b       (a0)
                beq         \quit

                cmp.b       #'+',(a0)
                beq         \quit

                cmp.b       #'-',(a0)
                beq         \quit

                cmp.b       #'/',(a0)
                beq         \quit

                cmp.b       #'*',(a0)
                beq         \quit

                addq.l      #1,a0
                bra         NextOp2

\quit           rts

; ===========================

GetNum          movem.l     d1/a1/a2,-(a7)

                move.l      a0,a1

                jsr         NextOp2
                move.l      a0,a2
                move.b      (a2),d1
                move.b      #0,(a2)

                move.l      a1,a0
                jsr         Convert
                beq         \true
 
\false          move.b      d1,(a2)
                and.b       #%11111011,ccr
                bra         \quit

\true           move.b      d1,(a2)
                move.l      a2,a0
                or.b        #%00000100,ccr

\quit           movem.l     (a7)+,d1/a1/a2
                rts

; ===========================

GetExpr         movem.l     d1/d2/a0,-(a7)

                jsr         GetNum
                bne         \false

                move.l      d0,d1

\loop           move.b      (a0)+,d2
                beq         \true

                jsr         GetNum
                bne         \false

\add            cmp.b       #'+',d2
                bne         \substract

                add.l       d0,d1
                bra         \loop

\substract      cmp.b       #'-',d2
                bne         \multiply

                sub.l       d0,d1
                bra         \loop

\multiply       cmp.b       #'*',d2
                bne         \divide

                muls.w      d0,d1
                bra         \loop

\divide         tst.b       d0
                beq         \false

                divs.w      d0,d1
                ext.l       d1
                bra         \loop

\false          and.b       #%11111011,ccr
                bra         \quit

\true           move.l      d1,d0
                or.b        #%00000100,ccr

\quit           movem.l     (a7)+,d1/d2/a0
                rts

; ===========================
; Data
; ===========================

String1         dc.b        "24    + 10",0
String2         dc.b        "90+ 46   +   2",0
String3         dc.b        "145b67",0
String4         dc.b        "32766",0
String5         dc.b        "32768",0
String6         dc.b        "1256+9876-5000",0

sTest           dc.b        "Hello World",0
