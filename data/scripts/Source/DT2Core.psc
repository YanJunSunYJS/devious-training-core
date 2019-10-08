Scriptname DT2Core extends Quest  

DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Actor Property DTActor Auto
DT2Storage Property DTStorage Auto
DT2Descriptor Property DTDescriptor Auto
DT2Expert Property DTExpert Auto
DT2Achievement Property DTAchievement Auto
DT2Sound Property DTSound Auto
DT2Body Property DTBody Auto
DT2Main Property DTMain Auto

SexLabFramework Property sexlab auto

function Process()
	DTTools.log("Start process")
	if DTConfig.modEnabled == false
		return 
	endIf
	DTTools.log("1: Scan actors start")
	;scan
	scanForActors()
	DTTools.log("1: Scan actors stop")
	DTTools.log("2: Calc progress start")
	calcProgress()
	DTTools.log("2: Calc progress stop")
	
	;day counter
	if DTConfig.gameDaysCount != Game.QueryStat("Days Passed") 
		DTConfig.gameDaysCount = Game.QueryStat("Days Passed") 
		newDay()
	endIf
	
	DTTools.log("End process")
endFunction




; --- --- -- - COUNT DAYS (REGISTERED IN THIS MOD) - -- --- --- ;
; will be userfull with tat's and maybe in future - staticstics

function newDay()

	int i 
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i]!= none
			DTActor.count_days[i] = DTActor.count_days[i] + 1
			i+=1
		endIf
	endWhile
endFunction





function calcProgress()
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None && isReadyForWatchdog(DTActor.npcs_ref[i]) == true
			calcActorValues(i)
		else
			if DTActor.npcs_ref[i] !=None
				DTActor.timeout[i] = DTActor.timeout[i] + 1
				;1h = 3600 /10
				if DTActor.timeout[i] > 360
					DTActor.unregisterActor(i)
				endif
			endif
	 	endif
		i+=1
	endWhile
	
	;i = 0
	;while i < DTActor.getArrayCount()
	;	if DTActor.npcs_ref[i] != None  && isReadyForWatchdog(DTActor.npcs_ref[i]) == true
	;		calcActorBuffs(i)
			;updateVisualEffects(i,false)
	 ;	endif
		;i+=1
	;endWhile	
	
	calcActorBuffsEv()
	
endFunction


function calcActorBuffs(int slot)

	if DTConfig.addBuffsAndDebuffs == false
		return
	endif

	if DTConfig.playerSlot != slot && DTConfig.fullProcessing == false
		return
	endIf
	
	float speedBuff = 0
	float carryBuff = 0
	float thiefBuff = 0
	float sneakBuff = 0
	float armorBuff = 0
	float combatBuff = 0
	float staminaBuff = 0
	float healthBuff = 0
	float magicaBuff = 0
	float speedAttackBuff = 0
	float speechBuff = 0	
	float magicBuff = 0
	float maleWeapons = 0
	float rangeWeapons = 0
	
	float buffMult = DTConfig.buffMult * 0.25
	
	
	float analPlugMod =  DTDescriptor.processAnalPlug(slot,   DTConfig.analPlug_min  ,  DTConfig.analPlug_max)
	DTTools.log("3:   Calc stats Start")
	if analPlugMod < 0
		
		speedAttackBuff= speedAttackBuff + (analPlugMod * 0.1)	
	else
		staminaBuff = staminaBuff + (analPlugMod * 0.5)
		magicaBuff = magicaBuff + (analPlugMod * 0.5)
		healthBuff = healthBuff + (analPlugMod * 0.5)
		combatBuff= combatBuff + (analPlugMod * 0.5)	
		carryBuff = carryBuff + (analPlugMod * 0.25)
	endif	
	speedBuff = speedBuff + ( analPlugMod * 0.2  )	
	combatBuff= combatBuff + (analPlugMod * 0.5)		
	
	
	

	float vaginalPlugMod =  DTDescriptor.processVaginalPlug(slot,   DTConfig.vaginalPlug_min  ,  DTConfig.vaginalPlug_max)
	DTTools.log("3:   Calc stats Start")
	if vaginalPlugMod < 0		
		speedAttackBuff= speedAttackBuff + (vaginalPlugMod * 0.1)	
	else
	staminaBuff = staminaBuff + (vaginalPlugMod * 0.5)
	magicaBuff = magicaBuff + (vaginalPlugMod * 0.5)
	healthBuff = healthBuff + (vaginalPlugMod * 0.5)
	carryBuff = carryBuff + (vaginalPlugMod * 0.25)
	endif	
	speedBuff = speedBuff + ( vaginalPlugMod * 0.2  )	
	combatBuff= combatBuff + (vaginalPlugMod * 0.5)		
	
	
	
	
	float blindfoldMod =  DTDescriptor.processBlindfold(slot,   DTConfig.blindfold_min  ,  DTConfig.blindfold_max)	
	if blindfoldMod < 0
		speedBuff = speedBuff + ( blindfoldMod * 0.1  )	
		speedAttackBuff= speedAttackBuff + (blindfoldMod * 0.1)	
	endif
	thiefBuff = thiefBuff + (blindfoldMod * 0.1)
	combatBuff= combatBuff + (blindfoldMod * 0.5)	
	magicaBuff = magicaBuff + (blindfoldMod * 0.5)
	
	
	
	float bootsMod =  DTDescriptor.processBoots(slot,   DTConfig.boots_min  ,  DTConfig.boots_max)
	
	speedBuff = speedBuff + ( bootsMod * 0.5  )
	carryBuff = carryBuff + (bootsMod)
	thiefBuff = thiefBuff + (bootsMod * 0.5)
	combatBuff= combatBuff + (bootsMod * 0.2)
	speedAttackBuff= speedAttackBuff + (bootsMod * 0.1)
	
	
	float corsetMod = DTDescriptor.processCorset(slot,   DTConfig.corset_min  ,  DTConfig.corset_max)
	
	speedBuff = speedBuff + (corsetMod * 0.25 )	
	carryBuff = carryBuff + (corsetMod)
	thiefBuff = thiefBuff + (corsetMod * 0.1)
	armorBuff = armorBuff + (corsetMod * 0.5)
	combatBuff= combatBuff + (corsetMod * 0.5)
	staminaBuff = staminaBuff + (corsetMod * 1)
	magicaBuff = magicaBuff + (corsetMod * 1)
	healthBuff = healthBuff + (corsetMod * 1)
	speedAttackBuff= speedAttackBuff + (corsetMod * 0.1)
	
	float harnessMod = DTDescriptor.processHarness(slot,   DTConfig.harness_min  ,  DTConfig.harness_max)
	
	speedBuff = speedBuff + (harnessMod * 0.1 )	
	carryBuff = carryBuff + (harnessMod * 0.75)
	thiefBuff = thiefBuff + (harnessMod * 0.05)
	armorBuff = armorBuff + (harnessMod * 0.75)
	combatBuff= combatBuff + (harnessMod * 0.3)
	staminaBuff = staminaBuff + (harnessMod * 1)
	magicaBuff = magicaBuff + (harnessMod * 1)
	healthBuff = healthBuff + (harnessMod * 1)
	speedAttackBuff= speedAttackBuff + (harnessMod * 0.1)
	
	float legcuffsMod = DTDescriptor.processLegCuffs(slot,   DTConfig.legcuffs_min  ,  DTConfig.legcuffs_max)
	
	speedBuff = speedBuff + (legcuffsMod * 0.2 )	
	thiefBuff = thiefBuff + (legcuffsMod * 0.05)
	armorBuff = armorBuff + (legcuffsMod * 0.3)
	combatBuff= combatBuff + (legcuffsMod * 0.2)
	speedAttackBuff= speedAttackBuff + (legcuffsMod * 0.05)
	
	float armcuffsMod = DTDescriptor.processArmCuffs(slot,   DTConfig.armcuffs_min  ,  DTConfig.armcuffs_max)
	combatBuff= combatBuff + (armcuffsMod * 0.5)
	thiefBuff = thiefBuff + (armcuffsMod * 0.5)
	armorBuff = armorBuff + (armcuffsMod * 0.15)
	speedAttackBuff= speedAttackBuff + (armcuffsMod * 0.2)
	
	float gagMod = DTDescriptor.processGag(slot,   DTConfig.gag_min  ,  DTConfig.gag_max)
	
	speechBuff = speechBuff  + (gagMod * 1)  
	
	float collarMod = DTDescriptor.processCollar(slot,   DTConfig.collar_min  ,  DTConfig.collar_max)
	combatBuff= combatBuff + (collarMod * 0.3)	
	armorBuff = armorBuff + (collarMod * 0.2)
	staminaBuff = staminaBuff + (collarMod * 0.5)
	magicBuff = magicBuff + (collarMod * 0.5)


	float chastityBeltMod = DTDescriptor.processChastityBelt(slot,   DTConfig.chastityBelt_min  ,  DTConfig.chastityBelt_max)
	staminaBuff = staminaBuff + (chastityBeltMod * 0.5)
	magicBuff = magicBuff + (chastityBeltMod * 0.5)
	combatBuff= combatBuff + (chastityBeltMod * 0.3)
	thiefBuff = thiefBuff + (chastityBeltMod * 0.1)
	armorBuff = armorBuff + (chastityBeltMod * 0.2)
	speedBuff = speedBuff + (chastityBeltMod * 0.3 )	
	speedAttackBuff= speedAttackBuff + (chastityBeltMod * 0.1)
	
	
	float chastityBraMod = DTDescriptor.processChastityBra(slot,   DTConfig.chastityBra_min  ,  DTConfig.chastityBra_max)
	combatBuff= combatBuff + (chastityBraMod * 0.8)
	armorBuff = armorBuff + (chastityBraMod * 0.7)
	speedAttackBuff= speedAttackBuff + (chastityBraMod * 0.2)
	
	
	float glovesMod = DTDescriptor.processGloves(slot, DTConfig.gloves_min, DTConfig.gloves_max)
	combatBuff= combatBuff + (glovesMod * 0.5)
	thiefBuff = thiefBuff + (glovesMod * 0.5)
	armorBuff = armorBuff + (glovesMod * 0.15)
	speedAttackBuff= speedAttackBuff + (glovesMod * 0.2)

	
	float armbinderMod = DTDescriptor.processArmbinder(slot, DTConfig.armbinder_min, DTConfig.armbinder_max) 

	if DTExpert.okArmbinder(slot)==true
		;if DTTools.getCurrentTrainingStage(slot,DTActor.npcs_armbinder,  DTConfig.armbinder_min,  DTConfig.armbinder_max) < 6
			speedBuff = speedBuff + (armbinderMod * 0.25 )	
			carryBuff = carryBuff + (armbinderMod)
		;else
			
		;endif
		
		thiefBuff = thiefBuff + (armbinderMod * 0.1)
		
		;if not trained then remove more armor
		if armbinderMod < 0
			armorBuff = armorBuff + (armbinderMod * 0.5)
		endif
	else
		combatBuff= combatBuff + (armbinderMod * 0.3)
		speedAttackBuff= speedAttackBuff + (armbinderMod * 0.2)
	endif
	
	DTTools.log("3:   Calc stats stage 1 end")
	;arch
	
	;pony girl
	
	;if  DTConfig.achievement_ponygirl_enabled == true && DTActor.achievementPonyGirl[slot] == true &&  ( DTExpert.okBoots(slot) == true || DTActor.npcs_ref[slot].GetWornForm(DTConfig.slotMask[37]) as Armor == DTStorage.DT_PonyGirlHooves)
	;	carryBuff = carryBuff + 50
	;	speedBuff = speedBuff + 10
	;	if carryBuff < 0 
	;		carryBuff = 0 
	;	endIf 
	;	if speedBuff < 0 
	;		speedBuff = 0 
	;	endIf
	;endif
	
	
	
	
	;if DTAchievement.isPonyGirlCondition(slot) == true

	;	speedBuff = speedBuff + ( 85 )	
	;	carryBuff = carryBuff + ( 800 )					
	;endif
	
	DTTools.log("3:   Calc stats stage 2 end ")
	speedBuff = speedBuff * buffMult
	carryBuff = carryBuff * buffMult
	thiefBuff = thiefBuff * buffMult
	sneakBuff = sneakBuff * buffMult
	armorBuff = armorBuff * buffMult
	combatBuff = combatBuff * buffMult
	staminaBuff = staminaBuff * buffMult
	healthBuff = healthBuff * buffMult
	magicaBuff = magicaBuff * buffMult
	speedAttackBuff = speedAttackBuff * buffMult
	speechBuff = speechBuff * buffMult
	magicBuff = magicBuff * buffMult
	maleWeapons = maleWeapons * buffMult
	rangeWeapons = rangeWeapons * buffMult

	if DTConfig.turnoffspeedattack==true
		speedAttackBuff = 0
	endif
	DTTools.log("3:   Calc stats stage 3 end")
	;--------
	;health
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTHealthRegBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTHealthRegBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTHealthRegDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTHealthRegDebuff)
	endIf
	
	if healthBuff < 0
		healthBuff = healthBuff * 0.25
		Spell tmpSpell = DTStorage.DTHealthRegDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * healthBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if healthBuff > 0
		Spell tmpSpell = DTStorage.DTHealthRegBuff
		tmpSpell.SetNthEffectMagnitude(0, healthBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	
	;--------
	;magica
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTMagicaRegBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTMagicaRegBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTMagicaRegDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTMagicaRegDebuff)
	endIf
	
	if magicaBuff < 0
		magicaBuff = magicaBuff * 0.25
		Spell tmpSpell = DTStorage.DTMagicaRegDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * magicaBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if magicaBuff > 0
		Spell tmpSpell = DTStorage.DTMagicaRegBuff
		tmpSpell.SetNthEffectMagnitude(0, magicaBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf	
	
	;--------
	;stamina
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTStaminaRegBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTStaminaRegBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTStaminaRegDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTStaminaRegDebuff)
	endIf
	
	if staminaBuff < 0
		staminaBuff = staminaBuff * 0.25
		Spell tmpSpell = DTStorage.DTStaminaRegDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * staminaBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if staminaBuff > 0
		Spell tmpSpell = DTStorage.DTStaminaRegBuff
		tmpSpell.SetNthEffectMagnitude(0, staminaBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf

	
	;--------
	;combat
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTCombatbuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTCombatbuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTCombatDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTCombatDebuff)
	endIf
	
	if combatBuff < 0
		Spell tmpSpell = DTStorage.DTCombatDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * combatBuff)
		tmpSpell.SetNthEffectMagnitude(1, -1 * combatBuff)	
		tmpSpell.SetNthEffectMagnitude(2, -1 * combatBuff)	
		tmpSpell.SetNthEffectMagnitude(3, -1 * combatBuff)	
		tmpSpell.SetNthEffectMagnitude(4, -1 * combatBuff)		
		tmpSpell.SetNthEffectMagnitude(5, -1 * combatBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if combatBuff > 0
		Spell tmpSpell = DTStorage.DTCombatBuff
		tmpSpell.SetNthEffectMagnitude(0, combatBuff)
		tmpSpell.SetNthEffectMagnitude(1, combatBuff)		
		tmpSpell.SetNthEffectMagnitude(2, combatBuff)		
		tmpSpell.SetNthEffectMagnitude(3, combatBuff)		
		tmpSpell.SetNthEffectMagnitude(4, combatBuff)		
		tmpSpell.SetNthEffectMagnitude(5, combatBuff)				
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf	
	
	;--------
	;armor
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTArmorBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTArmorBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTArmorDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTArmorDebuff)
	endIf
	
	if armorBuff < 0
		Spell tmpSpell = DTStorage.DTArmorDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * armorBuff)
		tmpSpell.SetNthEffectMagnitude(1, -1 * armorBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if armorBuff > 0
		Spell tmpSpell = DTStorage.DTArmorBuff
		tmpSpell.SetNthEffectMagnitude(0, armorBuff)
		tmpSpell.SetNthEffectMagnitude(1, armorBuff)		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	
	
	;--------
	;speech
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTSpeechBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTSpeechBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTSpeechDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTSpeechDebuff)
	endIf
	
	if speechBuff < 0
		Spell tmpSpell = DTStorage.DTSpeechDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * speechBuff)
		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if speechBuff > 0
		Spell tmpSpell = DTStorage.DTSpeechBuff
		tmpSpell.SetNthEffectMagnitude(0, speechBuff)
		
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	
	;--------
	;thief
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTThiefBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTThiefBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTThiefDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTThiefDebuff)
	endIf
	
	if thiefBuff < 0
		Spell tmpSpell = DTStorage.DTThiefDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * thiefBuff)
		tmpSpell.SetNthEffectMagnitude(1, -1 * thiefBuff)
		tmpSpell.SetNthEffectMagnitude(2, -1 * thiefBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if thiefBuff > 0
		Spell tmpSpell = DTStorage.DTThiefBuff
		tmpSpell.SetNthEffectMagnitude(0, thiefBuff)
		tmpSpell.SetNthEffectMagnitude(1, thiefBuff)
		tmpSpell.SetNthEffectMagnitude(2, thiefBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	
	
	;--------
	;carryBuff
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTCarryWeightBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTCarryWeightBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTCarryWeightDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTCarryWeightDebuff)
	endIf
	
	
	if DTConfig.preventCarryWeight > 0 && carryBuff < 0	
		DTTools.log("SPEED REGULATION:")
		float currentValue = DTActor.npcs_ref[slot].GetActorValue("CarryWeight")
		float acceptedValue = 150 +  (DTConfig.preventCarryWeight - 1) * 150
		carryBuff = carryBuff * -1
		
		DTTools.log("SPEED REGULATION currentValue:"+currentValue)
		DTTools.log("SPEED REGULATION acceptedValue:"+acceptedValue)
		DTTools.log("SPEED REGULATION carryBuff:"+carryBuff)
		
		if (currentValue - carryBuff) > acceptedValue
			DTTools.log("SPEED REGULATION NOTHING TO DO")
		else
			
			carryBuff = carryBuff - (acceptedValue - ( currentValue - carryBuff))
			DTTools.log("SPEED REGULATION RECALC 1:"+carryBuff)
			if carryBuff < 0
				carryBuff = 0
			endif
			DTTools.log("SPEED REGULATION RECALC 2:"+carryBuff)
	
		endif
		carryBuff = carryBuff * -1
		DTTools.log("SPEED REGULATION OUTPUT:"+carryBuff)
	endIf
	
	if carryBuff < 0
		Spell tmpSpell = DTStorage.DTCarryWeightDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * carryBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if carryBuff > 0
		Spell tmpSpell = DTStorage.DTCarryWeightBuff
		tmpSpell.SetNthEffectMagnitude(0, carryBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	
	
	
	;--------
	;speedMult
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTSpeedBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTSpeedBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTSpeedDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTSpeedDebuff)
	endIf
	
	
	
	if DTConfig.preventSpeedWalk > 0 && speedBuff < 0	
		DTTools.log("SPEED REGULATION:")
		float currentValue = DTActor.npcs_ref[slot].GetActorValue("SpeedMult")
		float acceptedValue = 50 +  (DTConfig.preventSpeedWalk - 1) * 15
		speedBuff = speedBuff * -1
		
		DTTools.log("SPEED REGULATION currentValue:"+currentValue)
		DTTools.log("SPEED REGULATION acceptedValue:"+acceptedValue)
		DTTools.log("SPEED REGULATION speedBuff:"+speedBuff)
		
		if (currentValue - speedBuff) > acceptedValue
			DTTools.log("SPEED REGULATION NOTHING TO DO")
		else
			
			speedBuff = speedBuff - (acceptedValue - ( currentValue - speedBuff))
			DTTools.log("SPEED REGULATION RECALC 1:"+speedBuff)
			if speedBuff < 0
				speedBuff = 0
			endif
			DTTools.log("SPEED REGULATION RECALC 2:"+speedBuff)
	
		endif
		speedBuff = speedBuff * -1
		DTTools.log("SPEED REGULATION OUTPUT:"+speedBuff)
	endIf
	
	if speedBuff > 100
		speedBuff = 100
	endIf
	if speedBuff < -50
		speedBuff = -50
	endIf
	
	;speedBuff = 100 + speedBuff
		
	if speedBuff < 0
		
		Spell tmpSpell = DTStorage.DTSpeedDebuff
		tmpSpell.SetNthEffectMagnitude(0, -1 * speedBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if speedBuff > 0
		Spell tmpSpell = DTStorage.DTSpeedBuff
		tmpSpell.SetNthEffectMagnitude(0, speedBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	
	
	
	;--------
	;speedAttack
	;--------
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTSpeedAttackBuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTSpeedAttackBuff)
	endIf
	if DTActor.npcs_ref[slot].hasSpell(DTStorage.DTSpeedAttackDebuff)
		DTActor.npcs_ref[slot].removeSpell(DTStorage.DTSpeedAttackDebuff)
	endIf
	
	
	
	;if DTConfig.preventSpeedWalk > 0 && speedBuff < 0	
	;	DTTools.log("SPEED REGULATION:")
	;	float currentValue = DTActor.npcs_ref[slot].GetActorValue("SpeedMult")
	;	float acceptedValue = 50 +  (DTConfig.preventSpeedWalk - 1) * 15
	;	speedBuff = speedBuff * -1
		
	;	DTTools.log("SPEED REGULATION currentValue:"+currentValue)
	;	DTTools.log("SPEED REGULATION acceptedValue:"+acceptedValue)
	;	DTTools.log("SPEED REGULATION speedBuff:"+speedBuff)
		
	;	if (currentValue - speedBuff) > acceptedValue
	;		DTTools.log("SPEED REGULATION NOTHING TO DO")
	;	else
			
	;		speedBuff = speedBuff - (acceptedValue - ( currentValue - speedBuff))
	;		DTTools.log("SPEED REGULATION RECALC 1:"+speedBuff)
	;		if speedBuff < 0
	;			speedBuff = 0
	;		endif
	;		DTTools.log("SPEED REGULATION RECALC 2:"+speedBuff)
	
	;	endif
	;	speedBuff = speedBuff * -1
	;	DTTools.log("SPEED REGULATION OUTPUT:"+speedBuff)
	;endIf
	

	speedAttackBuff = speedAttackBuff/400
	
	
	if speedAttackBuff > 1.5
		speedAttackBuff = 1.5
	endIf
	if speedAttackBuff < -1.5
		speedAttackBuff = -1.5
	endIf
	DTTools.log("speedAttack:"+speedAttackBuff)
		
	if speedAttackBuff < 0
		
		Spell tmpSpell = DTStorage.DTSpeedAttackDebuff
		tmpSpell.SetNthEffectMagnitude(0, 1 + speedAttackBuff)
		tmpSpell.SetNthEffectMagnitude(1, 1 + speedAttackBuff)
		tmpSpell.SetNthEffectMagnitude(2, 1 + speedAttackBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	if speedAttackBuff > 0
		Spell tmpSpell = DTStorage.DTSpeedAttackBuff
		tmpSpell.SetNthEffectMagnitude(0, 1 + speedAttackBuff)
		tmpSpell.SetNthEffectMagnitude(1, 1 + speedAttackBuff)
		tmpSpell.SetNthEffectMagnitude(2, 1 + speedAttackBuff)
		DTActor.npcs_ref[slot].addSpell(tmpSpell,false)
	endIf
	
	;additional scripts
	;DTTools.changeGagOptions(1.0)
	
	if Utility.RandomInt(1,3)==1
		DTSound.addSoundToActor(Slot,"pony",3)
	endif
	
	DTTools.log("-- Devious Training Table --")
	DTTools.log("  speedBuff:"+speedBuff)
	DTTools.log("  carryBuff:"+carryBuff)
	DTTools.log("----------------------------")
	
	DTTools.log("3:   Calc stats stage 4 end and finish")
	
	
endFunction


string function itemNameToName(String name)

	if name == "analplug"
		return "Anal Plug";
	endIf
	if name == "vaginalplug"
		return "Vaginal Plug";
	endIf
	
	if name == "boots"
		return "Boots";
	endIf

	if name == "corset"
		return "Corset";
	endIf	
	
	if name == "harness"
		return "Harness";
	endIf			
	
	if name == "legscuffs"
		return "Legs Cuffs";
	endIf		

	if name == "armscuffs"
		return "Arms Cuffs";
	endIf			

	if name == "gag"
		return "Gag";
	endIf			

	if name == "collar"
		return "Collar";
	endIf			
	
	if name == "chastitybelt"
		return "Chastity Belt";
	endIf				

	if name == "chastitybra"
		return "Chastity Bra";
	endIf				
	
	if name == "gloves"
		return "Gloves";
	endIf			
	
	if name == "armbinderyoke"
		return "Armbinder & Yoke";
	endIf			

	if name == "blindfold"
		return "Blindfold";
	endIf			
	
	
	
endFunction


function calcActorValues(int slot)

	String actorName = DTActor.npcs_ref[slot].GetLeveledActorBase().GetName()

	DTTools.log("1 -Summary: "+actorName+" - boots"+DTActor.npcs_boots[slot])
	DTTools.log("1- Summary: "+actorName+" - corset"+DTActor.npcs_corset[slot])
	DTTools.log("1- Summary: "+actorName+" - harness"+DTActor.npcs_harness[slot])
	DTTools.log("1- Summary: "+actorName+" - armcuffs"+DTActor.npcs_armcuffs[slot])
	DTTools.log("1- Summary: "+actorName+" - legcuffs"+DTActor.npcs_legcuffs[slot])
	DTTools.log("1- Summary: "+actorName+" - gag"+DTActor.npcs_gag[slot])	
	DTTools.log("1- Summary: "+actorName+" - collar"+DTActor.npcs_collar[slot])	
	DTTools.log("1- Summary: "+actorName+" - Chastity belt"+DTActor.npcs_chastityBelt[slot])	
	DTTools.log("1- Summary: "+actorName+" - Chastity bra"+DTActor.npcs_chastityBra[slot])	
	DTTools.log("1- Summary: "+actorName+" - Gloves"+DTActor.npcs_gloves[slot])
	DTTools.log("1- Summary: "+actorName+" - Armbinder"+DTActor.npcs_armbinder[slot])
	DTTools.log("1- Summary: "+actorName+" - Blindfold"+DTActor.npcs_blindfold[slot])
	
	DTTools.log("1- Summary: "+actorName+" - AnalPlug"+DTActor.npcs_analPlug[slot])
	DTTools.log("1- Summary: "+actorName+" - VaginalPlug"+DTActor.npcs_vaginalPlug[slot])
	
	int countWalk = DTActor.countWalk[slot]
	int countRun = DTActor.countRun[slot]
	int countSprint = DTActor.countSprint[slot]
	int countAttack = DTActor.countAttack[slot]
	int countJump = DTActor.countJump[slot]
	int countSwim = DTActor.countSwim[slot]
	int countSneak = DTActor.countSneak[slot]
	int countHorse = DTActor.countHorse[slot]
	int countSpeak = DTActor.countSpeak[slot]
	int countHit = DTActor.countHit[slot]
	
	DTActor.countWalk[slot] = 0
	DTActor.countRun[slot] = 0
	DTActor.countSprint[slot] = 0 
	DTActor.countAttack[slot] = 0
	DTActor.countJump[slot] = 0
	DTActor.countSwim[slot] = 0
	DTActor.countSneak[slot] = 0
	DTActor.countHorse[slot] = 0
	DTActor.countSpeak[slot] = 0
	DTActor.countHit[slot] = 0
	
	;0 - walk
	;1 - run
	;2 - sprint
	;3 - sneak
	;4 - jump
	;5 - attack
	;6 - swim
	;7 - horse
	;8 - speak
	
	Float[] modificators = new Float[10]
	int score = 0
	bool wearedItem = false
	
	;--------
	;BOOTS
	;--------
		
	;wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[0])
	wearedItem = DTExpert.okBoots(slot)
	
	if wearedItem || DTActor.npcs_boots[slot] > 0
		modificators[0] = 0.010 * countWalk
		modificators[1] = 0.010 * countRun
		modificators[2] = 0.030 * countSprint
		modificators[3] = 0.010 * countSneak
		modificators[4] = 0.040 * countJump
		modificators[5] = 0.005 * countAttack
		modificators[6] = 0.000 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.005 * countHit
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_boots, DTConfig.training_speed_boots, DTConfig.training_speed_boots, modificators, -0.08, DTConfig.boots_min, DTConfig.boots_max,"boots")
	else
		DTActor.npcs_boots[slot]  = -1
	endIf
	
	;--------
	;CORSET
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[1])
	
	if wearedItem || DTActor.npcs_corset[slot] > 0
		modificators[0] = 0.008 * countWalk
		modificators[1] = 0.008 * countRun
		modificators[2] = 0.030 * countSprint
		modificators[3] = 0.020 * countSneak
		modificators[4] = 0.002 * countJump
		modificators[5] = 0.050 * countAttack
		modificators[6] = 0.005 * countSwim
		modificators[7] = 0.010 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.025 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_corset, DTConfig.training_speed_corset, DTConfig.training_speed_corset, modificators, -0.08, DTConfig.corset_min, DTConfig.corset_max,"corset")
	else
		DTActor.npcs_corset[slot] = -1
	endIf
	
	;--------
	;HARNESS
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[2])
	
	if wearedItem || DTActor.npcs_harness[slot] > 0
		modificators[0] = 0.008 * countWalk
		modificators[1] = 0.008 * countRun
		modificators[2] = 0.030 * countSprint
		modificators[3] = 0.020 * countSneak
		modificators[4] = 0.002 * countJump
		modificators[5] = 0.050 * countAttack
		modificators[6] = 0.005 * countSwim
		modificators[7] = 0.010 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.025 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_harness, DTConfig.training_speed_harness, DTConfig.training_speed_harness, modificators, -0.08, DTConfig.harness_min, DTConfig.harness_max,"harness")
	else
		DTActor.npcs_harness[slot] = -1
	endIf
	
	;--------
	;LEG CUFFS
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[3])
	
	if wearedItem || DTActor.npcs_legcuffs[slot] > 0
		modificators[0] = 0.015 * countWalk
		modificators[1] = 0.018 * countRun
		modificators[2] = 0.020 * countSprint
		modificators[3] = 0.015 * countSneak
		modificators[4] = 0.010 * countJump
		modificators[5] = 0.010 * countAttack
		modificators[6] = 0.025 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.010 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_legcuffs, DTConfig.training_speed_legcuffs, DTConfig.training_speed_legcuffs, modificators, -0.08, DTConfig.legcuffs_min, DTConfig.legcuffs_max,"legscuffs")
	else
		DTActor.npcs_legcuffs[slot] = -1
	endIf
	
	;--------
	;ARM CUFFS
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[4])
	
	if wearedItem || DTActor.npcs_armcuffs[slot] > 0
		modificators[0] = 0.005 * countWalk
		modificators[1] = 0.010 * countRun
		modificators[2] = 0.010 * countSprint
		modificators[3] = 0.008 * countSneak
		modificators[4] = 0.010 * countJump
		modificators[5] = 0.055 * countAttack
		modificators[6] = 0.045 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.010 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_armcuffs, DTConfig.training_speed_armcuffs, DTConfig.training_speed_armcuffs, modificators, -0.08, DTConfig.armcuffs_min, DTConfig.armcuffs_max,"armscuffs")
	else
		DTActor.npcs_armcuffs[slot] = -1
	endIf	
	
	
	;--------
	;GAG
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[5])
	
	if wearedItem || DTActor.npcs_armcuffs[slot] > 0
		modificators[0] = 0.005 * countWalk
		modificators[1] = 0.007 * countRun
		modificators[2] = 0.010 * countSprint
		modificators[3] = 0.001 * countSneak
		modificators[4] = 0.000 * countJump
		modificators[5] = 0.005 * countAttack
		modificators[6] = 0.025 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.300 * countSpeak
		modificators[9] = 0.001 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_gag, DTConfig.training_speed_gag, DTConfig.training_speed_gag, modificators, -0.08, DTConfig.gag_min, DTConfig.gag_max,"gag")
	else
		DTActor.npcs_gag[slot] = -1
	endIf	


	;--------
	;COLLAR
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[6])
	
	if wearedItem || DTActor.npcs_collar[slot] > 0
		modificators[0] = 0.005 * countWalk
		modificators[1] = 0.007 * countRun
		modificators[2] = 0.009 * countSprint
		modificators[3] = 0.004 * countSneak
		modificators[4] = 0.01 * countJump
		modificators[5] = 0.050 * countAttack
		modificators[6] = 0.005 * countSwim
		modificators[7] = 0.010 * countHorse
		modificators[8] = 0.001 * countSpeak
		modificators[9] = 0.010 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_collar, DTConfig.training_speed_collar, DTConfig.training_speed_collar, modificators, -0.08, DTConfig.collar_min, DTConfig.collar_max,"collar")
	else
		DTActor.npcs_collar[slot] = -1
	endIf		
	
	
	;--------
	;CHASTITY BELT
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[7])
	
	if wearedItem || DTActor.npcs_chastityBelt[slot] > 0
		modificators[0] = 0.005 * countWalk
		modificators[1] = 0.007 * countRun
		modificators[2] = 0.015 * countSprint
		modificators[3] = 0.003 * countSneak
		modificators[4] = 0.015 * countJump
		modificators[5] = 0.002 * countAttack
		modificators[6] = 0.006 * countSwim
		modificators[7] = 0.010 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.040 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_chastityBelt, DTConfig.training_speed_chastityBelt, DTConfig.training_speed_chastityBelt, modificators, -0.08, DTConfig.chastityBelt_min, DTConfig.chastityBelt_max,"chastitybelt")
	else
		DTActor.npcs_chastityBelt[slot] = -1
	endIf		


	;--------
	;CHASTITY BRA
	;--------
		
	wearedItem = DTActor.npcs_ref[slot].WornHasKeyword(DTConfig.ddKeywords[8])
	
	if wearedItem || DTActor.npcs_chastityBra[slot] > 0
		modificators[0] = 0.001 * countWalk
		modificators[1] = 0.002 * countRun
		modificators[2] = 0.010 * countSprint
		modificators[3] = 0.002 * countSneak
		modificators[4] = 0.008 * countJump
		modificators[5] = 0.090 * countAttack
		modificators[6] = 0.002 * countSwim
		modificators[7] = 0.010 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.030 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_chastityBra, DTConfig.training_speed_chastityBra, DTConfig.training_speed_chastityBra, modificators, -0.08, DTConfig.chastityBra_min, DTConfig.chastityBra_max,"chastitybra")
	else
		DTActor.npcs_chastityBra[slot] = -1
	endIf	
	
	;--------
	;GLOVES
	;--------
		
	wearedItem = DTExpert.okGloves(slot)
	
	if wearedItem || DTActor.npcs_gloves[slot] > 0
		modificators[0] = 0.005 * countWalk
		modificators[1] = 0.010 * countRun
		modificators[2] = 0.010 * countSprint
		modificators[3] = 0.008 * countSneak
		modificators[4] = 0.010 * countJump
		modificators[5] = 0.055 * countAttack
		modificators[6] = 0.045 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.010 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_gloves, DTConfig.training_speed_gloves, DTConfig.training_speed_gloves, modificators, -0.08, DTConfig.gloves_min, DTConfig.gloves_max,"gloves")
	else
		DTActor.npcs_gloves[slot] = -1
	endIf	
	
	
	;--------
	;ARMBINDER
	;--------
		
	wearedItem = DTExpert.okArmbinder(slot)
	
	if wearedItem || DTActor.npcs_armbinder[slot] > 0
		modificators[0] = 0.010 * countWalk
		modificators[1] = 0.020 * countRun
		modificators[2] = 0.030 * countSprint
		modificators[3] = 0.010 * countSneak
		modificators[4] = 0.035 * countJump
		modificators[5] = 0.010 * countAttack
		modificators[6] = 0.015 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.000 * countSpeak
		modificators[9] = 0.080 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_armbinder, DTConfig.training_speed_armbinder, DTConfig.training_speed_armbinder, modificators, -0.08, DTConfig.armbinder_min, DTConfig.armbinder_max,"armbinderyoke")
	else
		DTActor.npcs_armbinder[slot] = -1
	endIf	
	
	;--------
	;BLINDFOLD
	;--------
		
	wearedItem = DTExpert.okBlindfold(slot)
	
	if wearedItem || DTActor.npcs_blindfold[slot] > 0
		modificators[0] = 0.010 * countWalk
		modificators[1] = 0.020 * countRun
		modificators[2] = 0.030 * countSprint
		modificators[3] = 0.010 * countSneak
		modificators[4] = 0.001 * countJump
		modificators[5] = 0.050 * countAttack
		modificators[6] = 0.015 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.001 * countSpeak
		modificators[9] = 0.080 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_blindfold, DTConfig.training_speed_blindfold, DTConfig.training_speed_blindfold, modificators, -0.08, DTConfig.blindfold_min, DTConfig.blindfold_max,"blindfold")
	else
		DTActor.npcs_blindfold[slot] = -1
	endIf	
	

	;--------
	;VAGINAL PLUG
	;--------
		
	wearedItem = DTExpert.okVaginalPlug(slot)
	
	if wearedItem || DTActor.npcs_vaginalPlug[slot] > 0
		modificators[0] = 0.010 * countWalk
		modificators[1] = 0.025 * countRun
		modificators[2] = 0.030 * countSprint
		modificators[3] = 0.010 * countSneak
		modificators[4] = 0.050 * countJump
		modificators[5] = 0.030 * countAttack
		modificators[6] = 0.015 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.001 * countSpeak
		modificators[9] = 0.001 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_vaginalPlug, DTConfig.training_speed_vaginalplug, DTConfig.training_speed_vaginalplug, modificators, -0.08, DTConfig.vaginalPlug_min, DTConfig.vaginalPlug_max, "vaginalplug")
	else
		DTActor.npcs_vaginalPlug[slot] = -1
	endIf	
	
	;--------
	;ANAL PLUG
	;--------
		
	wearedItem = DTExpert.okAnalPlug(slot)
	
	if wearedItem || DTActor.npcs_analPlug[slot] > 0
		modificators[0] = 0.010 * countWalk
		modificators[1] = 0.020 * countRun
		modificators[2] = 0.040 * countSprint
		modificators[3] = 0.010 * countSneak
		modificators[4] = 0.050 * countJump
		modificators[5] = 0.055 * countAttack
		modificators[6] = 0.015 * countSwim
		modificators[7] = 0.000 * countHorse
		modificators[8] = 0.001 * countSpeak
		modificators[9] = 0.002 * countHit
		
		score = score + calculateLevel(slot, wearedItem, DTActor.npcs_analPlug, DTConfig.training_speed_analplug, DTConfig.training_speed_analplug, modificators, -0.08, DTConfig.analPlug_min, DTConfig.analPlug_max, "analplug")
	else
		DTActor.npcs_analPlug[slot] = -1
	endIf		
	
	
	if score == 0
		DTActor.unregisterActor(slot)
	endIf
	
	
	
	;-------achievements
	
	;DTAchievement.tryPonyGirl(slot)
	;DTAchievement.tryBlindSlut(slot)
	
	
	DTTools.log("2 -Summary: "+actorName+" - boots"+DTActor.npcs_boots[slot])
	DTTools.log("2- Summary: "+actorName+" - corset"+DTActor.npcs_corset[slot])
	DTTools.log("2- Summary: "+actorName+" - harness"+DTActor.npcs_harness[slot])
	DTTools.log("2- Summary: "+actorName+" - armcuffs"+DTActor.npcs_armcuffs[slot])
	DTTools.log("2- Summary: "+actorName+" - legcuffs"+DTActor.npcs_legcuffs[slot])	
	DTTools.log("2- Summary: "+actorName+" - gag"+DTActor.npcs_gag[slot])	
	DTTools.log("2- Summary: "+actorName+" - collar"+DTActor.npcs_collar[slot])	
	DTTools.log("2- Summary: "+actorName+" - Chastity belt"+DTActor.npcs_chastityBelt[slot])	
	DTTools.log("2- Summary: "+actorName+" - Chastity bra"+DTActor.npcs_chastityBra[slot])		
	DTTools.log("2- Summary: "+actorName+" - Gloves"+DTActor.npcs_gloves[slot])	
	DTTools.log("2- Summary: "+actorName+" - Armbinder"+DTActor.npcs_armbinder[slot])	
	DTTools.log("2- Summary: "+actorName+" - Blindfold"+DTActor.npcs_blindfold[slot])	
endFunction

int function calculateLevel(int slot,bool wearItem, Float[] processedArray, int progressInc, int progressDec, Float[] modificators, float dec, float minRange, float maxRange, String nameItem)
	DTTools.log("Calc is started " + nameItem)	
	;DTTools.log("Slot:"+slot+" wear:"+wearItem+" Level:"+processedArray[slot])
	
	;DTTools.log("progressInc:"+progressInc)
	if progressInc == 0
		processedArray[slot] = -1
		return 0
	endif

	float speedAdd = progressInc as float
	float speedDec = progressDec as float
	
	;DTTools.log("wearItem:"+wearItem)
	if wearItem == false 
		if processedArray[slot] < 0		
			processedArray[slot] = -1
			return 0
		endif
	else
		if processedArray[slot] < 0	
			processedArray[slot] = 0
		endif
	endif
	
	
	
	if speedAdd == 0
		processedArray[slot] = -1
		return 0
	endif
	
	;if processedArray[slot] < 0
	;	processedArray[slot] = 0
	;endif
	
	float total = 0.0
	float lastKnowTotal = processedArray[slot]
	
	int i = modificators.length

	;DTTools.log("modificators:"+modificators)
	while i > 0
		i -= 1
		total = total + modificators[i]
	endWhile
	
	;DTTools.log("total:"+total)
	;save old values
	int oldLevel = DTTools.getCurrentTrainingStage(slot,processedArray,  minRange,  maxRange)
	float oldValue = processedArray[slot]
	
	
	
	if wearItem == true
		if total > 0
			if speedAdd  < 6
				total = total * (speedAdd/5) as float
			else
				total = total * 20 
			endif	
		else			
			total = dec
			if speedDec < 6			
				total = total * (speedDec/5) as float
			else
				total = total * 20
			endif			
		endIf
	
	else
			total = dec
			if speedDec < 6			
				total = total * (speedDec/5) as float
			else
				total = total * 20
			endif
	endif
	
	processedArray[slot] = processedArray[slot] + total	
	
	if processedArray[slot] < 0
		processedArray[slot] = 0
	endIf
	
	if processedArray[slot] > 100
		processedArray[slot] = 100
	endIf
	
	
	;save old values
	
	;newValue = processedArray[slot]	
	
	;correct with model
	
	;in debuff case only
	if DTConfig.training_level_model == 1
		if oldLevel >= 4 && total < 0
			processedArray[slot] = oldValue
		endif
	endIf

	if DTConfig.training_level_model == 2
		if oldLevel < 4 && total < 0
			processedArray[slot] = oldValue
		endif
	endIf	

	;if not master level
	if DTConfig.training_level_model == 3
		if oldLevel == 6 && total < 0
			processedArray[slot] = oldValue
		endif
	endIf		
	
	;never
	if  DTConfig.training_level_model == 4
		if total < 0
			processedArray[slot] = oldValue
		endif
	endIf
	
	DTTools.log("Calc is finished (almost)")	
	int newLevel = DTTools.getCurrentTrainingStage(slot,processedArray,  minRange,  maxRange)
	if oldLevel!=newLevel && slot == DTConfig.playerSlot
	DTTools.log("Need to update stats" + nameItem)	
		DTActor.updateFactions(i)
		
		int handle = ModEvent.Create("DT_ActorLevelChange") 
		ModEvent.PushForm(handle, DTActor.npcs_ref[i] as Form) 
		ModEvent.PushInt(handle, i)	
		ModEvent.PushString(handle, nameItem)
		ModEvent.PushInt(handle, oldLevel)
		ModEvent.PushInt(handle, newLevel)
		ModEvent.Send(handle)
		
		debug.notification(itemNameToName(nameItem)+": "+DTTools.getCurrentTrainingStageName(newLevel))
		
		;blindfold
		if processedArray == DTActor.npcs_blindfold
			if DTConfig.effect_blindfold_enabled == true
				if DTConfig.allowChangeDeviousDevices == true
					DTConfig.shadowShader = 0.8 - (newLevel * 0.1)
					DTTools.reconfigureIntegration()
					if  DTExpert.okBlindfold(slot)==true
						int iCameraState = Game.GetCameraState()
						if iCameraState == 0
							game.ForceThirdPerson()
							game.ForceFirstPerson()
						else
							game.ForceFirstPerson()
							game.ForceThirdPerson()
						endif
					endif
				endif
			endif
		endif
		
		
	endIf
	
	
	DTTools.log("Calc is ended " + nameItem)	
	;trick :)
	return 1
	
endFunction





;	update all visual effects
;	int  slot  = slot of current actor
;	bool force = extra flag to update nio elements

function updateVisualEffects(int slot, bool force = false, bool newDay = false)
	return 
	DTTools.log("Call DTCore::updateVisualEffects()",0)

	;check current processing
	
	if DTActor.npcs_ref[slot]==None
		return
	endIf
	
	if DTTools.isValid(DTActor.npcs_ref[slot])==false
		return
	endIf
	
	if DTActor.npcs_isBusy[slot] == true
		;wait 0.5s and try again
	
		Utility.wait(0.25)
		
		;if DTActor.npcs_isBusy[slot] == true
		;	return 
		;endIf
		
		;to understand recursion you need to understand recursion...
		DTTools.log("recursive updateVisualEffects (actor is busy now)")
		updateVisualEffects(slot,force)
		return
	endIf
	
	
	;mark as busy
	DTActor.npcs_isBusy[slot] = true
	
	;feet
	DTBody.setArchedFeet(DTActor.npcs_ref[slot], DTTools.getCurrentTrainingStage(slot, DTActor.npcs_boots, DTConfig.boots_min, DTConfig.boots_max))
	
	;additional items
	;DTAchievement.addAchievementItems(slot)
	
	;crawl
	DTBody.forceToAllFours(DTActor.npcs_ref[slot], DTTools.getCurrentTrainingStage(slot, DTActor.npcs_boots, DTConfig.boots_min, DTConfig.boots_max),force)
	
	;jaw
	DTBody.setOpenJaw(DTActor.npcs_ref[slot], slot)
	
	;eyses
	DTBody.setOpenEyes(DTActor.npcs_ref[slot], slot)
	
	;if force then update nio 
	if force == true || DTConfig.updateOnlyWithCellChange == false
		DTBody.setWaistScale(DTActor.npcs_ref[slot],DTActor.npcs_corset[slot])
		DTBody.setNeckScale(DTActor.npcs_ref[slot],DTActor.npcs_collar[slot])
	
		DTBody.applyTatsGroup1(DTActor.npcs_ref[slot],slot)
	endif
	
	if newDay == true
		DTBody.setActorWeight(DTActor.npcs_ref[slot],DTActor.bodyPointer[slot])
		DTBody.setBreast(DTActor.npcs_ref[slot],DTBody.calcBreastScale(DTActor.npcs_ref[slot] ,slot))
		DTBody.setBelly(DTActor.npcs_ref[slot],DTActor.bodyPointer[slot])
		DTBody.setButt(DTActor.npcs_ref[slot],DTActor.bodyPointer[slot])
		DTBody.applyDaysTats(DTActor.npcs_ref[slot],slot)
	endif
	
	;unmark
	DTActor.npcs_isBusy[slot] = false
	Game.UpdateHairColor()		
endFunction







function scanForActors()
	Actor[] actors
	actors = DTTools.getActors(DTConfig.playerRef)
	
	int i = actors.length
	
	while i > 0
		i -= 1
		if actors[i]!=None
			
			if DTActor.isRegistered(actors[i]) == -1
				if DTTools.isValid(actors[i]) == true && DTTools.isCorrectType(actors[i]) && DTTools.isDDWearer(actors[i]) 
					int slot = DTActor.registerActor(actors[i])	
					if slot>-1
						DTTools.log("Register actor "+actors[i].GetLeveledActorBase().GetName())
					endif
				endIf
			endIf
		endif
	endWhile
	
endFunction



function onLocationChangeExecute(bool complex=true)
	DTTools.log("Change location - START")
	if DTConfig.modEnabled==false		
		return
	endIf
	DTMain.turnOffMod()
	
	
	
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None
			DTTools.log("Change location - PROCESS ACTOR:"+i)
			if DTActor.npcs_ref[i].hasSpell(DTStorage.DTWatchdogMain)
				DTActor.npcs_ref[i].removeSpell(DTStorage.DTWatchdogMain)				
			endif			
			
			if DTActor.npcs_ref[i].hasSpell(DTStorage.DTWatchdogEffects)
				DTActor.npcs_ref[i].removeSpell(DTStorage.DTWatchdogEffects)				
			endif
			DTActor.npcs_ref[i].addSpell(DTStorage.DTWatchdogMain,false)
			
			if isReadyForWatchdog(DTActor.npcs_ref[i]) == true
				DTActor.npcs_ref[i].addSpell(DTStorage.DTWatchdogEffects,false)
				updateVisualEffects(i,true)
			endif
			
			
			if DTActor.npcs_ref[i].hasSpell(DTStorage.DT_Achievement_BlindSlut)
					DTActor.npcs_ref[i].removeSpell(DTStorage.DT_Achievement_BlindSlut)				
			endif
			;if DTAchievement.isBlindSlutConditionLite(i) == true			
			;	DTActor.npcs_ref[i].addSpell(DTStorage.DT_Achievement_BlindSlut,false)
			;endif
			
	 	endif
		i+=1
	endWhile
	
	
	
	
	
	Game.UpdateHairColor()
	DTMain.turnOnMod(10.0)
	DTTools.log("Change location - STOP")
endFunction




bool function isReadyForWatchdog(actor acActor)
	if acActor.Is3DLoaded()
		return true
	endif
	
	return false
endFunction




;---------------------------------------------------------
;SEXLAB SECTION
;---------------------------------------------------------
function unregisterSexLabEvents()
	UnregisterForModEvent("HookOrgasmEnd")
	UnregisterForModEvent("HookOrgasmEnd")
	UnregisterForModEvent("DT_Ping")
	UnregisterForModEvent("DT_AdditionalStats")
	UnregisterForModEvent("DT_ForceToCalcBuffs")
	
endFunction

function registerSexLabEvents()
	if DTConfig.separateOrgasmPack == false
		RegisterForModEvent("HookOrgasmEnd", "DTOrgasm")		
	else
		RegisterForModEvent("SexLabOrgasmSeparate","DTOrgasmS")
	endIf
	
	RegisterForModEvent("DT_Ping","pingEvent")
	RegisterForModEvent("DT_AdditionalStats","additionalStatsEvent")
	RegisterForModEvent("DT_ForceToCalcBuffs","forceToCalcBuffs")
	
endFunction

Event forceToCalcBuffs()
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None  && isReadyForWatchdog(DTActor.npcs_ref[i]) == true
			calcActorBuffs(i)
			;updateVisualEffects(i,false)
	 	endif
		i+=1
	endWhile	
endEvent

Function sendStatus(String status="")
	DTTools.log("Send status:"+status)
	int handle = ModEvent.Create("DT_SendStatus")
 	ModEvent.PushString(handle, status)	
	ModEvent.Send(handle)
endFunction

Event pingEvent(String modName="")

	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None
	
			int handle = ModEvent.Create("DT_CheckActor"+modName) 
			ModEvent.PushForm(handle, DTActor.npcs_ref[i] as Form) 	
			ModEvent.PushInt(handle, i)	
			ModEvent.Send(handle)
			Utility.wait(0.5)
	
		endif
	i = i + 1
	endwhile

endEvent

Event additionalStatsEvent(String modName="")
;debug.notification(modName)
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None
	
			int handle = ModEvent.Create("DT_AdditionalStatsActor"+modName) 
			ModEvent.PushForm(handle, DTActor.npcs_ref[i] as Form) 	
			ModEvent.PushInt(handle, i)	
			ModEvent.PushInt(handle, DTActor.count_orgasm[i])
			ModEvent.PushInt(handle, DTActor.count_steps[i])
			ModEvent.PushInt(handle, DTActor.count_dmg[i])
			ModEvent.PushInt(handle, DTActor.count_dmgZad[i])
			ModEvent.PushInt(handle, DTActor.count_days[i])
			ModEvent.Send(handle)
			Utility.wait(2.0)
	
		endif
	i = i + 1
	endwhile

endEvent


;tags 
;Vaginal
;Oral
;Anal
Event DTOrgasm(int thread, bool hasPlayer)
	SslThreadController threadctrl = SexLab.GetController(thread)
	SslBaseAnimation anim = threadctrl.Animation
	String[] tags = anim.GetTags()
	Actor[] actors = threadctrl.Positions	
	int i = actors.length
	while i > 0
    i -= 1	
		processActorSex(actors[i],tags)
	endwhile
	 
	
EndEvent

Event DTOrgasmS(Form ActorRef, Int Thread)
	actor akActor = ActorRef as actor
	string argString = Thread as string
	
	SslThreadController threadctrl = SexLab.GetController(thread)
	SslBaseAnimation anim = threadctrl.Animation
	String[] tags = anim.GetTags()
	processActorSex(akActor,tags)	
EndEvent

function processActorSex(Actor akActor, String[] sTags)
	DTTools.log2("DT2Core::processActorSex","Actor: " + akActor)
	DTTools.log2("DT2Core::processActorSex","Tags: " + sTags)
	
	
	int iSlot = DTActor.isRegistered(akActor)
	if iSlot >= 0		
		DTActor.orgasmCount[iSlot] = DTActor.orgasmCount[iSlot] + 1
		DTActor.count_orgasm[iSlot] = DTActor.count_orgasm[iSlot] + 1
		
		;send event - orgasm
		int handle = ModEvent.Create("DT_NewEvent")
		ModEvent.PushForm(handle, DTActor.npcs_ref[iSlot] as Form)
		ModEvent.PushInt(handle, iSlot)
		ModEvent.PushString(handle, "orgasm")
		ModEvent.PushInt(handle, DTActor.count_orgasm[iSlot])
		ModEvent.Send(handle)
		
	endIf
	
endFunction



;---------------------------------------------------------
;CLEAR SECTION
;---------------------------------------------------------




function resetAll()
	unregisterSexLabEvents()
	DTTools.log("Reset all - START")
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None
			;watchdogs
			DTActor.resetAll(i)
			
	 	endif
		i+=1
	endWhile
	DTTools.log("Reset all - STOP")
endFunction


function mcmResetAll()
	DTTools.log("Reset and recalc all - START")
	
	DTConfig.process_wildcard = true
	resetAll()	
	DTConfig.process_wildcard = false
	DTConfig.mcmTatsChanged = false
	DTConfig.mcmBodyChanged = false

	if DTConfig.modEnabled == false
		return
	endIf
	
	registerSexLabEvents()
	DTTools.log("mcmResetAll Call - again")
	
	;int i = 0
	;TODO - not sure if mod disabled?
	;while i < DTActor.getArrayCount()
	;	if DTActor.npcs_ref[i] != None
	;		calcActorBuffs(i)
			;TODO
			
			
	 ;	endif
		;i+=1
	;endWhile
	calcActorBuffsEv()
	
	onLocationChangeExecute()
	DTTools.log("Reset and recalc all - STOP")
endFunction

function removeAllActors()
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None
			DTActor.unregisterActor(i)
		endIf
		i+=1
	endwhile
endFunction




function calcActorBuffsEv()
	int handle = ModEvent.Create("DT_ForceToCalcBuffs") 
	ModEvent.Send(handle)
endFunction