Scriptname DT2Achievement extends Quest  

DT2Actor Property DTActor Auto
DT2Config Property DTConfig Auto
DT2Expert Property DTExpert Auto
DT2Storage Property DTStorage Auto
DT2Tools Property DTTools Auto
DT2Sound Property DTSound Auto

function addAchievementItems(int slot)
	return
	equipPonygirl(slot)
	
	if isBlindSlutConditionLite(slot) == true
		if DTActor.npcs_ref[slot].hasSpell(DTStorage.DT_Achievement_BlindSlut)==false
			DTActor.npcs_ref[slot].addSpell(DTStorage.DT_Achievement_BlindSlut,false)
		endif	
	endif
endFunction

function unequipAchievementItems(int slot)
	unequipPonygirl(slot)
endFunction



function resetAllWithAchievementRelated(int slot)
	
	DTActor.npcs_ref[slot].RemoveShout(DTStorage.DT_TransformToPonyShaut)
	resetAchievementItems(slot)
	
endFunction

function resetAchievementItems(int slot)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlTail)
	DTActor.npcs_ref[slot].RemoveItem(DTStorage.DT_PonyGirlTail, 1)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_achievement_ponygirl)
	DTActor.npcs_ref[slot].RemoveItem(DTStorage.DT_achievement_ponygirl, 1)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlEars)
	DTActor.npcs_ref[slot].RemoveItem(DTStorage.DT_PonyGirlEars, 1)	
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlGag)
	DTActor.npcs_ref[slot].RemoveItem(DTStorage.DT_PonyGirlGag, 1)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlGloves)
	DTActor.npcs_ref[slot].RemoveItem(DTStorage.DT_PonyGirlGloves, 1)	
	
endFunction

bool function isPonyGirlCondition(int slot)


	return false
	if DTConfig.playerSlot == slot && DTConfig.achievement_ponygirl_enabled == true
		if (DTExpert.okBoots(slot) || DTActor.npcs_ref[slot].GetWornForm(DTConfig.slotMask[37]) as Armor == DTStorage.DT_PonyGirlHooves) && DTExpert.okArmbinder(slot) && DTActor.npcs_armbinder[slot] == 100 && DTActor.npcs_boots[slot] == 100 && DTConfig.training_speed_boots > 0 && DTConfig.training_speed_armbinder > 0
			return true
		endIf
	endif

	return false
	
endFunction

bool function isBlindSlutCondition(int slot)
	return false
	if DTConfig.playerSlot == slot && DTConfig.achievement_blindslut_enabled == true && DTExpert.okBlindfold(slot)
		if DTActor.npcs_blindfold[slot] == 100 
			return true
		endif
	endif
	return false
endFunction

bool function isPonyGirlConditionLite(int slot)
	return false
	if DTConfig.achievement_ponygirl_enabled == false 
		return false
	endif

	if DTExpert.okBlindfold(slot) == false
		return false
	endif	
	

	return DTActor.achievementPonyGirl[slot]

	if DTConfig.playerSlot == slot && DTConfig.achievement_ponygirl_enabled == true
		if DTActor.npcs_armbinder[slot] == 100 && DTActor.npcs_boots[slot] == 100 && DTConfig.training_speed_boots > 0 && DTConfig.training_speed_armbinder > 0
			return true
		endIf
	endif

	return false


endFunction

bool function isBlindSlutConditionLite(int slot)
	return false
	if DTConfig.achievement_blindslut_enabled == false && DTExpert.okBlindfold(slot)==false
		return false
	endif
	
	return DTActor.achievementBlindSlut[slot]
		
endFunction


function tryPonyGirl(int slot)
	return
	if DTActor.achievementPonyGirl[slot] == true || DTConfig.playerSlot != slot 
		return
	endIf
	
	if DTActor.achievementPonyGirl[slot] == false && isPonyGirlCondition(slot) == true
		DTActor.achievementPonyGirl[slot] = true
		;DTActor.npcs_ref[slot].AddItem(DTStorage.DT_achievement_ponygirl)
		;DTActor.npcs_ref[slot].AddItem(DTStorage.DT_PonyGirlTail)
		;DTActor.npcs_ref[slot].AddItem(DTStorage.DT_PonyGirlEars)
		addAchievementItems(slot)
		DTSound.addSoundToActor(slot, "pony", 0)
		debug.messagebox("You are now a Pony Girl!\n\nAfter long training you are become a Pony Girl!")
			
		if DTActor.npcs_ref[slot]==DTConfig.playerRef
			DTActor.npcs_ref[slot].AddShout(DTStorage.DT_TransformToPonyShaut)
			Game.TeachWord(DTStorage.DT_TransformPonyWord1)
			Game.TeachWord(DTStorage.DT_TransformPonyWord2)
			Game.TeachWord(DTStorage.DT_TransformPonyWord3)
		endif
		
		;DTConfig.DT_ArchedFeet = DTStorage.DT_PonyGirlHooves
	endif
	
	
endFunction


function tryBlindSlut(int slot)

	return

	if DTActor.achievementBlindSlut[slot] == true || DTConfig.playerSlot != slot 
		return
	endIf
	if DTActor.achievementBlindSlut[slot] == false && isBlindSlutCondition(slot) == true
		DTActor.achievementBlindSlut[slot] = true
		debug.messagebox("After long term Blindfold training You hear heartbits of your enemies!")
		DTActor.npcs_ref[slot].addSpell(DTStorage.DT_Achievement_BlindSlut,false)
		
		DTActor.npcs_ref[slot].AddShout(DTStorage.DT_TransformToBlindShaut)
		Game.TeachWord(DTStorage.DT_TransformBlindWord1)
		Game.TeachWord(DTStorage.DT_TransformBlindWord2)
		Game.TeachWord(DTStorage.DT_TransformBlindWord3)
		
	endif
endFunction


function unequipPonygirl(int slot)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlTail)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_achievement_ponygirl)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlEars)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlGag)
	DTActor.npcs_ref[slot].UnequipItem(DTStorage.DT_PonyGirlGloves)
endFunction

function equipPonygirl(int slot)

	if DTConfig.achievement_ponygirl_equip_enabled == true
		
		int slotMod = 1
		if DTConfig.achievement_ponygirl_equip_force == true
			slotMod = 0
		endIf
		
		bool addItems = false
		
		if DTConfig.achievement_ponygirl_equip_tied == true && isPonyGirlCondition(slot) == true
			addItems = true
		endIf
		
		if DTConfig.achievement_ponygirl_equip_always == true && isPonyGirlConditionLite(slot) == true
			addItems = true
		endIf
		
		if addItems == true
		
			DTTools.equipItem(DTStorage.DT_achievement_ponygirl, DTActor.npcs_ref[slot], 35 * slotMod)			
			DTTools.equipItem(DTStorage.DT_PonyGirlTail, DTActor.npcs_ref[slot], 40 * slotMod)
			DTTools.equipItem(DTStorage.DT_PonyGirlEars, DTActor.npcs_ref[slot], 43 * slotMod)			
			DTTools.equipItem(DTStorage.DT_PonyGirlGag, DTActor.npcs_ref[slot], 44 * slotMod)
			;armbinder
			if  DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[15])==false
				DTTools.equipItem(DTStorage.DT_PonyGirlGloves, DTActor.npcs_ref[slot], 33 * slotMod)
			else
				DTActor.npcs_ref[slot].RemoveItem(DTStorage.DT_PonyGirlGloves, 1)
			endif
			
			
			
		else
			resetAchievementItems(slot)
		endIf
	else
		resetAchievementItems(slot)
	endIf
endFunction