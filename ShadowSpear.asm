		cmpi.b	 #$01, ($FFFFFFF6).w
		bne.s	@end
        btst    #4,($FFFFF605).w     ; is button B pressed?
        beq.s   @end              ; if not, branch
        jsr	    SingleObjLoad
        move.b    #2,0(a1)            ; load missile object
		move.w	#$B8,d0
		jsr	(PlaySound_Special).l
        move.w    8(a0),8(a1)
        move.w    $C(a0),$C(a1)
        move.w    #$A00,$10(a1)        ; move the projectile to the right
        btst    #0,$22(a0)           ; is Sonic actually facing the left?
        beq.s    @end            ; if not, branch
        neg.w    $10(a1)            ; negate the projectile's velocity, moving it to the left

@end:
    rts