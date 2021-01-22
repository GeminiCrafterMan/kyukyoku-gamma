		tst.w	($FFFFFE08).w
		beq.s	Obj06_Normal
		jmp	DebugMode
; ---------------------------------------------------------------------------

Obj06_Normal:					  ; ...
		moveq	#0,d0
		move.b	$24(a0),d0
		move.w	Obj06_Index(pc,d0.w),d1
		jmp	Obj06_Index(pc,d1.w)
; End of function Obj06

; ---------------------------------------------------------------------------
Obj06_Index:	dc.w Obj06_Init-Obj06_Index	  ; 0 ;	...
		dc.w Obj06_Control-Obj06_Index	  ; 1
		dc.w Obj06_Hurt-Obj06_Index	  ; 2
		dc.w Obj06_Dead-Obj06_Index	  ; 3
		dc.w Obj06_Gone-Obj06_Index	  ; 4
		dc.w Obj06_Respawning-Obj06_Index ; 5
; ---------------------------------------------------------------------------

Obj06_Init:					  ; ...
		addq.b	#2,$24(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.l	#SK_Map_Knuckles,4(a0)	  ; SK_Map_Knuckles
		move.b	#2,$18(a0)
		move.b	#$18,$19(a0)
		move.b	#4,1(a0)
		move.w	#$600,($FFFFF760).w
		move.w	#$C,($FFFFF762).w
		move.w	#$80,($FFFFF764).w
		tst.b	($FFFFFE30).w
		bne.s	Obj06_Init_Continued
		move.w	#$780,2(a0)
;		jsr	Adjust2PArtPointer
		move.b	#$C,$3E(a0)
		move.b	#$D,$3F(a0)
		move.w	8(a0),($FFFFFE32).w
		move.w	$C(a0),($FFFFFE34).w
		move.w	2(a0),($FFFFFE3C).w
		move.w	$3E(a0),($FFFFFE3E).w

Obj06_Init_Continued:				  ; ...
		move.b	#0,$2C(a0)
		move.b	#4,$2D(a0)
		move.b	#0,(Super_Sonic_flag).w
		move.b	#$1E,$28(a0)
		sub.w	#$20,8(a0)
		add.w	#4,$C(a0)
		move.w	#0,($FFFFEED2).w
		move.w	#$3F,d2

loc_3153EC:					  ; ...
		bsr.w	Knuckles_RecordPositions
		subq.w	#4,a1
		move.l	#0,(a1)
		dbf	d2,loc_3153EC
		add.w	#$20,8(a0)
		sub.w	#4,$C(a0)

Obj06_Control:					  ; ...
		tst.w	($FFFFFFDA).w
		beq.s	loc_315422
		btst	#4,($FFFFF605).w
		beq.s	loc_315422
		move.w	#1,($FFFFFE08).w
		clr.b	($FFFFF7CC).w
		rts
; ---------------------------------------------------------------------------

loc_315422:					  ; ...
		tst.b	($FFFFF7CC).w
		bne.s	loc_31542E
		move.w	($FFFFF604).w,($FFFFF602).w

loc_31542E:					  ; ...
		btst	#0,$2A(a0)
		beq.s	loc_31543E
		move.b	#0,$21(a0)
		bra.s	loc_315450
; ---------------------------------------------------------------------------

loc_31543E:					  ; ...
		moveq	#0,d0
		move.b	$22(a0),d0
		and.w	#6,d0
		move.w	Obj06_Modes(pc,d0.w),d1
		jsr	Obj06_Modes(pc,d1.w)

loc_315450:					  ; ...
		cmp.w	#$FF00,($FFFFEECC).w
		bne.s	loc_31545E
		and.w	#$7FF,$C(a0)

loc_31545E:					  ; ...
		bsr.s	Knuckles_Display
		bsr.w	Knuckles_Super
		bsr.w	Knuckles_RecordPositions
		bsr.w	Knuckles_Water
		move.b	($FFFFF768).w,$36(a0)
		move.b	($FFFFF76A).w,$37(a0)
		tst.b	($FFFFF7C7).w
		beq.s	loc_31548A
		tst.b	$1C(a0)
		bne.s	loc_31548A
		move.b	$1D(a0),$1C(a0)

loc_31548A:					  ; ...
		bsr.w	Knuckles_Animate
		tst.b	$2A(a0)
		bmi.s	loc_31549A
		jsr	TouchResponse

loc_31549A:					  ; ...
		bsr.w	Knux_Loops
		bra.w	LoadKnucklesDynPLC
; ---------------------------------------------------------------------------
Obj06_Modes:	dc.w Obj06_MdNormal-Obj06_Modes	  ; 0 ;	...
		dc.w Obj06_MdAir-Obj06_Modes	  ; 1
		dc.w Obj06_MdRoll-Obj06_Modes	  ; 2
		dc.w Obj06_MdJump-Obj06_Modes	  ; 3

; =============== S U B	R O U T	I N E =======================================


Knuckles_Display:				  ; ...
		move.w	$30(a0),d0
		beq.s	Obj06_Display
		subq.w	#1,$30(a0)
		lsr.w	#3,d0
		bcc.s	Obj06_CheckInvincibility

Obj06_Display:					  ; ...
		jsr	DisplaySprite



Obj06_CheckInvincibility:			  ; ...
		tst.b	($FFFFFE2D).w	; does Sonic have invincibility?
		beq.w	Obj06_CheckSpeedShoes	; if not, branch	; change to beq.w
		tst.w	$32(a0)		; check	time remaining for invinciblity
		beq.w	Obj06_CheckSpeedShoes	; if no	time remains, branch	; change to beq.w
		subq.w	#1,$32(a0)	; subtract 1 from time
		bne.w	Obj06_CheckSpeedShoes	; change to bne.w
		tst.b	($FFFFF7AA).w
		bne.w	Obj06_RemoveInvincibility	; change to bne.w
		cmpi.w	#$C,($FFFFFE14).w
		bcs.w	Obj06_RemoveInvincibility	; change to bcs.w
		moveq	#0,d0
		move.b	($FFFFFE10).w,d0
 
		cmpi.b	#$0,($FFFFFE11).w	; is this act 1?
		bne.s	Obj06_GetBgm2	; if not, branch
		lea	(MusicList1).l,a1	; load Music Playlist for Acts 1
		bra.s	Obj06_PlayMusic	; go to PlayMusic

Obj06_RemoveInvincibility:			  ; ...
		move.b	#0,($FFFFFE2D).w ; cancel invincibility

Obj06_CheckSpeedShoes:				  ; ...
		tst.b	($FFFFFE2E).w	; does Sonic have speed	shoes?
		beq.s	Obj06_ExitCheck	; if not, branch
		tst.w	$34(a0)		; check	time remaining
		beq.s	Obj06_ExitCheck
		subq.w	#1,$34(a0)	; subtract 1 from time
		bne.s	Obj06_ExitCheck
		move.w	#$600,($FFFFF760).w ; restore Sonic's speed
		move.w	#$C,($FFFFF762).w ; restore Sonic's acceleration
		move.w	#$80,($FFFFF764).w ; restore Sonic's deceleration
		move.b	#0,($FFFFFE2E).w ; cancel speed	shoes
		moveq	#0,d0
		move.b	($FFFFFE10).w,d0
		cmpi.b	#$0,($FFFFFE11).w	; is this act 1?
		bne.s	Obj06_GetBgm2	; if not, branch
		lea	(MusicList1).l,a1	; load Music Playlist for Acts 1
		bra.s	Obj06_PlayMusic	; go to PlayMusic
 
Obj06_GetBgm2:
		cmpi.b	#$1,($FFFFFE11).w	; is this act 2?
		bne.s	Obj06_GetBgm3	; if not, branch
		lea	(MusicList2).l,a1	; load Music Playlist for Acts 2
		bra.s	Obj06_PlayMusic	; go to PlayMusic
 
Obj06_GetBgm3:
		cmpi.b	#$2,($FFFFFE11).w	; is this act 3?
		bne.s	Obj06_GetBgm4	; if not, branch
		lea	(MusicList3).l,a1	; load Music Playlist for Acts 3
		bra.s	Obj06_PlayMusic	; go to PlayMusic
 
Obj06_GetBgm4:
		cmpi.b	#$3,($FFFFFE11).w	; is this act 4?
		bne.s	Obj06_PlayMusic	; if not, branch
		lea	(MusicList4).l,a1	; load Music Playlist for Acts 4
 
Obj06_PlayMusic:
		move.b	(a1,d0.w),d0
		jsr	(PlaySound).l	; play normal music

; ---------------------------------------------------------------------------

Obj06_ExitCheck:				  ; ...
		rts
; End of function Knuckles_Display


; =============== S U B	R O U T	I N E =======================================


Knuckles_RecordPositions:			  ; ...
		move.w	($FFFFF7A8).w,d0
		lea	($FFFFCB00).w,a1
		lea	(a1,d0.w),a1
		move.w	8(a0),(a1)+
		move.w	$C(a0),(a1)+
		addq.b	#4,($FFFFF7A9).w
		rts	
; End of function Knuckles_RecordPositions


; =============== S U B	R O U T	I N E =======================================


Knuckles_Water:					  ; ...
		cmpi.b	#1,($FFFFFE10).w ; is level LZ?
		beq.s	Obj06_InWater

return_31556C:					  ; ...
		rts
; ---------------------------------------------------------------------------

Obj06_InWater:					  ; ...
		move.w	($FFFFF646).w,d0
		cmp.w	$C(a0),d0	; is Sonic above the water?
		bge.s	Obj06_OutWater
		bset	#6,$22(a0)
		bne.s	return_31556C
		bsr.w	ResumeMusic
		move.b	#$A,($FFFFD340).w ; load bubbles object	from Sonic's mouth
		move.b	#$81,($FFFFD368).w
		move.w	#$300,($FFFFF760).w ; change Sonic's top speed
		move.w	#6,($FFFFF762).w ; change Sonic's acceleration
		move.w	#$40,($FFFFF764).w ; change Sonic's deceleration
		tst.b	(Super_Sonic_flag).w	; Is Sonic Super?
		beq.s	@Skip			; If not branch
		move.w	#$500,(Sonic_top_speed).w
		move.w	#$18,(Sonic_acceleration).w
		move.w	#$80,(Sonic_deceleration).w
@Skip
		asr	$10(a0)
		asr	$12(a0)
		asr	$12(a0)
		beq.s	return_31556C
		move.b	#8,($FFFFD300).w ; load	splash object
		move.w	#$AA,d0
		jmp	(PlaySound_Special).l ;	play splash sound
; ---------------------------------------------------------------------------

Obj06_OutWater:					  ; ...
		bclr	#6,$22(a0)
		beq.s	return_31556C
		bsr.w	ResumeMusic
		move.w	#$600,($FFFFF760).w ; restore Sonic's speed
		move.w	#$C,($FFFFF762).w ; restore Sonic's acceleration
		move.w	#$80,($FFFFF764).w ; restore Sonic's deceleration
		tst.b	(Super_Sonic_flag).w	; Is Sonic Super?
		beq.s	loc_315616			; If not branch
		move.w	#$800,($FFFFF760).w
		move.w	#$18,($FFFFF762).w
		move.w	#$C0,($FFFFF764).w

loc_315616:					  ; ...
		cmp.b	#4,$24(a0)
		beq.s	loc_315622
		asl	$12(a0)

loc_315622:					  ; ...
		tst.w	$12(a0)
		beq.w	return_31556C
		move.w	#$100,($FFFFD11C).w
		move.l	a0,a1
		move.b	#8,($FFFFD300).w ; load	splash object
		cmpi.w	#-$1000,$12(a0)
		bgt.s	loc_315644
		move.w	#-$1000,$12(a0)

loc_315644:					  ; ...
		move.w	#$AA,d0
		jmp	(PlaySound_Special).l ;	play splash sound
; End of function Knuckles_Water


; =============== S U B	R O U T	I N E =======================================


Obj06_MdNormal:					  ; ...
		bsr.w	Knuckles_Spindash
		bsr.w	Knuckles_Jump
		bsr.w	Knuckles_SlopeResist
		bsr.w	Knuckles_Move
		bsr.w	Knuckles_Roll
		bsr.w	Knuckles_LevelBoundaries
		jsr		SpeedToPos		  ; AKA	SpeedToPos in Sonic 1
		jsr		Sonic_AnglePos
		bsr.w	Knuckles_SlopeRepel
		rts
; End of function Obj06_MdNormal


; =============== S U B	R O U T	I N E =======================================


Obj06_MdAir:					  ; ...
		tst.b	$21(a0)
		bne.s	Obj06_MdAir_Gliding
		bsr.w	Knuckles_JumpHeight
		bsr.w	Knuckles_ChgJumpDir
		bsr.w	Knuckles_LevelBoundaries
		jsr		ObjectFall
		btst	#6,$22(a0)
		beq.s	loc_31569C
		sub.w	#$28,$12(a0)

loc_31569C:					  ; ...
		bsr.w	Knuckles_JumpAngle
		bsr.w	Sonic_Floor
		rts
; ---------------------------------------------------------------------------

Obj06_MdAir_Gliding:				  ; ...
		bsr.w	Knuckles_GlideSpeedControl
		bsr.w	Knuckles_LevelBoundaries
		jsr	SpeedToPos		  ; AKA	SpeedToPos in Sonic 1
		bsr.w	Knuckles_GlideControl

return_3156B8:					  ; ...
		rts
; End of function Obj06_MdAir


; =============== S U B	R O U T	I N E =======================================


Knuckles_GlideControl:				  ; ...

; FUNCTION CHUNK AT 00315C40 SIZE 0000003C BYTES

		move.b	$21(a0),d0
		beq.s	return_3156B8
		cmp.b	#2,d0
		beq.w	Knuckles_FallingFromGlide
		cmp.b	#3,d0
		beq.w	Knuckles_Sliding
		cmp.b	#4,d0
		beq.w	Knuckles_Climbing_Wall
		cmp.b	#5,d0
		beq.w	Knuckles_Climbing_Up

Knuckles_NormalGlide:
		move.b	#$A,$16(a0)
		move.b	#$A,$17(a0)
		bsr.w	Sonic_Floor
		btst	#5,($FFFFFF8F).w
		bne.w	Knuckles_BeginClimb
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		btst	#1,($FFFFFF8F).w
		beq.s	Knuckles_BeginSlide
		move.b	($FFFFF602).w,d0
		and.b	#$70,d0
		bne.s	loc_31574C
		move.b	#2,$21(a0)
		move.b	#$21,$1C(a0)
		bclr	#0,$22(a0)
		tst.w	$10(a0)
		bpl.s	loc_315736
		bset	#0,$22(a0)

loc_315736:					  ; ...
		asr	$10(a0)
		asr	$10(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		rts
; ---------------------------------------------------------------------------

loc_31574C:					  ; ...
		bra.w	sub_315C7C
; ---------------------------------------------------------------------------

Knuckles_BeginSlide:				  ; ...
		bclr	#0,$22(a0)
		tst.w	$10(a0)
		bpl.s	loc_315762
		bset	#0,$22(a0)

loc_315762:					  ; ...
		move.b	$26(a0),d0
		add.b	#$20,d0
		and.b	#$C0,d0
		beq.s	loc_315780
		move.w	$14(a0),$10(a0)
		move.w	#0,$12(a0)
		bra.w	Knuckles_ResetOnFloor_Part2
; ---------------------------------------------------------------------------

loc_315780:					  ; ...
		move.b	#3,$21(a0)
		move.b	#$CC,$1A(a0)
		move.b	#$7F,$1E(a0)
		move.b	#0,$1B(a0)
		cmp.b	#$C,$28(a0)
		bcs.s	return_3157AC
		move.b	#6,($FFFFD124).w
		move.b	#$15,($FFFFD11A).w

return_3157AC:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_BeginClimb:				  ; ...
		tst.b	($FFFFF7AF).w
		bmi.w	loc_31587A
		move.b	$3F(a0),d5
		move.b	$1F(a0),d0
		add.b	#$40,d0
		bpl.s	loc_3157D8
		bset	#0,$22(a0)
		jsr		CheckLeftCeilingDist
		or.w	d0,d1
		bne.s	Knuckles_FallFromGlide
		addq.w	#1,8(a0)
		bra.s	loc_3157E8
; ---------------------------------------------------------------------------

loc_3157D8:					  ; ...
		bclr	#0,$22(a0)
		jsr		CheckRightCeilingDist
		or.w	d0,d1
		bne.w	loc_31586A

loc_3157E8:					  ; ...
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		tst.b	(Super_Sonic_flag).w
		beq.s	loc_315804
		cmp.w	#$480,$14(a0)
		bcs.s	loc_315804
		nop

loc_315804:					  ; ...
		move.w	#0,$14(a0)
		move.w	#0,$10(a0)
		move.w	#0,$12(a0)
		move.b	#4,$21(a0)
		move.b	#$B7,$1A(a0)
		move.b	#$7F,$1E(a0)
		move.b	#0,$1B(a0)
		move.b	#3,$1F(a0)
		move.w	8(a0),$A(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_FallFromGlide:				  ; ...
		move.w	8(a0),d3
		move.b	$16(a0),d0
		ext.w	d0
		sub.w	d0,d3
		subq.w	#1,d3

loc_31584A:					  ; ...
		move.w	$C(a0),d2
		sub.w	#$B,d2
		jsr		ObjHitFloor2
		tst.w	d1
		bmi.s	loc_31587A
		cmp.w	#$C,d1
		bcc.s	loc_31587A
		add.w	d1,$C(a0)
		bra.w	loc_3157E8
; ---------------------------------------------------------------------------

loc_31586A:					  ; ...
		move.w	8(a0),d3
		move.b	$16(a0),d0
		ext.w	d0
		add.w	d0,d3
		addq.w	#1,d3
		bra.s	loc_31584A
; ---------------------------------------------------------------------------

loc_31587A:					  ; ...
		move.b	#2,$21(a0)
		move.b	#$21,$1C(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		bset	#1,($FFFFFF8F).w
		rts
; ---------------------------------------------------------------------------

Knuckles_FallingFromGlide:			  ; ...
		bsr.w	Knuckles_ChgJumpDir
		add.w	#$38,$12(a0)
		btst	#6,$22(a0)
		beq.s	loc_3158B2
		sub.w	#$28,$12(a0)

loc_3158B2:					  ; ...
		bsr.w	Sonic_Floor
		btst	#1,($FFFFFF8F).w
		bne.s	return_315900
		move.w	#0,$14(a0)
		move.w	#0,$10(a0)
		move.w	#0,$12(a0)
		move.b	$16(a0),d0
		sub.b	#$13,d0
		ext.w	d0
		add.w	d0,$C(a0)
		move.b	$26(a0),d0
		add.b	#$20,d0
		and.b	#$C0,d0
		beq.s	loc_3158F0
		bra.w	Knuckles_ResetOnFloor_Part2
; ---------------------------------------------------------------------------

loc_3158F0:					  ; ...
		bsr.w	Knuckles_ResetOnFloor_Part2
		move.w	#$F,$2E(a0)
		move.b	#$23,$1C(a0)

return_315900:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_Sliding:				  ; ...
		move.b	($FFFFF602).w,d0
		and.b	#$70,d0
		beq.s	loc_315926
		tst.w	$10(a0)
		bpl.s	loc_31591E
		add.w	#$20,$10(a0)
		bmi.s	loc_31591C
		bra.s	loc_315926
; ---------------------------------------------------------------------------

loc_31591C:					  ; ...
		bra.s	loc_315958
; ---------------------------------------------------------------------------

loc_31591E:					  ; ...
		sub.w	#$20,$10(a0)
		bpl.s	loc_315958

loc_315926:					  ; ...
		move.w	#0,$14(a0)
		move.w	#0,$10(a0)
		move.w	#0,$12(a0)
		move.b	$16(a0),d0
		sub.b	#$13,d0
		ext.w	d0
		add.w	d0,$C(a0)
		bsr.w	Knuckles_ResetOnFloor_Part2
		move.w	#$F,$2E(a0)
		move.b	#$22,$1C(a0)
		rts
; ---------------------------------------------------------------------------

loc_315958:					  ; ...
		move.b	#$A,$16(a0)
		move.b	#$A,$17(a0)
		bsr.w	Sonic_Floor
		jsr		Sonic_HitFloor
		cmp.w	#$E,d1
		bge.s	loc_315988
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		rts
; ---------------------------------------------------------------------------

loc_315988:					  ; ...
		move.b	#2,$21(a0)
		move.b	#$21,$1C(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		bset	#1,($FFFFFF8F).w
		rts
; ---------------------------------------------------------------------------

Knuckles_Climbing_Wall:				  ; ...
		tst.b	($FFFFF7AF).w
		bmi.w	loc_315BAE
		move.w	8(a0),d0
		cmp.w	$A(a0),d0
		bne.w	loc_315BAE
		btst	#3,$22(a0)
		bne.w	loc_315BAE
		move.w	#0,$14(a0)
		move.w	#0,$10(a0)
		move.w	#0,$12(a0)
		move.l	#$FFFFD600,($FFFFF796).w
		cmp.b	#$D,$3F(a0)
		beq.s	loc_3159F0
		move.l	#$FFFFD900,($FFFFF796).w

loc_3159F0:					  ; ...
		move.b	$3F(a0),d5
		move.b	#$A,$16(a0)
		move.b	#$A,$17(a0)
		moveq	#0,d1
		btst	#0,($FFFFF602).w
		beq.w	loc_315A76
		move.w	$C(a0),d2
		sub.w	#$B,d2
		bsr.w	sub_315C22
		cmp.w	#4,d1
		bge.w	Knuckles_ClimbUp	  ; Climb onto the floor above you
		tst.w	d1
		bne.w	loc_315B30
		move.b	$3F(a0),d5
		move.w	$C(a0),d2
		subq.w	#8,d2
		move.w	8(a0),d3
		bsr.w	sub_3192E6		  ; Doesn't exist in S2
		tst.w	d1
		bpl.s	loc_315A46
		sub.w	d1,$C(a0)
		moveq	#1,d1
		bra.w	loc_315B04
; ---------------------------------------------------------------------------

loc_315A46:					  ; ...
		subq.w	#1,$C(a0)
		tst.b	(Super_Sonic_flag).w
		beq.s	loc_315A54
		subq.w	#1,$C(a0)

loc_315A54:					  ; ...
		moveq	#1,d1
		move.w	($FFFFEECC).w,d0
		cmp.w	#-$100,d0
		beq.w	loc_315B04
		add.w	#$10,d0
		cmp.w	$C(a0),d0
		ble.w	loc_315B04
		move.w	d0,$C(a0)
		bra.w	loc_315B04
; ---------------------------------------------------------------------------

loc_315A76:					  ; ...
		btst	#1,($FFFFF602).w
		beq.w	loc_315B04
		cmp.b	#$BD,$1A(a0)
		bne.s	loc_315AA2
		move.b	#$B7,$1A(a0)
		addq.w	#3,$C(a0)
		subq.w	#3,8(a0)
		btst	#0,$22(a0)
		beq.s	loc_315AA2
		addq.w	#6,8(a0)

loc_315AA2:					  ; ...
		move.w	$C(a0),d2
		add.w	#$B,d2
		bsr.w	sub_315C22
		tst.w	d1
		bne.w	loc_315BAE
		move.b	$3E(a0),d5
		move.w	$C(a0),d2
		add.w	#9,d2
		move.w	8(a0),d3
		bsr.w	sub_318FF6
		tst.w	d1
		bpl.s	loc_315AF4
		add.w	d1,$C(a0)
		move.b	($FFFFF768).w,$26(a0)
		move.w	#0,$14(a0)
		move.w	#0,$10(a0)
		move.w	#0,$12(a0)
		bsr.w	Knuckles_ResetOnFloor_Part2
		move.b	#5,$1C(a0)
		rts
; ---------------------------------------------------------------------------

loc_315AF4:					  ; ...
		addq.w	#1,$C(a0)
		tst.b	(Super_Sonic_flag).w
		beq.s	loc_315B02
		addq.w	#1,$C(a0)

loc_315B02:					  ; ...
		moveq	#-1,d1

loc_315B04:					  ; ...
		tst.w	d1
		beq.s	loc_315B30
		subq.b	#1,$1F(a0)
		bpl.s	loc_315B30
		move.b	#3,$1F(a0)
		add.b	$1A(a0),d1
		cmp.b	#$B7,d1
		bcc.s	loc_315B22
		move.b	#$BC,d1

loc_315B22:					  ; ...
		cmp.b	#$BC,d1
		bls.s	loc_315B2C
		move.b	#$B7,d1

loc_315B2C:					  ; ...
		move.b	d1,$1A(a0)

loc_315B30:					  ; ...
		move.b	#$20,$1E(a0)
		move.b	#0,$1B(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.w	($FFFFF602).w,d0
		and.w	#$70,d0
		beq.s	return_315B94
		move.w	#$FC80,$12(a0)
		move.w	#$400,$10(a0)
		bchg	#0,$22(a0)
		bne.s	loc_315B6A
		neg.w	$10(a0)

loc_315B6A:					  ; ...
		bset	#1,$22(a0)
		move.b	#1,$3C(a0)
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)
		bset	#2,$22(a0)
		move.b	#0,$21(a0)

return_315B94:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_ClimbUp:				  ; ...
		move.b	#5,$21(a0)		  ; Climb up to	the floor above	you
		cmp.b	#$BD,$1A(a0)
		beq.s	return_315BAC
		move.b	#0,$1F(a0)
		bsr.s	sub_315BDA

return_315BAC:					  ; ...
		rts
; ---------------------------------------------------------------------------

loc_315BAE:					  ; ...
		move.b	#2,$21(a0)
		move.w	#$2121,$1C(a0)
		move.b	#$CB,$1A(a0)
		move.b	#7,$1E(a0)
		move.b	#1,$1B(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		rts
; End of function Knuckles_GlideControl


; =============== S U B	R O U T	I N E =======================================


sub_315BDA:					  ; ...
		moveq	#0,d0
		move.b	$1F(a0),d0
		lea	word_315C12(pc,d0.w),a1
		move.b	(a1)+,$1A(a0)
		move.b	(a1)+,d0
		ext.w	d0
		btst	#0,$22(a0)
		beq.s	loc_315BF6
		neg.w	d0

loc_315BF6:					  ; ...
		add.w	d0,8(a0)
		move.b	(a1)+,d1
		ext.w	d1
		add.w	d1,$C(a0)
		move.b	(a1)+,$1E(a0)
		addq.b	#4,$1F(a0)
		move.b	#0,$1B(a0)
		rts
; End of function sub_315BDA

; ---------------------------------------------------------------------------
word_315C12:	dc.w $BD03,$FD06,$BE08,$F606,$BFF8,$F406,$D208,$FB06; 0	; ...

; =============== S U B	R O U T	I N E =======================================


sub_315C22:					  ; ...

; FUNCTION CHUNK AT 00319208 SIZE 00000020 BYTES
; FUNCTION CHUNK AT 003193D2 SIZE 00000024 BYTES

		move.b	$3F(a0),d5
		btst	#0,$22(a0)
		bne.s	loc_315C36
		move.w	8(a0),d3
		bra.w	loc_319208
; ---------------------------------------------------------------------------

loc_315C36:					  ; ...
		move.w	8(a0),d3
		subq.w	#1,d3
		bra.w	loc_3193D2
; End of function sub_315C22

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Knuckles_GlideControl

Knuckles_Climbing_Up:				  ; ...
		tst.b	$1E(a0)
		bne.s	return_315C7A
		bsr.w	sub_315BDA
		cmp.b	#$10,$1F(a0)
		bne.s	return_315C7A
		move.w	#0,$14(a0)
		move.w	#0,$10(a0)
		move.w	#0,$12(a0)
		btst	#0,$22(a0)
		beq.s	loc_315C70
		subq.w	#1,8(a0)

loc_315C70:					  ; ...
		bsr.w	Knuckles_ResetOnFloor_Part2
		move.b	#5,$1C(a0)

return_315C7A:					  ; ...
		rts
; END OF FUNCTION CHUNK	FOR Knuckles_GlideControl

; =============== S U B	R O U T	I N E =======================================


sub_315C7C:					  ; ...
		move.b	#$20,$1E(a0)
		move.b	#0,$1B(a0)
		move.w	#$2020,$1C(a0)
		bclr	#5,$22(a0)
		bclr	#0,$22(a0)
		moveq	#0,d0
		move.b	$1F(a0),d0
		add.b	#$10,d0
		lsr.w	#5,d0
		move.b	byte_315CC2(pc,d0.w),d1
		move.b	d1,$1A(a0)
		cmp.b	#$C4,d1
		bne.s	return_315CC0
		bset	#0,$22(a0)
		move.b	#$C0,$1A(a0)

return_315CC0:					  ; ...
		rts
; End of function sub_315C7C

; ---------------------------------------------------------------------------
byte_315CC2:	dc.b $C0,$C1,$C2,$C3,$C4,$C3,$C2,$C1; 0	; ...

; =============== S U B	R O U T	I N E =======================================


Knuckles_GlideSpeedControl:			  ; ...
		cmp.b	#1,$21(a0)
		bne.w	loc_315D88
		move.w	$14(a0),d0
		cmp.w	#$400,d0
		bcc.s	loc_315CE2
		addq.w	#8,d0
		bra.s	loc_315CFC
; ---------------------------------------------------------------------------

loc_315CE2:					  ; ...
		cmp.w	#$1800,d0
		bcc.s	loc_315CFC
		move.b	$1F(a0),d1
		and.b	#$7F,d1
		bne.s	loc_315CFC
		addq.w	#4,d0
		tst.b	(Super_Sonic_flag).w
		beq.s	loc_315CFC
		addq.w	#8,d0

loc_315CFC:					  ; ...
		move.w	d0,$14(a0)
		move.b	$1F(a0),d0
		btst	#2,($FFFFF602).w
		beq.s	loc_315D1C
		cmp.b	#$80,d0
		beq.s	loc_315D1C
		tst.b	d0
		bpl.s	loc_315D18
		neg.b	d0

loc_315D18:					  ; ...
		addq.b	#2,d0
		bra.s	loc_315D3A
; ---------------------------------------------------------------------------

loc_315D1C:					  ; ...
		btst	#3,($FFFFF602).w
		beq.s	loc_315D30
		tst.b	d0
		beq.s	loc_315D30
		bmi.s	loc_315D2C
		neg.b	d0

loc_315D2C:					  ; ...
		addq.b	#2,d0
		bra.s	loc_315D3A
; ---------------------------------------------------------------------------

loc_315D30:					  ; ...
		move.b	d0,d1
		and.b	#$7F,d1
		beq.s	loc_315D3A
		addq.b	#2,d0

loc_315D3A:					  ; ...
		move.b	d0,$1F(a0)
		move.b	$1F(a0),d0
		jsr	(CalcSine).l
		muls.w	$14(a0),d1
		asr.l	#8,d1
		move.w	d1,$10(a0)
		cmp.w	#$80,$12(a0)
		blt.s	loc_315D62
		sub.w	#$20,$12(a0)
		bra.s	loc_315D68
; ---------------------------------------------------------------------------

loc_315D62:					  ; ...
		add.w	#$20,$12(a0)

loc_315D68:					  ; ...
		move.w	($FFFFEECC).w,d0
		cmp.w	#$FF00,d0
		beq.w	loc_315D88
		add.w	#$10,d0
		cmp.w	$C(a0),d0
		ble.w	loc_315D88
		asr	$10(a0)
		asr	$14(a0)

loc_315D88:					  ; ...
		cmp.w	#$60,($FFFFEED8).w
		beq.s	return_315D9A
		bcc.s	loc_315D96
		addq.w	#4,($FFFFEED8).w

loc_315D96:					  ; ...
		subq.w	#2,($FFFFEED8).w

return_315D9A:					  ; ...
		rts
; End of function Knuckles_GlideSpeedControl

; ---------------------------------------------------------------------------

Obj06_MdRoll:					  ; ...
		tst.b	$39(a0)
		bne.s	loc_315DA6
		bsr.w	Knuckles_Jump

loc_315DA6:					  ; ...
		bsr.w	Knuckles_RollRepel
		bsr.w	Knuckles_RollSpeed
		bsr.w	Knuckles_LevelBoundaries
		jsr		SpeedToPos		  ; AKA	SpeedToPos in Sonic 1
		jsr		Sonic_AnglePos
		bsr.w	Knuckles_SlopeRepel
		rts
; ---------------------------------------------------------------------------

Obj06_MdJump:					  ; ...
		bsr.w	Knuckles_JumpHeight
		bsr.w	Knuckles_ChgJumpDir
		bsr.w	Knuckles_LevelBoundaries
		jsr	ObjectFall
		btst	#6,$22(a0)
		beq.s	loc_315DE2
		sub.w	#$28,$12(a0)

loc_315DE2:					  ; ...
		bsr.w	Knuckles_JumpAngle
		bsr.w	Sonic_Floor
		rts

; =============== S U B	R O U T	I N E =======================================


Knuckles_Move:					  ; ...
		move.w	($FFFFF760).w,d6
		move.w	($FFFFF762).w,d5
		move.w	($FFFFF764).w,d4
		tst.b	$2B(a0)
		bmi.w	Obj06_Traction
		tst.w	$2E(a0)
		bne.w	Obj06_ResetScreen
		btst	#2,($FFFFF602).w
		beq.s	Obj06_NotLeft
		bsr.w	Knuckles_MoveLeft

Obj06_NotLeft:					  ; ...
		btst	#3,($FFFFF602).w
		beq.s	Obj06_NotRight
		bsr.w	Knuckles_MoveRight

Obj06_NotRight:					  ; ...
		move.b	$26(a0),d0
		add.b	#$20,d0
		and.b	#$C0,d0
		bne.w	Obj06_ResetScreen
		tst.w	$14(a0)
		bne.w	Obj06_ResetScreen
		bclr	#5,$22(a0)
		move.b	#5,$1C(a0)
		btst	#3,$22(a0)
		beq.w	Knuckles_Balance
		moveq	#0,d0
		move.b	$3D(a0),d0
		lsl.w	#6,d0
		lea	($FFFFB000).w,a1
		lea	(a1,d0.w),a1
		tst.b	$22(a1)
		bmi.w	Knuckles_LookUp
		moveq	#0,d1
		move.b	$19(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#2,d2
		add.w	8(a0),d1
		sub.w	8(a1),d1
		cmp.w	#2,d1
		blt.s	Knuckles_BalanceOnObjLeft
		cmp.w	d2,d1
		bge.s	Knuckles_BalanceOnObjRight
		bra.w	Knuckles_LookUp
; ---------------------------------------------------------------------------

Knuckles_BalanceOnObjRight:			  ; ...
		btst	#0,$22(a0)
		bne.s	loc_315E9A
		move.b	#6,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

loc_315E9A:					  ; ...
		bclr	#0,$22(a0)
		move.b	#0,$1E(a0)
		move.b	#4,$1B(a0)
		move.w	#$606,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

Knuckles_BalanceOnObjLeft:			  ; ...
		btst	#0,$22(a0)
		beq.s	loc_315EC8
		move.b	#6,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

loc_315EC8:					  ; ...
		bset	#0,$22(a0)
		move.b	#0,$1E(a0)
		move.b	#4,$1B(a0)
		move.w	#$606,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

Knuckles_Balance:				  ; ...
		jsr		ObjHitFloor
		cmp.w	#$C,d1
		blt.w	Knuckles_LookUp
		cmp.b	#3,$36(a0)
		bne.s	Knuckles_BalanceLeft
		btst	#0,$22(a0)
		bne.s	loc_315F0C
		move.b	#6,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

loc_315F0C:					  ; ...
		bclr	#0,$22(a0)
		move.b	#0,$1E(a0)
		move.b	#4,$1B(a0)
		move.w	#$606,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

Knuckles_BalanceLeft:				  ; ...
		cmp.b	#3,$37(a0)
		bne.s	Knuckles_LookUp
		btst	#0,$22(a0)
		beq.s	loc_315F42
		move.b	#6,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

loc_315F42:					  ; ...
		bset	#0,$22(a0)
		move.b	#0,$1E(a0)
		move.b	#4,$1B(a0)
		move.w	#$606,$1C(a0)
		bra.w	Obj06_ResetScreen
; ---------------------------------------------------------------------------

Knuckles_LookUp:				  ; ...
		btst	#0,($FFFFF602).w
		beq.s	Knuckles_Duck
		move.b	#7,$1C(a0)
		addq.w	#1,($FFFFF66C).w
		cmp.w	#$78,($FFFFF66C).w
		bcs.s	Obj06_ResetScreen_Part2
		move.w	#$78,($FFFFF66C).w
		cmp.w	#$C8,($FFFFEED8).w
		beq.s	Obj06_UpdateSpeedOnGround
		addq.w	#2,($FFFFEED8).w
		bra.s	Obj06_UpdateSpeedOnGround
; ---------------------------------------------------------------------------

Knuckles_Duck:					  ; ...
		btst	#1,($FFFFF602).w
		beq.s	Obj06_ResetScreen
		move.b	#8,$1C(a0)
		addq.w	#1,($FFFFF66C).w
		cmp.w	#$78,($FFFFF66C).w
		bcs.s	Obj06_ResetScreen_Part2
		move.w	#$78,($FFFFF66C).w
		cmp.w	#8,($FFFFEED8).w
		beq.s	Obj06_UpdateSpeedOnGround
		subq.w	#2,($FFFFEED8).w
		bra.s	Obj06_UpdateSpeedOnGround
; ---------------------------------------------------------------------------

Obj06_ResetScreen:				  ; ...
		move.w	#0,($FFFFF66C).w

Obj06_ResetScreen_Part2:			  ; ...
		cmp.w	#$60,($FFFFEED8).w
		beq.s	Obj06_UpdateSpeedOnGround
		bcc.s	loc_315FCE
		addq.w	#4,($FFFFEED8).w

loc_315FCE:					  ; ...
		subq.w	#2,($FFFFEED8).w

Obj06_UpdateSpeedOnGround:			  ; ...
		tst.b	(Super_Sonic_flag).w
		beq.s	loc_315FDC
		move.w	#$C,d5

loc_315FDC:					  ; ...
		move.b	($FFFFF602).w,d0
		and.b	#$C,d0
		bne.s	Obj06_Traction
		move.w	$14(a0),d0
		beq.s	Obj06_Traction
		bmi.s	Obj06_SettleLeft
		sub.w	d5,d0
		bcc.s	loc_315FF6
		move.w	#0,d0

loc_315FF6:					  ; ...
		move.w	d0,$14(a0)
		bra.s	Obj06_Traction
; ---------------------------------------------------------------------------

Obj06_SettleLeft:				  ; ...
		add.w	d5,d0
		bcc.s	loc_316004
		move.w	#0,d0

loc_316004:					  ; ...
		move.w	d0,$14(a0)

Obj06_Traction:					  ; ...
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	$14(a0),d1
		asr.l	#8,d1
		move.w	d1,$10(a0)
		muls.w	$14(a0),d0
		asr.l	#8,d0
		move.w	d0,$12(a0)

Obj06_CheckWallsOnGround:			  ; ...
		move.b	$26(a0),d0
		add.b	#$40,d0
		bmi.s	return_3160A6
		move.b	#$40,d1
		tst.w	$14(a0)
		beq.s	return_3160A6
		bmi.s	loc_31603E
		neg.w	d1

loc_31603E:					  ; ...
		move.b	$26(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		jsr		Sonic_WalkSpeed		  ; Also known as Sonic_WalkSpeed in Sonic 1
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	return_3160A6
		asl.w	#8,d1
		add.b	#$20,d0
		and.b	#$C0,d0
		beq.s	loc_3160A2
		cmp.b	#$40,d0
		beq.s	loc_316088
		cmp.b	#$80,d0
		beq.s	loc_316082
		add.w	d1,$10(a0)
		move.w	#0,$14(a0)
		btst	#0,$22(a0)
		bne.s	return_316080
		bset	#5,$22(a0)

return_316080:					  ; ...
		rts
; ---------------------------------------------------------------------------

loc_316082:					  ; ...
		sub.w	d1,$12(a0)
		rts
; ---------------------------------------------------------------------------

loc_316088:					  ; ...
		sub.w	d1,$10(a0)
		move.w	#0,$14(a0)
		btst	#0,$22(a0)
		beq.s	return_316080
		bset	#5,$22(a0)
		rts
; ---------------------------------------------------------------------------

loc_3160A2:					  ; ...
		add.w	d1,$12(a0)

return_3160A6:					  ; ...
		rts
; End of function Knuckles_Move


; =============== S U B	R O U T	I N E =======================================


Knuckles_MoveLeft:				  ; ...
		move.w	$14(a0),d0
		beq.s	loc_3160B0
		bpl.s	Knuckles_TurnLeft

loc_3160B0:					  ; ...
		bset	#0,$22(a0)
		bne.s	loc_3160C4
		bclr	#5,$22(a0)
		move.b	#1,$1D(a0)

loc_3160C4:					  ; ...
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_3160D6
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_3160D6
		move.w	d1,d0

loc_3160D6:					  ; ...
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_TurnLeft:				  ; ...
		sub.w	d4,d0
		bcc.s	loc_3160EA
		move.w	#-$80,d0

loc_3160EA:					  ; ...
		move.w	d0,$14(a0)
		move.b	$26(a0),d1
		add.b	#$20,d1
		and.b	#$C0,d1
		bne.s	return_31612C
		cmp.w	#$400,d0
		blt.s	return_31612C
		move.b	#$D,$1C(a0)
		bclr	#0,$22(a0)
		move.w	#$A4,d0
		jsr	(PlaySound_Special).l
		cmp.b	#$C,$28(a0)
		bcs.s	return_31612C
		move.b	#6,($FFFFD124).w
		move.b	#$15,($FFFFD11A).w

return_31612C:					  ; ...
		rts
; End of function Knuckles_MoveLeft


; =============== S U B	R O U T	I N E =======================================


Knuckles_MoveRight:				  ; ...
		move.w	$14(a0),d0
		bmi.s	Knuckles_TurnRight
		bclr	#0,$22(a0)
		beq.s	loc_316148
		bclr	#5,$22(a0)
		move.b	#1,$1D(a0)

loc_316148:					  ; ...
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_316156
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_316156
		move.w	d6,d0

loc_316156:					  ; ...
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_TurnRight:				  ; ...
		add.w	d4,d0
		bcc.s	loc_31616A
		move.w	#$80,d0

loc_31616A:					  ; ...
		move.w	d0,$14(a0)
		move.b	$26(a0),d1
		add.b	#$20,d1
		and.b	#$C0,d1
		bne.s	return_3161AC
		cmp.w	#$FC00,d0
		bgt.s	return_3161AC
		move.b	#$D,$1C(a0)
		bset	#0,$22(a0)
		move.w	#$A4,d0
		jsr	(PlaySound_Special).l
		cmp.b	#$C,$28(a0)
		bcs.s	return_3161AC
		move.b	#6,($FFFFD124).w
		move.b	#$15,($FFFFD11A).w

return_3161AC:					  ; ...
		rts
; End of function Knuckles_MoveRight


; =============== S U B	R O U T	I N E =======================================


Knuckles_RollSpeed:				  ; ...
		move.w	($FFFFF760).w,d6
		asl.w	#1,d6
		move.w	($FFFFF762).w,d5
		asr.w	#1,d5
		move.w	#$20,d4
		tst.b	$2B(a0)
		bmi.w	Obj06_Roll_ResetScreen
		tst.w	$2E(a0)
		bne.s	Knuckles_Apply_RollSpeed
		btst	#2,($FFFFF602).w
		beq.s	loc_3161D8
		bsr.w	Knuckles_RollLeft

loc_3161D8:					  ; ...
		btst	#3,($FFFFF602).w
		beq.s	Knuckles_Apply_RollSpeed
		bsr.w	Knuckles_RollRight

Knuckles_Apply_RollSpeed:			  ; ...
		move.w	$14(a0),d0
		beq.s	Knuckles_CheckRollStop
		bmi.s	Knuckles_ApplyRollSpeedLeft
		sub.w	d5,d0
		bcc.s	loc_3161F4
		move.w	#0,d0

loc_3161F4:					  ; ...
		move.w	d0,$14(a0)
		bra.s	Knuckles_CheckRollStop
; ---------------------------------------------------------------------------

Knuckles_ApplyRollSpeedLeft:			  ; ...
		add.w	d5,d0
		bcc.s	loc_316202
		move.w	#0,d0

loc_316202:					  ; ...
		move.w	d0,$14(a0)

Knuckles_CheckRollStop:				  ; ...
		tst.w	$14(a0)
		bne.s	Obj06_Roll_ResetScreen
		tst.b	$39(a0)
		bne.s	Knuckles_KeepRolling
		bclr	#2,$22(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.b	#5,$1C(a0)
		subq.w	#5,$C(a0)
		bra.s	Obj06_Roll_ResetScreen
; ---------------------------------------------------------------------------
; magically gives Knuckles an extra push if he's going to stop rolling where it's not allowed
; (such	as in an S-curve in HTZ	or a stopper chamber in	CNZ)


Knuckles_KeepRolling:				  ; ...
		move.w	#$400,$14(a0)
		btst	#0,$22(a0)
		beq.s	Obj06_Roll_ResetScreen
		neg.w	$14(a0)

Obj06_Roll_ResetScreen:				  ; ...
		cmp.w	#$60,($FFFFEED8).w
		beq.s	Knuckles_SetRollSpeeds
		bcc.s	loc_316250
		addq.w	#4,($FFFFEED8).w

loc_316250:					  ; ...
		subq.w	#2,($FFFFEED8).w

Knuckles_SetRollSpeeds:				  ; ...
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	$14(a0),d0
		asr.l	#8,d0
		move.w	d0,$12(a0)
		muls.w	$14(a0),d1
		asr.l	#8,d1
		cmp.w	#$1000,d1
		ble.s	loc_316278
		move.w	#$1000,d1

loc_316278:					  ; ...
		cmp.w	#-$1000,d1
		bge.s	loc_316282
		move.w	#-$1000,d1

loc_316282:					  ; ...
		move.w	d1,$10(a0)
		bra.w	Obj06_CheckWallsOnGround
; End of function Knuckles_RollSpeed


; =============== S U B	R O U T	I N E =======================================


Knuckles_RollLeft:				  ; ...
		move.w	$14(a0),d0
		beq.s	loc_316292
		bpl.s	Knuckles_BrakeRollingRight

loc_316292:					  ; ...
		bset	#0,$22(a0)
		move.b	#2,$1C(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_BrakeRollingRight:			  ; ...
		sub.w	d4,d0
		bcc.s	loc_3162A8
		move.w	#-$80,d0

loc_3162A8:					  ; ...
		move.w	d0,$14(a0)
		rts
; End of function Knuckles_RollLeft


; =============== S U B	R O U T	I N E =======================================


Knuckles_RollRight:				  ; ...
		move.w	$14(a0),d0
		bmi.s	Knuckles_BrakeRollingLeft
		bclr	#0,$22(a0)
		move.b	#2,$1C(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_BrakeRollingLeft:			  ; ...
		add.w	d4,d0
		bcc.s	loc_3162CA
		move.w	#$80,d0

loc_3162CA:					  ; ...
		move.w	d0,$14(a0)
		rts
; End of function Knuckles_RollRight

; ---------------------------------------------------------------------------
; Subroutine for moving	Knuckles left or right when he's in the air
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================


Knuckles_ChgJumpDir:				  ; ...
		move.w	($FFFFF760).w,d6
		move.w	($FFFFF762).w,d5
		asl.w	#1,d5
		btst	#4,$22(a0)
		bne.s	Obj06_Jump_ResetScreen
		move.w	$10(a0),d0
		btst	#2,($FFFFF602).w
		beq.s	loc_31630E
		bset	#0,$22(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_31630E
		tst.w	($FFFFFFD0).w
		bne.w	loc_31630C
		add.w	d5,d0
		cmp.w	d1,d0
		ble.s	loc_31630E

loc_31630C:					  ; ...
		move.w	d1,d0

loc_31630E:					  ; ...
		btst	#3,($FFFFF602).w
		beq.s	loc_316332
		bclr	#0,$22(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_316332
		tst.w	($FFFFFFD0).w
		bne.w	loc_316330
		sub.w	d5,d0
		cmp.w	d6,d0
		bge.s	loc_316332

loc_316330:					  ; ...
		move.w	d6,d0

loc_316332:					  ; ...
		move.w	d0,$10(a0)

Obj06_Jump_ResetScreen:				  ; ...
		cmp.w	#$60,($FFFFEED8).w
		beq.s	Knuckles_JumpPeakDecelerate
		bcc.s	loc_316344
		addq.w	#4,($FFFFEED8).w

loc_316344:					  ; ...
		subq.w	#2,($FFFFEED8).w

Knuckles_JumpPeakDecelerate:			  ; ...
		cmp.w	#-$400,$12(a0)
		bcs.s	return_316376
		move.w	$10(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	return_316376
		bmi.s	Knuckles_JumpPeakDecelerateLeft
		sub.w	d1,d0
		bcc.s	loc_316364
		move.w	#0,d0

loc_316364:					  ; ...
		move.w	d0,$10(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_JumpPeakDecelerateLeft:		  ; ...
		sub.w	d1,d0
		bcs.s	loc_316372
		move.w	#0,d0

loc_316372:					  ; ...
		move.w	d0,$10(a0)

return_316376:					  ; ...
		rts
; End of function Knuckles_ChgJumpDir


; =============== S U B	R O U T	I N E =======================================


Knuckles_LevelBoundaries:			  ; ...
		move.l	8(a0),d1
		move.w	$10(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	($FFFFF728).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0		; has Sonic touched the	side boundary?
		bhi.s	Knuckles_Boundary_Sides
		move.w	($FFFFF72A).w,d0
		addi.w	#$128,d0
		tst.b	($FFFFF7AA).w
		bne.s	loc_3163A6
		addi.w	#$40,d0

loc_3163A6:					  ; ...
		cmp.w	d1,d0
		bls.s	Knuckles_Boundary_Sides

Knuckles_Boundary_CheckBottom:			  ; ...
		move.w	($FFFFF72E).w,d0
		addi.w	#$E0,d0
		cmp.w	$C(a0),d0	; has Sonic touched the	bottom boundary?
		blt.s	Knuckles_Boundary_Bottom
		rts
; ---------------------------------------------------------------------------

Knuckles_Boundary_Bottom:			  ; ...
		move.w	($FFFFF726).w,d0
		move.w	($FFFFF72E).w,d1
		cmp.w	d0,d1
		blt.s	Knuckles_Boundary_Bottom_locret
		cmpi.w	#$501,($FFFFFE10).w ; is level SBZ2 ?
		bne.w	KillThatRedFuckwit	; if not, kill Sonic
		cmpi.w	#$2000,($FFFFD008).w

		bcs.w	KillThatRedFuckwit

		clr.b	($FFFFFE30).w	; clear	lamppost counter
		move.w	#1,($FFFFFE02).w ; restart the level
		move.w	#$103,($FFFFFE10).w ; set level	to SBZ3	(LZ4)

Knuckles_Boundary_Bottom_locret:
		rts
KillThatRedFuckwit:
		jmp	KillSonic
		rts
; ---------------------------------------------------------------------------

Knuckles_Boundary_Sides:			  ; ...
		move.w	d0,8(a0)
		move.w	#0,$A(a0)
		move.w	#0,$10(a0)	; stop Sonic moving
		move.w	#0,$14(a0)
		bra.s	Knuckles_Boundary_CheckBottom
; End of function Knuckles_LevelBoundaries


; =============== S U B	R O U T	I N E =======================================


Knuckles_Roll:					  ; ...
		tst.b	($FFFFF7CA).w
		bne.s	Obj06_NoRoll
		move.w	$14(a0),d0
		bpl.s	loc_3163E6
		neg.w	d0

loc_3163E6:					  ; ...
		cmpi.w	#$80,d0
		bcs.s	Obj06_NoRoll
		move.b	($FFFFF602).w,d0
		andi.b	#$C,d0
		bne.s	Obj06_NoRoll
		btst	#1,($FFFFF602).w
		bne.s	Obj06_ChkRoll

Obj06_NoRoll:					  ; ...
		rts
; ---------------------------------------------------------------------------

Obj06_ChkRoll:					  ; ...
		btst	#2,$22(a0)
		beq.s	Obj06_DoRoll
		rts
; ---------------------------------------------------------------------------

Obj06_DoRoll:					  ; ...
		bset	#2,$22(a0)
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,$1C(a0)	; use "rolling"	animation
		addq.w	#5,$C(a0)
		move.w	#$BE,d0
		jsr	(PlaySound_Special).l ;	play rolling sound
		tst.w	$14(a0)
		bne.s	return_31643C
		move.w	#$200,$14(a0)

return_31643C:					  ; ...
		rts
; End of function Knuckles_Roll


; =============== S U B	R O U T	I N E =======================================


Knuckles_Jump:					  ; ...
		move.b	($FFFFF603).w,d0
		andi.b	#$70,d0
		beq.w	return_3164EC
		moveq	#0,d0
		move.b	$26(a0),d0
		add.b	#$80,d0
		jsr		sub_14D48
		cmp.w	#6,d1
		blt.w	return_3164EC
		move.w	#$600,d2
		btst	#6,$22(a0)
		beq.s	loc_31647A
		move.w	#$300,d2

loc_31647A:					  ; ...
		moveq	#0,d0
		move.b	$26(a0),d0
		sub.b	#$40,d0
		jsr	(CalcSine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,$10(a0)	; make Sonic jump
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,$12(a0)	; make Sonic jump
		bset	#1,$22(a0)
		bclr	#5,$22(a0)
		addq.l	#4,sp
		move.b	#1,$3C(a0)
		clr.b	$38(a0)
		move.w	#$A0,d0
		jsr	(PlaySound_Special).l ;	play jumping sound
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		btst	#2,$22(a0)
		bne.s	Knuckles_RollJump
		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.w	($FFFFD008).w,d0
		move.b	#2,$1C(a0)	; use "jumping"	animation
		bset	#2,$22(a0)
		addq.w	#5,$C(a0)

return_3164EC:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_RollJump:				  ; ...
		bset	#4,$22(a0)
		rts
; End of function Knuckles_Jump


; =============== S U B	R O U T	I N E =======================================


Knuckles_JumpHeight:				  ; ...
        tst.b    $3C(a0)
		beq.s	Knuckles_UpwardsVelocityCap
        move.w    #-$400,d1
        btst    #6,$22(a0)
		beq.s	loc_31650C
        move.w    #-$200,d1

loc_31650C:					  ; ...
        cmp.w    $12(a0),d1
		ble.w	Knuckles_CheckGlide	  ; Check if Knuckles should begin a glide
        move.b    ($FFFFF602).w,d0
		andi.b	#$70,d0
		bne.s	return_316522
        move.w    d1,$12(a0)

return_316522:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_UpwardsVelocityCap:			  ; ...
		tst.b	$39(a0)
		bne.s	return_316538
		cmpi.w	#-$FC0,$12(a0)
		bge.s	return_316538
		move.w	#-$FC0,$12(a0)

return_316538:					  ; ...
		rts

; ---------------------------------------------------------------------------

Knuckles_CheckGlide:				  ; ...
		tst.w	($FFFFFFD0).w		  ; Don't glide on demos
		bne.w	return_3165D2
		tst.b	$21(a0)
		bne.w	return_3165D2
		move.b	($FFFFF603).w,d0
		andi.b	#$70,d0
		beq.w	return_3165D2
		tst.b	(Super_Sonic_flag).w
		bne.s	Knuckles_BeginGlide
		cmp.b	#6,($FFFFFFB1).w
		bcs.s	Knuckles_BeginGlide
		cmp.w	#1,($FFFFFE20).w
		bcs.s	Knuckles_BeginGlide
		tst.b	($FFFFFE1E).w
		bne.s	Knuckles_TurnSuper

Knuckles_BeginGlide:				  ; ...
		bclr	#2,$22(a0)
		move.b	#$A,$16(a0)
		move.b	#$A,$17(a0)
		bclr	#4,$22(a0)
		move.b	#1,$21(a0)
		add.w	#$200,$12(a0)
		bpl.s	loc_31659E
		move.w	#0,$12(a0)

loc_31659E:					  ; ...
		moveq	#0,d1
		move.w	#$400,d0
		move.w	d0,$14(a0)
		btst	#0,$22(a0)
		beq.s	loc_3165B4
		neg.w	d0
		moveq	#-$80,d1

loc_3165B4:					  ; ...
		move.w	d0,$10(a0)
		move.b	d1,$1F(a0)
		move.w	#0,$26(a0)
		move.b	#0,($FFFFFF8F).w
		bset	#1,($FFFFFF8F).w
		bsr.w	sub_315C7C

return_3165D2:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_TurnSuper:				  ; ...
		move.b	#1,(Super_Sonic_palette).w
		move.b	#$F,($FFFFF65E).w
		move.b	#1,(Super_Sonic_flag).w
		move.w	#60,($FFFFF670).w
		move.b	#$81,$2A(a0)
		move.b	#$1F,$1C(a0)
		move.b	#$7E,($FFFFD040).w
		move.w	#$800,($FFFFF760).w
		move.w	#$18,($FFFFF762).w
		move.w	#$C0,($FFFFF764).w
		move.w	#0,$32(a0)
		bset	#1,$2B(a0)
		move.w	#$C3,d0
		jsr	(PlaySound).l	; Play special ring sound effect.
		move.w	#$99,d0         
		jmp	(PlaySound_Special).l	; load the super theme and return also playmusic doesn't exist
; End of function Knuckles_JumpHeight

; ---------------------------------------------------------------------------
		rts

; =============== S U B	R O U T	I N E =======================================


Knuckles_Super:					  ; ...
		tst.b	(Super_Sonic_flag).w
		beq.w	return_3166C8
		tst.b	($FFFFFE1E).w
		beq.s	loc_31667E
		subq.w	#1,($FFFFF670).w
		bpl.w	return_3166C8
		move.w	#60,($FFFFF670).w
		tst.w	($FFFFFE20).w
		beq.s	loc_31667E
		or.b	#1,($FFFFFE1D).w
		cmp.w	#1,($FFFFFE20).w
		beq.s	loc_316672
		cmp.w	#10,($FFFFFE20).w
		beq.s	loc_316672
		cmp.w	#100,($FFFFFE20).w
		bne.s	loc_316678

loc_316672:					  ; ...
		or.b	#%10000000,($FFFFFE1D).w

loc_316678:					  ; ...
		subq.w	#1,($FFFFFE20).w
		bne.s	return_3166C8

loc_31667E:					  ; ...
		move.b	#2,(Super_Sonic_palette).w
		move.w	#40,($FFFFF65C).w
		move.b	#0,(Super_Sonic_flag).w
		move.b	#1,$1D(a0)
		move.w	#1,$32(a0)
		move.w	#$600,($FFFFF760).w
		move.w	#$C,($FFFFF762).w
		move.w	#$80,($FFFFF764).w
		btst	#6,$22(a0)
		beq.s	return_3166C8
		move.w	#$300,($FFFFF760).w
		move.w	#6,($FFFFF762).w
		move.w	#$40,($FFFFF764).w

return_3166C8:					  ; ...
		rts
; End of function Knuckles_Super


; =============== S U B	R O U T	I N E =======================================


Knuckles_Spindash:				  ; ...
		tst.b	$39(a0)
		bne.s	Knuckles_UpdateSpindash
		cmpi.b	#8,$1C(a0)
		bne.s	return_316718
		move.b	($FFFFF603).w,d0	; read controller
		andi.b	#$70,d0			; pressing A/B/C ?
		beq.w	return_316718
		move.b	#9,$1C(a0)
		move.w	#$D1,d0			; spin sound ($E0 in s2)
		jsr	(PlaySound_Special).l	; play spin sound
		addq.l	#4,sp			; increment stack ptr
		move.b	#1,$39(a0)		; set spindash flag
		move.w	#0,$3A(a0)		; set charge count to 0
		cmpi.b	#$C,$28(a0)		; ??? oxygen remaining?
		move.b	#2,($FFFFD1DC).w	; ??? $D11C only seems
						; to be used in spindash
loc_316710:					  ; ...
		bsr.w	Knuckles_LevelBoundaries
		jsr		Sonic_AnglePos

return_316718:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_UpdateSpindash:			  ; ...
		move.b	#$9,$1C(a0)
		move.b	($FFFFF602).w,d0	; read controller
		btst	#1,d0			; check down button
		bne.w	Knuckles_ChargingSpindash
		move.b	#$E,$16(a0)		; $16(a0) is height/2
		move.b	#7,$17(a0)		; $17(a0) is width/2
		move.b	#2,$1C(a0)		; set animation to roll
		addq.w	#5,$C(a0)		; $C(a0) is Y coordinate
		move.b	#0,$39(a0)		; clear spindash flag
		moveq	#0,d0
		move.b	$3A(a0),d0		; copy charge count
		add.w	d0,d0			; double it
		move.w	Spindash_Speeds(pc,d0.w),$14(a0)
		tst.b	(Super_Sonic_flag).w
		beq.s	loc_31675C
		move.w	Super_Spindash_Speeds(pc,d0.w),$14(a0)

loc_31675C:					  ; ...
		move.w	$14(a0),d0		; get inertia
		subi.w	#$800,d0		; subtract $800
		add.w	d0,d0			; double it
		andi.w	#$1F00,d0		; mask it against $1F00
		neg.w	d0			; negate it
		addi.w	#$2000,d0		; add $2000
		move.w	d0,($FFFFC904).w	; move to $C904
		btst	#0,$22(a0)		; is sonic facing right?
		beq.s	loc_316780
		neg.w	$14(a0)			; negate inertia

loc_316780:					  ; ...
		bset	#2,$22(a0)		; set unused (in s1) flag
		move.b	#0,($FFFFD1DC).w	; clear $D11C (unused?)
		move.w	#$BC,d0			; spin release sound
		jsr	(PlaySound_Special).l	; play it!
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	$14(a0),d1
		asr.l	#8,d1
		move.w	d1,$10(a0)
		muls.w	$14(a0),d0
		asr.l	#8,d0
		move.w	d0,$12(a0)

		bra.s	Obj06_Spindash_ResetScreen
; ---------------------------------------------------------------------------
Spindash_Speeds:				  ; ...
		dc.w  $800, $880, $900,	$980, $A00, $A80, $B00,	$B80, $C00; 0
Super_Spindash_Speeds:				  ; ...
		dc.w  $B00, $B80, $C00,	$C80, $D00, $D80, $E00,	$E80, $F00; 0
; ---------------------------------------------------------------------------

Knuckles_ChargingSpindash:			  ; ...
		tst.w	$3A(a0)		; check charge count
		beq.s	loc_3167D4
		move.w	$3A(a0),d0	; otherwise put it in d0
		lsr.w	#5,d0		; shift right 5 (divide it by 32)
		sub.w	d0,$3A(a0)	; subtract from charge count
		bcc.s	loc_3167D4
		move.w	#0,$3A(a0)	; set charge count to 0

loc_3167D4:					  ; ...
		move.b	($FFFFF603).w,d0	; read controller
		andi.b	#$70,d0			; pressing A/B/C ?
		beq.w	Obj06_Spindash_ResetScreen
		move.w	#$900,$1C(a0)		; reset spdsh animation
		move.w	#$D1,d0			; was $E0 in sonic 2
		move.b	#2,$FFFFD1DC.w	; Set the spindash dust animation to $2.
		jsr	(PlaySound_Special).l	; play charge sound	
		addi.w	#$200,$3A(a0)		; increase charge count
		cmpi.w	#$800,$3A(a0)		; check if it's maxed
		bcs.s	Obj06_Spindash_ResetScreen
		move.w	#$800,$3A(a0)		; reset it to max

Obj06_Spindash_ResetScreen:			  ; ...
		addq.l	#4,sp			; increase stack ptr
		cmpi.w	#$60,($FFFFF73E).w
		beq.s	loc_316818
		bcc.s	loc_316814
		addq.w	#4,($FFFFF73E).w

loc_316814:					  ; ...
		subq.w	#2,($FFFFF73E).w

loc_316818:					  ; ...
		bsr.w	Knuckles_LevelBoundaries
		jsr		Sonic_AnglePos
		rts
; End of function Knuckles_Spindash


; =============== S U B	R O U T	I N E =======================================


Knuckles_SlopeResist:				  ; ...
		move.b	$26(a0),d0
		add.b	#$60,d0
		cmp.b	#$C0,d0
		bcc.s	return_316856
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	$14(a0)
		beq.s	return_316856
		bmi.s	loc_316852
		tst.w	d0
		beq.s	return_316850
		add.w	d0,$14(a0)

return_316850:					  ; ...
		rts
; ---------------------------------------------------------------------------

loc_316852:					  ; ...
		add.w	d0,$14(a0)

return_316856:					  ; ...
		rts
; End of function Knuckles_SlopeResist

; ---------------------------------------------------------------------------
; Subroutine to	push Sonic down	a slope	while he's rolling
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Knuckles_RollRepel:				  ; ...
		move.b	$26(a0),d0
		addi.b	#$60,d0
		cmpi.b	#-$40,d0
		bcc.s	return_316892
		move.b	$26(a0),d0
		jsr	(CalcSine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	$14(a0)
		bmi.s	loc_316888
		tst.w	d0
		bpl.s	loc_316882
		asr.l	#2,d0

loc_316882:					  ; ...
		add.w	d0,$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_316888:					  ; ...
		tst.w	d0
		bmi.s	loc_31688E
		asr.l	#2,d0

loc_31688E:					  ; ...
		add.w	d0,$14(a0)

return_316892:					  ; ...
		rts
; End of function Knuckles_RollRepel

; ---------------------------------------------------------------------------
; Subroutine to	push Sonic down	a slope
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Knuckles_SlopeRepel:				  ; ...
		nop	
		tst.b	$38(a0)
		bne.s	return_3168CE
		tst.w	$3E(a0)
		bne.s	loc_3168D0
		move.b	$26(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	return_3168CE
		move.w	$14(a0),d0
		bpl.s	loc_3168B8
		neg.w	d0

loc_3168B8:					  ; ...
		cmpi.w	#$280,d0
		bcc.s	return_3168CE
		clr.w	$14(a0)
		bset	#1,$22(a0)
		move.w	#$1E,$3E(a0)

return_3168CE:					  ; ...
		rts
; ---------------------------------------------------------------------------

loc_3168D0:					  ; ...
		subq.w	#1,$3E(a0)
		rts
; End of function Knuckles_SlopeRepel


; =============== S U B	R O U T	I N E =======================================


Knuckles_JumpAngle:				  ; ...
		move.b	$26(a0),d0
		beq.s	Knuckles_JumpFlip
		bpl.s	loc_3168E6
		addq.b	#2,d0
		bcc.s	BraTo_Knuckles_JumpAngleSet
		moveq	#0,d0

BraTo_Knuckles_JumpAngleSet:			  ; ...
		bra.s	Knuckles_JumpAngleSet
; ---------------------------------------------------------------------------

loc_3168E6:					  ; ...
		subq.b	#2,d0
		bcc.s	Knuckles_JumpAngleSet
		moveq	#0,d0

Knuckles_JumpAngleSet:				  ; ...
		move.b	d0,$26(a0)

Knuckles_JumpFlip:				  ; ...
		move.b	$27(a0),d0
		beq.s	return_316934
		tst.w	$14(a0)
		bmi.s	Knuckles_JumpLeftFlip

Knuckles_JumpRightFlip:				  ; ...
		move.b	$2D(a0),d1
		add.b	d1,d0
		bcc.s	BraTo_Knuckles_JumpFlipSet
		subq.b	#1,$2C(a0)
		bcc.s	BraTo_Knuckles_JumpFlipSet
		move.b	#0,$2C(a0)
		moveq	#0,d0

BraTo_Knuckles_JumpFlipSet:			  ; ...
		bra.s	Knuckles_JumpFlipSet
; ---------------------------------------------------------------------------

Knuckles_JumpLeftFlip:				  ; ...
		tst.b	$29(a0)
		bne.s	Knuckles_JumpRightFlip
		move.b	$2D(a0),d1
		sub.b	d1,d0
		bcc.s	Knuckles_JumpFlipSet
		subq.b	#1,$2C(a0)
		bcc.s	Knuckles_JumpFlipSet
		move.b	#0,$2C(a0)
		moveq	#0,d0

Knuckles_JumpFlipSet:				  ; ...
		move.b	d0,$27(a0)

return_316934:					  ; ...
		rts
; End of function Knuckles_JumpAngle


; =============== S U B	R O U T	I N E =======================================


Knuckles_DoLevelCollision2:			  ; ...
		move.l	#$FFFFD600,($FFFFF796).w
		cmp.b	#$C,$3E(a0)
		beq.s	loc_31694E
		move.l	#$FFFFD900,($FFFFF796).w

loc_31694E:					  ; ...
		move.b	$3F(a0),d5
		move.w	$10(a0),d1
		move.w	$12(a0),d2
		jsr	(CalcAngle).l
		move.b	d0,($FFFFFFEC).w
		subi.b	#$20,d0
		move.b	d0,($FFFFFFED).w
		andi.b	#$C0,d0
		move.b	d0,($FFFFFFEE).w
		cmpi.b	#$40,d0
		beq.w	Knuckles_HitLeftWall2
		cmpi.b	#$80,d0
		beq.w	Knuckles_HitCeilingAndWalls2
		cmpi.b	#-$40,d0
		beq.w	Knuckles_HitRightWall2
		jsr		Sonic_HitWall
		tst.w	d1
		bpl.s	loc_316998
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)
		bset	#5,($FFFFFF8F).w

loc_316998:					  ; ...
		jsr		sub_14EB4
		tst.w	d1
		bpl.s	loc_3169B0
		add.w	d1,8(a0)
		move.w	#0,$10(a0)
		bset	#5,($FFFFFF8F).w

loc_3169B0:					  ; ...
		jsr		Sonic_HitFloor
		move.b	d1,($FFFFFFEF).w
		tst.w	d1
		bpl.s	return_3169CC
		move.b	$12(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d0
		blt.s	return_3169CC
		bclr	#1,($FFFFFF8F).w

return_3169CC:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitLeftWall2:				  ; ...
		jsr		Sonic_HitWall
		tst.w	d1
		bpl.s	Knuckles_HitCeilingAlt
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)
		move.w	$12(a0),$14(a0)
		bset	#5,($FFFFFF8F).w
		rts

Knuckles_HitCeilingAlt:				  ; ...
		jsr		Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	Knuckles_HitFloor
		neg.w	d1
		cmp.w	#$14,d1
		bcc.s	loc_316A08
		add.w	d1,$C(a0)
		tst.w	$12(a0)
		bpl.s	return_316A06
		move.w	#0,$12(a0)

return_316A06:					  ; ...
		rts
; ---------------------------------------------------------------------------

loc_316A08:					  ; ...
		jsr		sub_14EB4
		tst.w	d1
		bpl.s	return_316A20
		add.w	d1,8(a0)
		move.w	#0,$10(a0)
		bset	#5,($FFFFFF8F).w

return_316A20:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitFloor:				  ; ...
		tst.w	$12(a0)
		bmi.s	return_316A44
		jsr		Sonic_HitFloor
		tst.w	d1
		bpl.s	return_316A44
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Knuckles_ResetOnFloor
		move.b	#0,$1C(a0)
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)
		bclr	#1,($FFFFFF8F).w

return_316A44:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitCeilingAndWalls2:			  ; ...
		jsr		Sonic_HitWall
		tst.w	d1
		bpl.s	loc_316A5E
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)
		bset	#5,($FFFFFF8F).w

loc_316A5E:					  ; ...
		jsr		sub_14EB4
		tst.w	d1
		bpl.s	loc_316A76
		add.w	d1,8(a0)
		move.w	#0,$10(a0)
		bset	#5,($FFFFFF8F).w

loc_316A76:					  ; ...
		jsr		Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	return_316A88
		sub.w	d1,$C(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	Knuckles_HitRightWall2
		move.w	#0,$12(a0)

return_316A88:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitRightWall2:				  ; ...
		jsr		sub_14EB4
		tst.w	d1
		bpl.s	loc_316AA2
		add.w	d1,8(a0)
		move.w	#0,$10(a0)
		bset	#5,($FFFFFF8F).w

loc_316AA2:					  ; ...
		jsr		Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	loc_316ABC
		sub.w	d1,$C(a0)
		tst.w	$12(a0)
		bpl.s	return_316ABA
		move.w	#0,$12(a0)

return_316ABA:					  ; ...
		rts
; ---------------------------------------------------------------------------

loc_316ABC:					  ; ...
		tst.w	$12(a0)
		bmi.s	return_316ADE
		jsr		Sonic_HitFloor
		tst.w	d1
		bpl.s	return_316ADE
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		move.w	#0,$12(a0)
		bclr	#1,($FFFFFF8F).w

return_316ADE:					  ; ...
		rts
; End of function Knuckles_DoLevelCollision2


; =============== S U B	R O U T	I N E =======================================


Knuckles_DoLevelCollision:			  ; ...
		move.l	#$FFFFD600,($FFFFF796).w
		cmp.b	#$C,$3E(a0)
		beq.s	loc_316AF8
		move.l	#$FFFFD900,($FFFFF796).w

loc_316AF8:					  ; ...
		move.b	$3F(a0),d5
		move.w	$10(a0),d1
		move.w	$12(a0),d2
		jsr	(CalcAngle).l
		sub.b	#$20,d0
		and.b	#$C0,d0
		cmp.b	#$40,d0
		beq.w	Knuckles_HitLeftWall
		cmp.b	#$80,d0
		beq.w	Knuckles_HitCeilingAndWalls
		cmp.b	#$C0,d0
		beq.w	Knuckles_HitRightWall
		jsr		Sonic_HitWall
		tst.w	d1
		bpl.s	loc_316B3C
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_316B3C:					  ; ...
		jsr		sub_14EB4
		tst.w	d1
		bpl.s	loc_316B4E
		add.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_316B4E:					  ; ...
		jsr		Sonic_HitFloor
		tst.w	d1
		bpl.s	return_316BC0
		move.b	$12(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_316B66
		cmp.b	d2,d0
		blt.s	return_316BC0

loc_316B66:					  ; ...
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Knuckles_ResetOnFloor
		move.b	d3,d0
		add.b	#$20,d0
		and.b	#$40,d0
		bne.s	loc_316B9E
		move.b	d3,d0
		add.b	#$10,d0
		and.b	#$20,d0
		beq.s	loc_316B90
		asr	$12(a0)
		bra.s	loc_316BB2
; ---------------------------------------------------------------------------

loc_316B90:					  ; ...
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)
		rts
; ---------------------------------------------------------------------------

loc_316B9E:					  ; ...
		move.w	#0,$10(a0)
		cmp.w	#$FC0,$12(a0)
		ble.s	loc_316BB2
		move.w	#$FC0,$12(a0)

loc_316BB2:					  ; ...
		move.w	$12(a0),$14(a0)
		tst.b	d3
		bpl.s	return_316BC0
		neg.w	$14(a0)

return_316BC0:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitLeftWall:				  ; ...
		jsr		Sonic_HitWall
		tst.w	d1
		bpl.s	Knuckles_HitCeiling
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)
		move.w	$12(a0),$14(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_HitCeiling:				  ; ...
		jsr		Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	Knuckles_HitFloor_0
		sub.w	d1,$C(a0)
		tst.w	$12(a0)
		bpl.s	return_316BF4
		move.w	#0,$12(a0)

return_316BF4:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitFloor_0:				  ; ...
		tst.w	$12(a0)
		bmi.s	return_316C1C
		jsr		Sonic_HitFloor
		tst.w	d1
		bpl.s	return_316C1C
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Knuckles_ResetOnFloor
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)

return_316C1C:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitCeilingAndWalls:			  ; ...
		jsr		Sonic_HitWall
		tst.w	d1
		bpl.s	loc_316C30
		sub.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_316C30:					  ; ...
		jsr		sub_14EB4
		tst.w	d1
		bpl.s	loc_316C42
		add.w	d1,8(a0)
		move.w	#0,$10(a0)

loc_316C42:					  ; ...
		jsr		Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	return_316C78
		sub.w	d1,$C(a0)
		move.b	d3,d0
		add.b	#$20,d0
		and.b	#$40,d0
		bne.s	loc_316C62
		move.w	#0,$12(a0)
		rts
; ---------------------------------------------------------------------------

loc_316C62:					  ; ...
		move.b	d3,$26(a0)
		bsr.w	Knuckles_ResetOnFloor
		move.w	$12(a0),$14(a0)
		tst.b	d3
		bpl.s	return_316C78
		neg.w	$14(a0)

return_316C78:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitRightWall:				  ; ...
		jsr		sub_14EB4
		tst.w	d1
		bpl.s	Knuckles_HitCeiling2
		add.w	d1,8(a0)
		move.w	#0,$10(a0)
		move.w	$12(a0),$14(a0)
		rts
; ---------------------------------------------------------------------------

Knuckles_HitCeiling2:				  ; ...
		jsr		Sonic_DontRunOnWalls
		tst.w	d1
		bpl.s	Knuckles_HitFloor2
		sub.w	d1,$C(a0)
		tst.w	$12(a0)
		bpl.s	return_316CAC
		move.w	#0,$12(a0)

return_316CAC:					  ; ...
		rts
; ---------------------------------------------------------------------------

Knuckles_HitFloor2:				  ; ...
		tst.w	$12(a0)
		bmi.s	return_316CD4
		jsr		Sonic_HitFloor
		tst.w	d1
		bpl.s	return_316CD4
		add.w	d1,$C(a0)
		move.b	d3,$26(a0)
		bsr.w	Knuckles_ResetOnFloor
		move.w	#0,$12(a0)
		move.w	$10(a0),$14(a0)

return_316CD4:					  ; ...
		rts
; End of function Sonic_Floor


; =============== S U B	R O U T	I N E =======================================


Knuckles_ResetOnFloor:				  ; ...
		btst	#4,$22(a0)
		beq.s	Knuckles_ResetOnFloor_Part3
		nop
		nop
		nop
; End of function Knuckles_ResetOnFloor


; =============== S U B	R O U T	I N E =======================================


Knuckles_ResetOnFloor_Part2:			  ; ...
		move.b	$16(a0),d0
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		btst	#2,$22(a0)
		beq.s	Knuckles_ResetOnFloor_Part3
		bclr	#2,$22(a0)
		move.b	#0,$1C(a0)
		sub.b	#$13,d0
		ext.w	d0
		add.w	d0,$C(a0)

Knuckles_ResetOnFloor_Part3:			  ; ...
		bclr	#1,$22(a0)
		bclr	#5,$22(a0)
		bclr	#4,$22(a0)
		move.b	#0,$3C(a0)
		move.w	#0,($FFFFF7D0).w
		move.b	#0,$27(a0)
		move.b	#0,$29(a0)
		move.b	#0,$2C(a0)
		move.w	#0,($FFFFF66C).w
		move.b	#0,$21(a0)
		cmp.b	#$20,$1C(a0)
		bcc.s	loc_316D5C
		cmp.b	#$14,$1C(a0)
		bne.s	return_316D62

loc_316D5C:					  ; ...
		move.b	#0,$1C(a0)

return_316D62:					  ; ...
		rts
; End of function Knuckles_ResetOnFloor_Part2


; =============== S U B	R O U T	I N E =======================================


Obj06_Hurt:					  ; ...
		jsr	SpeedToPos
		addi.w	#$30,$12(a0)
		btst	#6,$22(a0)
		beq.s	loc_316DAE
		subi.w	#$20,$12(a0)

loc_316DAE:					  ; ...
		bsr.w	Knuckles_HurtStop
		bsr.w	Knuckles_LevelBoundaries
		bsr.w	Knuckles_RecordPositions
		bsr.w	Knuckles_Animate
		bsr.w	LoadKnucklesDynPLC
		jmp	DisplaySprite
; End of function Obj06_Hurt


; =============== S U B	R O U T	I N E =======================================


Knuckles_HurtStop:				  ; ...
		move.w	($FFFFF72E).w,d0
		addi.w	#$E0,d0
		cmp.w	$C(a0),d0
		bcs.w	KillSonicHurtStop
		bsr.w	Sonic_Floor
		btst	#1,$22(a0)
		bne.s	return_316E0C
		moveq	#0,d0
		move.w	d0,$12(a0)
		move.w	d0,$10(a0)
		move.w	d0,$14(a0)
		move.b	#0,$1C(a0)
		subq.b	#2,$24(a0)
		move.w	#$78,$30(a0)

return_316E0C:					  ; ...
		rts
; ---------------------------------------------------------------------------

JmpToK_KillSonic:				  ; ...
		jmp	KillSonic
		rts
; End of function Knuckles_HurtStop

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Obj06_Hurt

Knuckles_HurtInstantRecover:			  ; ...
		subq.b	#2,$24(a0)
		move.b	#0,$25(a0)
		bsr.w	Knuckles_RecordPositions
		bsr.w	Knuckles_Animate
		bsr.w	LoadKnucklesDynPLC
		jmp	DisplaySprite
; END OF FUNCTION CHUNK	FOR Obj06_Hurt

; =============== S U B	R O U T	I N E =======================================


Obj06_Dead:					  ; ...
		tst.w	($FFFFFFDA).w
		beq.s	loc_316E4A
		btst	#4,($FFFFF605).w
		beq.s	loc_316E4A
		move.w	#1,($FFFFFE08).w
		clr.b	($FFFFF7CC).w
		rts
; ---------------------------------------------------------------------------

loc_316E4A:					  ; ...
		bsr.w	GameOver
		jsr		ObjectFall
		bsr.w	Knuckles_RecordPositions
		bsr.w	Knuckles_Animate
		bsr.w	LoadKnucklesDynPLC
		jmp	DisplaySprite
; End of function Obj06_Dead


; =============== S U B	R O U T	I N E =======================================


Obj06_CheckGameOver:					  ; ...
		move.w	($FFFFF704).w,d0
		addi.w	#$100,d0
		cmp.w	$C(a0),d0
		bge.w	return_316F64
		move.w	#-$38,$12(a0)
		addq.b	#2,$24(a0)
		clr.b	($FFFFFE1E).w	; stop time counter
		addq.b	#1,($FFFFFE1C).w ; update lives	counter
		subq.b	#1,($FFFFFE12).w ; subtract 1 from number of lives
		bne.s	Obj06_ResetLevel
		move.w	#0,$3A(a0)
		move.b	#$39,($FFFFD080).w ; load GAME object
		move.b	#$39,($FFFFD0C0).w ; load OVER object
		move.b	#1,($FFFFD0DA).w ; set OVER object to correct frame
		clr.b	($FFFFFE1A).w

Obj06_Finished:					  ; ...
		move.w	#$8F,d0
		jsr	(PlaySound).l	; play game over music
		moveq	#3,d0
		jmp	(LoadPLC).l	; load game over patterns
; ---------------------------------------------------------------------------

Obj06_ResetLevel:				  ; ...
		tst.b	($FFFFFE1A).w
		beq.s	Obj06_ResetLevel_Part2
		move.w	#0,$3A(a0)
		move.b	#$39,($FFFFB080).w
		move.b	#$39,($FFFFB0C0).w
		move.b	#2,($FFFFB09A).w
		move.b	#3,($FFFFB0DA).w
		move.w	a0,($FFFFB0BE).w
		bra.s	Obj06_Finished
; ---------------------------------------------------------------------------

Obj06_ResetLevel_Part2:				  ; ...
		tst.w	(Two_player_mode).w
		beq.s	return_316F64
		move.b	#0,($FFFFEEBE).w
		move.b	#$A,$24(a0)
		move.w	($FFFFFE32).w,8(a0)
		move.w	($FFFFFE34).w,$C(a0)
		move.w	($FFFFFE3C).w,2(a0)
		move.w	($FFFFFE3E).w,$3E(a0)
		clr.w	($FFFFFE20).w
		clr.b	($FFFFFE1B).w
		move.b	#0,$2A(a0)
		move.b	#5,$1C(a0)
		move.w	#0,$10(a0)
		move.w	#0,$12(a0)
		move.w	#0,$14(a0)
		move.b	#2,$22(a0)
		move.w	#0,$2E(a0)
		move.w	#0,$3A(a0)

return_316F64:					  ; ...
		rts
; End of function Obj06_CheckGameOver


; =============== S U B	R O U T	I N E =======================================


Obj06_Gone:					  ; ...
		tst.w	$3A(a0)
		beq.s	return_316F78
		subq.w	#1,$3A(a0)
		bne.s	return_316F78
		move.w	#1,($FFFFFE02).w

return_316F78:					  ; ...
		rts
; End of function Obj06_Gone

; ---------------------------------------------------------------------------

Obj06_Respawning:				  ; ...
		tst.w	($FFFFEEB0).w
		bne.s	loc_316F8C
		tst.w	($FFFFEEB2).w
		bne.s	loc_316F8C
		move.b	#2,$24(a0)

loc_316F8C:					  ; ...
		bsr.w	Knuckles_Animate
		bsr.w	LoadKnucklesDynPLC
		jmp	DisplaySprite

; =============== S U B	R O U T	I N E =======================================


Knuckles_Animate:				  ; ...
		lea	(KnucklesAniData).l,a1
		moveq	#0,d0
		move.b	$1C(a0),d0
		cmp.b	$1D(a0),d0
		beq.s	KAnim_Do
		move.b	d0,$1D(a0)
		move.b	#0,$1B(a0)
		move.b	#0,$1E(a0)

KAnim_Do:					  ; ...
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	KAnim_WalkRun
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		subq.b	#1,$1E(a0)
		bpl.s	KAnim_Delay
		move.b	d0,$1E(a0)

KAnim_Do2:					  ; ...
		moveq	#0,d1
		move.b	$1B(a0),d1
		move.b	1(a1,d1.w),d0
		cmp.b	#$FD,d0
		bhs	KAnim_End_FF

KAnim_Next:					  ; ...
		move.b	d0,$1A(a0)
		addq.b	#1,$1B(a0)

KAnim_Delay:					  ; ...
		rts
; ---------------------------------------------------------------------------

KAnim_End_FF:					  ; ...
		addq.b	#1,d0
		bne.s	KAnim_End_FE
		move.b	#0,$1B(a0)
		move.b	1(a1),d0
		bra.s	KAnim_Next
; ---------------------------------------------------------------------------

KAnim_End_FE:					  ; ...
		addq.b	#1,d0
		bne.s	KAnim_End_FD
		move.b	2(a1,d1.w),d0
		sub.b	d0,$1B(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	KAnim_Next
; ---------------------------------------------------------------------------

KAnim_End_FD:					  ; ...
		addq.b	#1,d0
		bne.s	KAnim_End
		move.b	2(a1,d1.w),$1C(a0)

KAnim_End:					  ; ...
		rts
; ---------------------------------------------------------------------------

KAnim_WalkRun:					  ; ...
		addq.b	#1,d0
		bne.w	KAnim_Roll
		moveq	#0,d0
		move.b	$27(a0),d0
		bne.w	KAnim_Tumble
		moveq	#0,d1
		move.b	$26(a0),d0
		bmi.s	loc_31704E
		beq.s	loc_31704E
		subq.b	#1,d0

loc_31704E:					  ; ...
		move.b	$22(a0),d2
		andi.b	#1,d2
		bne.s	loc_31705A
		not.b	d0

loc_31705A:					  ; ...
		addi.b	#$10,d0
		bpl.s	loc_317062
		moveq	#3,d1

loc_317062:					  ; ...
		andi.b	#$FC,1(a0)
		eor.b	d1,d2
		or.b	d2,1(a0)
		btst	#5,$22(a0)
		bne.w	KAnim_Push
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	$14(a0),d2
		bpl.s	loc_317086
		neg.w	d2

loc_317086:					  ; ...
		tst.b	$2B(a0)
		bpl.w	loc_317090
		add.w	d2,d2

loc_317090:					  ; ...
		lea	(KnucklesAni_Run).l,a1
		cmpi.w	#$600,d2
		bcc.s	loc_3170A4
		lea	(KnucklesAni_Walk).l,a1
		add.b	d0,d0

loc_3170A4:					  ; ...
		add.b	d0,d0
		move.b	d0,d3
		moveq	#0,d1
		move.b	$1B(a0),d1
		move.b	1(a1,d1.w),d0
		cmp.b	#$FF,d0
		bne.s	loc_3170C2
		move.b	#0,$1B(a0)
		move.b	1(a1),d0

loc_3170C2:					  ; ...
		move.b	d0,$1A(a0)
		add.b	d3,$1A(a0)
		subq.b	#1,$1E(a0)
		bpl.s	return_3170E4
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_3170DA
		moveq	#0,d2

loc_3170DA:					  ; ...
		lsr.w	#8,d2
		move.b	d2,$1E(a0)
		addq.b	#1,$1B(a0)

return_3170E4:					  ; ...
		rts
; ---------------------------------------------------------------------------

KAnim_Tumble:					  ; ...
		move.b	$27(a0),d0
		moveq	#0,d1
		move.b	$22(a0),d2
		and.b	#1,d2
		bne.s	KAnim_Tumble_Left
		and.b	#$FC,1(a0)
		add.b	#$B,d0
		divu.w	#$16,d0
		add.b	#$31,d0
		move.b	d0,$1A(a0)
		move.b	#0,$1E(a0)
		rts
; ---------------------------------------------------------------------------

KAnim_Tumble_Left:				  ; ...
		and.b	#$FC,1(a0)
		tst.b	$29(a0)
		beq.s	loc_31712C
		or.b	#1,1(a0)
		add.b	#$B,d0
		bra.s	loc_317138
; ---------------------------------------------------------------------------

loc_31712C:					  ; ...
		or.b	#3,1(a0)
		neg.b	d0
		add.b	#-$71,d0

loc_317138:					  ; ...
		divu.w	#$16,d0
		add.b	#$31,d0
		add.b	d3,$1A(a0)	; modify frame number
		move.b	#0,$1E(a0)
		rts
; ---------------------------------------------------------------------------

KAnim_Roll:					  ; ...
		subq.b	#1,$1E(a0)
		bpl.w	KAnim_Delay
		addq.b	#1,d0
		bne.s	KAnim_Push
		move.w	$14(a0),d2
		bpl.s	loc_317160
		neg.w	d2

loc_317160:					  ; ...
		lea	(KnucklesAni_Roll2).l,a1
		cmpi.w	#$600,d2
		bcc.s	loc_317172
		lea	(KnucklesAni_Roll).l,a1

loc_317172:					  ; ...
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_31717C
		moveq	#0,d2

loc_31717C:					  ; ...
		lsr.w	#8,d2
		move.b	d2,$1E(a0)
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		bra.w	KAnim_Do2
; ---------------------------------------------------------------------------

KAnim_Push:					  ; ...
		subq.b	#1,$1E(a0)
		bpl.w	KAnim_Delay
		move.w	$14(a0),d2
		bmi.s	loc_3171A8
		neg.w	d2

loc_3171A8:					  ; ...
		addi.w	#$800,d2
		bpl.s	loc_3171B0
		moveq	#0,d2

loc_3171B0:					  ; ...
		lsr.w	#8,d2
		move.b	d2,$1E(a0)
		lea	(KnucklesAni_Push).l,a1
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		bra.w	KAnim_Do2
; End of function Knuckles_Animate

; ---------------------------------------------------------------------------
KnucklesAniData:
		dc.w KnucklesAni_Walk-KnucklesAniData; 0 ; ...
		dc.w KnucklesAni_Run-KnucklesAniData; 1
		dc.w KnucklesAni_Roll-KnucklesAniData; 2
		dc.w KnucklesAni_Roll2-KnucklesAniData;	3
		dc.w KnucklesAni_Push-KnucklesAniData; 4
		dc.w KnucklesAni_Wait-KnucklesAniData; 5
		dc.w KnucklesAni_Balance-KnucklesAniData; 6
		dc.w KnucklesAni_LookUp-KnucklesAniData; 7
		dc.w KnucklesAni_Duck-KnucklesAniData; 8
		dc.w KnucklesAni_Spindash-KnucklesAniData; 9
		dc.w KnucklesAni_Unused-KnucklesAniData; 10
		dc.w KnucklesAni_Pull-KnucklesAniData; 11
		dc.w KnucklesAni_Balance2-KnucklesAniData; 12
		dc.w KnucklesAni_Stop-KnucklesAniData; 13
		dc.w KnucklesAni_Float-KnucklesAniData;	14
		dc.w KnucklesAni_Float2-KnucklesAniData; 15
		dc.w KnucklesAni_Spring-KnucklesAniData; 16
		dc.w KnucklesAni_Hang-KnucklesAniData; 17
		dc.w KnucklesAni_Unused_0-KnucklesAniData; 18
		dc.w KnucklesAni_S3EndingPose-KnucklesAniData; 19
		dc.w KnucklesAni_WFZHang-KnucklesAniData; 20
		dc.w KnucklesAni_Bubble-KnucklesAniData; 21
		dc.w KnucklesAni_DeathBW-KnucklesAniData; 22
		dc.w KnucklesAni_Drown-KnucklesAniData;	23
		dc.w KnucklesAni_Death-KnucklesAniData;	24
		dc.w KnucklesAni_OilSlide-KnucklesAniData; 25
		dc.w KnucklesAni_Hurt-KnucklesAniData; 26
		dc.w KnucklesAni_OilSlide_0-KnucklesAniData; 27
		dc.w KnucklesAni_Blank-KnucklesAniData;	28
		dc.w KnucklesAni_Unused_1-KnucklesAniData; 29
		dc.w KnucklesAni_Unused_2-KnucklesAniData; 30
		dc.w KnucklesAni_Transform-KnucklesAniData; 31
		dc.w KnucklesAni_Gliding-KnucklesAniData; 32
		dc.w KnucklesAni_FallFromGlide-KnucklesAniData;	33
		dc.w KnucklesAni_GetUp-KnucklesAniData;	34
		dc.w KnucklesAni_HardFall-KnucklesAniData; 35
		dc.w KnucklesAni_Badass-KnucklesAniData; 36
KnucklesAni_Walk:dc.b $FF,  7,	8,  1,	2,  3,	4,  5,	6,$FF; 0 ; ...
KnucklesAni_Run:dc.b $FF,$21,$22,$23,$24,$FF,$FF,$FF,$FF,$FF; 0	; ...
KnucklesAni_Roll:dc.b $FE,$9A,$96,$9A,$97,$9A,$98,$9A,$99,$FF; 0 ; ...
KnucklesAni_Roll2:dc.b $FE,$9A,$96,$9A,$97,$9A,$98,$9A,$99,$FF;	0 ; ...
KnucklesAni_Push:dc.b $FD,$CE,$CF,$D0,$D1,$FF,$FF,$FF,$FF,$FF; 0 ; ...
KnucklesAni_Wait:dc.b	5,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56; 0 ; ...
		dc.b $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56; 13
		dc.b $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56; 26
		dc.b $56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$56,$D2; 39
		dc.b $D2,$D2,$D3,$D3,$D3,$D2,$D2,$D2,$D3,$D3,$D3,$D2,$D2; 52
		dc.b $D2,$D3,$D3,$D3,$D2,$D2,$D2,$D3,$D3,$D3,$D2,$D2,$D2; 65
		dc.b $D3,$D3,$D3,$D2,$D2,$D2,$D3,$D3,$D3,$D2,$D2,$D2,$D3; 78
		dc.b $D3,$D3,$D2,$D2,$D2,$D3,$D3,$D3,$D2,$D2,$D2,$D3,$D3; 91
		dc.b $D3,$D4,$D4,$D4,$D4,$D4,$D7,$D8,$D9,$DA,$DB,$D8,$D9; 104
		dc.b $DA,$DB,$D8,$D9,$DA,$DB,$D8,$D9,$DA,$DB,$D8,$D9,$DA; 117
		dc.b $DB,$D8,$D9,$DA,$DB,$D8,$D9,$DA,$DB,$D8,$D9,$DA,$DB; 130
		dc.b $DC,$DD,$DC,$DD,$DE,$DE,$D8,$D7,$FF; 143
KnucklesAni_Balance:dc.b   3,$9F,$9F,$A0,$A0,$A1,$A1,$A2,$A2,$A3,$A3,$A4,$A4; 0	; ...
		dc.b $A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5; 13
		dc.b $A5,$A5,$A6,$A6,$A6,$A7,$A7,$A7,$A8,$A8,$A9,$A9,$AA; 26
		dc.b $AA,$FE,  6		  ; 39
KnucklesAni_LookUp:dc.b	  5,$D5,$D6,$FE,  1	     ; 0 ; ...
KnucklesAni_Duck:dc.b	5,$9B,$9C,$FE,	1	   ; 0 ; ...
KnucklesAni_Spindash:dc.b   0,$86,$87,$86,$88,$86,$89,$86,$8A,$86,$8B,$FF; 0 ; ...
KnucklesAni_Unused:dc.b	  9,$BA,$C5,$C6,$C6,$C6,$C6,$C6,$C6,$C7,$C7,$C7,$C7; 0 ; ...
		dc.b $C7,$C7,$C7,$C7,$C7,$C7,$C7,$C7,$FD,  0; 13
KnucklesAni_Pull:dc.b  $F,$8F,$FF		   ; 0 ; ...
KnucklesAni_Balance2:dc.b   3,$A1,$A1,$A2,$A2,$A3,$A3,$A4,$A4,$A5,$A5,$A5,$A5; 0 ; ...
		dc.b $A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A6,$A6; 13
		dc.b $A6,$A7,$A7,$A7,$A8,$A8,$A9,$A9,$AA,$AA,$FE; 26
		dc.b   6
KnucklesAni_Stop:dc.b	3,$9D,$9E,$9F,$A0,$FD,	0  ; 0 ; ...
KnucklesAni_Float:dc.b	 7,$C0,$FF		    ; 0	; ...
KnucklesAni_Float2:dc.b	  5,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$FF; 0 ; ...
KnucklesAni_Spring:dc.b	$2F,$8E,$FD,  0		     ; 0 ; ...
KnucklesAni_Hang:dc.b	1,$AE,$AF,$FF		   ; 0 ; ...
KnucklesAni_Unused_0:dc.b  $F,$43,$43,$43,$FE,	1      ; 0 ; ...
KnucklesAni_S3EndingPose:dc.b	5,$B1,$B2,$B2,$B2,$B3,$B4,$FE,	1,  7,$B1,$B3,$B3; 0 ; ...
		dc.b $B3,$B3,$B3,$B3,$B2,$B3,$B4,$B3,$FE,  4; 13
KnucklesAni_WFZHang:dc.b $13,$91,$FF		      ;	0 ; ...
KnucklesAni_Bubble:dc.b	 $B,$B0,$B0,  3,  4,$FD,  0  ; 0 ; ...
KnucklesAni_DeathBW:dc.b $20,$AC,$FF		      ;	0 ; ...
KnucklesAni_Drown:dc.b $20,$AD,$FF		    ; 0	; ...
KnucklesAni_Death:dc.b $20,$AB,$FF		    ; 0	; ...
KnucklesAni_OilSlide:dc.b   9,$8C,$FF		       ; 0 ; ...
KnucklesAni_Hurt:dc.b $40,$8D,$FF		   ; 0 ; ...
KnucklesAni_OilSlide_0:dc.b   9,$8C,$FF			 ; 0 ; ...
KnucklesAni_Blank:dc.b $77,  0,$FF		    ; 0	; ...
KnucklesAni_Unused_1:dc.b $13,$D0,$D1,$FF	       ; 0 ; ...
KnucklesAni_Unused_2:dc.b   3,$CF,$C8,$C9,$CA,$CB,$FE  ; 0 ; ...
		dc.b   4
KnucklesAni_Gliding:dc.b $1F,$C0,$FF		      ;	0 ; ...
KnucklesAni_FallFromGlide:dc.b	 7,$CA,$CB,$FE,	 1	    ; 0	; ...
KnucklesAni_GetUp:dc.b	$F,$CD,$FD,  0		    ; 0	; ...
KnucklesAni_HardFall:dc.b  $F,$9C,$FD,	0	       ; 0 ; ...
KnucklesAni_Badass:dc.b	  5,$D8,$D9,$DA,$DB,$D8,$D9,$DA,$DB,$D8,$D9,$DA,$DB; 0 ; ...
		dc.b $D8,$D9,$DA,$DB,$D8,$D9,$DA,$DB,$D8,$D9,$DA,$DB,$D8; 13
		dc.b $D9,$DA,$DB,$D8,$D9,$DA,$DB,$DC,$DD,$DC,$DD,$DE,$DE; 26
		dc.b $FF			  ; 39
KnucklesAni_Transform:dc.b   2,$EB,$EB,$EC,$ED,$EC,$ED,$EC,$ED,$EC,$ED,$EC,$ED;	0 ; ...
		dc.b $FD,  0,  0		  ; 13

; =============== S U B	R O U T	I N E =======================================

LoadKnucklesDynPLC:				  ; ...
		moveq	#0,d0
		move.b	$1A(a0),d0	; load frame number
; End of function LoadKnucklesDynPLC

; START	OF FUNCTION CHUNK FOR sub_333D66

LoadKnucklesDynPLC_Part2:			  ; ...
		cmp.b	($FFFFF766).w,d0
		beq.s	return_31753E
		move.b	d0,($FFFFF766).w
		lea	(SK_PLC_Knuckles).l,a2	  ; SK_PLC_Knuckles
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		moveq	#0,d5
		move.b	(a2)+,d5
		subq.w	#1,d5
		bmi.s	return_31753E
		move.w	#$F000,d4
		move.l	#SK_ArtUnc_Knux,d6

; loc_1B86E:
KPLC_ReadEntry:
		moveq	#0,d1
		move.b	(a2)+,d1
		lsl.w	#8,d1
		move.b	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,KPLC_ReadEntry	; repeat for number of entries

return_31753E:					  ; ...
		rts
; END OF FUNCTION CHUNK	FOR sub_333D66

; =============== S U B	R O U T	I N E =======================================

; Doesn't exist in S2

sub_3192E6:					  ; ...
		move.b	$17(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eor.w	#$F,d2
		lea	($FFFFF768).w,a4
		move.w	#-$10,a3
		move.w	#$800,d6
		jsr		FindFloor
		move.b	#$80,d2

loc_319306:
		bra.w	loc_318FE8
; End of function sub_3192E6

; START	OF FUNCTION CHUNK FOR sub_14EB4

loc_318FE8:					  ; ...
		move.b	($FFFFF768).w,d3
		btst	#0,d3
		beq.s	return_318FF4
		move.b	d2,d3

return_318FF4:					  ; ...
		rts
; END OF FUNCTION CHUNK	FOR sub_14EB4

; =============== S U B	R O U T	I N E =======================================


sub_318FF6:					  ; ...
		move.b	$17(a0),d0
		ext.w	d0
		add.w	d0,d2
		lea	($FFFFF768).w,a4
		move.w	#$10,a3
		move.w	#0,d6
		jsr		FindFloor
		move.b	#0,d2
		bra.s	loc_318FE8
; End of function sub_318FF6

; ---------------------------------------------------------------------------
; This doesn't exist in S2...
; START	OF FUNCTION CHUNK FOR sub_315C22

loc_319208:					  ; ...
		move.b	$17(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	($FFFFF768).w,a4
		move.w	#$10,a3
		move.w	#0,d6
		jsr		FindWall
		move.b	#$C0,d2
		bra.w	loc_318FE8
; END OF FUNCTION CHUNK	FOR sub_315C22

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_315C22

loc_3193D2:					  ; ...
		move.b	$17(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eor.w	#$F,d3
		lea	($FFFFF768).w,a4
		move.w	#$FFF0,a3
		move.w	#$400,d6
		jsr		FindWall
		move.b	#$40,d2
		bra.w	loc_318FE8
; END OF FUNCTION CHUNK	FOR sub_315C22
		include "knuxstuff.asm"
		include "Knux_Loops.asm"