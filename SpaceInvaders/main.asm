; ================================
; Definition of constants
; ================================

VIDEO_START         equ         $ffb500
VIDEO_WIDTH         equ         480
VIDEO_HEIGHT        equ         320
VIDEO_SIZE          equ         (VIDEO_WIDTH*VIDEO_HEIGHT/8)
BYTE_PER_LINE       equ         (VIDEO_WIDTH/8)

; ================================
; Vector initialization
; ================================

                    org         $0

vector_000          dc.l        VIDEO_START
vector_001          dc.l        Main

; ================================
; Vector initialization
; ================================

                    org         $500

Main


                    illegal

; ================================
; Subroutines
; ================================

FillScreen          move.l      a0,-(a7)

                    move.l      #VIDEO_START,a0

\loop               cmp.l       (a0)+,$ffffff
                    beq         \quit

                    move.l      d0,(a0)

                    bra         \loop

\quit
                    move.l      (a7)+,a0
                    rts

; ================================
; Data
; ================================
