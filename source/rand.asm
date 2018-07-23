seed:
    !byte 123

rand_in_a:
           lda seed
           beq doEor
           clc
           asl
           beq noEor    ;if the input was $80, skip the EOR
           bcc noEor
doEor      eor #$1d
noEor      sta seed
           rts
