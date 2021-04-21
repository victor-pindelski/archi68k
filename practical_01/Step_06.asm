            org     $4

Vector_001  dc.l    Main

            org     $500

Main        add.l   d4,d0       ; d4 + d0 -> d0     and c0 -> X
            addx.l  d5,d1       ; d5 + d1 + X -> d1 and c1 -> X
            addx.l  d6,d2       ; ...
            addx.l  d7,d3
