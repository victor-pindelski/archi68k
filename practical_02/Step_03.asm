            org     $4

Vector_001  dc.l    Main

            org     $500

Main        move.l  #-32769,d0    ; -32769(10) = FFFF7FFF(16)

Abs         tst.l   d0
            bpl     \quit
            neg.l   d0

\quit       illegal
