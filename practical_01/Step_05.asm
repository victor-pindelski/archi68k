            org     $4

Vector_001  dc.l    Main

            org     $500

Main        move.b  #$b4,d0
            add.b   #$4c,d0

            move.w  #$b4,d1
            add.w   #$4c,d1

            move.w  #$4ac9,d2
            add.w   #$d841,d2

            move.l  #$FFFFFFFF,d3
            add.l   #$00000015,d3

            illegal
