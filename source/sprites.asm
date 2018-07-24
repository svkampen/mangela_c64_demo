sprite_inc_x_0:
    lda #1
    bit $d010
    bne six0_over_255   ; If we're over 255, handle seperately
    lda $d000
    beq six0_flip_and_zero ; We're at 256, so we should turn on bit 9
    inc $d000
    rts

six0_over_255:
    lda $d000   ; If we're 85, we should wrap to the beginning
    cmp #85     
    beq six0_flip_and_zero
    inc $d000   ; Otherwise, just increment.
    rts

six0_flip_and_zero:
    jsr six0_flip_bit9
    lda #1
    sta $d000
    rts

six0_flip_bit9:
    lda $d010
    eor #$01
    sta $d010
    rts

sprite_dec_x_1:
    lda #2
    bit $d010
    bne sdx1_over_255   ; If we're over 255, handle seperately
    lda $d002
    beq sdx1_flip_and_zero ; We're at 256, so we should turn on bit 9
    dec $d002
    rts

sdx1_over_255:
    lda $d002   ; If we're 85, we should wrap to the beginning
    beq sdx1_flip_and_255
    dec $d002   ; Otherwise, just decrement.
    rts

sdx1_flip_and_255:
    jsr sdx1_flip_bit9
    lda #$ff
    sta $d002
    rts

sdx1_flip_and_zero:
    jsr sdx1_flip_bit9
    lda #85
    sta $d002
    rts

sdx1_flip_bit9:
    lda $d010
    eor #$02
    sta $d010
    rts

sprite_frame:
    !for i,0,2 {
        jsr sprite_inc_x_0
        jsr sprite_dec_x_1
    }

    lda #1 
    bit $dc01 ; read from joystick port
    beq move_wheel_up
    lda #2
    bit $dc01
    beq move_wheel_down
    lda #4
    bit $dc01
    beq move_wheel_left
    lda #8
    bit $dc01
    beq move_wheel_right
    rts

move_wheel_up:
    dec $d009
    dec $d009
    dec $d00f
    dec $d00f
    rts

move_wheel_down:
    inc $d009
    inc $d009
    inc $d00f
    inc $d00f
    rts

move_wheel_left:
    dec $d008
    dec $d008
    dec $d00e
    dec $d00e
    rts

move_wheel_right:
    inc $d008
    inc $d008
    inc $d00e
    inc $d00e
    rts

sprite_init:
    ldx #$80        ; We're saving sprites at 0x1000
    stx $07f8
    inx
    stx $07f9
    inx
    stx $07fa
    inx
    stx $07fb
    inx
    stx $07fc
    inx
    stx $07fd
    inx
    stx $07fe
    inx
    stx $07ff

    lda #%11111111      ; We're enabling all
    sta $d015

    lda #%00100111  ; all except 4,5 and 7,8 are multicolor
    sta $d01c       

    lda #%11110000  ; sprite 5,6,7,8 is larger
    sta $d01d
    sta $d017

    lda #%00001100
    sta $d010

    lda #$00
    sta $d025       ; Set multicolor 1 to black

    lda #15         ; Set multicolor 2 to grey
    sta $d026

    ldx #150
    stx $d000       ;1X: 150

    lda #60
    sta $d001       ;1Y: 60

    stx $d002       ;2X: 150
    lda #80
    sta $d003       ;2Y: 80

    ldx #1
    lda #230
    stx $d004       ;3X: 150
    sta $d005       ;3Y: 200

    ldx #30
    lda #230
    stx $d006       ; 4: 180 by 200
    sta $d007

    ldx #20
    lda #200
    stx $d008
    sta $d009
    stx $d00e
    sta $d00f

    ldx #130
    lda #200
    stx $d00a       ; 6: 230 by 100
    sta $d00b

    ldx #180
    lda #200
    stx $d00c
    sta $d00d

    lda #1
    sta $d027       ; Sprite 1 has white as individual color

    lda #2
    sta $d028       ; sprite 2 has brown as individual color

    lda #4         ; Sprite 3 has violet as an individual color
    sta $d029

    lda #7          ; 4: yellow
    sta $d02a

    lda #7
    sta $d02b       ; 5: yellow dots

    lda #13
    sta $d02c       ; 6: green 

    lda #3
    sta $d02d       ; 7: cyan

    lda #10
    sta $d02e       ; lblue hat

    rts
