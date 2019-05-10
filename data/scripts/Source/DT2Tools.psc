Scriptname DT2Tools extends Quest  

DT2Config Property DTConfig Auto
DT2Storage Property DTStorage Auto
DT2Actor	Property DTActor Auto
DT2Expert Property DTExpert Auto
import MiscUtil
import MfgConsoleFunc
zadConfig Property zadConfigH Auto

zadGagQuestScript Property zadGagH Auto
slaUtilScr Property Aroused Auto




Float Function GetActorValuePercentageEX(Actor akActor, String asValueName)

	;sorry for that
	Float currentState = akActor.GetActorValue(asValueName)
	akActor.RestoreActorValue(asValueName, 5000)
	Float maxState = akActor.GetActorValue(asValueName)
	akActor.DamageActorValue(asValueName, maxState-currentState)
	
	
	; max = 100
	; cur = ?
	
	return currentState * 100 / maxState
	
	;log("current"+currentState)
	;log("current"+maxState)
	
	;return 100.0

	return akActor.GetActorValuePercentage(asValueName) * 100
	;return  100 * ((akActor.GetBaseActorValue(asValueName)*akActor.GetActorValuePercentage(asValueName))/akActor.GetActorValue(asValueName))
	;Float Max = akActor.GetActorValue(asValueName) * akActor.GetActorValuePercentage(asValueName)
	;	max = 100
	;	now = ?
	;log("MAX"+Max)
	;return akActor.GetActorValue(asValueName) * 100 / Max
  ;Float CurrentHealth = akActor.GetActorValue(asValueName)
  ;Float BaseHealth = akActor.GetBaseActorValue(asValueName)
 
  ;Float HealthPercent = (CurrentHealth / BaseHealth) * 100
 
  ;return HealthPercent
EndFunction 

;IS VALID

bool function isCorrectType(Actor acActor)
	if acActor==None
		return false
	endIf
	
	
	int ratePoints = 0
	
	;process player
	
	if acActor == DTConfig.playerRef
		ratePoints += 1
	endif
	
	
	if DTConfig.process_wildcard == true
		ratePoints += 1
	endIf
	
	if DTConfig.process_follower
		if acActor.IsPlayerTeammate() == true
			ratePoints += 1
		endif
	endIf
	
	if DTConfig.process_enemies
		if acActor.GetRelationshipRank(DTConfig.playerRef) <= -1
			ratePoints += 1
		endIf
	endIf	
	
	if DTConfig.process_friends
		if acActor.GetRelationshipRank(DTConfig.playerRef) >= 1
			ratePoints += 1
		endIf
	endIf
	
	if DTConfig.process_neutral
		if acActor.GetRelationshipRank(DTConfig.playerRef) == 0
			ratePoints += 1
		endIf
	endIf
	log2("DTTools::isValid", "Score: "+ratePoints)
	if ratePoints == 0
		return false
	endif
	return true
endFunction

bool function isDDWearer(Actor acActor)
	if acActor==None
		return false
	endIf
	int i = DTConfig.ddKeywords.length
	while i > 0
		i -= 1
		if DTConfig.ddKeywords[i]!=None
	
			if acActor.WornHasKeyword(DTConfig.ddKeywords[i])==true
				return true
			endIf
		endif
	endWhile
		
	
	return false
endFunction

bool function isValid(Actor acActor)

	log2("DTTools::isValid", "Check Actor"+acActor+" - wildcard:"+DTConfig.process_wildcard as int)

	if acActor==None
		return false
	endIf
	

	;state
	if acActor.isDead() == true || acActor.IsChild() == true || acActor.IsGhost() == true
		return false
	endIf

	;gander/sex
	if DTConfig.allowedsex != 2
		if acActor.GetActorBase().GetSex() != DTConfig.allowedsex
			return false
		endif
	endIf
	
	;race
	;if DT2Config.allowedRaces.find(acActor.getRace()) == -1 
	;	if DButtConfig.playerRef != acActor
	;		return false
	;	endIf		
	;endIf
	
	
	
	return true
endFunction

;SCAN

Actor[] function getActors(Actor acAktor, float rad = 0.0)

	Actor[] actors
	actors = new Actor[32]

	Actor acActor = acAktor
	if rad == 0.0
		rad = DTConfig.scanerRange as float
	endif
	float posx = acActor.GetPositionX()
	float posy = acActor.GetPositionY()
	float posz = acActor.GetPositionZ()


	int i = 0
	int index = 0
	while i < 30
		
		actor npctoadd = Game.FindRandomActor(posx, posy, posz, rad)

		if actors.find(npctoadd)==-1
			actors[index] = npctoadd
			index+=1
		endif
		
		i+=1
	endWhile

	return actors
endFunction


bool function getIsWalking(Actor acActor)
	if acActor.IsSprinting()
		return false
	endIf
	if acActor.IsRunning()
		return false
	endIf
	if acActor.IsSneaking()
		return false
	endIf	
	if acActor.IsSwimming()
		return false
	endIf	
	if acActor.GetAnimationVariableFloat("Speed")>0
		return true
	endIf
	
	
	return false
endFunction

bool function getIsSwimming(Actor acActor)
	return acActor.IsSwimming()
endFunction

bool function getIsSneaking(Actor acActor)
	return acActor.IsSneaking()
endFunction

bool function getIsRunning(Actor acActor)
	if acActor.IsRunning()==true && acActor.IsSprinting()==false
		return true
	endIf
	return false
endFunction

bool function getIsSprinting(Actor acActor)
	if acActor.IsRunning() && acActor.IsSprinting()
		return true
	endIf
	return false
endFunction

bool function getIsJumping(Actor acActor)
	if acActor.GetAnimationVariableBool("bInJumpState") as int == 1
		return true
	endif
	return false
endFunction




function log2(String Context, String Msg, int level = 2, bool showAlways = false)

	log(Context+" - "+Msg,level, showAlways)

endFunction

function log(String Msg, int level = 2, bool showAlways = false)
	
	if DTConfig.showConsoleOutput == true || showAlways == true
		PrintConsole("DT: "+ Msg)
	endIf
	
	if DTConfig.showTraceOutput == true || showAlways == true
		debug.trace("DT: "+ Msg)
	endIf
endFunction



;MATH STORY
float function calcExponential(float skill)
	return 0.02 * Math.pow(skill, 2) - 100
	
endFunction

float function calcLogarithmic(float skill)
	return Math.pow(skill, 0.5) * 20 - 100
endFunction

float function calcLinear(float skill)
	return 2*skill - 100
endFunction

float function rescaleToRange(float value, float minRange, float maxRange)

	;example for from -20 to 80
	;-20 + (80 + 20 ) * (x + 100) / ( 100+100)
	float result =  minRange + (maxRange -minRange ) * ((value + 100) / 200)
	;log("rescaleToRange:"+result)
	return result
endFunction

int function getCurrentTrainingStage(int slot,  float[] processedArray, float minRange, float maxRange)
	
	if processedArray[slot]<=0
		return 0
	endif
	
	float progress = processedArray[slot]
	
	float rescaledProgress = rescaleToRange(getAdvancedLevel(progress),minRange,maxRange)

	
	if rescaledProgress<=0
		float minimum = rescaleToRange(getAdvancedLevel(0),minRange,maxRange)
		
		minimum = minimum / 4

		if rescaledProgress >= minimum * 4 && rescaledProgress <= minimum * 3
			return 0
		endIf

		if rescaledProgress > minimum * 3 && rescaledProgress <= minimum * 2
			return 1
		endIf
		
		if rescaledProgress > minimum * 2 && rescaledProgress <= minimum * 1
			return 2
		endIf
		
		if rescaledProgress > minimum * 1 && rescaledProgress <= minimum * 0
			return 3
		endIf
		
		return 0
	endIf
	
	if rescaledProgress>0
		float maximum = rescaleToRange(getAdvancedLevel(100),minRange,maxRange)
		
		maximum = maximum / 2

		if rescaledProgress > maximum * 0 && rescaledProgress <= maximum * 1
			return 4
		endIf		
		if rescaledProgress > maximum * 1 && rescaledProgress < maximum * 2
			return 5
		endIf	
		if rescaledProgress >= maximum
			return 6
		endIf			
	endIf


endFunction

string function getCurrentTrainingStageName(int stage)
	if stage == 0
		return "Newbie [Level:0]"
	endIf
	if stage == 1
		return "Beginner [Level:1]"
	endIf
	if stage == 2
		return "Novice [Level:2]"
	endIf
	if stage == 3
		return "Amateur [Level:3]"
	endIf
	if stage == 4
		return "Expirianced [Level:4]"
	endIf
	if stage == 5
		return "Proficient [Level:5]"
	endIf
	if stage == 6
		return "Lover [Level:6]"
	endIf
endFunction



bool function getProb(int slot, float[] processedArray, float minRange, float maxRange, int weight, float probMult = 1.0 )

	float recalculatedStage =  rescaleToRange(processedArray[slot], minRange, maxRange);  DTLevel.rescaleByArray(DTLevel.getAdvancedLevel(processedArray[slot]),processedArray)

	float prob = 0
	
	;set a proportion from new 0
	if recalculatedStage>0
		;DTUtilities.log("  Its will be positive prob")
		float max = rescaleToRange(100,minRange,maxRange) ;DTLevel.rescaleByArray(DTLevel.getAdvancedLevel(100),processedArray)
		;DTUtilities.log("  maximum:" + max)
		prob = recalculatedStage * 100 / max 
		;DTUtilities.log("  Found reproportioned prob value:" + prob)
	endIf
	
	;set a proportion from new 0
	if recalculatedStage<0
		;DTUtilities.log("  Its will be negative prob")
		float min = rescaleToRange(0,minRange,maxRange)  ;DTLevel.rescaleByArray(DTLevel.getAdvancedLevel(0),processedArray)
		;DTUtilities.log("  minimum:" + min)
		prob =  ( recalculatedStage * 100 / min )
		if prob < 0
			prob = prob * -1
		endif
		;DTUtilities.log("  Found reproportioned prob value:" + prob)
	endIf
	
	
	
	prob = prob * ( (weight as float) / 100) as float
	prob = prob * probMult
	int randomValue = Utility.RandomInt(1, 100)
	
	if randomValue < prob as Int
return true
	endif
return false


endfunction

float function getAdvancedLevel(float skill)
	;log("getAdvancedLevel:1"+skill)
	;log("getAdvancedLevel:2"+DTConfig.training_level_curve)
	;log("getAdvancedLevel:3"+DTConfig.linearTable[skill as int] as float)
	;log("getAdvancedLevel:3"+DTConfig.exponentialTable[skill as int] as float)
	;log("getAdvancedLevel:3"+DTConfig.logarithmicTable[skill as int] as float)
	
	if skill < 0
		skill = 0
	endif
	;some math...
	;lin: 2*x-100
	;exp: 0.02*x^2-100
	;log: x^0.5*20-100


	if DTConfig.training_level_curve == 0
		return DTConfig.linearTable[skill as int] as float		
	endif
	
	if DTConfig.training_level_curve == 1
		return DTConfig.exponentialTable[skill as int] as float	
	endIf
	
	if DTConfig.training_level_curve == 2
		return DTConfig.logarithmicTable[skill as int] as float	
	endIf

	return 0
endFunction









;helper function to play with slots
function equipItem(Armor item,Actor acActor, int slot = 0)
	if slot > 0
		Armor thisArmor = acActor.GetWornForm(DTConfig.slotMask[slot]) as Armor
		if thisArmor == None
			acActor.EquipItem(item, false, true)				
		endIf
	else
		acActor.EquipItem(item, false, true)				
	endif
endFunction






function restoreIntegration()

	if DTConfig.allowChangeDeviousDevices == true
		zadConfigH.bootsSlowdownToggle = true
		zadConfigH.blindfoldMode = 0
		zadConfigH.blindfoldStrength = 0.5
	endIf
	
	if DTConfig.allowChangecursedLootPack == true
		;changeGagOptions(1)
		log("changedf")
	endif
	

endFunction

function reconfigureIntegration()
	if DTConfig.allowChangeDeviousDevices == true
		zadConfigH.bootsSlowdownToggle = false
		zadConfigH.blindfoldMode = 2
		zadConfigH.blindfoldStrength = DTConfig.shadowShader
		
	endIf
	
	if DTConfig.allowChangecursedLootPack == true
		;changeGagOptions(0)
		
	;	dcur_mcmconfig dcur_mcm  = Game.GetFormFromFile(0x080012C4, "Deviously Cursed Loot.esp") as dcur_mcmconfig
;		myQuest = GetOwningQuest() as MQ01Script
	;	dcur_mcm.gagtalkchance = 0
		log("changedf")
	endif
endFunction



function changeGagOptions(float delay=0.1)
	
	if DTConfig.playerSlot < 0
		return
	endIf
		
	if DTConfig.effect_gag_enabled==true && DTConfig.effect_gag_enabled_talk == true && DTConfig.training_speed_gag > 0
	
		int stage = getCurrentTrainingStage(DTConfig.playerSlot,  DTActor.npcs_gag, DTConfig.gag_min,  DTConfig.gag_max)
		
		if stage < 4
			return
		endIf
	
		Utility.wait(delay)

		if DTConfig.allowChangecursedLootPack == true
			GlobalVariable  dcur_gagtalk_enabled  = Game.GetFormFromFile(0x080A0339, "Deviously Cursed Loot.esp") as GlobalVariable  
			dcur_gagtalk_enabled.setValue(0);
		endIf
		if DTConfig.allowChangeDeviousDevices == true
			zadGagH.enableTalk()
		endif
	endif
endFunction







function changeArousal(Actor acActor, int value)
	log("changeArousal actor: "+acActor.GetLeveledActorBase().GetName())
	log("changeArousal value to set :"+value)
	int current = Aroused.GetActorExposure(acActor)
	log("changeArousal old value: "+current)
	current = current + value
	
	if current > 100 
		current = 100
	endif
	
	if current < 0
		current = 0
	endif
	log("changeArousal new value: "+current)
	Aroused.SetActorExposure(acActor, current)
	
	
endFunction


string function generateTatsPatternForGroup1(Int Slot)
	
	
	String binnaryMark = "1"
	
	
	
		int testLevel = 0
		
		
		testLevel = getCurrentTrainingStage(Slot, DTActor.npcs_chastityBelt,  DTConfig.chastityBelt_min,  DTConfig.chastityBelt_max)
		
		if testLevel >= 4 && DTConfig.tats_item_chastity_belt == true
			binnaryMark = binnaryMark+"1"
		else
			binnaryMark = binnaryMark+"0"
		endIf
		
		testLevel = getCurrentTrainingStage(Slot, DTActor.npcs_chastityBra,  DTConfig.chastityBra_min,  DTConfig.chastityBra_max)
		
		if testLevel >= 4 && DTConfig.tats_item_chastity_bra == true
			binnaryMark = binnaryMark+"1"
		else
			binnaryMark = binnaryMark+"0"
		endIf

		testLevel = getCurrentTrainingStage(Slot, DTActor.npcs_corset,  DTConfig.corset_min,  DTConfig.corset_max)
		
		if testLevel >= 4 && DTConfig.tats_item_corset == true
			binnaryMark = binnaryMark+"1"
		else
			binnaryMark = binnaryMark+"0"
		endIf		

		testLevel = getCurrentTrainingStage(Slot, DTActor.npcs_harness,  DTConfig.harness_min,  DTConfig.harness_max)
		
		if testLevel >= 4 && DTConfig.tats_item_harness == true
			binnaryMark = binnaryMark+"1"
		else
			binnaryMark = binnaryMark+"0"
		endIf		


	
	
	return binnaryMark
	

endFunction
