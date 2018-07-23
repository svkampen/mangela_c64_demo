; color data table
; first 9 rows (40 bytes) are used for the color washer
; on start the gradient is done by byte 40 is mirroed in byte 1, byte 39 in byte 2 etc... 

color   !byte $0a,$0a,$08,$08,$07
        !byte $07,$07,$0d,$0d,$0d
        !byte $05,$05,$05,$0e,$0e
        !byte $06,$06,$03,$03,$03
        !byte $04,$04,$04,$03,$03
        !byte $03,$06,$06,$0e,$0e
        !byte $05,$05,$05,$0d,$0d
        !byte $0d,$07,$07,$07,$08

color2  !byte $0a,$0a,$08,$08,$07
        !byte $07,$07,$0d,$0d,$0d
        !byte $05,$05,$05,$0e,$0e
        !byte $06,$06,$03,$03,$03
        !byte $04,$04,$04,$03,$03
        !byte $03,$06,$06,$0e,$0e
        !byte $05,$05,$05,$0d,$0d
        !byte $0d,$07,$07,$07,$08
