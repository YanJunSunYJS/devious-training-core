Scriptname DT2Actor extends Quest  

DT2Config Property DTConfig Auto
DT2Storage Property DTStorage Auto
DT2Tools Property DTTools Auto
DT2Descriptor Property DTDescriptor Auto
DT2Achievement Property DTAchievement Auto

DT2Body Property DTBody Auto

Actor[] Property npcs_ref Auto

Float[] Property npcs_corset Auto
Float[] Property npcs_boots Auto
Float[] Property npcs_harness Auto
Float[] Property npcs_legcuffs Auto
Float[] Property npcs_armcuffs Auto
Float[] Property npcs_gag Auto
Float[] Property npcs_collar Auto

Float[] Property npcs_chastityBelt Auto
Float[] Property npcs_chastityBra Auto
Float[] Property npcs_vaginalPlug Auto
Float[] Property npcs_analPlug Auto
Float[] Property npcs_vaginalPiercing Auto
Float[] Property npcs_nipplePiercing Auto
Float[] Property npcs_gloves Auto
Float[] Property npcs_armbinder Auto
Float[] Property npcs_blindfold Auto

;additional stuff

Int[] Property npcs_sound_pointer Auto
Int[] Property npcs_sound1 Auto
Int[] Property npcs_sound2 Auto
Int[] Property npcs_sound3 Auto
Int[] Property npcs_sound4 Auto
Int[] Property npcs_sound5 Auto
Int[] Property npcs_sound6 Auto
Int[] Property npcs_sound7 Auto

Int[] Property timeout Auto
bool[] Property toremove Auto
bool[] Property npcs_isCrowl Auto
bool[] Property npcs_isBusy Auto

Int[] Property countWalk Auto
Int[] Property countSprint Auto
Int[] Property countRun Auto
Int[] Property countJump Auto
Int[] Property countAttack Auto
Int[] Property countSwim Auto
Int[] Property countHorse Auto
Int[] Property countSneak Auto
Int[] Property countSpeak Auto
Int[] Property countSexOral Auto
Int[] Property countSexAnal Auto
Int[] Property countSexVaginal Auto
Int[] Property countHit Auto

Int[] Property orgasmCount Auto
Float[] Property bodyPointer Auto
Float[] Property orgWeight Auto

Bool[] Property achievementPonyGirl Auto
Bool[] Property achievementBlindSlut Auto

string[] Property lastKnowTatsSetGroup1 Auto

Int[] Property npcs_daysInBondage Auto
Int[] Property npcs_daysInBondageLastKnow Auto

Int[] Property count_steps Auto
Int[] Property count_dmg Auto
Int[] Property count_dmgZad Auto
Int[] Property count_weight Auto
Int[] Property count_orgasm Auto
Int[] Property count_days Auto 

int function getArrayCount()
	return ( npcs_ref.length - 1 )
endFunction

int function getActorCount()
	int count = 0
	int i = 0
	while i < getArrayCount()
		if npcs_ref[i] != None
			count+=1
	 	endif
		i+=1
	endWhile
	
	return count

endFunction

int function isRegistered(Actor acAktor)
	int i = 0
    while i < getArrayCount()
		if acAktor == npcs_ref[i]
			return i
		endif
		i+=1
	endWhile
	return -1
endFunction

int function getFirstFreeSlot()
	int i = 0
    while i < getArrayCount()
	  if npcs_ref[i] == None
	    return i
	  endif
	i+=1
	endWhile
	return -1
endFunction

function unregisterActor(int slot)
	resetAll(slot)
	resetAchievementItems(slot)	
	int handle = ModEvent.Create("DT_ActorUnRegister") 
	ModEvent.PushForm(handle, npcs_ref[slot] as Form) 
	ModEvent.PushInt(handle,slot)
	ModEvent.Send(handle)
	
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Boots)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Corset)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Harness)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Legscuffs)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Armscuffs)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Gag)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Collar)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Chastitybelt)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Chastitybra)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Gloves)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Armbinderyoke)
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_Blindfold)		
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_AnalPlug)		
	npcs_ref[slot].RemoveFromFaction(DTConfig.DT_VaginalPlug)		
	
	
	npcs_ref[slot] = None
endFunction

int function registerActor(Actor acAktor)
	
	int registerId = isRegistered(acAktor)
		
	if registerId>=0    		
		return registerId
	endif
      
	int i = getFirstFreeSlot()
    
	if i >=0
		if acAktor == DTConfig.playerRef
			DTConfig.playerSlot = i
		endif
		
		int handle = ModEvent.Create("DT_ActorRegister") 
		ModEvent.PushForm(handle, acAktor as Form) 
		ModEvent.PushInt(handle,i)
		ModEvent.Send(handle)
		
		npcs_ref[i] = acAktor
		npcs_corset[i] = 0
		npcs_boots[i] = 0
		npcs_harness[i] = 0
		npcs_legcuffs[i] = 0
		npcs_armcuffs[i] = 0
		npcs_gag[i] = 0
		npcs_collar[i] = 0
		npcs_chastityBelt[i] = 0
		npcs_chastityBra[i] = 0
		npcs_analPlug[i] = 0
		npcs_vaginalPlug[i] = 0
		npcs_vaginalPiercing[i] = 0
		npcs_nipplePiercing[i] = 0		
		npcs_gloves[i] = 0
		npcs_armbinder[i] = 0
		npcs_blindfold[i] = 0
		timeout[i] = 0
		toremove[i] = false
		npcs_isCrowl[i] = false
		orgasmCount[i] = 0
		bodyPointer[i] = 50
		orgWeight[i] = acAktor.GetWeight()
		achievementPonyGirl[i] = false
		achievementBlindSlut[i] = false
		lastKnowTatsSetGroup1[i] = "xxxx"
		npcs_daysInBondage[i] = 0
		npcs_daysInBondageLastKnow[i] = -1
		acAktor.addSpell(DTStorage.DTWatchdogMain,false)
		acAktor.addSpell(DTStorage.DTWatchdogEffects,false)

		count_steps[i] = 0
		count_weight[i] = 0
		count_days[i] = 0
		count_dmg[i] = 0
		count_dmgZad[i] = 0
		count_orgasm[i] = 0
		
			npcs_ref[i].AddToFaction(DTConfig.DT_Boots)
			npcs_ref[i].AddToFaction(DTConfig.DT_Corset)
			npcs_ref[i].AddToFaction(DTConfig.DT_Harness)
			npcs_ref[i].AddToFaction(DTConfig.DT_Legscuffs)
			npcs_ref[i].AddToFaction(DTConfig.DT_Armscuffs)
			npcs_ref[i].AddToFaction(DTConfig.DT_Gag)
			npcs_ref[i].AddToFaction(DTConfig.DT_Collar)
			npcs_ref[i].AddToFaction(DTConfig.DT_Chastitybelt)
			npcs_ref[i].AddToFaction(DTConfig.DT_Chastitybra)
			npcs_ref[i].AddToFaction(DTConfig.DT_Gloves)
			npcs_ref[i].AddToFaction(DTConfig.DT_Armbinderyoke)
			npcs_ref[i].AddToFaction(DTConfig.DT_Blindfold)		
			npcs_ref[i].AddToFaction(DTConfig.DT_VaginalPlug)		
			npcs_ref[i].AddToFaction(DTConfig.DT_AnalPlug)		
				
	  return i
	endif
			
	return -1
	
endFunction

function updateFactions(int slot)
	
	if DTConfig.training_speed_boots > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Boots, DTTools.getCurrentTrainingStage(slot, npcs_boots, DTConfig.boots_min, DTConfig.boots_max))
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Boots, -1)
	endif
		
	if DTConfig.training_speed_corset > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Corset, DTTools.getCurrentTrainingStage(slot, npcs_corset, DTConfig.corset_min, DTConfig.corset_max))
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Corset, -1)
	endif
	
	if DTConfig.training_speed_harness > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Harness, DTTools.getCurrentTrainingStage(slot, npcs_harness, DTConfig.harness_min, DTConfig.harness_max))
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Harness, -1)
	endif
	
	if DTConfig.training_speed_legcuffs > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Legscuffs, DTTools.getCurrentTrainingStage(slot, npcs_legcuffs, DTConfig.legcuffs_min, DTConfig.legcuffs_max))
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Legscuffs, -1)
	endif
	
	if DTConfig.training_speed_armcuffs > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Armscuffs, DTTools.getCurrentTrainingStage(slot, npcs_armcuffs, DTConfig.armcuffs_min, DTConfig.armcuffs_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Armscuffs, -1)	
	endif
	
	if DTConfig.training_speed_gag > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Gag, DTTools.getCurrentTrainingStage(slot, npcs_gag, DTConfig.gag_min, DTConfig.gag_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Gag, -1)	
	endif
	
	if DTConfig.training_speed_collar > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Collar, DTTools.getCurrentTrainingStage(slot, npcs_collar, DTConfig.collar_min, DTConfig.collar_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Collar, -1)	
	endif
	
	if DTConfig.training_speed_chastityBelt > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Chastitybelt, DTTools.getCurrentTrainingStage(slot, npcs_chastityBelt, DTConfig.chastitybelt_min, DTConfig.chastitybelt_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Chastitybelt, -1)	
	endif
	
	if DTConfig.training_speed_chastityBra > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Chastitybra, DTTools.getCurrentTrainingStage(slot, npcs_chastityBra, DTConfig.chastitybra_min, DTConfig.chastitybra_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Chastitybra, -1)	
	endif
	
	if DTConfig.training_speed_gloves > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Gloves, DTTools.getCurrentTrainingStage(slot, npcs_gloves, DTConfig.gloves_min, DTConfig.gloves_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Gloves, -1)	
	endif
	
	if DTConfig.training_speed_armbinder > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Armbinderyoke, DTTools.getCurrentTrainingStage(slot, npcs_armbinder, DTConfig.armbinder_min, DTConfig.armbinder_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Armbinderyoke, -1)	
	endif
	
	if DTConfig.training_speed_blindfold > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Blindfold, DTTools.getCurrentTrainingStage(slot, npcs_blindfold, DTConfig.blindfold_min, DTConfig.blindfold_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_Blindfold, -1)	
	endif

	if DTConfig.training_speed_analplug > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_AnalPlug, DTTools.getCurrentTrainingStage(slot, npcs_analPlug, DTConfig.analPlug_min, DTConfig.analPlug_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_AnalPlug, -1)	
	endif
	
	if DTConfig.training_speed_vaginalplug > 0
		npcs_ref[slot].SetFactionRank(DTConfig.DT_VaginalPlug, DTTools.getCurrentTrainingStage(slot, npcs_vaginalPlug, DTConfig.vaginalPlug_min, DTConfig.vaginalPlug_max))	
	else
		npcs_ref[slot].SetFactionRank(DTConfig.DT_VaginalPlug, -1)	
	endif	
	
endFunction

function resetAll(int slot)
	;if DTTools.isValid(npcs_ref[slot]) == true || DTTools.isRegistered(npcs_ref[slot])
	if npcs_ref[slot] != None
		resetAllMagicEffects(slot)
		resetAllVisual(slot)
	endif
	
endFunction

function resetAllMagicEffects(int slot)
	
	npcs_ref[slot].removeSpell(DTStorage.DTWatchdogMain)				
	npcs_ref[slot].removeSpell(DTStorage.DTWatchdogEffects)				
			
	;descriptors items
	DTDescriptor.clearSpells(DTConfig.bootsSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.corsetSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.harnessSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.armCuffsSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.legCuffsSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.gagSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.collarSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.glovesSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.armbinderSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.blindfoldSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.chastityBeltSpellDescr,npcs_ref[slot])	
	DTDescriptor.clearSpells(DTConfig.chastityBraSpellDescr,npcs_ref[slot])	
			
	;buffs
	npcs_ref[slot].removeSpell(DTStorage.DTSpeedBuff)			
	npcs_ref[slot].removeSpell(DTStorage.DTSpeedDebuff)			
	npcs_ref[slot].removeSpell(DTStorage.DTCarryWeightBuff)			
	npcs_ref[slot].removeSpell(DTStorage.DTCarryWeightDebuff)			
	npcs_ref[slot].removeSpell(DTStorage.DTThiefBuff)			
	npcs_ref[slot].removeSpell(DTStorage.DTThiefDebuff)	
	npcs_ref[slot].removeSpell(DTStorage.DTArmorBuff)	
	npcs_ref[slot].removeSpell(DTStorage.DTArmorDebuff)	
	npcs_ref[slot].removeSpell(DTStorage.DTCombatBuff)	
	npcs_ref[slot].removeSpell(DTStorage.DTCombatDebuff)		
	npcs_ref[slot].removeSpell(DTStorage.DTStaminaRegBuff)		
	npcs_ref[slot].removeSpell(DTStorage.DTStaminaRegDebuff)	
	npcs_ref[slot].removeSpell(DTStorage.DTMagicaRegBuff)		
	npcs_ref[slot].removeSpell(DTStorage.DTMagicaRegDebuff)		
	npcs_ref[slot].removeSpell(DTStorage.DTHealthRegBuff)		
	npcs_ref[slot].removeSpell(DTStorage.DTHealthRegDebuff)		
	npcs_ref[slot].removeSpell(DTStorage.DTSpeedAttackBuff)		
	npcs_ref[slot].removeSpell(DTStorage.DTSpeedAttackDebuff)

	npcs_ref[slot].removeSpell(DTStorage.DT_Achievement_BlindSlut)	
	
endFunction

function resetAllVisual(int slot)
DTTools.log2("DTActor::resetAllVisual","Reset all from slot: "+slot)
	resetWaist(slot)
	resetFeet(slot)
	resetOnAllFour(slot)
	resetOpenJaw(slot)
	resetNeckScale(slot)
	
	if DTConfig.mcmTatsChanged == true
		DTBody.removeTats(npcs_ref[slot])
	endIf
	
	DTBody.clearAllBodyScales(npcs_ref[slot],slot)
endFunction

function resetAchievementItems(int slot)
	DTAchievement.unequipAchievementItems(slot)
	DTAchievement.resetAllWithAchievementRelated(slot)
endFunction

function resetNeckScale(int slot)
	DTBody.resetNeckScale(npcs_ref[slot])
endFunction

function resetOpenJaw(int slot)
	DTBody.resetOpenJaw(npcs_ref[slot])
endFunction

function resetWaist(int slot)
	DTBody.resetWaistScale(npcs_ref[slot])
endFunction

function resetFeet(int slot)
	DTBody.resetArchedFeet(npcs_ref[slot])
endFunction

function resetOnAllFour(int slot)
	DTBody.resetforceToAllFours(npcs_ref[slot])
endFunction