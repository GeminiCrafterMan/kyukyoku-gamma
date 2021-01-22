; ---------------------------------------------------------------------------
; Animation script - Shadow
; ---------------------------------------------------------------------------
		dc.w ShadAni_Walk-ShadowAniData
		dc.w ShadAni_Run-ShadowAniData
		dc.w ShadAni_Roll-ShadowAniData
		dc.w ShadAni_Roll2-ShadowAniData
		dc.w ShadAni_Push-ShadowAniData
		dc.w ShadAni_Wait-ShadowAniData
		dc.w ShadAni_Balance-ShadowAniData
		dc.w ShadAni_LookUp-ShadowAniData
		dc.w ShadAni_Duck-ShadowAniData
		dc.w ShadAni_Warp1-ShadowAniData
		dc.w ShadAni_Warp2-ShadowAniData
		dc.w ShadAni_Warp3-ShadowAniData
		dc.w ShadAni_Warp4-ShadowAniData
		dc.w ShadAni_Stop-ShadowAniData
		dc.w ShadAni_Float1-ShadowAniData
		dc.w ShadAni_Float2-ShadowAniData
		dc.w ShadAni_Spring-ShadowAniData
		dc.w ShadAni_LZHang-ShadowAniData
		dc.w ShadAni_Leap1-ShadowAniData
		dc.w ShadAni_Leap2-ShadowAniData
		dc.w ShadAni_Surf-ShadowAniData
		dc.w ShadAni_Bubble-ShadowAniData
		dc.w ShadAni_Death1-ShadowAniData
		dc.w ShadAni_Drown-ShadowAniData
		dc.w ShadAni_Death2-ShadowAniData
		dc.w ShadAni_Shrink-ShadowAniData
		dc.w ShadAni_Hurt-ShadowAniData
		dc.w ShadAni_LZSlide-ShadowAniData
		dc.w ShadAni_Blank-ShadowAniData
		dc.w ShadAni_Float3-ShadowAniData
		dc.w ShadAni_Float4-ShadowAniData
		dc.w ShadAni_SpinDash-ShadowAniData ; 1f
		dc.w ShadAni_DoubleJump-ShadowAniData ; 20
		dc.w ShadAni_Falling-ShadowAniData ; 21
		dc.w ShadAni_Blank2-ShadowAniData ; 22
ShadAni_Walk:	dc.b $FF, 8, 9,	$A, $B,	6, 7, $FF
ShadAni_Run:	dc.b $FF, $1E, $1F, $20, $21, $22, $23, $24, $25, $FF, $FF,	$FF
ShadAni_Roll:	dc.b $FE, $3E, $3F, $40, $41, $42, $FF,	$FF
ShadAni_Roll2:	dc.b $FE, $3E, $3F, $42, $40, $41, $42,	$FF
ShadAni_Push:	dc.b $FD, $4F, $50, $51, $52, $FF, $FF,	$FF
ShadAni_Wait:	dc.b $17, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 3, 2, 2, 2
		dc.b 3, 4, 3, 4, 3, 4, 3, 4, 3, 4, 3, 4, 3, 4, 3, 4, 3, 4 
		dc.b 2, 2, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
		dc.b $64, $65, $65, $65, $65, $65, $65, $65, $65, $65, $65
		dc.b $65, $66, $65, $66, $65, $66, $65, $66, $65, $66, $65
		dc.b $66, $65, $66, $65, $66, $65, $66, $67, $67, $67, $67
		dc.b $68, $69, $69, $69, $69, $69, $6A, $69, $6A, $69, $6A
		dc.b $69, $69, $6A, $69, $6A, $69, $6A, $69, $69, $6A, $69, -2, 2, $FE
ShadAni_Balance:	dc.b $1F, $46, $47, $FF
ShadAni_LookUp:	dc.b $3F, 5, $FF, 0
ShadAni_Duck:	dc.b $3F, $45, $FF, 0
ShadAni_Warp1:	dc.b $3F, $33, $FF, 0
ShadAni_Warp2:	dc.b $3F, $34, $FF, 0
ShadAni_Warp3:	dc.b $3F, $35, $FF, 0
ShadAni_Warp4:	dc.b $3F, $36, $FF, 0
ShadAni_Stop:	dc.b 7,	$43, $44, $FF
ShadAni_Float1:	dc.b 7,	$48, $4B, $FF
ShadAni_Float2:	dc.b 7,	$48, $49, $55, $4A, $56, $FF, 0
ShadAni_Spring:	dc.b $2F, $4C, $FD, $21
ShadAni_LZHang:	dc.b 4,	$4D, $4E, $FF
ShadAni_Leap1:	dc.b $F, $43, $43, $43,	$FE, 1
ShadAni_Leap2:	dc.b $F, $43, $44, $FE,	1, 0
ShadAni_Surf:	dc.b $3F, $49, $FF, 0
ShadAni_Bubble:	dc.b $B, $58, $58, $A, $B, $FD,	0, 0
ShadAni_Death1:	dc.b $20, $4B, $FF, 0
ShadAni_Drown:	dc.b $2F, $53, $FF, 0
ShadAni_Death2:	dc.b 3,	$54, $FF, 0
ShadAni_Shrink:	dc.b 3,	$4E, $4F, $50, $51, $52, 0, $FE, 1, 0
ShadAni_Hurt:	dc.b 3,	$57, $FF, 0
ShadAni_LZSlide:	dc.b 7, $57, $59, $FF
ShadAni_Blank:	dc.b $77, 0, $FD, 0
ShadAni_Float3:	dc.b 3,	$48, $49, $55, $4A, $56, $FF, 0
ShadAni_Float4:	dc.b 3,	$38, $FD, 0
ShadAni_SpinDash:	dc.b 0, $5A, $5B, $5A, $5C, $5A, $5D, $5A, $5E, $5A, $5F, $FF
ShadAni_DoubleJump:	dc.b 1, $60, $61, $60, $61, $60, $61, $60, $61, $60, $61, $60, $61, $FD, $21
ShadAni_Falling:	dc.b 3, $62, $63, $FF
ShadAni_Blank2:	dc.b $77, 0, $FD, 0
		even