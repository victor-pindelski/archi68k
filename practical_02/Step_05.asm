            org     $4

Vector_001  dc.l    Main

            org     $500

Main        movea.l #STRING,a0

SpaceCount  clr.l   d0

\loop       cmpi.b  #0,(a0)         ; Compare to 0 but do not increment yet.
            beq     \quit

            cmpi.b  #' ',(a0)+
            bne     \loop

            addq.l  #1,d0
            bra     \loop

\quit       illegal

            org     $550

STRING      dc.b    "This string contains 4 spaces.",0
