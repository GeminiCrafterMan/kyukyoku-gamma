; ---------------------------------------------------------------------------
; Animation script - "PRESS START" on the title screen
; ---------------------------------------------------------------------------
		dc.w Sonic_St-Ani_obj0F
		dc.w Shadow_St-Ani_obj0F
		dc.w Metal_St-Ani_obj0F
		dc.w Mighty_St-Ani_obj0F
		dc.w Knux_St-Ani_obj0F
Sonic_St:	dc.b $1F, 4, $FF
Shadow_St:	dc.b $1F, 5, $FF
Metal_St:	dc.b $1F, 6, $FF
Mighty_St:	dc.b $1F, 7, $FF
Knux_St:	dc.b $1F, 8, $FF
		even