; How to install this:

; Go to "Cred_ClrPallet:"
; Replace:
; "		move.b	#$8A,($FFFFD080).w ; load credits object"
; with:
; "		jsr	Credits_MapLoad"
; Now, go to the "end of ROM", and put this above it:

;		include  EniCredProg.asm
;		even
;EniCred_0:	incbin	credeni\cred0.bin	; Credits #0 mappings
;		even
;EniCred_1:	incbin	credeni\cred1.bin	; Credits #1 mappings
;		even
;EniCred_2:	incbin	credeni\cred2.bin	; Credits #2 mappings
;		even
;EniCred_3:	incbin	credeni\cred3.bin	; Credits #3 mappings
;		even
;EniCred_4:	incbin	credeni\cred4.bin	; Credits #4 mappings
;		even
;EniCred_5:	incbin	credeni\cred5.bin	; Credits #5 mappings
;		even
;EniCred_6:	incbin	credeni\cred6.bin	; Credits #6 mappings
;		even
;EniCred_7:	incbin	credeni\cred7.bin	; Credits #7 mappings
;		even
;EniCred_8:	incbin	credeni\cred8.bin	; Credits #8 mappings
;		even
;EniCred_9:	incbin	credeni\cred9.bin	; Credits #9 mappings
;		even

; Then uncomment it

Credits_MapLoad:
		lea	($FF0000).l,a1
		cmpi.w	#0,($FFFFFFF4).w ; is credit id = 0?
		bne.s	EniCred1	 ; if not, branch
		lea	(EniCred_0).l,a0 ; load credits enigma mappings
EniCred1:
		cmpi.w	#1,($FFFFFFF4).w ; is credit id = 1?
		bne.s	EniCred2	 ; if not, branch
		lea	(EniCred_1).l,a0 ; load credits enigma mappings
EniCred2:
		cmpi.w	#2,($FFFFFFF4).w ; is credit id = 2?
		bne.s	EniCred3	 ; if not, branch
		lea	(EniCred_2).l,a0 ; load credits enigma mappings
EniCred3:
		cmpi.w	#3,($FFFFFFF4).w ; is credit id = 3?
		bne.s	EniCred4	 ; if not, branch
		lea	(EniCred_3).l,a0 ; load credits enigma mappings
EniCred4:
		cmpi.w	#4,($FFFFFFF4).w ; is credit id = 4?
		bne.s	EniCred5	 ; if not, branch
		lea	(EniCred_4).l,a0 ; load credits enigma mappings
EniCred5:
		cmpi.w	#5,($FFFFFFF4).w ; is credit id = 5?
		bne.s	EniCred6	 ; if not, branch
		lea	(EniCred_5).l,a0 ; load credits enigma mappings
EniCred6:
		cmpi.w	#6,($FFFFFFF4).w ; is credit id = 6?
		bne.s	EniCred7	 ; if not, branch
		lea	(EniCred_6).l,a0 ; load credits enigma mappings
EniCred7:
		cmpi.w	#7,($FFFFFFF4).w ; is credit id = 7?
		bne.s	EniCred8	 ; if not, branch
		lea	(EniCred_7).l,a0 ; load credits enigma mappings
EniCred8:
		cmpi.w	#8,($FFFFFFF4).w ; is credit id = 8?
		bne.s	EniCred9	 ; if not, branch
		lea	(EniCred_8).l,a0 ; load credits enigma mappings
EniCred9:
		cmpi.w	#9,($FFFFFFF4).w ; is credit id = 9?
		bne.s	EniCredLoad	 ; if not, branch
		lea	(EniCred_9).l,a0 ; load credits enigma mappings
EniCredLoad:
		move.w	#0,d0
		jsr	EniDec
		lea	($FF0000).l,a1
		move.l	#$40000003,d0
		moveq	#39,d1		 ; X size = 40
		moveq	#27,d2		 ; Y size = 28
		jsr	ShowVDPGraphics
EniCredEnd:
		rts