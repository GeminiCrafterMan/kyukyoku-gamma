		tst.b   ($FFFFFFF6).w ; if player flag set?
		bne.w	ReturnDK
        tst.b    ($FFFFFF89).w        ; was Stomp flag set?
        bne.s	ReturnDK                ; EB: was it set? if not, branch
        move.b    ($FFFFF603).w,d1    ; read controller
        andi.b    #$10,d1                ; is A pressed?
		beq.w	ReturnDK
        move.b    #1,($FFFFFF89).w    ; if not, set Stomp flag
		move.w	#$BC,d0			; spin release sound
		jsr	(PlaySound_Special).l	; play it!
		move.b	#$24,$1C(a0)	; use Sonic's DK animation
        btst	#0,$22(a0)        ; is sonic facing left?
        bne.s	DK_NoFlip        ; if not, branch
        move.w	#$850, $10(a0)            ; EB: set X speed
;		move.b  #5, ($FFFFFF89).w

DK_SetY:
;		subi 	#5, ($FFFFFF89).w
		move.w	#$500,$12(a0)
		rts

DK_NoFlip:
        move.w	#-$850, $10(a0)            ; EB: set X speed
;		move.b  #5, ($FFFFFF89).w
		bra.s	DK_SetY

ReturnDK:
		rts                             ; EB: return