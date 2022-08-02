	dc.w byte4_CBEA-Map_obj3A_Mty
		dc.w byte4_CC13-Map_obj3A_Mty
		dc.w byte4_CC32-Map_obj3A_Mty
		dc.w byte4_CC51-Map_obj3A_Mty
		dc.w byte4_CC75-Map_obj3A_Mty
		dc.w byte_CB47-Map_obj3A_Mty
		dc.w byte_CB26-Map_obj3A_Mty
		dc.w byte_CB31-Map_obj3A_Mty
		dc.w byte_CB3C-Map_obj3A_Mty
byte4_CBEA:	dc.b 9			; MIGHTY HAS
	dc.b $F8, $1, $0, $20, $C0
	dc.b $F8, $5, $0, $1C, $10
	dc.b $F8, $5, $0, $0, $20
	dc.b $F8, $5, $0, $3E, $30
	dc.b $F8, $5, $0, $2A, $B0
	dc.b $F8, $5, $0, $18, $C8
	dc.b $F8, $5, $0, $1C, $D8
	dc.b $F8, $5, $0, $4A, $F7
	dc.b $F8, $5, $0, $42, $E8
byte4_CC13:	dc.b 6			; PASSED
		dc.b $F8, 5, 0,	$36, $D0
		dc.b $F8, 5, 0,	0, $E0
		dc.b $F8, 5, 0,	$3E, $F0
		dc.b $F8, 5, 0,	$3E, 0
		dc.b $F8, 5, 0,	$10, $10
		dc.b $F8, 5, 0,	$C, $20
byte4_CC32:	dc.b 6			; SCORE
		dc.b $F8, $D, 1, $4A, $B0
		dc.b $F8, 1, 1,	$62, $D0
		dc.b $F8, 9, 1,	$64, $18
		dc.b $F8, $D, 1, $6A, $30
		dc.b $F7, 4, 0,	$6E, $CD
		dc.b $FF, 4, $18, $6E, $CD
byte4_CC51:	dc.b 7			; TIME BONUS
		dc.b $F8, $D, 1, $5A, $B0
		dc.b $F8, $D, 0, $66, $D9
		dc.b $F8, 1, 1,	$4A, $F9
		dc.b $F7, 4, 0,	$6E, $F6
		dc.b $FF, 4, $18, $6E, $F6
		dc.b $F8, $D, $FF, $F0,	$28
		dc.b $F8, 1, 1,	$70, $48
byte4_CC75:	dc.b 7			; RING BONUS
		dc.b $F8, $D, 1, $52, $B0
		dc.b $F8, $D, 0, $66, $D9
		dc.b $F8, 1, 1,	$4A, $F9
		dc.b $F7, 4, 0,	$6E, $F6
		dc.b $FF, 4, $18, $6E, $F6
		dc.b $F8, $D, $FF, $F8,	$28
		dc.b $F8, 1, 1,	$70, $48
		even