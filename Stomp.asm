		cmpi.b	 #$03, ($FFFFFFF6).w
		bne.w	Stomp_rts
		btst	#4,($FFFFF605).w ; is button B pressed?
        beq.w    Stomp_rts                ; if not, branch
        tst.b    ($FFFFFF89).w        ; was Stomp flag set?
        bne.w    Stomp_rts                ; if yes, branch
        move.b    #1,($FFFFFF89).w    ; if not, set Stomp flag
        bclr    #4,$22(a0)            ; clear double jump flag

; ---------------------------------------------------------------------------
; Stomp vars
; ---------------------------------------------------------------------------

Stomp_Stomp:
        move.w    #$A00,d0        ; set normal Stomp speed

Stomp_Move:
        move.b    ($FFFFF604).w,d2
        cmpi.b    #$40,d2            
        bne.s    Stomp    
        rts
Stomp:
        cmpi.b    #$42,d2            ; are buttons a,down pressed
        beq.w    downstomp        ; If true branch 
;--------------------------------------------------------------------------------
downstomp:
        move.b    #$24,$1C(a0)    ; use stomp animation
        clr.w    $10(a0)            ;clr
        move.w    d0,$12(a0)        ;d0 to Y
		move.w	#$BC,d0			; spin release sound
		jsr	(PlaySound_Special).l	; play it!

Stomp_rts:
        rts                        ; return