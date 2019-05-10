Scriptname DT2TransformToBlindME extends ActiveMagicEffect  




DT2Actor Property DTActor Auto
DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Expert Property DTExpert Auto
DT2Storage Property DTStorage Auto
DT2Sound Property DTSound Auto
DT2Achievement Property DTAchievement Auto


Actor Property acActor Auto
Int Property Slot Auto
Bool Property effectEnabled Auto


bool Property activeEffect Auto
Zadlibs property libs auto  
SexLabFramework Property sexlab auto

Armor[] property blindfoldInventory auto
Armor[] property blindfoldScript auto

Armor property selectedBlindfold Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

Slot = DTActor.isRegistered(akTarget)
	
	if Slot == -1 || DTActor.achievementBlindSlut[slot] == false
	;	DTTools.log("DT2TransformToBlindME::Something went wrong"+Slot+ " " + DTActor.achievementPonyGirl[slot],0)
		self.Dispel()
		return
	endIf
	
	acActor = akTarget
	
	activeEffect = false
	
	if DTExpert.okBlindfold(Slot) == false
	
		libs.equipdevice(acActor, blindfoldInventory[DTConfig.achievement_ponygirl_colorset], blindfoldScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[16])
		activeEffect = true
		selectedBlindfold = blindfoldScript[DTConfig.achievement_ponygirl_colorset] as Armor
		DTTools.log("DT2TransformToPonyME::Equip Armbinder Selected:"+selectedBlindfold,0)
	else
		;DTTools.log("DT2TransformToPonyME::Equip Armbinder Skipped:"+acActor.GetWornForm(DTConfig.slotMask[46]) as Armor,0)
	endIf
	
	
EndEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)




	if activeEffect == false		
		return
	endIf
	
	effectEnabled = false
	
	
	
	if acActor.GetWornForm(DTConfig.slotMask[55]) as Armor == selectedBlindfold as Armor
		DTTools.log("DT2TransformToPonyME::Remove Armbinder (Try)")	
		libs.RemoveDevice(acActor, blindfoldInventory[DTConfig.achievement_ponygirl_colorset], blindfoldScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[16])
		acActor.RemoveItem(blindfoldInventory[DTConfig.achievement_ponygirl_colorset], 1)
		acActor.RemoveItem(blindfoldScript[DTConfig.achievement_ponygirl_colorset], 1)
	else
		DTTools.log("DT2TransformToPonyME::Remove Armbinder (Fail)")	
	;DTTools.log("DT2TransformToPonyME::Compared Items: "+acActor.GetWornForm(DTConfig.slotMask[46]) as Armor+" and "+selectedArmbinder as Armor)		
	endif
	
EndEvent