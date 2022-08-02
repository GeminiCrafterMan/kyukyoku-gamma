	tst.b	($FFFFFFF6).w ; is the player flag set?
	beq.w	AR_Valid
	rts

AR_Valid:
    btst    #1,$22(a0)   ; is Sonic in the air?
    beq.s   ARnope   ; if not, branch
    move.b  ($FFFFF602).w,d0
	andi.b	#$60,d0			; pressing A/B/C ?
    beq.s   ARnope   ; if not, branch
    move.b  #$22,$1C(a0)   ; use "rolling"   animation
	bset   #2,$22(a0)   ; force Sonic to roll
    move.b    #1,($FFFFFFF9).w

ARnope:
    move.b     #0,($FFFFFFF9).w
    rts


; End of function Sonic_AirRoll