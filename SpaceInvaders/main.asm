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

Main                move.l      #$ffffffff,d0
                    jsr         FillScreen

                    move.l      #$f0f0f0f0,d0
                    jsr         FillScreen

                    move.l      #$fff0fff0,d0
                    jsr         FillScreen

                    moveq.l     #$0,d0
                    jsr         FillScreen

                    jsr         HLines

                    illegal

; ================================
; Subroutines
; ================================

FillScreen          movem.l     a0/d7,-(a7)

                    ; load start adress in a0
                    movea.l     #VIDEO_START,a0

                    ; set the counter (-1 for dbra doing n+1)
                    move.w      #VIDEO_SIZE/4-1,d7

\loop
                    ; fill (a0) with d0's content
                    move.l      d0,(a0)+
                    dbra        d7,\loop

                    movem.l     (a7)+,a0/d7
                    rts

HLines              movem.l     a0/d6/d7,-(a7)

                    ; load the address in a0
                    movea.l     #VIDEO_START,a0

                    ; loop through the whole height
                    move.l      #VIDEO_HEIGHT/16-1,d7

\loop
                    ; loop through the white stripe
                    move.l      #BYTE_PER_LINE*8/4-1,d6
\whiteloop          move.l      #$ffffffff,(a0)+
                    dbra        d6,\whiteloop

                    ; loop through the black stripe
                    move.l      #BYTE_PER_LINE*8/4-1,d6
\blackloop          move.l      #$00000000,(a0)+
                    dbra        d6,\blackloop

                    dbra        d7,\loop

                    movem.l     (a7)+,a0/d6/d7
                    rts

; ================================
; Data
; ================================
