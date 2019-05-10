Scriptname DT2Body extends Quest  

DT2Config Property DTConfig Auto
DT2Actor	Property DTActor Auto
DT2Storage Property DTStorage Auto
DT2Expert Property DTExpert Auto
DT2Tools Property DTTools Auto
zadLibs Property zadLibsH Auto
import MiscUtil
import MfgConsoleFunc


;Remove arched feet 
function resetArchedFeet(Actor acActor)

	Armor tmpFeet
	tmpFeet = DTConfig.DT_ArchedFeet
	if DTConfig.achievement_ponygirl_enabled == true
		if DTConfig.achievement_ponygirl_equip_enabled == true
			if acActor == DTActor.npcs_ref[DTConfig.playerSlot] && DTActor.achievementPonyGirl[DTConfig.playerSlot] == true
				DTConfig.DT_ArchedFeet = DTStorage.DT_PonyGirlHooves
			endif			
		endif
	endif
	
	

	if acActor.IsEquipped(DTConfig.DT_ArchedFeet) == true
		acActor.UnequipItem(DTConfig.DT_ArchedFeet)
		acActor.RemoveItem(DTConfig.DT_ArchedFeet, 1)
	endIf
	
	DTConfig.DT_ArchedFeet = tmpFeet
	
endFunction

function setArchedFeet(Actor acActor, int value)
return
	Armor tmpFeet
	tmpFeet = DTConfig.DT_ArchedFeet
	bool ponyBoots = false
	if DTConfig.achievement_ponygirl_enabled == true
		if DTConfig.achievement_ponygirl_equip_enabled == true
			if DTConfig.achievement_ponygirl_equip_always == true
				if acActor == DTActor.npcs_ref[DTConfig.playerSlot] && DTActor.achievementPonyGirl[DTConfig.playerSlot] == true
					DTConfig.DT_ArchedFeet = DTStorage.DT_PonyGirlHooves
					ponyBoots = true
				endif
			endif			
		endif
	endif
	
	;reset if pony boots are not in use	
	if ponyBoots == false
		if  DTConfig.effect_arched_feet_crawl_visual == false
			DTConfig.DT_ArchedFeet = DTStorage.DT_ArchedFeet
		else
			DTConfig.DT_ArchedFeet = DTStorage.DT_ArchedFeetNoHDT
		endif
	endif
	
	
	
	
	if DTConfig.effect_arched_feet_visual==true && DTConfig.training_speed_boots > 0
		;if acActor.WornHasKeyword(DTConfig.ddKeywords[0]) == false && value >= 4 && DTExpert.okBoots(DTActor.isRegistered(acActor))==false
		if value >= 4 && DTExpert.okBoots(DTActor.isRegistered(acActor), true)==false
			if acActor.IsEquipped(DTConfig.DT_ArchedFeet) == false
				acActor.EquipItem(DTConfig.DT_ArchedFeet)				
			endif
			
		else
			if acActor.IsEquipped(DTConfig.DT_ArchedFeet) == true
					acActor.UnequipItem(DTConfig.DT_ArchedFeet)
					acActor.RemoveItem(DTConfig.DT_ArchedFeet, 1)
				
				
			endIf
		endIf
	endIf
	
	DTConfig.DT_ArchedFeet = tmpFeet
	
endFunction

function clearAllBodyScales(Actor acActor, int iSlot)
	if NiOverride.HasNodeTransformScale(acActor, False,True, "NPC Spine1 [Spn1]", "Devious Training") == true
		NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Spine1 [Spn1]","Devious Training")    
		NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Spine2 [Spn2]","Devious Training")		
		NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Spine1 [Spn1]") 
		NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Spine2 [Spn2]") 
	endif
	if NiOverride.HasNodeTransformScale(acActor, False,True, "NPC Neck [Neck]", "Devious Training") == true
		NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Neck [Neck]","Devious Training")    
		NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Head [Head]","Devious Training")
		NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Neck [Neck]") 
		NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Head [Head]") 
	endif
	if DTConfig.slifPack == true
		;SLIF_Main.unregisterNode(acActor, "NPC Neck [Neck]", "Devious Training")
		;SLIF_Main.unregisterNode(acActor, "NPC Head [Head]", "Devious Training")
		;SLIF_Main.unregisterNode(acActor, "NPC Spine1 [Spn1]", "Devious Training")
		;SLIF_Main.unregisterNode(acActor, "NPC Spine2 [Spn2]", "Devious Training")
		;SLIF_Main.unregisterNode(acActor, "slif_breast", "Devious Training")
		;SLIF_Main.unregisterNode(acActor, "slif_belly", "Devious Training")
		;SLIF_Main.unregisterNode(acActor, "slif_butt", "Devious Training")
		
		SLIF_Main.unregisterActor(acActor, "Devious Training")
	endif
	setActorWeight(acActor,DTActor.orgWeight[iSlot])
endFunction

function resetNeckScale(Actor acActor)
	return
	if DTConfig.slifPack == true && DTConfig.enableSlif == true
		SLIF_Main.unregisterNode(acActor, "NPC Neck [Neck]", "Devious Training")
		SLIF_Main.unregisterNode(acActor, "NPC Head [Head]", "Devious Training")
	else
		if NiOverride.HasNodeTransformScale(acActor, False,True, "NPC Neck [Neck]", "Devious Training") == true
			NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Neck [Neck]","Devious Training")    
			NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Head [Head]","Devious Training")
			NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Neck [Neck]") 
			NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Head [Head]") 
		endif
	endif
	
endFunction

function setNeckScale(Actor acActor, float value)
	return
	if DTConfig.effect_collar_long_visual > 0 && DTConfig.training_speed_collar > 0 && DTConfig.effect_collar_enabled == true
	
		if value < 0
			resetNeckScale(acActor)
		else
			float reduction = value / 100
			reduction = reduction * (DTConfig.effect_collar_long_visual as float/ 100) as float  ;max 0.5
			
			float neck = 1 + (reduction * 1.5)
			float head = 1 - reduction
			
			if DTConfig.slifPack == true && DTConfig.enableSlif == true
				SLIF_Main.inflate(acActor, "Devious Training", "NPC Neck [Neck]", neck, -1, -1, "Devious Training")
				SLIF_Main.inflate(acActor, "Devious Training", "NPC Head [Head]", head, -1, -1, "Devious Training")
			else
				if NiOverride.GetNodeTransformScale(acActor,False,True,"NPC Head [Head]","Devious Training") != (1 - reduction)
					NiOverride.AddNodeTransformScale(acActor,False,True,"NPC Neck [Neck]","Devious Training", neck)
					NiOverride.AddNodeTransformScale(acActor,False,True,"NPC Head [Head]","Devious Training", head)
	
			
					NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Neck [Neck]") 
					NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Head [Head]") 
				endif
			endif
		endif
	else
		resetNeckScale(acActor)
	endif

endFunction


function setOpenEyes(Actor acActor, int Slot = -1, float value = -1.0)
	return
	if DTConfig.effect_blindfold_enabled == true  && DTConfig.training_speed_blindfold > 0
	
		if DTActor.npcs_blindfold[Slot] < 0 
			return
		endif
	
		if DTConfig.effect_blindfold_eyes_close==0
			return
		endIf
	
		float mod = -1 * DTConfig.effect_blindfold_eyes_close * (DTActor.npcs_blindfold[Slot]/100)
		DTTools.log("OPEN EYE MOD:"+mod)
		if mod > 0
			
			DTActor.npcs_ref[Slot].SetExpressionModifier(0,  mod )
			DTActor.npcs_ref[Slot].SetExpressionModifier(1,  mod )
		else
			mod = mod * -1.0
			
			DTActor.npcs_ref[Slot].SetExpressionModifier(6,  mod )
			DTActor.npcs_ref[Slot].SetExpressionModifier(7,  mod )
			DTActor.npcs_ref[Slot].SetExpressionOverride(12, (mod * 100) as int)
		endif
	
	endif
	
endFunction

function setOpenJaw(Actor acActor, int Slot = -1, float value = -1.0)
return

	
endFunction

function resetOpenJaw(Actor acActor, int Slot = -1)
	zadLibsH.RemoveGagEffect(acActor)
endFunction

function resetWaistScale(Actor acActor)
	
	if DTConfig.slifPack == true && DTConfig.enableSlif == true
		SLIF_Main.unregisterNode(acActor, "NPC Spine1 [Spn1]", "Devious Training")
		SLIF_Main.unregisterNode(acActor, "NPC Spine2 [Spn2]", "Devious Training")
	else
		if NiOverride.HasNodeTransformScale(acActor, False,True, "NPC Spine1 [Spn1]", "Devious Training") == true
			NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Spine1 [Spn1]","Devious Training")    
			NiOverride.RemoveNodeTransformScale(acActor,False,True,"NPC Spine2 [Spn2]","Devious Training")		
			NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Spine1 [Spn1]") 
			NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Spine2 [Spn2]") 
		endif
	endif
endFunction

function setWaistScale(Actor acActor, float value)
return 
	if DTConfig.effect_corset_waist_visual > 0 && DTConfig.training_speed_corset > 0 && DTConfig.effect_corset_enabled == true
	
		if value < 0
			resetWaistScale(acActor)
		else
		
			int waistFactor = DTConfig.effect_corset_waist_visual
			int Slot = DTActor.isRegistered(acActor)
			
			if DTExpert.okCorset(Slot) == false
				waistFactor = DTConfig.effect_corset_waist_visualWithout
			endif
		
			float reduction = value / 100
			reduction = reduction * (waistFactor as float/ 100) as float  ;max 0.5
			
			float sp1 = 1 - reduction
			float sp2 = 1 + (reduction * (1+ (waistFactor as float/ 100) ) * 1.4 )
			
			if DTConfig.slifPack == true && DTConfig.enableSlif == true
				SLIF_Main.inflate(acActor, "Devious Training", "NPC Spine1 [Spn1]", sp1, -1, -1, "Devious Training")
				SLIF_Main.inflate(acActor, "Devious Training", "NPC Spine2 [Spn2]", sp2, -1, -1, "Devious Training")
			else
				if NiOverride.GetNodeTransformScale(acActor,False,True,"NPC Spine1 [Spn1]","Devious Training") != (sp1)
					NiOverride.AddNodeTransformScale(acActor,False,True,"NPC Spine1 [Spn1]","Devious Training", sp1)
					;NiOverride.AddNodeTransformScale(acActor,False,True,"NPC Spine2 [Spn2]","Devious Training", 1 + (reduction * (1.55)))
					NiOverride.AddNodeTransformScale(acActor,False,True,"NPC Spine2 [Spn2]","Devious Training", sp2)
			
					NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Spine1 [Spn1]") 
					NiOverride.UpdateNodeTransform(acActor, false, True, "NPC Spine2 [Spn2]") 
				endif
			
			endif
			
			
		endif
	else
		resetWaistScale(acActor)
	endif
endFunction



function resetforceToAllFours(Actor acActor)
return
	if DTConfig.sanguneDebucheryPack == true
		if StorageUtil.GetStringValue( acActor, "_SD_sDefaultStance") != "Standing"
			StorageUtil.SetStringValue( acActor , "_SD_sDefaultStance","Standing")		
		endif	
	else
		if DTConfig.zazExtensionPack == true
			FNIS_aa.SetAnimGroup(acActor, "_mtidle",0,0,"ZazExtensionPack",true)
			FNIS_aa.SetAnimGroup(acActor, "_mt",0,0,"ZazExtensionPack",true)
			FNIS_aa.SetAnimGroup(acActor, "_mtx",0,0,"ZazExtensionPack",true)
		endIf
	endif
endFunction

function forceToAllFours(Actor acActor, int value,bool reset = false)
return
	DTTools.log2("DT2Tools::forceToAllFours","Start: "+ acActor+", "+value+", "+reset as bool ,2)
	
	if DTConfig.effect_arched_feet_crawl_visual==true && DTConfig.zazExtensionPack &&  DTConfig.training_speed_boots > 0
		
		DTTools.log2("DT2Tools::forceToAllFours","In crawl section",2)
		
		
		int Slot = DTActor.isRegistered(acActor)
		
		DTTools.log2("DT2Tools::forceToAllFours","  Found slot:"+Slot,2)
		
		if acActor.GetWornForm(DTConfig.slotMask[37]) as Armor == DTStorage.DT_PonyGirlHooves
			if DTActor.npcs_isCrowl[Slot] == true
				DTTools.log2("DT2Tools::forceToAllFours","  Current item prevent to walk on fours, reset crawling",2)
				resetforceToAllFours(acActor)
			endIf
			DTActor.npcs_isCrowl[Slot] = false
			return
		endif
		
		
		
		;if acActor.WornHasKeyword(DTConfig.ddKeywords[0]) == false && value >= 4
		
		bool testValue = DTExpert.okBoots(DTActor.isRegistered(acActor), true)
		
		DTTools.log2("DT2Tools::forceToAllFours","    Input state: okBoots"+(testValue as int)+", value must be greater or equal 4"+value , 2)
		
		if testValue==false && value >= 4
		
			DTTools.log2("DT2Tools::forceToAllFours","    Applay crawling",2)
			
			if DTConfig.sanguneDebucheryPack == true
				DTTools.log2("DT2Tools::forceToAllFours","      ...Sanguine Debuchery",2)
				DTActor.npcs_isCrowl[Slot] = true
				if StorageUtil.GetStringValue( acActor, "_SD_sDefaultStance") != "Crawling"
					StorageUtil.SetStringValue( acActor , "_SD_sDefaultStance","Crawling")		
				endif		
			else
				if DTConfig.zazExtensionPack == true
					DTTools.log2("DT2Tools::forceToAllFours","      ...ZazExtensionPack",2)
					DTActor.npcs_isCrowl[Slot] = true
					
					int modID = FNIS_aa.GetAAModID("zbx", "ZazExtensionPack", true)
					int mtIdleBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtidle(),"ZazExtensionPack",true) 
					int mtBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mt(),"ZazExtensionPack",true) 
					int mtxBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtx(),"ZazExtensionPack",true)
					
					FNIS_aa.SetAnimGroup(acActor, "_mtidle", mtIdleBase, 0, "ZazExtensionPack",true)
					FNIS_aa.SetAnimGroup(acActor, "_mt", mtBase, 0, "ZazExtensionPack",true)
					FNIS_aa.SetAnimGroup(acActor, "_mtx", mtxBase, 0, "ZazExtensionPack",true)
					
					DTTools.log2("DT2Tools::forceToAllFours","        FNIS:: ID"+modID+", mtIdleBase:"+mtIdleBase+", mtBase:"+mtBase+", mtxBase:"+mtxBase  ,2)
								
				
				endIf
			endif
		else
		
			DTTools.log2("DT2Tools::forceToAllFours","    Remove crawling",2)
		
			if DTConfig.sanguneDebucheryPack == true
				if DTActor.npcs_isCrowl[Slot] == true
					if StorageUtil.GetStringValue( acActor, "_SD_sDefaultStance") != "Standing"
						StorageUtil.SetStringValue( acActor , "_SD_sDefaultStance","Standing")		
					endif	
					DTActor.npcs_isCrowl[Slot] = false
				endif
			else
				if DTConfig.zazExtensionPack == true
					if DTActor.npcs_isCrowl[Slot] == true
						FNIS_aa.SetAnimGroup(acActor, "_mtidle",0,0,"ZazExtensionPack",true)
						FNIS_aa.SetAnimGroup(acActor, "_mt",0,0,"ZazExtensionPack",true)
						FNIS_aa.SetAnimGroup(acActor, "_mtx",0,0,"ZazExtensionPack",true)
						DTActor.npcs_isCrowl[Slot] = false
					endif
				endIf
			endif
		endif
	
	endIf
endFunction


function setActorWeight(Actor akActor, float weight)
	return
	DTTools.log2("DTBody::setActorWeight","Actor: "+akActor+" Current Weight: "+akActor.GetWeight() + " Input Weight: "+weight )
	DTTools.log2("DTBody::setActorWeight","Defined pointers:"+DTActor.bodyPointer)
	
	float PlayerOrigWeight = akActor.GetWeight() ;Collect the Player's original weight.
	float PlayerNewWeight = weight
	
	;nothing to do? so skip!
	if weight == PlayerOrigWeight
		DTTools.log2("DTBody::setActorWeight","Skip ->Input weight:"+weight+", current weight:"+PlayerNewWeight)
		return
	endIf
	
	Float NeckDelta = (PlayerOrigWeight / 100) - (PlayerNewWeight / 100) ;Work out the neckdelta.
	
	DTTools.log2("DTBody::setActorWeight","NeckDelta: "+NeckDelta)
	
 	akActor.GetActorBase().SetWeight(weight) 
	akActor.UpdateWeight(NeckDelta) ;Apply the changes.
	akActor.QueueNiNodeUpdate() ;Apply the changes.
	
	DTTools.log2("DTBody::setActorWeight","Actor: "+akActor+" output Weight: "+akActor.GetWeight())
endFunction

function setBreast(Actor akActor, float value)

	return

	DTTools.log2("DTBody::setBreast","Start, Actor: "+akActor+", value"+value)
	if DTConfig.slifPack == true && DTConfig.enableSlif == true
	
		if value <= -10
			SLIF_Main.unregisterNode(akActor, "slif_breast", "Devious Training")
			return 
		endif
	
	
		DTTools.log2("DTBody::setBreast","Inside!")		
		;point = min + ( (max - min) * (val/100))		
		
		DTTools.log2("DTBody::setBreast","modifier: "+value)		
		
		if akActor.WornHasKeyword(DTConfig.ddKeywords[8])
			SLIF_Main.hideNode(akActor, "Devious Training", "slif_breast", 0.001, "Devious Training")
		else
			SLIF_Main.showNode(akActor, "Devious Training", "slif_breast")
			SLIF_Main.inflate(akActor, "Devious Training", "slif_breast", value, -1, -1, "Devious Training")
		endif
		
		
	
	endIf
endFunction

function setButt(Actor akActor, float value)
return
	DTTools.log2("DTBody::setButt","Start, Actor: "+akActor+", value"+value)
	if DTConfig.slifPack == true && DTConfig.enableSlif == true
		DTTools.log2("DTBody::setButt","Inside!")		
		;point = min + ( (max - min) * (val/100))		
		float modifier = DTConfig.bodyMinButt as float + (  (  DTConfig.bodyMaxButt - DTConfig.bodyMinButt ) as float * ( value / 100 ) as float )
		DTTools.log2("DTBody::setButt","modifier: "+modifier)		
		SLIF_Main.inflate(akActor, "Devious Training", "slif_butt", modifier, -1, -1, "Devious Training")
	
	endIf
endFunction

function setBelly(Actor akActor, float value)
return
	DTTools.log2("DTBody::setBelly","Start, Actor: "+akActor+", value"+value)
	if DTConfig.slifPack == true && DTConfig.enableSlif == true
		DTTools.log2("DTBody::setBelly","Inside!")		
		;point = min + ( (max - min) * (val/100))	
		float modifier = DTConfig.bodyMinBelly as float + (  (  DTConfig.bodyMaxBelly - DTConfig.bodyMinBelly ) as float * ( value / 100 ) as float )
		DTTools.log2("DTBody::setBelly","modifier: "+modifier)		
		SLIF_Main.inflate(akActor, "Devious Training", "slif_belly", modifier, -1, -1, "Devious Training")
	
	endIf
endFunction

float function calcBreastScale(Actor akActor, int iSlot)

	if DTExpert.okChastityBra(iSlot) == true
		return -10
	endif 

	float value = 0
	
	if DTConfig.bodyScaleOrgasmEnabled == true
		value = DTConfig.bodyMinBrests as float + (  (  DTConfig.bodyMaxBrests - DTConfig.bodyMinBrests ) as float * ( DTActor.bodyPointer[iSlot] / 100 ) as float )
	endIf
	
	if DTExpert.okChastityBra(iSlot) == false
		if DTConfig.training_speed_chastityBra > 0 && DTConfig.effect_chastityBra_enabled == true && DTConfig.effect_chastity_breast_visual != 0
			float breastMod = DTActor.npcs_chastityBra[iSlot]/100 *  DTConfig.effect_chastity_breast_visual
			value = value + breastMod
		endIf
	endIf
	if value < 0 
		value = 0
	endIf
	return value
	
	
	
endFunction

function removeTats(Actor acActor)
	
		if DTConfig.slaveTatsPack == false
			return
		endIf
	
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "10001")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "10010")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "10011")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "10100")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "10101")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "10110")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "10111")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11000")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11001")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11010")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11011")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11100")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11101")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11110")
		SlaveTats.simple_remove_tattoo(acActor, "DTTats", "11111")
		Int Slot = DTActor.isRegistered(acActor)
		DTActor.lastKnowTatsSetGroup1[Slot] = "xxxx"
		DTActor.npcs_daysInBondageLastKnow[Slot] = -1

		
		int i = 0
		while i < 128
			SlaveTats.simple_remove_tattoo(acActor, "DTTatsDays", "day"+i)
			i = i + 1
		endWhile
endFunction

function applyDaysTats(Actor acActor, int iSlot)
return
	;if function is disabled just skip and back
	if DTConfig.slaveTatsPack == false || DTConfig.tats_days_enabled == false
		return
	endIf
	
	
	
	;get slot number
	;TODO, add it as 2th parameter - to tune up script
	
	
		
	if iSlot >= 0
	
		;do not nothing if counter is greater than 63 days (graphic limit)
		if DTActor.npcs_daysInBondage[iSlot]>63			
			return
		endif
		
		DTTools.log("TATS DAY COUNT: "+DTActor.npcs_ref[iSlot].GetLeveledActorBase().GetName()+" - "+DTActor.npcs_daysInBondage[iSlot])
		int day = DTActor.npcs_daysInBondage[iSlot]
		int dayMinusOne = DTActor.npcs_daysInBondage[iSlot]
		dayMinusOne-=1
		if DTActor.npcs_daysInBondageLastKnow[iSlot] != day
			SlaveTats.simple_remove_tattoo(acActor, "DTTatsDays", "day"+day)	
			SlaveTats.simple_remove_tattoo(acActor, "DTTatsDays", "day"+dayMinusOne)				
			SlaveTats.simple_add_tattoo(acActor, "DTTatsDays", "day"+day)
			DTActor.npcs_daysInBondageLastKnow[iSlot] = day
		endif
		
	endif
endFunction


function applyTatsGroup1(Actor acActor, int iSlot)
return

	if DTConfig.slaveTatsPack == false || DTConfig.tats_item_enabled == false
		return
	endIf
		
	if iSlot >= 0
		String lastKnowTatsSet = DTActor.lastKnowTatsSetGroup1[iSlot]
		String newTatsSet = DTTools.generateTatsPatternForGroup1(iSlot)
		
		DTTools.log("TATS: "+DTActor.npcs_ref[iSlot].GetLeveledActorBase().GetName()+" - "+lastKnowTatsSet+" -> "+newTatsSet)
		
		if lastKnowTatsSet != newTatsSet
			SlaveTats.simple_remove_tattoo(acActor, "DTTats", lastKnowTatsSet)
			SlaveTats.simple_add_tattoo(acActor, "DTTats", newTatsSet)
			DTActor.lastKnowTatsSetGroup1[iSlot] = newTatsSet
		endif
	endif
	
endFunction
