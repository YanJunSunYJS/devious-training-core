Scriptname DT2TransformToPonyME extends ActiveMagicEffect  



DT2Actor Property DTActor Auto
DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Expert Property DTExpert Auto
DT2Storage Property DTStorage Auto
DT2Sound Property DTSound Auto
DT2Achievement Property DTAchievement Auto

Spell Property DT_Clairvoyance Auto

Actor Property acActor Auto
Int Property Slot Auto
Bool Property effectEnabled Auto


bool Property activeEffect Auto
Zadlibs property libs auto  
SexLabFramework Property sexlab auto

Armor[] property armbinderInventory auto
Armor[] property armbinderScript auto

Armor[] property bootsInventory auto
Armor[] property bootsScript auto

Armor[] property collarInventory auto
Armor[] property collarScript auto

Armor[] property harnessInventory auto
Armor[] property harnessScript auto

Armor[] property corsetInventory auto
Armor[] property corsetScript auto

Armor[] property armCuffsInventory auto
Armor[] property armCuffsScript auto

Armor[] property legCuffsInventory auto
Armor[] property legCuffsScript auto

Armor[] property chastityBeltInventory auto
Armor[] property chastityBeltScript auto

Armor[] property chastityBraInventory auto
Armor[] property chastityBraScript auto


Form[] property strippedItems auto

Armor property selectedArmbinder Auto
Armor property selectedBoots Auto
Armor property selectedHarness Auto
Armor property selectedCorset Auto
Armor property selectedCollar Auto
Armor property selectedLegCuffs Auto
Armor property selectedArmCuffs Auto
Armor property selectedChastityBelt Auto
Armor property selectedChastityBra Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)


	DTTools.log("DT2TransformToPonyME::OnEffectStart (begin)")

	Slot = DTActor.isRegistered(akTarget)
	
	if Slot == -1 || DTActor.achievementPonyGirl[slot] == false
		DTTools.log("DT2TransformToPonyME::Something went wrong"+Slot+ " " + DTActor.achievementPonyGirl[slot],0)
		self.Dispel()
		return
	endIf
	
	acActor = akTarget
	
	activeEffect = false
	
	DTTools.log("DT2TransformToPonyME::Equip items with color: "+DTConfig.achievement_ponygirl_colorset,0)
	
	if DTExpert.okArmbinder(Slot) == false
	
		libs.equipdevice(acActor, armbinderInventory[DTConfig.achievement_ponygirl_colorset], armbinderScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[15])
		activeEffect = true
		selectedArmbinder = armbinderScript[DTConfig.achievement_ponygirl_colorset] as Armor
		DTTools.log("DT2TransformToPonyME::Equip Armbinder Selected:"+selectedArmbinder,0)
	else
		DTTools.log("DT2TransformToPonyME::Equip Armbinder Skipped:"+acActor.GetWornForm(DTConfig.slotMask[46]) as Armor,0)
	endIf
	
	if DTExpert.okBoots(Slot) == false
		libs.equipdevice(acActor, bootsInventory[DTConfig.achievement_ponygirl_colorset], bootsScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[0])
		activeEffect = true
		selectedBoots = bootsScript[DTConfig.achievement_ponygirl_colorset] as Armor
		DTTools.log("DT2TransformToPonyME::Equip Boots Selected:"+selectedBoots,0)
	else
		DTTools.log("DT2TransformToPonyME::Equip Boots Skipped, Actor wear:"+acActor.GetWornForm(DTConfig.slotMask[37]) as Armor,0)
		DTTools.log("DT2TransformToPonyME::Additional stack of items:",0)
		DTTools.log("DT2TransformToPonyME::Boots0 "+DTConfig.acceptBoots0,0)
		DTTools.log("DT2TransformToPonyME::Boots1 "+DTConfig.acceptBoots1,0)
		DTTools.log("DT2TransformToPonyME::Boots2 "+DTConfig.acceptBoots2,0)
		DTTools.log("DT2TransformToPonyME::Boots3 "+DTConfig.acceptBoots3,0)
	endIf
	
	if activeEffect == true
	
		if DTConfig.achievement_ponygirl_add_another_items == true
		
			DTTools.log("DT2TransformToPonyME::Add Harness If "+DTTools.getAdvancedLevel( DTActor.npcs_harness[slot])+" >= 4")	
			if DTExpert.okChastityBelt(Slot) == false && DTExpert.okHarness(Slot) == false && DTExpert.okCollar(Slot) == false && DTExpert.okCorset(Slot) == false && DTTools.getAdvancedLevel( DTActor.npcs_harness[slot])>=4
				libs.equipdevice(acActor, harnessInventory[DTConfig.achievement_ponygirl_colorset], harnessScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[2])		
				selectedHarness =harnessScript[DTConfig.achievement_ponygirl_colorset] as Armor
			else
				
				DTTools.log("DT2TransformToPonyME::Add Corset If "+DTTools.getAdvancedLevel( DTActor.npcs_corset[slot])+" >= 4")	
				if DTExpert.okCorset(Slot) == false && DTExpert.okHarness(Slot) == false && DTTools.getAdvancedLevel( DTActor.npcs_corset[slot])>=4
					libs.equipdevice(acActor, corsetInventory[DTConfig.achievement_ponygirl_colorset], corsetScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[1])		
					selectedCorset = corsetScript[DTConfig.achievement_ponygirl_colorset] as Armor
				endif

				DTTools.log("DT2TransformToPonyME::Add Collar If "+DTTools.getAdvancedLevel( DTActor.npcs_collar[slot])+" >= 4")	
				if DTExpert.okCollar(Slot) == false && DTExpert.okHarness(Slot) == false && DTTools.getAdvancedLevel( DTActor.npcs_collar[slot])>=4
					libs.equipdevice(acActor, collarInventory[DTConfig.achievement_ponygirl_colorset], collarScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[6])		
					selectedCollar = collarScript[DTConfig.achievement_ponygirl_colorset] as Armor
				endif				

				DTTools.log("DT2TransformToPonyME::Add Chastity Belt If "+DTTools.getAdvancedLevel( DTActor.npcs_chastityBelt[slot])+" >= 4")	
				if DTExpert.okChastityBelt(Slot) == false && DTExpert.okHarness(Slot)== false && DTTools.getAdvancedLevel( DTActor.npcs_chastityBelt[slot])>=4
					libs.equipdevice(acActor, chastityBeltInventory[0], chastityBeltScript[0],DTConfig.ddKeywords[7])		
					selectedChastityBelt = chastityBeltScript[0] as Armor
				endif	

				DTTools.log("DT2TransformToPonyME::Add Chastity Bra If "+DTTools.getAdvancedLevel( DTActor.npcs_chastityBra[slot])+" >= 4")	
				if DTExpert.okChastityBra(Slot) == false && DTTools.getAdvancedLevel( DTActor.npcs_chastityBra[slot])>=4
					libs.equipdevice(acActor, chastityBraInventory[0], chastityBraScript[0],DTConfig.ddKeywords[8])		
					selectedChastityBra = chastityBraScript[0] as Armor
				endif	
				
			endif

			DTTools.log("DT2TransformToPonyME::Add Leg Cuffs If "+DTTools.getAdvancedLevel( DTActor.npcs_legcuffs[slot])+" >= 4")	
			if DTExpert.okLegCuffs(Slot) == false && DTTools.getAdvancedLevel( DTActor.npcs_legcuffs[slot])>=4
				libs.equipdevice(acActor, legCuffsInventory[DTConfig.achievement_ponygirl_colorset], legCuffsScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[3])		
				selectedLegCuffs = legCuffsScript[DTConfig.achievement_ponygirl_colorset] as Armor
			endif			
		
			DTTools.log("DT2TransformToPonyME::Add Arm Cuffs If "+DTTools.getAdvancedLevel( DTActor.npcs_armcuffs[slot])+" >= 4")	
			if DTExpert.okArmCuffs(Slot) == false && DTTools.getAdvancedLevel( DTActor.npcs_armcuffs[slot])>=4
				libs.equipdevice(acActor, armCuffsInventory[DTConfig.achievement_ponygirl_colorset], armCuffsScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[4])		
				selectedArmCuffs = armCuffsScript[DTConfig.achievement_ponygirl_colorset] as Armor
			endif		

			

			
		endif
	
	
	
		strippedItems = sexlab.StripActor(acActor, none, false, false)
		DTAchievement.equipPonygirl(slot)
		DTSound.addSoundToActor(slot, "pony", 0)
		
	else
		DTTools.log("DT2TransformToPonyME::Abord! (end)")
		self.Dispel()
		return
	endif
	
	DTTools.log("DT2TransformToPonyME::Duration"+self.GetDuration())

	DTTools.log("DT2TransformToPonyME::OnEffectStart (end)")
	effectEnabled = true
	
	RegisterForAnimationEvent(acActor, "StartAnimatedCameraDelta")
	acActor.AddSpell(DT_Clairvoyance)
;	RegisterForSingleUpdate(10)
	
endEvent

;Event onUpdate()
;	if effectEnabled == true
;		DTTools.log("DT2TransformToPonyME::onUpdate Period update...")
;		acActor.RemoveSpell(DT_Clairvoyance)
;		acActor.AddSpell(DT_Clairvoyance)
;		DT_Clairvoyance.cast(acActor, acActor)
;		RegisterForSingleUpdate(10)
;	endif
;endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if DTConfig.achievement_ponygirl_cast_helpfull_spells == true
		DT_Clairvoyance.cast(acActor, acActor)
	endIf
endEvent


Event OnEffectFinish(Actor acActor, Actor akCaster)
	
	DTTools.log("DT2TransformToPonyME::OnEffectFinish (begin)")
	
	if activeEffect == false
		DTTools.log("DT2TransformToPonyME::Nothing to do becouse activeEffect=="+activeEffect as int)
		DTSound.addSoundToActor(slot, "pony", 1)
		Game.UpdateHairColor()			
		return
	endIf
	DTSound.addSoundToActor(slot, "pony", 2)
	
	effectEnabled = false
	acActor.RemoveSpell(DT_Clairvoyance)
	DTAchievement.unequipPonygirl(slot)
	
	
	
	if acActor.GetWornForm(DTConfig.slotMask[46]) as Armor == selectedArmbinder as Armor
		DTTools.log("DT2TransformToPonyME::Remove Armbinder (Try)")	
		libs.RemoveDevice(acActor, armbinderInventory[DTConfig.achievement_ponygirl_colorset], armbinderScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[15])
		acActor.RemoveItem(armbinderInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(armbinderScript[DTConfig.achievement_ponygirl_colorset], 1)
	else
		DTTools.log("DT2TransformToPonyME::Remove Armbinder (Fail)")	
		DTTools.log("DT2TransformToPonyME::Compared Items: "+acActor.GetWornForm(DTConfig.slotMask[46]) as Armor+" and "+selectedArmbinder as Armor)		
	endif
	
	if acActor.GetWornForm(DTConfig.slotMask[37]) as Armor == selectedBoots as Armor
		DTTools.log("DT2TransformToPonyME::Remove Boots (Try)")	
		libs.RemoveDevice(acActor, bootsInventory[DTConfig.achievement_ponygirl_colorset], bootsScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[0])
		acActor.RemoveItem(bootsInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(bootsScript[DTConfig.achievement_ponygirl_colorset], 1)
	else
		DTTools.log("DT2TransformToPonyME::Remove Boots (Fail)")	
		DTTools.log("DT2TransformToPonyME::Compared Items: "+acActor.GetWornForm(DTConfig.slotMask[37]) as Armor+" and "+selectedBoots as Armor)
	endIf
	
	if acActor.GetWornForm(DTConfig.slotMask[49]) as Armor == selectedChastityBelt as Armor
		libs.RemoveDevice(acActor, chastityBeltInventory[0], chastityBeltScript[0], DTConfig.ddKeywords[7])
		acActor.RemoveItem(chastityBeltInventory[0], 1)
		acActor.RemoveItem(chastityBeltScript[0], 1)		
		Utility.wait(0.5)
	endif	
	
	if acActor.GetWornForm(DTConfig.slotMask[56]) as Armor == selectedChastityBra as Armor
		libs.RemoveDevice(acActor, chastityBraInventory[0], chastityBraScript[0], DTConfig.ddKeywords[8])
		acActor.RemoveItem(chastityBraInventory[0], 1)
		acActor.RemoveItem(chastityBraScript[0], 1)
		Utility.wait(0.5)
	endif	
	
	if acActor.GetWornForm(DTConfig.slotMask[45]) as Armor == selectedHarness as Armor
		libs.RemoveDevice(acActor, harnessInventory[DTConfig.achievement_ponygirl_colorset], harnessScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[2])
		acActor.RemoveItem(harnessInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(harnessScript[DTConfig.achievement_ponygirl_colorset], 1)		
		Utility.wait(0.5)
	endif
	
	if acActor.GetWornForm(DTConfig.slotMask[53]) as Armor == selectedLegCuffs as Armor
		libs.RemoveDevice(acActor, legCuffsInventory[DTConfig.achievement_ponygirl_colorset], legCuffsScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[3])
		acActor.RemoveItem(legCuffsInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(legCuffsScript[DTConfig.achievement_ponygirl_colorset], 1)		
		Utility.wait(0.5)
	endif
	
	if acActor.GetWornForm(DTConfig.slotMask[59]) as Armor == selectedArmCuffs as Armor
		libs.RemoveDevice(acActor, armCuffsInventory[DTConfig.achievement_ponygirl_colorset], armCuffsScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[4])
		acActor.RemoveItem(armCuffsInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(armCuffsScript[DTConfig.achievement_ponygirl_colorset], 1)		
		Utility.wait(0.5)
	endif
	
	if acActor.GetWornForm(DTConfig.slotMask[45]) as Armor == selectedCollar as Armor
		libs.RemoveDevice(acActor, collarInventory[DTConfig.achievement_ponygirl_colorset], collarScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[6])
		acActor.RemoveItem(collarInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(collarScript[DTConfig.achievement_ponygirl_colorset], 1)
		Utility.wait(0.5)
	endif		
	
	if acActor.GetWornForm(DTConfig.slotMask[58]) as Armor == selectedCorset as Armor
		DTTools.log("DT2TransformToPonyME::Remove Corset (Try)")	
		libs.RemoveDevice(acActor, corsetInventory[DTConfig.achievement_ponygirl_colorset], corsetScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[1])
		acActor.RemoveItem(corsetInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(corsetScript[DTConfig.achievement_ponygirl_colorset], 1)
		
	else
		DTTools.log("DT2TransformToPonyME::Remove Corset (Fail)")	
		DTTools.log("DT2TransformToPonyME::Compared Items: "+acActor.GetWornForm(DTConfig.slotMask[58]) as Armor+" and "+selectedCorset as Armor)
		DTTools.log("DT2TransformToPonyME::corsetInventory:")	
		DTTools.log(corsetInventory)	
		DTTools.log("DT2TransformToPonyME::corsetScript:")	
		DTTools.log(corsetScript)	
	endif		
	
	sexlab.UnstripActor(acActor, strippedItems)
	Game.UpdateHairColor()			
	DTTools.log("DT2TransformToPonyME::OnEffectFinish (end)")
	
endEvent


