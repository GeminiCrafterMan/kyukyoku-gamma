CheckLeftCeilingDist:
	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
	moveq	#0,d0
	move.b	x_radius(a0),d0
	ext.w	d0
	sub.w	d0,d2
	move.b	y_radius(a0),d0
	ext.w	d0
	sub.w	d0,d3
	eori.w	#$F,d3
	lea	(Primary_Angle).w,a4
	movea.w	#-$10,a3
	move.w	#$400,d6
	bsr.w	FindWall
	move.w	d1,-(sp)

	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
	moveq	#0,d0
	move.b	x_radius(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	y_radius(a0),d0
	ext.w	d0
	sub.w	d0,d3
	eori.w	#$F,d3
	lea	(Secondary_Angle).w,a4
	movea.w	#-$10,a3
	move.w	#$400,d6
	bsr.w	FindWall
	move.w	(sp)+,d0
	move.b	#$40,d2
	bra.w	loc_14DD0
; End of function CheckLeftCeilingDist

CheckRightCeilingDist:
	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
	moveq	#0,d0
	move.b	x_radius(a0),d0
	ext.w	d0
	sub.w	d0,d2
	move.b	y_radius(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	(Primary_Angle).w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	bsr.w	FindWall
	move.w	d1,-(sp)
	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
	moveq	#0,d0
	move.b	x_radius(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	y_radius(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	(Secondary_Angle).w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	bsr.w	FindWall
	move.w	(sp)+,d0
	move.b	#-$40,d2
	bra.w	loc_14DD0
; End of function CheckRightCeilingDist


; ---------------------------------------------------------------------------
; Subroutine to calculate how much space is empty above Sonic's/Tails' head
; d0 = input angle perpendicular to the spine
; d1 = output about how many pixels are overhead (up to some high enough amount)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; sub_1EC0A:
CalcRoomOverHead:
	move.l	#Primary_Collision,(Collision_addr).w
	cmpi.b	#$C,top_solid_bit(a0)
	beq.s	plusroomhead
	move.l	#Secondary_Collision,(Collision_addr).w
plusroomhead:
	move.b	lrb_solid_bit(a0),d5
	move.b	d0,(Primary_Angle).w
	move.b	d0,(Secondary_Angle).w
	addi.b	#$20,d0
	andi.b	#$C0,d0
	cmpi.b	#$40,d0
	beq.w	CheckLeftCeilingDist
	cmpi.b	#$80,d0
	beq.w	Sonic_CheckCeiling
	cmpi.b	#$C0,d0
	beq.w	CheckRightCeilingDist

; End of function CalcRoomOverHead

ChkFloorEdge:
	move.w	x_pos(a0),d3
; loc_1ED5A:
ChkFloorEdge_Part2:
	move.w	y_pos(a0),d2
	moveq	#0,d0
	move.b	y_radius(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.l	#Primary_Collision,(Collision_addr).w
	cmpi.b	#$C,top_solid_bit(a0)
	beq.s	flooredgepart2plus
	move.l	#Secondary_Collision,(Collision_addr).w
flooredgepart2plus:
	lea	(Primary_Angle).w,a4
	move.b	#0,(a4)
	movea.w	#$10,a3
	move.w	#0,d6
	move.b	top_solid_bit(a0),d5
	bsr.w	FindFloor
	move.b	(Primary_Angle).w,d3
	btst	#0,d3
	beq.s	flooredgepart2plus2
	move.b	#0,d3
flooredgepart2plus2:
	rts
; ===========================================================================
; Identical to ChkFloorEdge except that this uses a1 instead of a0
;loc_1EDA8:
ChkFloorEdge2:
	move.w	x_pos(a1),d3
	move.w	y_pos(a1),d2
	moveq	#0,d0
	move.b	y_radius(a1),d0
	ext.w	d0
	add.w	d0,d2
	move.l	#Primary_Collision,(Collision_addr).w
	cmpi.b	#$C,top_solid_bit(a1)
	beq.s	flooredge2plus
	move.l	#Secondary_Collision,(Collision_addr).w
flooredge2plus:
	lea	(Primary_Angle).w,a4
	move.b	#0,(a4)
	movea.w	#$10,a3
	move.w	#0,d6
	move.b	top_solid_bit(a1),d5
	bsr.w	FindFloor
	move.b	(Primary_Angle).w,d3
	btst	#0,d3
	beq.s	return_1EDF8
	move.b	#0,d3

return_1EDF8:
	rts

; ---------------------------------------------------------------------------
; Stores a distance to the nearest wall on the left of Sonic/Tails into d1
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Checks a 16x16 block to find solid walls. May check an additional
; 16x16 block up for walls.
; d5 = ($c,$d) or ($e,$f) - solidity type bit (L/R/B or top)
; returns relevant block ID in (a1)
; returns distance in d1
; returns angle in d3, or zero if angle was odd
; loc_1F05E: Sonic_HitWall:
CheckLeftWallDist:
	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
; loc_1F066:
CheckLeftWallDist_Part2:
	subi.w	#$A,d3
	eori.w	#$F,d3
	lea	(Primary_Angle).w,a4
	movea.w	#-$10,a3
	move.w	#$400,d6
	bsr.w	FindWall
	move.b	#$40,d2
	bra.w	loc_1ECFE
; End of function CheckLeftWallDist

CheckFloorDist_Part2:
	addi.w	#$A,d2
	lea	(Primary_Angle).w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	bsr.w	FindFloor
	move.b	#0,d2

; d2 what to use as angle if (Primary_Angle).w is odd
; returns angle in d3, or value in d2 if angle was odd
loc_1ECFE:
	move.b	(Primary_Angle).w,d3
	btst	#0,d3
	beq.s	@1ecfe
	move.b	d2,d3
@1ecfe:
	rts
; ---------------------------------------------------------------------------
; Stores a distance from Sonic/Tails to the nearest ceiling into d1
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1EF2E: Sonic_DontRunOnWalls: CheckCeilingDist:
Sonic_CheckCeiling:
	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
	moveq	#0,d0
	move.b	y_radius(a0),d0
	ext.w	d0
	sub.w	d0,d2
	eori.w	#$F,d2 ; flip position upside-down within the current 16x16 block?
	move.b	x_radius(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	(Primary_Angle).w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	bsr.w	FindFloor
	move.w	d1,-(sp)

	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
	moveq	#0,d0
	move.b	y_radius(a0),d0
	ext.w	d0
	sub.w	d0,d2
	eori.w	#$F,d2
	move.b	x_radius(a0),d0
	ext.w	d0
	sub.w	d0,d3
	lea	(Secondary_Angle).w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	bsr.w	FindFloor
	move.w	(sp)+,d0

	move.b	#$80,d2
	bra.w	loc_14DD0
; End of function Sonic_CheckCeiling

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Checks a 16x16 block to find solid ceiling. May check an additional
; 16x16 block up for ceilings.
; d2 = y_pos
; d3 = x_pos
; d5 = ($c,$d) or ($e,$f) - solidity type bit (L/R/B or top)
; returns relevant block ID in (a1)
; returns distance in d1
; returns angle in d3, or zero if angle was odd
; loc_1EF9E: CheckSlopeDist:
CheckCeilingDist_Part2:
	subi.w	#$A,d2
	eori.w	#$F,d2
	lea	(Primary_Angle).w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	bsr.w	FindFloor
	move.b	#$80,d2
	bra.w	loc_1ECFE
; End of function CheckCeilingDist
