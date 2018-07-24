music_addr=$7000
sid_init = $7000
sid_play = $7003
*=music_addr
!bin "source/fallen_down.sid",,$7e

ctr=$4000
clr=$4004

sprite_location=$2000
*=sprite_location
!source "graphics/sprite1.gpx"
!source "graphics/sprites2.asm"

code_addr=$c000
*=code_addr

!source "source/main.asm"
!source "source/rand.asm"
!source "source/sprites.asm"
