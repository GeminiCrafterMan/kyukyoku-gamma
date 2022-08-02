	move.b	(Super_Sonic_palette).w,d0
	beq.s	return2_2186
	bmi.w	loc2_21E6
	subq.b	#1,d0
	bne.s	loc2_2188
	subq.b	#1,(Palette_frame_count).w
	bpl.s	return2_2186
	move.b	#3,(Palette_frame_count).w
	lea	(RedMetal_Pal).l,a0
	move.w	($FFFFF65C).w,d0
	addq.w	#8,($FFFFF65C).w
	cmpi.w	#$30,($FFFFF65C).w
	bcs.s	redm1
	move.b	#-1,(Super_Sonic_palette).w
	move.b	#0,(MainCharacter+obj_control).w
redm1:
	lea	(Normal_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

return2_2186:
	rts
; ===========================================================================

loc2_2188:
	subq.b	#1,(Palette_frame_count).w
	bpl.s	return2_2186
	move.b	#3,(Palette_frame_count).w
	lea	(RedMetal_Pal).l,a0
	move.w	($FFFFF65C).w,d0
	subq.w	#8,($FFFFF65C).w
	bcc.s	loc2_21B0
	move.b	#0,($FFFFF65C).w
	move.b	#0,(Super_Sonic_palette).w
loc2_21B0:
	lea	(Normal_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	lea	(Pal_22C6).l,a0
	cmpi.b	#$2,(Current_Zone).w
	beq.s	redm2
	cmpi.b	#$F,(Current_Zone).w
	bne.s	return2_2186
	lea	(Pal_2346).l,a0
redm2:
	lea	(Underwater_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	rts
; ===========================================================================

loc2_21E6:
	subq.b	#1,(Palette_frame_count).w
	bpl.s	return2_2186
	move.b	#7,(Palette_frame_count).w
	lea	(RedMetal_Pal).l,a0
	move.w	($FFFFF65C).w,d0
	addq.w	#8,($FFFFF65C).w
	cmpi.w	#$78,($FFFFF65C).w
	bcs.s	redm3
	move.w	#$30,($FFFFF65C).w
redm3:
	lea	(Normal_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	lea	(Pal_22C6).l,a0
	cmpi.b	#$1,(Current_Zone).w
	beq.s	redm4
	cmpi.b	#$F,(Current_Zone).w
	bne.w	return2_2186
	lea	(Pal_2346).l,a0
redm4:
	lea	(Underwater_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	rts