Scriptname DT2Visual extends Quest  



DT2Actor Property DTActor Auto
DT2Config Property DTConfig Auto

Function addEffect(int slot, ImageSpaceModifier effect,float str = 1.0)
	if DTConfig.effect_shader_enabled == true
		if DTActor.npcs_ref[slot] == DTConfig.playerRef
			effect.Apply(str)
		endIf
	endif

endFunction

Function cameraShake(int slot,float str = 1.0,float dur = 0.5)
	if DTConfig.effect_shader_enabled == true
		if DTActor.npcs_ref[slot] == DTConfig.playerRef
			Game.ShakeCamera(None,str,dur)
		endIf
	endif
endFunction

