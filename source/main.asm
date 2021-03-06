main:
    lda #5
    sta ctr

    jsr init_intr
    jsr init_screen
    jsr init_text
    jsr sid_init
    jsr sprite_init
    jmp *

init_intr: ; set up the raster interrupt to fire at rasterline 0
    sei
    ldy #$7f
    sty $dc0d
    sty $dd0d
    lda $dc0d
    lda $dd0d

    lda #$01
    sta $d01a

    lda #<irq
    ldx #>irq

    sta $314
    stx $315

    lda #$00
    sta $d012

    lda $d011
    and #$7f
    sta $d011

    cli

    rts

init_screen:
    ldx #$00    ; set X to black
    stx $d021   ; set background color
    stx $d020   ; set border color
clear:
    lda #$20    ; Spacebar
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $06e8,x
    lda #$00
    sta $d800,x
    sta $d900,x
    sta $da00,x
    sta $dae8,x
    inx

    bne clear

    rts

init_text:
    ldx #$00
loop_text:
    lda line,x
    sta $0540,x

    lda line2,x
    sta $0590,x

    lda line3,x
    sta $05e0,x

    lda line4,x
    sta $0630,x

    inx
    cpx #$28
    bne loop_text
    rts

irq:
    lda #<irq2
    sta $314
    lda #>irq2
    sta $315
    lda #200
    sta $d012

    ldx #0
    stx $d021
    stx $d020

    asl $d019

    dec ctr
    bne irq_end

    lda #5
    sta ctr
    jsr colwash
    jsr sprite_frame

;    inc clr
;    ldx clr
;    cpx #13
;    bne irq_end
;
;    ldx #0
;    stx clr

irq_end:
    jmp irq_common_end

irq2:
    ldx clr

wait_line:
    lda $d012
    cmp $d012
    beq wait_line

    stx $d020
    stx $d021

irq2_end:
    lda #<irq
    sta $314
    lda #>irq
    sta $315
    lda #0
    sta $d012

    asl $d019
    jmp $ea81


irq_common_end: ; plays music, then ends interrupt handler
    jsr sid_play
    jmp $ea81


!source "source/data_colorwash.asm"
!source "source/sub_colorwash.asm"

line:    !scr "    marnix en angola zijn plopkoeken    "
line2:   !scr "       jurriaan is een toffe peer       "
line3:   !scr "   't is hun verjaardag die we vieren   "
line4:   !scr "       wanneer was die ook alweer?      "
