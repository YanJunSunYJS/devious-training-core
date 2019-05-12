Scriptname DT2Sound extends Quest  

DT2Actor Property DTActor Auto
Zadlibs property libs auto
DT2Config Property DTConfig Auto
DT2Achievement Property DTAchievement Auto

bool function isGaged(actor acActor)
	if acActor.WornHasKeyword(libs.zad_DeviousGag)
		return true
	endif
	return false
endFunction



function addSoundToActor(int slot, string effect, int level = 0, float volume = 1.0)

	volume = calcVolume(slot,volume)

	if DTConfig.effect_sound_enabled == 0
		return
	endif
	if volume==0
		return
	endif
	if effect == "breath"
		if isGaged(DTActor.npcs_ref[slot])
			if DTConfig.fem_breath_gaged.length > level
				playSound(slot,DTConfig.fem_breath_gaged[level],volume)
			endif
		else
			if DTConfig.fem_breath_normal.length > level
				playSound(slot,DTConfig.fem_breath_normal[level],volume)
			endif
		endif
	
	endIf	
	if effect == "gasp"
		if isGaged(DTActor.npcs_ref[slot])
			if DTConfig.fem_gasp_normal.length > level
				playSound(slot,DTConfig.fem_gasp_normal[level],volume)
			endif
		else
			if DTConfig.fem_gasp_normal.length > level
				playSound(slot,DTConfig.fem_gasp_normal[level],volume)
			endif
		endif
	
	endIf	
	if effect == "pain"
		if isGaged(DTActor.npcs_ref[slot])
			if DTConfig.fem_pain_gaged.length > level
				playSound(slot,DTConfig.fem_pain_gaged[level],volume)
			endif
		else
			if DTConfig.fem_pain_normal.length > level
				playSound(slot,DTConfig.fem_pain_normal[level],volume)
			endif
		endif
	
	endIf	
	
	if effect == "moan"
		if isGaged(DTActor.npcs_ref[slot])
			if DTConfig.fem_moan_gaged.length > level
				playSound(slot,DTConfig.fem_moan_gaged[level],volume)
			else
				playSound(slot,DTConfig.fem_moan_gaged[0],volume)
			endif
		else
			if DTConfig.fem_moan_normal.length > level
				playSound(slot,DTConfig.fem_moan_normal[level],volume)
			else
				playSound(slot,DTConfig.fem_moan_normal[0],volume)
			endif
		endif
	
	endIf	
	
	if effect == "chain"
		
			playSound(slot,DTConfig.sound_chain[level],volume)
		
	endIf		
	if effect == "chastity"
		
			playSound(slot,DTConfig.chastity_normal[level],volume)
		
	endIf	
	
	if effect == "pony"	
		return
		bool playSound = false
	
		if DTAchievement.isPonyGirlCondition(slot) && DTConfig.achievement_ponygirl_sound_tied == true
			playSound = true
		endif
		
		if DTAchievement.isPonyGirlConditionLite(slot) && DTConfig.achievement_ponygirl_sound_always == true
			playSound = true
		endif
		
		if playSound == true
			playSound(slot,DTConfig.fem_pony[level],volume)
		endif
	endIf
endFunction


;import MiscUtil

float function calcVolume(int slot,float initVolume)

	;player will get always x1.0
	if DTActor.npcs_ref[slot]==DTConfig.playerRef
		return initVolume
	endIf

	float scanerRange = DTConfig.scanerRange / 2
	
	;so far...
	if DTConfig.playerRef.GetDistance(DTActor.npcs_ref[slot]) > scanerRange
		return 0
	endIf
	
	; 1 = scanerRange
	; x = currentDist
	
	float returnVolume = 1.0 - (1.0 * DTConfig.playerRef.GetDistance(DTActor.npcs_ref[slot]) / scanerRange)
	
	return initVolume* returnVolume
	
	
	
endFunction












function playSound(int slot, sound effect, float volume = 1.0)

	int lastPointer = DTActor.npcs_sound_pointer[slot]
	lastPointer = lastPointer + 1
	if lastPointer > 7
		lastPointer = 1
	endif
	
	DTActor.npcs_sound_pointer[slot] = lastPointer
	
	
	if lastPointer == 1
		DTActor.npcs_sound1[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npcs_sound1[slot],volume)
	endif
	
	if lastPointer == 2
		DTActor.npcs_sound2[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npcs_sound2[slot],volume)
	endif
	
	if lastPointer == 3
		DTActor.npcs_sound3[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npcs_sound3[slot],volume)
	endif

	if lastPointer == 4
		DTActor.npcs_sound4[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npcs_sound4[slot],volume)
	endif
	
	if lastPointer == 5
		DTActor.npcs_sound5[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npcs_sound5[slot],volume)
	endif
	
	if lastPointer == 6
		DTActor.npcs_sound6[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npcs_sound6[slot],volume)
	endif

	if lastPointer == 7
		DTActor.npcs_sound7[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npcs_sound7[slot],volume)
	endif	
endfunction