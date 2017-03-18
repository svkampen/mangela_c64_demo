textMode:
	lda #%11001000
	sta $d016

	lda #%00011011
	sta $d011
	rts

graphicsMode:
	lda #%11011000
	sta $d016

	lda #%00111011
	sta $d011
	rts