SCNKEY=$FF9F
GETIN =$FFE4

move_se:
    !for i, 4 {
        inc $d000,x
        inc $d001,x
    }
    rts

move_s:
    !for i, 4 {
        inc $d000,x
    }
    rts

move_sw:
    !for i, 4 {
        inc $d000,x
        dec $d001,x
    }
    rts

sprite_frame:
    jsr sprite_frame_i
    jsr sprite_frame_i
    rts

sprite_frame_i:
    ldx #0
    jsr sprite_frame_x
    ldx #2
    jsr sprite_frame_x
    rts

sprite_frame_x:
    jsr rand_in_a
    cmp #32
    bcc move_n
    cmp #64
    bcc move_ne
    cmp #96
    bcc move_se
    cmp #128
    bcc move_s
    cmp #160
    bcc move_e
    cmp #192
    bcc move_sw
    cmp #224
    bcc move_w
    jmp move_nw
    rts

move_n:
    !for i, 4 {
        dec $d000,x
    }
    rts

move_ne:
    !for i, 4 {
        dec $d000,x
        inc $d001,x
    }
    rts

move_w:
    !for i, 4 {
        dec $d001,x
    }
    rts

move_nw:
    !for i, 4 {
        dec $d000,x
        dec $d001,x
    }
    rts

move_e:
    !for i, 4 {
        inc $d001,x
    }
    rts


sprite_init:
    ldx #$80        ; We're saving sprites at 0x1000
    stx $07f8
    inx
    stx $07f9

    lda #3          ; We're only enabling sprites 1 and 2
    sta $d015
    sta $d01c       ; both are in multicolor mode

    lda #$40        ; We're setting the sprite's X and Y to 128
    sta $d000
    sta $d001
    sta $d003
    lda #$20

    sta $d002       ; 0,0 for sprite 2
    sta $d003

    lda #$00
    sta $d025       ; Set multicolor 1 to black

    lda #15         ; Set multicolor 2 to grey
    sta $d026

    lda #1
    sta $d027       ; Sprite 1 has white as individual color

    lda #2
    sta $d028       ; sprite 2 has brown as individual color

    rts
