Scriptname DT2WatchdogEffects extends activemagiceffect  

DT2Actor Property DTActor Auto
DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Sound Property DTSound Auto
DT2Visual Property DTVisual Auto
DT2Storage Property DTStorage Auto
DT2Expert Property DTExpert Auto
DT2Core Property DTCore Auto

Actor Property acActor Auto
Int Property Slot Auto
Bool Property Terminate Auto
bool Property bReady Auto
bool Property bEquip Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Slot = DTActor.isRegistered(akTarget)
	
	if Slot == -1	
		self.Dispel()
	endIf
	
	Terminate = False
	acActor = akTarget

	RegisterForAnimationEvent(acActor, "weaponSwing") 
	RegisterForAnimationEvent(acActor, "WeaponLeftSwing") 
	RegisterForAnimationEvent(acActor, "BowRelease") 
	RegisterForAnimationEvent(acActor, "BeginCastRight") 
	RegisterForAnimationEvent(acActor, "BeginCastLeft") 
	
	
	RegisterForAnimationEvent(acActor, "JumpUp") 
	RegisterForAnimationEvent(acActor, "JumpDown")
	
	RegisterForAnimationEvent(acActor, "FootLeft") 
	RegisterForAnimationEvent(acActor, "FootRight")
    
	RegisterForAnimationEvent(acActor, "tailSneakLocomotion")
	RegisterForAnimationEvent(acActor, "SoundPlay.FSTSwimSwim")	
	
	RegisterForAnimationEvent(acActor, "StartAnimatedCameraDelta")	
	RegisterForAnimationEvent(acActor, "EndAnimatedCameraDelta")	
	
	bReady = true
	bEquip = false
endEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)
	
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	DTTools.log("onHit" + akAggressor,2, true)
	DTTools.log("onHit" + akSource,2, true)
	
	
	if DTExpert.isZazWeapon(akSource) == true
		DTActor.count_dmgZad[Slot] = DTActor.count_dmgZad[Slot] + 1

		;send event - zaz hit detected
		int handle = ModEvent.Create("DT_NewEvent")
		ModEvent.PushForm(handle, DTActor.npcs_ref[Slot] as Form)
		ModEvent.PushInt(handle, Slot)
		ModEvent.PushString(handle, "zazHit")
		ModEvent.PushInt(handle, DTActor.count_dmgZad[Slot])
		ModEvent.Send(handle)

		;add sounds
		if Utility.randomInt(0,2)==0
			DTSound.addSoundToActor(Slot,"pain",3,1)
		endif
		
	else
		DTActor.count_dmg[Slot] = DTActor.count_dmg[Slot] + 1
		
		;send event - std hit detected
		int handle = ModEvent.Create("DT_NewEvent")
		ModEvent.PushForm(handle, DTActor.npcs_ref[Slot] as Form)
		ModEvent.PushInt(handle, Slot)
		ModEvent.PushString(handle, "stdHit")
		ModEvent.PushInt(handle, DTActor.count_dmg[Slot])
		ModEvent.Send(handle)
		
		;add sounds
		if Utility.randomInt(0,5)==0
			DTSound.addSoundToActor(Slot,"pain",Utility.randomInt(1,3),1)
		endif
		
	endIf

	if DTConfig.training_speed_armbinder == 0
		return
	endif
	
	if DTExpert.okArmbinder(slot)==false
		return 
	endif
	if Utility.RandomInt(1,3)==1
		DTSound.addSoundToActor(Slot,"pony",0)
	endif
  
	int level = DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_armbinder,DTConfig.armbinder_min,DTConfig.armbinder_max)

	;if !DTActor.npcs_ref[slot].HasMagicEffect(DTStorage.DTslowDownTimeME)
	
	
		float mag = 0
		float dur = 0
		

		if level == 4
			mag = 0.5
			dur = 8
		endif		
	
		if level == 5
			mag = 0.4
			dur = 14
		endif	

		if level == 6
			mag = 0.3
			dur = 18
		endif
		
		if mag == 0
			return
		endIf
		
		int healthProcent = DTTools.GetActorValuePercentageEX(DTActor.npcs_ref[slot],"Health") as Int
		
		DTTools.log("health proc "+healthProcent)
		
		dur = dur * ( (100.0 - healthProcent as float) / 100)
	
		if healthProcent < DTConfig.effect_armbinder_health
			Spell tmpSpell = DTStorage.DTslowDownTime
			tmpSpell.SetNthEffectMagnitude(0, mag)		
			tmpSpell.SetNthEffectDuration(0, dur as int)	
			DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
			tmpSpell.cast(DTActor.npcs_ref[slot])
			DTActor.npcs_ref[slot].UnequipSpell(tmpSpell, 0)
			DTActor.npcs_ref[slot].UnequipSpell(tmpSpell, 1)
			DTActor.npcs_ref[slot].removeSpell(tmpSpell)
		endif
	;endif
  
  ;endIf
  
EndEvent

event OnMenuClose(String asMenuName)
	if asMenuName == "Dialogue Menu"	
	
		if Utility.RandomInt(1,3)==1
			DTSound.addSoundToActor(Slot,"pony",3)
		endif
		DTTools.changeGagOptions(0.5)	
		DTTools.changeGagOptions(1.0)
		DTTools.changeGagOptions(1.5)	
	endIf
endEvent

event OnMenuOpen(String asMenuName)
	if asMenuName == "Dialogue Menu"		
	
		
	
		DTTools.changeGagOptions(0.0)	
		
		if Utility.RandomInt(1,3)==1
			DTSound.addSoundToActor(Slot,"pony",3)
		endif
		
		DTTools.changeGagOptions(0.5)
		
			
		DTTools.changeGagOptions(1.0)	

		Utility.wait(5.0)
	
		if Utility.RandomInt(1,5)==1
			DTSound.addSoundToActor(Slot,"pony",3)
		endif
		
	endIf
endevent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

	armor test = akBaseObject as armor
	if test
		if bReady == true && bEquip == false
			UnregisterForUpdate()
			bReady = false
		;	DTCore.updateVisualEffects(slot,true)
			bEquip = true
			RegisterForSingleUpdate(3)
		endif
	endif
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
	
	armor test = akBaseObject as armor
	if test
		if bReady == true && bEquip == false
			UnregisterForUpdate()
			bReady = false		
			bEquip = true
			RegisterForSingleUpdate(3)
		endif
	endif
EndEvent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)


	if asEventName == "StartAnimatedCameraDelta"
	;DTTools.log("SPRINT START")
		if Utility.RandomInt(1,2)==1
			DTSound.addSoundToActor(Slot,"pony",2)
		endif
		
		;add sounds
		if Utility.randomInt(0,3)==0 && DTExpert.okGag(Slot) == true
			DTSound.addSoundToActor(Slot,"breath",Utility.randomInt(0,3),1)			
		endif
	endif	
	if asEventName == "EndAnimatedCameraDelta"
	;DTTools.log("SPRINT STOP")
		if Utility.RandomInt(1,2)==1
			DTSound.addSoundToActor(Slot,"pony",2)
		endif
		
		;add sounds
		if Utility.randomInt(0,5)==0 && DTExpert.okGag(Slot) == true
			DTSound.addSoundToActor(Slot,"breath",Utility.randomInt(0,3),1)			
		endif
	endif
	
	if bReady == false
		return
	endif
	
	
	bReady = false
	
	if Slot == -1	
		self.Dispel()
	endIf
	
	
	
	if asEventName == "weaponSwing" || asEventName == "WeaponLeftSwing" || asEventName == "BowRelease" || asEventName == "BeginCastRight" || asEventName == "BeginCastLeft" 
		chainProcess(4)
		chastityProcess(-1,0)
		if effectCollar(1.5,4.0,1) == true
			return
		endif				
		
		if effectCorset(1,5.0,1.0) == true
			return
		endif	
		
		if effectHarness(1.5,4.0,0.5) == true
			return
		endif		
		
		;add sounds
		if Utility.randomInt(0,10)==0 && DTExpert.okGag(Slot) == true
			DTSound.addSoundToActor(Slot,"breath",Utility.randomInt(0,3),1)			
		endif
		
	endif
	
	if asEventName == "JumpUp" || asEventName == "JumpDown"
	
	
		
		
	
		if asEventName == "JumpDown"
			if Utility.RandomInt(1,3)==1
				DTSound.addSoundToActor(Slot,"pony",2)
			endif
			
			;add sounds
			if Utility.randomInt(0,7)==0 && DTExpert.okGag(Slot) == true
				DTSound.addSoundToActor(Slot,"breath",Utility.randomInt(0,3),1)
			endif
			
			chainProcess(-1)
			chastityProcess(8,0)
			if effectBoots(5.0,4.0,1) == true
				return
			endif				
			
			if effectCollar(0.1,4.0,1) == true
				return
			endif			
			if effectVaginalPlug(0.3,5.0) == true
				return
			endif
		endif
		
		if asEventName == "JumpUp"
			if Utility.RandomInt(1,3)==1
				DTSound.addSoundToActor(Slot,"pony",2)
			endif
			chainProcess(3)
			chastityProcess(7,0)
			if effectCorset(1,5.0,1.0) == true
				return
			endif		
			
			if effectCollar(0.5,4.0,1) == true
				return
			endif	
			if effectVaginalPlug(0.3,5.0) == true
				return
			endif			
			
		endIf
		
	endif
	
	if asEventName == "FootLeft" || asEventName == "FootRight"
	
		DTActor.count_steps[Slot] = DTActor.count_steps[Slot] + 1
		
		if DTTools.getIsRunning(acActor)
	

			;add sounds
			if Utility.randomInt(0,20)==0 && DTExpert.okGag(Slot) == true
				DTSound.addSoundToActor(Slot,"breath",Utility.randomInt(0,3),1)
			endif
	
			if Utility.RandomInt(1,10)==1
				DTSound.addSoundToActor(Slot,"pony",3)
			endif
			
			chainProcess(-1)
			chastityProcess(-1,2)
			if effectCorset(0.3,4.0,0.5) == true
				return
			endif				
			if effectHarness(0.3,4.0,0.5) == true
				return
			endif		
			
			if effectBoots(0.5,4.0,1) == true
				return
			endif	
			if effectVaginalPlug(0.2,5.0) == true
				return
			endif
		endIf
	
		if DTTools.getIsSprinting(acActor)
			
			
			if Utility.randomInt(0,10)==0 && DTExpert.okGag(Slot) == true
				DTSound.addSoundToActor(Slot,"breath",Utility.randomInt(0,3),1)
			endif
			
			if Utility.RandomInt(1,10)==1
				DTSound.addSoundToActor(Slot,"pony",2)
			endif
			
			chastityProcess(-1,1)
			chainProcess(-1)
		
			if effectBoots(2.5,4.0,1) == true
				return
			endif			
		
			if effectCorset(1.5,5.0,0.7) == true
				return
			endif				
			if effectHarness(1.5,5.0,0.7) == true
				return
			endif		

			if effectCollar(0.1,4.0,1) == true
				return
			endif				
			
			if effectVaginalPlug(0.1,5.0) == true
				return
			endif
			
		endIf
	
		if DTTools.getIsWalking(acActor)
			chastityProcess(-1,3)
			chainProcess(3)
		
			if effectBoots(0.3,4.0,1) == true
				return
			endif	
			if effectVaginalPlug(0.4,5.0) == true
				return
			endif
		endIf
	endif
  
	if asEventName == "tailSneakLocomotion"
		chastityProcess(-1,3)
		chainProcess(3)
	
		if effectBoots(0.1,4.0,1) == true
			return
		endif	
		if effectVaginalPlug(0.55,5.0) == true
			return
		endif
	endif
	
	if asEventName == "SoundPlay.FSTSwimSwim"
	
	endif
	
	bReady = true
	
EndEvent


;7 = belt
;8 = bra
bool function chastityProcess(int keyNr, int str = 0)
	if DTConfig.effect_chastityBelt_enabled == false && DTConfig.effect_chastityBra_enabled == false
		return false
	endif

	if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[7]) == false && DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[8]) == false
		return false
	endif

	bool alert = false
	
	if keyNr == 7 ||  keyNr == -1		
		if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[7]) == true 
	
			if Utility.RandomInt(1, 100) < DTConfig.effect_chastityBelt_weight				
			
				DTSound.addSoundToActor(Slot,"chastity",str)

			endif
	
		endif
	endif
	
	if keyNr == 8 ||  keyNr == -1		
		if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[8]) == true 
	
			if Utility.RandomInt(1, 100) < DTConfig.effect_chastityBra_weight				
				
				DTSound.addSoundToActor(Slot,"chastity",str)
			endif
	
		endif
	endif
	return true 
endFunction





bool function chainProcess(int keyNr)
	
	
	
	if DTConfig.effect_legcuffs_enabled == false && DTConfig.effect_armcuffs_enabled == false
		return false
	endif
	
	if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[3]) == false && DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[4]) == false
		return false
	endif
	
	bool alert = false
	
	if keyNr == 3 ||  keyNr == -1		
		if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[3]) == true 
	
			if Utility.RandomInt(1, 100) < DTConfig.effect_legcuffs_weight				
				
				if Utility.RandomInt(1, 100) < DTConfig.effect_legcuffs_alert_weight
					DTSound.addSoundToActor(Slot,"chain",2)
						
						if Utility.RandomInt(1, 100) < (DTActor.npcs_legcuffs[slot]*0.95) as int
							DTTools.log("alert ready but not fired (its ok)")
						else
							DTTools.log("alert ready and fired")
							alert = true
						endif
					
				else
					DTSound.addSoundToActor(Slot,"chain",0)
				endif
				
				
			endif
	
		endif
	endif
	
	if keyNr == 4 ||  keyNr == -1
		if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[4]) == true
	
			if Utility.RandomInt(1, 100) < DTConfig.effect_armcuffs_weight				
				
				if Utility.RandomInt(1, 100) < DTConfig.effect_armcuffs_alert_weight
					DTSound.addSoundToActor(Slot,"chain",2)
						if Utility.RandomInt(1, 100) < (DTActor.npcs_armcuffs[Slot] * 0.95) as int
							DTTools.log("alert ready but not fired (its ok)")
						else
							DTTools.log("alert ready and fired")
							alert = true
						endif
				else
					DTSound.addSoundToActor(Slot,"chain",0)
				endif
				
				
			endif
	
		endif
	endif
	
	if alert == true
		
			alertEnemies()
		
		
	endif
	return true 
endFunction

bool function effectBoots(float weight = 1.0, float pause = 5.0, float str = 1.0)
	if DTConfig.training_speed_boots == 0 || DTConfig.effect_boots_enabled == false
		return false
	endif
	
	;if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[0]) == false
	if DTExpert.okBoots(Slot) == false
		return false
	endif


	if  DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_boots,DTConfig.boots_min,DTConfig.boots_max) < 4 && DTTools.getProb(Slot,DTActor.npcs_boots,DTConfig.boots_min,DTConfig.boots_max,DTConfig.effect_boots_weight,weight) == true		
		bReady = false
		RegisterForSingleUpdate(pause)
				
	
		if DTConfig.effect_values_enabled == true		
			float Health = acActor.GetActorValue("health")
			float HealthMod = Health * (str/Utility.randomInt(4,8))
			if Health - HealthMod > 100
				acActor.DamageActorValue("health", HealthMod)				
			endif
			
		
		endif	
		
		
		
		DTSound.addSoundToActor(Slot,"pain",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_boots,DTConfig.boots_min,DTConfig.boots_max),1)
		;DTVisual.setFacialExpression(Slot,"fear")
		DTVisual.addEffect(Slot,DTStorage.DT_Pain)
		DTVisual.cameraShake(Slot,1.0,0.5)
		alertEnemies()
					
					
		;DTUtilities.log(PartName+": play effect corset:Done")
		
		applyArousal(Utility.randomInt(1,10),DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_boots,DTConfig.boots_min,DTConfig.boots_max))
		
			
		
		return true
	endif	
	return false	

endFunction

bool function effectCorset(float weight = 1.0 ,float pause = 5.0, float str = 1.0)

	if DTConfig.training_speed_corset == 0 || DTConfig.effect_corset_enabled == false
		return false
	endif

	if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[1]) == false
		return false
	endif

	if  DTTools.getProb(Slot,DTActor.npcs_corset,DTConfig.corset_min,DTConfig.corset_max,DTConfig.effect_corset_weight,weight) == true		
		
				
		if DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_corset,DTConfig.corset_min,DTConfig.corset_max) < 4
			bReady = false
			RegisterForSingleUpdate(pause)		
			if DTConfig.effect_values_enabled == true
				float Stamina = acActor.GetActorValue("Stamina")
				acActor.DamageActorValue("Stamina", Stamina * (str/4))
				float Magicka = acActor.GetActorValue("Magicka")
				acActor.DamageActorValue("Magicka", Magicka * (str/4))				
			endif
		
			
			
		
			DTSound.addSoundToActor(Slot,"breath",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_corset,DTConfig.corset_min,DTConfig.corset_max),1)
			;DTVisual.setFacialExpression(Slot,"fear")
			;DTVisual.addEffect(Slot,DTVisual.Breath)
			DTVisual.addEffect(Slot,DTStorage.DT_Blackout)
			DTVisual.cameraShake(Slot,0.2,3.0)
			applyArousal(Utility.randomInt(1,10),DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_corset,DTConfig.corset_min,DTConfig.corset_max))
			
				
			
			return true
		else
			return false
			if  DTTools.getProb(Slot,DTActor.npcs_corset,DTConfig.corset_min,DTConfig.corset_max,DTConfig.effect_corset_weight,weight/4) == true	
				bReady = false
				RegisterForSingleUpdate(pause)
				
				DTSound.addSoundToActor(Slot,"breath",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_corset,DTConfig.corset_min,DTConfig.corset_max),1)
				
				return true
			else			
				return false
			endif
		
		endif
				
					
					
		;DTUtilities.log(PartName+": play effect corset:Done")
		
	endif	
	return false
endFunction


bool function effectHarness(float weight = 1.0 ,float pause = 5.0, float str = 1.0)

	if DTConfig.training_speed_harness == 0 || DTConfig.effect_harness_enabled == false
		return false
	endif

	if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[2]) == false
		return false
	endif

	if  DTTools.getProb(Slot,DTActor.npcs_harness,DTConfig.harness_min,DTConfig.harness_max,DTConfig.effect_harness_weight,weight) == true		
		
				
		if DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_harness,DTConfig.harness_min,DTConfig.harness_max) < 4		
			bReady = false
			RegisterForSingleUpdate(pause)
			if DTConfig.effect_values_enabled == true
				float Stamina = acActor.GetActorValue("Stamina")
				acActor.DamageActorValue("Stamina", Stamina * (str/4))
				float Magicka = acActor.GetActorValue("Magicka")
				acActor.DamageActorValue("Magicka", Magicka * (str/4))				
			endif
		
			DTSound.addSoundToActor(Slot,"breath",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_harness,DTConfig.harness_min,DTConfig.harness_max),1)
			;DTVisual.setFacialExpression(Slot,"fear")
			;DTVisual.addEffect(Slot,DTVisual.Breath)
			DTVisual.addEffect(Slot,DTStorage.DT_Blackout)
			DTVisual.cameraShake(Slot,0.2,3.0)
			applyArousal(Utility.randomInt(1,10),DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_harness,DTConfig.harness_min,DTConfig.harness_max))
			
			return true	
		else
			return false
			if  DTTools.getProb(Slot,DTActor.npcs_harness,DTConfig.harness_min,DTConfig.harness_max,DTConfig.effect_harness_weight,weight/4) == true		
			
				bReady = false
				RegisterForSingleUpdate(pause)
				
				DTSound.addSoundToActor(Slot,"breath",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_harness,DTConfig.harness_min,DTConfig.harness_max),1)
				
				return true
			else
				return false
			endif
		endif
				
					
					
		;DTUtilities.log(PartName+": play effect corset:Done")
		
	endif	
	
	
	return false
endFunction



bool function effectCollar(float weight = 1.0 ,float pause = 5.0, float str = 1.0)

	if DTConfig.training_speed_collar == 0 || DTConfig.effect_collar_enabled == false
		return false
	endif

	if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[6]) == false
		return false
	endif

	if  DTTools.getProb(Slot,DTActor.npcs_collar,DTConfig.collar_min,DTConfig.collar_max,DTConfig.effect_collar_weight,weight) == true		
		
				
		if DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_collar,DTConfig.collar_min,DTConfig.collar_max) < 4		
			bReady = false
			RegisterForSingleUpdate(pause)
			
			if DTConfig.effect_values_enabled == true
				float Stamina = acActor.GetActorValue("Stamina")
				acActor.DamageActorValue("Stamina", Stamina * (str/4))
				float Magicka = acActor.GetActorValue("Magicka")
				acActor.DamageActorValue("Magicka", Magicka * (str/4))				
			endif
		
			DTSound.addSoundToActor(Slot,"gasp",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_collar,DTConfig.collar_min,DTConfig.collar_max),1)
			;DTVisual.setFacialExpression(Slot,"fear")
			;DTVisual.addEffect(Slot,DTVisual.Breath)
			DTVisual.addEffect(Slot,DTStorage.DT_Blackout)
			DTVisual.cameraShake(Slot,0.1,1.5)
			applyArousal(Utility.randomInt(1,10),DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_collar,DTConfig.collar_min,DTConfig.collar_max))
			
			return true	
		else
			return false
			if  DTTools.getProb(Slot,DTActor.npcs_collar,DTConfig.collar_min,DTConfig.collar_max,DTConfig.effect_harness_weight,weight/4) == true		
			
				bReady = false
				RegisterForSingleUpdate(pause)
				
				if DTConfig.effect_values_enabled == true
					float Stamina = acActor.GetActorValue("Stamina")
					acActor.RestoreActorValue ("Stamina", Stamina * (str/4))
					float Magicka = acActor.GetActorValue("Magicka")
					acActor.RestoreActorValue ("Magicka", Magicka * (str/4))				
				endif
				
				DTSound.addSoundToActor(Slot,"breath",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_collar,DTConfig.collar_min,DTConfig.collar_max),1)
				
				return true
			else
				return false
			endif
		endif
				
					
					
		;DTUtilities.log(PartName+": play effect corset:Done")
		
	endif	
	
	
	return false
endFunction

bool function effectVaginalPlug(float weight = 1.0 ,float pause = 5.0, float str = 1.0)

	if DTConfig.training_speed_vaginalplug == 0
		return false
	endif

	if DTActor.npcs_ref[Slot].WornHasKeyword(DTConfig.ddKeywords[10]) == false
		return false
	endif

	if Utility.randomInt(0,100) >= DTConfig.effect_vaginalPlug_weight
		return false
	endif
	
	if Utility.randomInt(0,100) >= ( weight * 100 ) as int
		return false
	endif
		
				
		;if DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_vaginalPlug,DTConfig.vaginalPlug_min,DTConfig.vaginalPlug_max) < 4		
			bReady = false
			RegisterForSingleUpdate(pause)
		
			DTSound.addSoundToActor(Slot,"moan",DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_vaginalPlug,DTConfig.vaginalPlug_min,DTConfig.vaginalPlug_max),1)
			int curTraining = DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_vaginalPlug,DTConfig.vaginalPlug_min,DTConfig.vaginalPlug_max)
			if curTraining==0
				DTVisual.cameraShake(Slot,0.4,2.5)
			endif
			if curTraining==1
				DTVisual.cameraShake(Slot,0.3,2.5)
			endif			
			if curTraining==2
				DTVisual.cameraShake(Slot,0.2,2)
			endif
			if curTraining==3
				DTVisual.cameraShake(Slot,0.15,2)
			endif			
			if curTraining==4
				DTVisual.cameraShake(Slot,0.1,2)
			endif			
			if curTraining>=5
				DTVisual.cameraShake(Slot,0.05,2)
			endif			
			applyArousal(Utility.randomInt(1,10),DTTools.getCurrentTrainingStage(Slot,DTActor.npcs_vaginalPlug,DTConfig.vaginalPlug_min,DTConfig.vaginalPlug_max))
			
			return true	
		;else
		;	return false
		;endif
				
					
					
		;DTUtilities.log(PartName+": play effect corset:Done")
		
		
	
	
	return false
endFunction

Event OnUpdate()	
	if bEquip == true
		DTCore.updateVisualEffects(slot)
		bEquip = false
	endIf
		
	bReady = true
	
	
	
EndEvent


function alertEnemies()
	if DTConfig.effect_alert_enabled == true
		spell tmpSpell = DTStorage.DTAlertEnemies			
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
		tmpSpell.cast(DTActor.npcs_ref[slot], DTActor.npcs_ref[slot])
		DTActor.npcs_ref[slot].removeSpell(tmpSpell)
	endif
endFunction


function applyArousal(int value,int level)
	if DTConfig.effect_arousal_enabled == true
	
		DTTools.log("applyArousal input value:"+value)
		DTTools.log("applyArousal input level:"+level)
		
		if DTConfig.effect_arousal_behavior == 1
			value = value * -1
			DTTools.log("invert becouse model is always down")
		endif

		if DTConfig.effect_arousal_behavior == 2
			if level < 4
				value = value * -1
				DTTools.log("invert becouse model is untrained down and level < 4")
			endif
		endif		
		
		if DTConfig.effect_arousal_behavior == 3
			if level >=4
				value = value * -1
				DTTools.log("invert becouse model is trained down and level >= 4")
			endif
		endif	
		
		DTTools.log("applyArousal set value:"+value)
		
		DTTools.changeArousal(DTActor.npcs_ref[Slot],value)	
	
	endif
	
endFunction