; ---------------------------------------------------------------------------
; Animation script - Sonic
; ---------------------------------------------------------------------------
Ani_Sonic:

ptr_Walk:	dc.w SonAni_Walk-Ani_Sonic ;0
ptr_Run:	dc.w SonAni_Run-Ani_Sonic ;1
ptr_Roll:	dc.w SonAni_Roll-Ani_Sonic ;2
ptr_Roll2:	dc.w SonAni_Roll2-Ani_Sonic ;3
ptr_Push:	dc.w SonAni_Push-Ani_Sonic ;4
ptr_Wait:	dc.w SonAni_Wait-Ani_Sonic ;5
ptr_Balance:	dc.w SonAni_Balance-Ani_Sonic ;6
ptr_LookUp:	dc.w SonAni_LookUp-Ani_Sonic ;7
ptr_Duck:	dc.w SonAni_Duck-Ani_Sonic ;8
ptr_Spindash:	dc.w SonAni_Spindash-Ani_Sonic ;9
ptr_Blink:	dc.w SonAni_Blink-Ani_Sonic ;a 
ptr_GetUp:	dc.w SonAni_GetUp-Ani_Sonic ;b
ptr_Balance2:	dc.w SonAni_Balance2-Ani_Sonic ;c
ptr_Stop:	dc.w SonAni_Stop-Ani_Sonic ;d
ptr_Float:	dc.w SonAni_Float-Ani_Sonic ;e
ptr_Float2:	dc.w SonAni_Float2-Ani_Sonic ;f
ptr_Spring:	dc.w SonAni_Spring-Ani_Sonic ;10
ptr_Hang:	dc.w SonAni_Hang-Ani_Sonic ;11
ptr_Dash2:	dc.w SonAni_Dash2-Ani_Sonic ;12
ptr_Dash3:	dc.w SonAni_Dash3-Ani_Sonic ;13
ptr_Hang2:	dc.w SonAni_Hang2-Ani_Sonic ;14
ptr_Bubble:	dc.w SonAni_Bubble-Ani_Sonic ;15
ptr_DeathBW:	dc.w SonAni_DeathBW-Ani_Sonic ;16
ptr_Drown:	dc.w SonAni_Drown-Ani_Sonic ;17
ptr_Death:	dc.w SonAni_Death-Ani_Sonic ;18
ptr_Hurt:	dc.w SonAni_Hurt-Ani_Sonic ;19
ptr_Hurt2:	dc.w SonAni_Hurt2-Ani_Sonic ;1A
ptr_Slide:	dc.w SonAni_Slide-Ani_Sonic ;1B
ptr_Blank:	dc.w SonAni_Blank-Ani_Sonic ;1C
ptr_Balance3:	dc.w SonAni_Balance3-Ani_Sonic ;1D
ptr_Balance4:	dc.w SonAni_Balance4-Ani_Sonic ;1E
ptr_Lying:	dc.w SonAni_Lying-Ani_Sonic ;1F
ptr_LieDown:	dc.w SonAni_LieDown-Ani_Sonic ;20
ptr_DropDash:	dc.w SonAni_DropDash-Ani_Sonic ;21

SonAni_Walk:	dc.b $FF, $F,$10,$11,$12,$13,$14, $D, $E,$FF
	even
SonAni_Run:	dc.b $FF,$2D,$2E,$2F,$30,$FF,$FF,$FF,$FF,$FF
	even
SonAni_Roll:	dc.b $FE,$3D,$41,$3E,$41,$3F,$41,$40,$41,$FF
	even
SonAni_Roll2:	dc.b $FE,$3D,$41,$3E,$41,$3F,$41,$40,$41,$FF
	even
SonAni_Push:	dc.b $FD,$48,$49,$4A,$4B,$FF,$FF,$FF,$FF,$FF
	even
SonAni_Wait:
	dc.b   5,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	dc.b   1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2
	dc.b   3,  3,  3,  3,  3,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5
	dc.b   5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  6,  6,  6
	dc.b   6,  6,  6,  6,  6,  6,  6,  4,  4,  4,  5,  5,  5,  4,  4,  4
	dc.b   5,  5,  5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  6
	dc.b   6,  6,  6,  6,  6,  6,  6,  6,  6,  4,  4,  4,  5,  5,  5,  4
	dc.b   4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5
	dc.b   5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  6,  4,  4,  4,  5,  5
	dc.b   5,  4,  4,  4,  5,  5,  5,  4,  4,  4,  5,  5,  5,  4,  4,  4
	dc.b   5,  5,  5,  6,  6,  6,  6,  6,  6,  6,  6,  6,  6,  7,  8,  8
	dc.b   8,  9,  9,  9,$FE,  6
	even
SonAni_Balance:	dc.b   9,$CC,$CD,$CE,$CD,$FF
	even
SonAni_LookUp:	dc.b   5, $B, $C,$FE,  1
	even
SonAni_Duck:	dc.b   5,$4C,$4D,$FE,  1
	even
SonAni_Spindash:dc.b   0,$42,$43,$42,$44,$42,$45,$42,$46,$42,$47,$FF
	even
SonAni_Blink:	dc.b   1,  2,$FD,  0
	even
SonAni_GetUp:	dc.b   3, $A,$FD,  0
	even
SonAni_Balance2:dc.b   3,$C8,$C9,$CA,$CB,$FF
	even
SonAni_Stop:	dc.b   5,$D2,$D3,$D4,$D5,$FF ; halt/skidding animation
	even
SonAni_Float:	dc.b   7,$54,$59,$FF
	even
SonAni_Float2:	dc.b   7,$54,$55,$56,$57,$58,$FF
	even
SonAni_Spring:	dc.b $2F,$5B,$FD,  0
	even
SonAni_Hang:	dc.b   1,$50,$51,$FF
	even
SonAni_Dash2:	dc.b  $F,$43,$43,$43,$FE,  1
	even
SonAni_Dash3:	dc.b  $F,$43,$44,$FE,  1
	even
SonAni_Hang2:	dc.b $13,$6B,$6C,$FF
	even
SonAni_Bubble:	dc.b  $B,$5A,$5A,$11,$12,$FD,  0 ; breathe
	even
SonAni_DeathBW:	dc.b $20,$5E,$FF
	even
SonAni_Drown:	dc.b $20,$5D,$FF
	even
SonAni_Death:	dc.b $20,$5C,$FF
	even
SonAni_Hurt:	dc.b $40,$4E,$FF
	even
SonAni_Hurt2:	dc.b $40,$4E,$FF
	even
SonAni_Slide:	dc.b   9,$4E,$4F,$FF
	even
SonAni_Blank:	dc.b $77,  0,$FD,  0
	even
SonAni_Balance3:dc.b $13,$D0,$D1,$FF
	even
SonAni_Balance4:dc.b   3,$CF,$C8,$C9,$CA,$CB,$FE,  4
	even
SonAni_Lying:	dc.b   9,  8,  9,$FF
	even
SonAni_LieDown:	dc.b   3,  7,$FD,  0
	even
SonAni_DropDash: dc.b 0, $41, $D6, $41, $D7, $41, $D8, $41, $D9, $41, $DA, $41, $DB, $FF
	even