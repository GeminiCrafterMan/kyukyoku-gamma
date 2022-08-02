	move.b	(Super_Sonic_palette).w,d0
	beq.s	return_2186
	bmi.w	loc_21E6
	subq.b	#1,d0
	bne.s	loc_2188
	subq.b	#1,(Palette_frame_count).w
	bpl.s	return_2186
	move.b	#3,(Palette_frame_count).w
	lea	(DarkSonic_Pal).l,a0
	move.w	($FFFFF65C).w,d0
	addq.w	#8,($FFFFF65C).w
	cmpi.w	#$30,($FFFFF65C).w
	bcs.s	super1
	move.b	#-1,(Super_Sonic_palette).w
	move.b	#0,(MainCharacter+obj_control).w
super1:
	lea	(Normal_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

return_2186:
	rts
; ===========================================================================

loc_2188:
	subq.b	#1,(Palette_frame_count).w
	bpl.s	return_2186
	move.b	#3,(Palette_frame_count).w
	lea	(DarkSonic_Pal).l,a0
	move.w	($FFFFF65C).w,d0
	subq.w	#8,($FFFFF65C).w
	bcc.s	loc_21B0
	move.b	#0,($FFFFF65C).w
	move.b	#0,(Super_Sonic_palette).w
loc_21B0:
	lea	(Normal_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	lea	(Pal_22C6).l,a0
	cmpi.b	#$2,(Current_Zone).w
	beq.s	super2
	cmpi.b	#$F,(Current_Zone).w
	bne.s	return_2186
	lea	(Pal_2346).l,a0
super2:
	lea	(Underwater_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	rts
; ===========================================================================

loc_21E6:
	subq.b	#1,(Palette_frame_count).w
	bpl.s	return_2186
	move.b	#7,(Palette_frame_count).w
	lea	(DarkSonic_Pal).l,a0
	move.w	($FFFFF65C).w,d0
	addq.w	#8,($FFFFF65C).w
	cmpi.w	#$78,($FFFFF65C).w
	bcs.s	super3
	move.w	#$30,($FFFFF65C).w
super3:
	lea	(Normal_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	lea	(Pal_22C6).l,a0
	cmpi.b	#$1,(Current_Zone).w
	beq.s	super4
	cmpi.b	#$F,(Current_Zone).w
	bne.w	return_2186
	lea	(Pal_2346).l,a0
super4:
	lea	(Underwater_palette+4).w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)
	rts
; End of function PalCycle_SuperSonic