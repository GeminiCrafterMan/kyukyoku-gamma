		cmpi.b 	#$01, ($FFFFFFF6).w ; if player flag set?
		beq.s	@continue
		rts
@continue:
        moveq	#0,d0
        move.b	$24(a0),d0
        move.w	Obj_ShadowProjectile_Index(pc,d0.w),d1
        jmp		Obj_ShadowProjectile_Index(pc,d1.w)
; ===========================================================================
Obj_ShadowProjectile_Index:
        dc.w Obj_ShadowProjectile_Init-Obj_ShadowProjectile_Index
		dc.w Obj_ShadowProjectile_Main-Obj_ShadowProjectile_Index
; ===========================================================================
Obj_ShadowProjectile_Init:
        addq.b    #2,$24(a0)        ; go to the next routine
        move.l    #Map_Obj02,4(a0)    ; set mappings
        move.w    #$1799,2(a0)        ; set VRAM tile
        move.b    #4,1(a0)        ; set render flags
        move.b    #3,$18(a0)        ; set priority
        move.b    #8,$19(a0)        ; set horizontal radius
        move.b    #8,$16(a0)        ; set horizontal radius
    btst    #0,($FFFFD022).w    ; which way is Shadow facing?
    bne.s    @blehg
    bclr    #0,1(a0)
    bra.s    Obj_ShadowProjectile_Main
@blehg:
    bset    #0,1(a0)    
; ===========================================================================
Obj_ShadowProjectile_Main:
        move.b  $26(a1),d0  ; get Shadow's angle (?)
 
continueSpear:
        jsr     (ChkObjOnScreen).l ; is the projectile off-screen?
        bne.s   @delete            ; if so, branch
        jsr     ObjHitFloor
        tst.w   d1
        ble.s   @delete    
        jsr     (TouchResponse).l
        jsr     (SpeedToPos).l
        jmp     (DisplaySprite).l
 
@delete:
        jmp     (DeleteObject).l
; ===========================================================================
; ---------------------------------------------------------------------------
; Art - Chaos Spear
; ---------------------------------------------------------------------------
Nem_ShadProj:	incbin	artnem\chaos_spear.bin ; Sonic's bullets!
		even
; ---------------------------------------------------------------------------
; Mappings - Chaos Spear
; ---------------------------------------------------------------------------
Map_Obj02:
	include	"_maps\Chaos_Spear.asm"