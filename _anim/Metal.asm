; ---------------------------------------------------------------------------
; Animation script - Metal
; ---------------------------------------------------------------------------
		dc.w MetAni_Walk-MetalAniData
		dc.w MetAni_Run-MetalAniData
		dc.w MetAni_Roll-MetalAniData
		dc.w MetAni_Roll2-MetalAniData
		dc.w MetAni_Push-MetalAniData
		dc.w MetAni_Wait-MetalAniData
		dc.w MetAni_Balance-MetalAniData
		dc.w MetAni_LookUp-MetalAniData
		dc.w MetAni_Duck-MetalAniData
		dc.w MetAni_Warp1-MetalAniData
		dc.w MetAni_Warp2-MetalAniData
		dc.w MetAni_Warp3-MetalAniData
		dc.w MetAni_Warp4-MetalAniData
		dc.w MetAni_Stop-MetalAniData
		dc.w MetAni_Float1-MetalAniData
		dc.w MetAni_Float2-MetalAniData
		dc.w MetAni_Spring-MetalAniData
		dc.w MetAni_LZHang-MetalAniData
		dc.w MetAni_Leap1-MetalAniData
		dc.w MetAni_Leap2-MetalAniData
		dc.w MetAni_Surf-MetalAniData
		dc.w MetAni_Bubble-MetalAniData
		dc.w MetAni_Death1-MetalAniData
		dc.w MetAni_Drown-MetalAniData
		dc.w MetAni_Death2-MetalAniData
		dc.w MetAni_Shrink-MetalAniData
		dc.w MetAni_Hurt-MetalAniData
		dc.w MetAni_LZSlide-MetalAniData
		dc.w MetAni_Blank-MetalAniData
		dc.w MetAni_Float3-MetalAniData
		dc.w MetAni_Float4-MetalAniData
		dc.w MetAni_SpinDash-MetalAniData	;1F
		dc.w MetAni_3rdRun-MetalAniData 	;20
		dc.w MetAni_DashCharge-MetalAniData	;21
		dc.w MetAni_Super-MetalAniData		;22
		dc.w MetAni_Filler-MetalAniData		;23
		dc.w MetAni_CDDash-MetalAniData
MetAni_Walk:	dc.b $FF, 8, 9,	$A, $B,	6, 7, $FF
MetAni_Run:	dc.b $FF, $1E, $1F, $20, $21, $FF, $FF,	$FF
MetAni_Roll:	dc.b $FE, $2E, $2F, $30, $31, $32, $FF,	$FF
MetAni_Roll2:	dc.b $FE, $2E, $2F, $32, $30, $31, $32,	$FF
MetAni_Push:	dc.b $FD, $45, $46, $47, $48, $FF, $FF,	$FF
MetAni_Wait:	dc.b $B, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 1,	1
		dc.b 1, 1, 1, 1, 1, 1, 1,	1, 1, 3, 3, 2, 2, 2, 2, 2, 2
		dc.b 3, 3, 4, 4, 3, 3, 4, 4, 3, 3, 4, 4, 3, 3, 4, 4, 3, 3
		dc.b 4, 4, 3, 3, 4, 4, 3, 3, 4, 4, 3, 3, 4, 4, 3, 3, 4, 4
		dc.b 2, 2, 2, 2, 2, 2, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
		dc.b 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
		dc.b $72, $73, $73, $73, $74, $75, $76, $75, -2, 4, $FE
MetAni_Balance:	dc.b $1F, $3A, $3B, $FF
MetAni_LookUp:	dc.b $3F, 5, $FF, 0
MetAni_Duck:	dc.b $3F, $39, $FF, 0
MetAni_Warp1:	dc.b $3F, $33, $FF, 0
MetAni_Warp2:	dc.b $3F, $34, $FF, 0
MetAni_Warp3:	dc.b $3F, $35, $FF, 0
MetAni_Warp4:	dc.b $3F, $36, $FF, 0
MetAni_Stop:	dc.b 7,	$37, $38, $FF
MetAni_Float1:	dc.b 7,	$3C, $3F, $FF
MetAni_Float2:	dc.b 7,	$3C, $3D, $53, $3E, $54, $FF, 0
MetAni_Spring:	dc.b $2F, $40, $FD, 0
MetAni_LZHang:	dc.b 4,	$41, $42, $FF
MetAni_Leap1:	dc.b $F, $43, $43, $43,	$FE, 1
MetAni_Leap2:	dc.b $F, $43, $44, $FE,	1, 0
MetAni_Surf:	dc.b $3F, $49, $FF, 0
MetAni_Bubble:	dc.b $B, $56, $56, $A, $B, $FD,	0, 0
MetAni_Death1:	dc.b $20, $4B, $FF, 0
MetAni_Drown:	dc.b $2F, $4C, $FF, 0
MetAni_Death2:	dc.b 3,	$4D, $FF, 0
MetAni_Shrink:	dc.b 3,	$4E, $4F, $50, $51, $52, 0, $FE, 1, 0
MetAni_Hurt:	dc.b 3,	$55, $FF, 0
MetAni_LZSlide:	dc.b 7, $55, $57, $FF
MetAni_Blank:	dc.b $77, 0, $FD, 0
MetAni_Float3:	dc.b 3,	$3C, $3D, $53, $3E, $54, $FF, 0
MetAni_Float4:	dc.b 3,	$3C, $FD, 0
MetAni_SpinDash:	dc.b 0, $58, $59, $58, $5A, $58, $5B, $58, $5C, $58, $5D, $FF
MetAni_3rdRun:	dc.b $FF, $5E, $5F, $60, $61, $FF, $FF,	$FF
MetAni_DashCharge:	dc.b 0,  8, 8, 8, 8, 8, 8, 8, 8
		dc.b	9, 9, 9, 9, $A, $A, $21, $21
		dc.b	$1E,  $1F,  $20,  $21, $1E,  $1F,  $20,  $21
		dc.b	$5E,  $5F,  $60,  $61, -2, 4, $FE
MetAni_Super:	dc.b 2,$6E,$6E,$6F,$6F,$70,$71,$71,$71,$70,$70,$FD,  0
MetAni_Filler:	dc.b $77, 0, $FD, 0
MetAni_CDDash:	dc.b $FE, $2E, $2F, $30, $31, $32, $2E, $2F, $32, $30, $31, $32, -2, 5, $FE
		even
