		lea	(ShadowAniData).l,a1
		moveq	#0,d0
		move.b	$1C(a0),d0
		cmp.b	$1D(a0),d0	; is animation set to restart?
		beq.s	ShAnim_Do	; if not, branch
		move.b	d0,$1D(a0)	; set to "no restart"
		move.b	#0,$1B(a0)	; reset	animation
		move.b	#0,$1E(a0)	; reset	frame duration

ShAnim_Do:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1	; jump to appropriate animation	script
		move.b	(a1),d0
		bmi.s	ShAnim_WalkRun	; if animation is walk/run/roll/jump, branch
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		subq.b	#1,$1E(a0)	; subtract 1 from frame	duration
		bpl.s	ShAnim_Delay	; if time remains, branch
		move.b	d0,$1E(a0)	; load frame duration

ShAnim_Do2:
		moveq	#0,d1
		move.b	$1B(a0),d1	; load current frame number
		move.b	1(a1,d1.w),d0	; read sprite number from script
		bmi.s	ShAnim_End_FF	; if animation is complete, branch

ShAnim_Next:
		move.b	d0,$1A(a0)	; load sprite number
		addq.b	#1,$1B(a0)	; next frame number

ShAnim_Delay:
		rts	
; ===========================================================================

ShAnim_End_FF:
		addq.b	#1,d0		; is the end flag = $FF	?
		bne.s	ShAnim_End_FE	; if not, branch
		move.b	#0,$1B(a0)	; restart the animation
		move.b	1(a1),d0	; read sprite number
		bra.s	ShAnim_Next
; ===========================================================================

ShAnim_End_FE:
		addq.b	#1,d0		; is the end flag = $FE	?
		bne.s	ShAnim_End_FD	; if not, branch
		move.b	2(a1,d1.w),d0	; read the next	byte in	the script
		sub.b	d0,$1B(a0)	; jump back d0 bytes in	the script
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0	; read sprite number
		bra.s	ShAnim_Next
; ===========================================================================

ShAnim_End_FD:
		addq.b	#1,d0		; is the end flag = $FD	?
		bne.s	ShAnim_End	; if not, branch
		move.b	2(a1,d1.w),$1C(a0) ; read next byte, run that animation

ShAnim_End:
		rts	
; ===========================================================================

ShAnim_WalkRun:				; XREF: ShAnim_Do
		subq.b	#1,$1E(a0)	; subtract 1 from frame	duration
		bpl.s	ShAnim_Delay	; if time remains, branch
		addq.b	#1,d0		; is animation walking/running?
		bne.w	ShAnim_RollJump	; if not, branch
		moveq	#0,d1
		move.b	$26(a0),d0	; get Shadow's angle
		move.b	$22(a0),d2
		andi.b	#1,d2		; is Shadow mirrored horizontally?
		bne.s	loc2_13A70	; if yes, branch
		not.b	d0		; reverse angle

loc2_13A70:
		addi.b	#$10,d0		; add $10 to angle
		bpl.s	loc2_13A78	; if angle is $0-$7F, branch
		moveq	#3,d1

loc2_13A78:
		andi.b	#$FC,1(a0)
		eor.b	d1,d2
		or.b	d2,1(a0)
		btst	#5,$22(a0)
		bne.w	ShAnim_Push
		lsr.b	#4,d0		; divide angle by $10
		andi.b	#6,d0		; angle	must be	0, 2, 4	or 6
		move.w	$14(a0),d2	; get Shadow's speed
		bpl.s	loc2_13A9C
		neg.w	d2

loc2_13A9C:
        lea    (ShadAni_Run).l,a1 ; use    running    animation
        cmpi.w    #$600,d2    ; is Shadow at running speed?
        bcc.s    loc2_13AB4    ; if yes, branch
        lea    (ShadAni_Walk).l,a1 ; use walking animation
        move.b    d0,d1
        lsr.b    #1,d1
        add.b    d1,d0
        add.b    d0,d0
        bra.s   name_this_whatever_you_want

loc2_13AB4:
        add.b    d0,d0
        add.b    d0,d0

name_this_whatever_you_want:
        move.b    d0,d3
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc2_13AC2
		moveq	#0,d2

loc2_13AC2:
		lsr.w	#8,d2
		move.b	d2,$1E(a0)	; modify frame duration
		bsr.w	ShAnim_Do2
		add.b	d3,$1A(a0)	; modify frame number
		rts	
; ===========================================================================

ShAnim_RollJump:				; XREF: ShAnim_WalkRun
		addq.b	#1,d0		; is animation rolling/jumping?
		bne.s	ShAnim_Push	; if not, branch
		move.w	$14(a0),d2	; get Shadow's speed
		bpl.s	loc2_13ADE
		neg.w	d2

loc2_13ADE:
		lea	(ShadAni_Roll2).l,a1 ; use fast animation
		cmpi.w	#$600,d2	; is Shadow moving fast?
		bcc.s	loc2_13AF0	; if yes, branch
		lea	(ShadAni_Roll).l,a1 ; use slower	animation

loc2_13AF0:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc2_13AFA
		moveq	#0,d2

loc2_13AFA:
		lsr.w	#8,d2
		move.b	d2,$1E(a0)	; modify frame duration
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		bra.w	ShAnim_Do2
; ===========================================================================

ShAnim_Push:				; XREF: ShAnim_RollJump
		move.w	$14(a0),d2	; get Shadow's speed
		bmi.s	loc2_13B1E
		neg.w	d2

loc2_13B1E:
		addi.w	#$800,d2
		bpl.s	loc2_13B26
		moveq	#0,d2

loc2_13B26:
		lsr.w	#6,d2
		move.b	d2,$1E(a0)	; modify frame duration
		lea	(ShadAni_Push).l,a1
		move.b	$22(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,1(a0)
		or.b	d1,1(a0)
		bra.w	ShAnim_Do2

; ===========================================================================