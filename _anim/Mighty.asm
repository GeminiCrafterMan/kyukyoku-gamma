; ---------------------------------------------------------------------------
; Animation script - Mighty
; ---------------------------------------------------------------------------
		dc.w MtyAni_Walk-MightyAniData
		dc.w MtyAni_Run-MightyAniData
		dc.w MtyAni_Roll-MightyAniData
		dc.w MtyAni_Roll2-MightyAniData
		dc.w MtyAni_Push-MightyAniData
		dc.w MtyAni_Wait-MightyAniData
		dc.w MtyAni_Balance-MightyAniData
		dc.w MtyAni_LookUp-MightyAniData
		dc.w MtyAni_Duck-MightyAniData
		dc.w MtyAni_Warp1-MightyAniData
		dc.w MtyAni_Warp2-MightyAniData
		dc.w MtyAni_Warp3-MightyAniData
		dc.w MtyAni_Warp4-MightyAniData
		dc.w MtyAni_Stop-MightyAniData
		dc.w MtyAni_Float1-MightyAniData
		dc.w MtyAni_Float2-MightyAniData
		dc.w MtyAni_Spring-MightyAniData
		dc.w MtyAni_LZHang-MightyAniData
		dc.w MtyAni_Leap1-MightyAniData
		dc.w MtyAni_Leap2-MightyAniData
		dc.w MtyAni_Surf-MightyAniData
		dc.w MtyAni_Bubble-MightyAniData
		dc.w MtyAni_Death1-MightyAniData
		dc.w MtyAni_Drown-MightyAniData
		dc.w MtyAni_Death2-MightyAniData
		dc.w MtyAni_Shrink-MightyAniData
		dc.w MtyAni_Hurt-MightyAniData
		dc.w MtyAni_LZSlide-MightyAniData
		dc.w MtyAni_Blank-MightyAniData
		dc.w MtyAni_Float3-MightyAniData
		dc.w MtyAni_Float4-MightyAniData
		dc.w MtyAni_SpinDash-MightyAniData	;1F
		dc.w MtyAni_3rdRun-MightyAniData 	;20
		dc.w MtyAni_DashCharge-MightyAniData ;21
		dc.w MtyAni_Placeholder-MightyAniData ;22
		dc.w MtyAni_WallJump-MightyAniData ;23
		dc.w MtyAni_HammDrop-MightyAniData	;24
MtyAni_Walk:	dc.b $FF, 8, 9,	$A, $B,	6, 7, $FF
MtyAni_Run:	dc.b $FF, $1E, $1F, $20, $21, $FF, $FF,	$FF
MtyAni_Roll:	dc.b $FE, $2E, $2F, $30, $31, $32, $FF,	$FF
MtyAni_Roll2:	dc.b $FE, $2E, $2F, $32, $30, $31, $32,	$FF
MtyAni_Push:	dc.b $FD, $45, $46, $47, $48, $FF, $FF,	$FF
MtyAni_Wait:	dc.b $17, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 3, 2, 2, 2, 3, 4, $FE, 2, 0
MtyAni_Balance:	dc.b $1F, $3A, $3B, $FF
MtyAni_LookUp:	dc.b $3F, 5, $FF, 0
MtyAni_Duck:	dc.b $3F, $39, $FF, 0
MtyAni_Warp1:	dc.b $3F, $33, $FF, 0
MtyAni_Warp2:	dc.b $3F, $34, $FF, 0
MtyAni_Warp3:	dc.b $3F, $35, $FF, 0
MtyAni_Warp4:	dc.b $3F, $36, $FF, 0
MtyAni_Stop:	dc.b 7,	$37, $38, $FF
MtyAni_Float1:	dc.b 7,	$3C, $3F, $FF
MtyAni_Float2:	dc.b 7,	$3C, $3D, $53, $3E, $54, $FF, 0
MtyAni_Spring:	dc.b $2F, $40, $FD, 0
MtyAni_LZHang:	dc.b 4,	$41, $42, $FF
MtyAni_Leap1:	dc.b $F, $43, $43, $43,	$FE, 1
MtyAni_Leap2:	dc.b $F, $43, $44, $FE,	1, 0
MtyAni_Surf:	dc.b $3F, $49, $FF, 0
MtyAni_Bubble:	dc.b $B, $56, $56, $A, $B, $FD,	0, 0
MtyAni_Death1:	dc.b $20, $4B, $FF, 0
MtyAni_Drown:	dc.b $2F, $4C, $FF, 0
MtyAni_Death2:	dc.b 3,	$4D, $FF, 0
MtyAni_Shrink:	dc.b 3,	$4E, $4F, $50, $51, $52, 0, $FE, 1, 0
MtyAni_Hurt:	dc.b 3,	$55, $FF, 0
MtyAni_LZSlide:	dc.b 7, $55, $57, $FF
MtyAni_Blank:	dc.b $77, 0, $FD, 0
MtyAni_Float3:	dc.b 3,	$3C, $3D, $53, $3E, $54, $FF, 0
MtyAni_Float4:	dc.b 3,	$3C, $FD, 0
MtyAni_SpinDash:	dc.b 0, $58, $59, $58, $5A, $58, $5B, $58, $5C, $58, $5D, $FF
MtyAni_3rdRun:	dc.b $FF, $5E, $5F, $60, $61, $FF, $FF,	$FF
MtyAni_DashCharge:	dc.b 0,  8, 8, 8, 8, 8, 8, 8, 8
		dc.b	9, 9, 9, 9, $A, $A, $21, $21
		dc.b	$1E,  $1F,  $20,  $21, $1E,  $1F,  $20,  $21
		dc.b	$5E,  $5F,  $60,  $61, -2, 4, $FE
MtyAni_Placeholder:	dc.b 3, 0, $FF
MtyAni_WallJump:	dc.b 3,	$6E, $FF
MtyAni_HammDrop:	dc.b 3, $35, $FF
		even