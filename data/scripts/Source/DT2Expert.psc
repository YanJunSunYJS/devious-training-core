Scriptname DT2Expert extends Quest  

DT2Config Property DTConfig Auto
DT2Actor Property DTActor Auto
DT2Storage Property DTStorage Auto


bool function isZazWeapon(Form item)

	Weapon weap = item as Weapon
	
	if item.HasKeyword(DTConfig.zadWeapon)
		return true
	endif
	if weap.HasKeyword(DTConfig.zadWeapon)
		return true
	endif
	
	if (Game.GetModbyName("Shout Like a Virgin.esp") != 255)		
		if weap	== Game.GetFormFromFile(0x080C6892, "Shout Like a Virgin.esp") as Weapon
			return true
		endif
	endif


	return false
endfunction

String function levelToName(int level)

	if level == 0
		return "Untrained"
	endif
	
	if level == 1
		return "Untrained"
	endif
	
	if level == 2
		return "Beginner"
	endif
	
	if level == 3
		return "Basic training"
	endif
	
	if level == 4
		return "Trained"
	endif
	
	if level == 5
		return "Enjoyer"
	endif
	
	if level == 6
		return "Lover"
	endif
	

endfunction

bool function okBoots(int slot, bool checkItem=false)

	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[0])	
		return true
	else
	
		if DTConfig.bacPack == true
			if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.bac_hooves)	
				return true
			endif
		endif
	
		Armor thisArmor = DTActor.npcs_ref[slot].GetWornForm(DTConfig.slotMask[37]) as Armor
	
	;	if DTConfig.achievement_ponygirl_enabled == true && DTActor.achievementPonyGirl[slot] == true
	;		if thisArmor == DTStorage.DT_PonyGirlHooves
	;			return true
	;		endif
	;	endif
	
		if DTConfig.acceptBoots0 != none		
			if DTConfig.acceptBoots0==thisArmor
				return true
			endif		
		endif
		
		if checkItem == false
			return false
		endif
		
		if DTConfig.acceptBoots1 != none		
			if DTConfig.acceptBoots1==thisArmor
				return true
			endif		
		endif

		if DTConfig.acceptBoots2 != none		
			if DTConfig.acceptBoots2==thisArmor
				return true
			endif		
		endif

		if DTConfig.acceptBoots3 != none		
			if DTConfig.acceptBoots3==thisArmor
				return true
			endif		
		endif

		
	endif

	return false;



endfunction


bool function okGloves(int slot, bool checkItem=false)

		if DTConfig.bacPack == true
			if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.bac_hooves_hand)	
				return true
			endif
		endif
		
		if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[9])
			return true
		endif
		
		return false
		
endfunction

bool function okVaginalPlug(int slot, bool checkItem=false)

	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[10])
		return true
	endif
	
	return false
endfunction

bool function okAnalPlug(int slot, bool checkItem=false)

	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[11])
		return true
	endif
	
	return false
endfunction

bool function okBlindfold(int slot, bool checkItem=false)

	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[16])
		return true
	endif
	
	return false
endfunction

bool function okGag(int slot, bool checkItem=false)

	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[5])
		return true
	endif
	
	return false
endfunction

bool function okArmbinder(int slot, bool checkItem=false)

	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[19]) || DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[14]) || DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[15]) || DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[17]) || DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[18])
		return true
	endif
	
	return false
endfunction

bool function okCollar(int slot, bool checkItem=false)
	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[6])
		return true
	endif
	
	return false
endfunction


bool function okCorset(int slot, bool checkItem=false)
	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[1])
		return true
	endif
	
	return false
endfunction


bool function okHarness(int slot, bool checkItem=false)
	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[2])
		return true
	endif
	
	return false
endfunction

bool function okLegCuffs(int slot, bool checkItem=false)
	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[3])
		return true
	endif
	
	return false
endfunction

bool function okArmCuffs(int slot, bool checkItem=false)
	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[4])
		return true
	endif
	
	return false
endfunction

bool function okChastityBelt(int slot, bool checkItem=false)
	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[7])
		return true
	endif
	
	return false
endfunction

bool function okChastityBra(int slot, bool checkItem=false)
	if DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[8])
		return true
	endif
	
	return false
endfunction