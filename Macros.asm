SetVdpRegister  MACRO
		MOVE.W  #$8000|(\1<<8)|\2,VCTRL; check out the SEGA manual
		ENDM
SetVdpRegisterCode	  MACRO
		and.w   #$00ff,\2			  ; Mask off high part
		or.w	#$8000|(\1<<8),\2
		move.w  \2,VCTRL
		ENDM
AutoIncrement   MACRO
		SetVdpRegister  15,\1
		ENDM
VramWrtAddr  MACRO
		MOVE.L  #$40000000|((\1&$3fff)<<16)|((\1>>14)&3),\2
		ENDM
VSramWrtAddr  MACRO
		MOVE.L  #$40000010|((\1&$3fff)<<16)|((\1>>14)&3),\2
		ENDM
CramWrtAddr  MACRO
		MOVE.L  #$C0000000|((\1&$3fff)<<16)|((\1>>14)&3),\2
		ENDM
CalcVramWrtAddrCode MACRO
		move.w  \1,\2		  ; Copy for lower 14 bits
		and.l   #$3fff,\2	  ; mask
		lsl.l   #8,\2
		lsl.l   #8,\2		  ; Shift up
		or.l	#$40000000,\2  ; Set bit that tells VDP it's a VRAM WRITE
		lsr.l   #8,\1
		lsr.l   #6,\1		  ; Shift down 14 bits
		and.l   #$3,\1
		or.l	\1,\2		  ; and combine
		ENDM

align macro
	cnop 0,\1
	endm