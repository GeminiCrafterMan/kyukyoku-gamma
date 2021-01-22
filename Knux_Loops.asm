Knux_Loops:
		cmpi.b	#3,($FFFFFE10).w ; is level SLZ	?
		beq.s	loc2_13926	; if yes, branch
		tst.b	($FFFFFE10).w	; is level GHZ ?
		bne.w	loc2ret_139C2	; if not, branch

loc2_13926:
		move.w	$C(a0),d0
		lsr.w	#1,d0
		andi.w	#$380,d0
		move.b	8(a0),d1
		andi.w	#$7F,d1
		add.w	d1,d0
		lea	($FFFFA400).w,a1
		move.b	(a1,d0.w),d1	; d1 is	the 256x256 tile Sonic is currently on
		cmp.b	($FFFFF7AE).w,d1
		beq.w	Obj06_ChkRoll
		cmp.b	($FFFFF7AF).w,d1
		beq.w	Obj06_ChkRoll
		cmp.b	($FFFFF7AC).w,d1
		beq.s	loc2_13976
		cmp.b	($FFFFF7AD).w,d1
		beq.s	loc2_13966
		bclr	#6,1(a0)
		rts	
; ===========================================================================

loc2_13966:
		btst	#1,$22(a0)
		beq.s	loc2_13976
		bclr	#6,1(a0)	; send Sonic to	high plane
		rts	
; ===========================================================================

loc2_13976:
		move.w	8(a0),d2
		cmpi.b	#$2C,d2
		bcc.s	loc2_13988
		bclr	#6,1(a0)	; send Sonic to	high plane
		rts	
; ===========================================================================

loc2_13988:
		cmpi.b	#-$20,d2
		bcs.s	loc2_13996
		bset	#6,1(a0)	; send Sonic to	low plane
		rts	
; ===========================================================================

loc2_13996:
		btst	#6,1(a0)
		bne.s	loc2_139B2
		move.b	$26(a0),d1
		beq.s	loc2ret_139C2
		cmpi.b	#-$80,d1
		bhi.s	loc2ret_139C2
		bset	#6,1(a0)	; send Sonic to	low plane
		rts	
; ===========================================================================

loc2_139B2:
		move.b	$26(a0),d1
		cmpi.b	#-$80,d1
		bls.s	loc2ret_139C2
		bclr	#6,1(a0)	; send Sonic to	high plane

loc2ret_139C2:
		rts	