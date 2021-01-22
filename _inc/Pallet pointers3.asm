; ---------------------------------------------------------------------------
; Pallet pointers 3
; ---------------------------------------------------------------------------
	dc.l Pal_SegaBG		; pallet address
	dc.w $FB00		; RAM address
	dc.w $1F		; (pallet length / 2) - 1
	dc.l Pal_Title
	dc.w $FB00
	dc.w $1F
	dc.l Pal_LevelSel
	dc.w $FB00
	dc.w $1F
	dc.l Pal_Sonic
	dc.w $FB00
	dc.w 7
	dc.l Pal_GHZ3
	dc.w $FB20
	dc.w $17
	dc.l Pal_LZ3
	dc.w $FB20
	dc.w $17
	dc.l Pal_MZ3
	dc.w $FB20
	dc.w $17
	dc.l Pal_SLZ3
	dc.w $FB20
	dc.w $17
	dc.l Pal_SYZ3
	dc.w $FB20
	dc.w $17
	dc.l Pal_SBZ1
	dc.w $FB20
	dc.w $17
	dc.l Pal_Special
	dc.w $FB00
	dc.w $1F
	dc.l Pal_LZWater3
	dc.w $FB00
	dc.w $1F
	dc.l Pal_SBZ3
	dc.w $FB20
	dc.w $17
	dc.l Pal_SBZ3Water
	dc.w $FB00
	dc.w $1F
	dc.l Pal_SBZ2
	dc.w $FB20
	dc.w $17
	dc.l Pal_LZSonWater3
	dc.w $FB00
	dc.w 7
	dc.l Pal_SBZ3SonWat
	dc.w $FB00
	dc.w 7
	dc.l Pal_SpeResult
	dc.w $FB00
	dc.w $1F
	dc.l Pal_SpeContinue
	dc.w $FB00
	dc.w $F
	dc.l Pal_Ending
	dc.w $FB00
	dc.w $1F
	dc.l Menu_Palette; pallet address
	dc.w $FB00	; RAM address
	dc.w $1F	; (pallet length / 2) - 1
	dc.l Pal_Shadow
	dc.w $FB00
	dc.w 7
	dc.l Pal_Mighty
	dc.w $FB00
	dc.w 7
	dc.l Pal_SpecialSh
	dc.w $FB00
	dc.w $1F
	dc.l Pal_SpecialM
	dc.w $FB00
	dc.w $1F