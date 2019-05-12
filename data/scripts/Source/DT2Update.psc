Scriptname DT2Update extends Quest  

DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Actor Property DTActor Auto
DT2Storage Property DTStorage Auto
DT2Core Property DTCore Auto
DT2Body Property DTBody Auto
DT2Achievement Property DTAchievement Auto
zadLibs Property libs Auto

Function Update(Float version)

	
	DTTools.log("Update - Check for updates...",2, true)
	updateOnEveryLoad()
	if version <= DTConfig.lastVersion
		DTTools.log("Update - Not update requied",2, true)
		return
	endIf

	DTTools.log("Update DT - version:"+version+" START", 2, true)

	updateAlwyas()	
	
	if DTConfig.lastVersion < 0.1
		DTTools.log("Run module updateTo01",2, true)
		updateTo01()
	endIf	
	
	if DTConfig.lastVersion < 0.2
		DTTools.log("Run module updateTo02",2, true)
		updateTo02()
	endIf	
	
	if DTConfig.lastVersion < 0.3
		DTTools.log("Run module updateTo03",2, true)
		updateTo03()
	endIf	
	if DTConfig.lastVersion < 0.4
		DTTools.log("Run module updateTo04",2, true)
		updateTo04()
	endIf
	
	if DTConfig.lastVersion < 0.5
		DTTools.log("Run module updateTo05",2, true)
		updateTo05()
	endIf	
	
	if DTConfig.lastVersion < 0.6
		DTTools.log("Run module updateTo06",2, true)
		updateTo06()
	endIf	
	
	if DTConfig.lastVersion < 0.7
		DTTools.log("Run module updateTo07",2, true)
		updateTo07()
	endIf	
	
	if DTConfig.lastVersion < 0.8
		DTTools.log("Run module updateTo08",2, true)
		updateTo08()
	endIf	
	
	if DTConfig.lastVersion < 0.9
		DTTools.log("Run module updateTo09",2, true)
		updateTo09()
	endIf	
	
	if DTConfig.lastVersion < 1.0
		DTTools.log("Run module updateTo10",2, true)
		updateTo10()
	endIf	
	if DTConfig.lastVersion < 1.1
		DTTools.log("Run module updateTo11",2, true)
		updateTo11()
	endIf	
	if DTConfig.lastVersion < 1.2
		DTTools.log("Run module updateTo12",2, true)
		updateTo12()
	endIf
	if DTConfig.lastVersion < 1.3
		DTTools.log("Run module updateTo13",2, true)
		updateTo13()
	endIf	
	if DTConfig.lastVersion < 1.4
		DTTools.log("Run module updateTo14",2, true)
		updateTo14()
	endIf	
	if DTConfig.lastVersion < 1.5
		DTTools.log("Run module updateTo15",2, true)
		updateTo15()
	endIf		
	if DTConfig.lastVersion < 1.6
		DTTools.log("Run module updateTo16",2, true)
		updateTo16()
	endIf	
	if DTConfig.lastVersion < 1.7
		DTTools.log("Run module updateTo17",2, true)
		updateTo17()
	endIf		
	if DTConfig.lastVersion < 1.8
		DTTools.log("Run module updateTo18",2, true)		
	endIf				
	
	if DTConfig.lastVersion < 1.9
		DTTools.log("Run module updateTo19",2, true)
		updateTo19()
	endIf		
	if DTConfig.lastVersion < 2.0
		DTTools.log("Run module updateTo20",2, true)
		updateTo20()
	endIf

	if DTConfig.lastVersion < 2.1
		DTTools.log("Run module updateTo21",2, true)
		updateTo21()
	endIf			
	
	if DTConfig.lastVersion < 2.2
		DTTools.log("Run module updateTo22",2, true)
		updateTo22()
	endIf			
	if DTConfig.lastVersion < 2.3
		DTTools.log("Run module updateTo23",2, true)
		updateTo23()
	endIf		
	if DTConfig.lastVersion < 2.4
		DTTools.log("Run module updateTo24",2, true)
		updateTo24()
	endIf	
	if DTConfig.lastVersion < 2.5
		DTTools.log("Run module updateTo25",2, true)
		updateTo25()
	endIf			
	if DTConfig.lastVersion < 2.6
		DTTools.log("Run module updateTo26",2, true)
		updateTo26()
	endIf			
	if DTConfig.lastVersion < 2.7
		DTTools.log("Run module updateTo27",2, true)
		updateTo27()
	endIf	

	if DTConfig.lastVersion < 2.8
		DTTools.log("Run module updateTo28",2, true)
		updateTo28()
	endIf		
	
	if DTConfig.lastVersion < 2.9
		DTTools.log("Run module updateTo29",2, true)
		updateTo29()
	endIf	
	
	if DTConfig.lastVersion < 3.1
		DTTools.log("Run module updateTo31",2, true)
		updateTo31()
	endIf	
	if DTConfig.lastVersion < 3.2
		DTTools.log("Run module updateTo32",2, true)
		updateTo32()
	endIf		
	
	if DTConfig.lastVersion < 3.3
		DTTools.log("Run module updateTo33",2, true)
		updateTo33()
	endIf	

if DTConfig.lastVersion < 3.4
		DTTools.log("Run module updateTo34",2, true)
		updateTo34()
	endIf			
	if DTConfig.lastVersion < 3.5
		DTTools.log("Run module updateTo35",2, true)
		updateTo35()
	endIf	
	if DTConfig.lastVersion < 3.6
		DTTools.log("Run module updateTo36",2, true)
		updateTo36()
	endIf	
	if DTConfig.lastVersion < 3.7
		DTTools.log("Run module updateTo37",2, true)
		updateTo37()
	endIf	
	if DTConfig.lastVersion < 3.8
		DTTools.log("Run module updateTo38",2, true)
		updateTo38()
	endIf
	if DTConfig.lastVersion < 3.9
		DTTools.log("Run module updateTo39",2, true)
		updateTo39()
	endIf
	if DTConfig.lastVersion < 4.1
		DTTools.log("Run module updateTo41",2, true)
		updateTo41()
	endIf
	DTTools.log("Update DT - version:"+version+" FINISH",2, true)
	
	DTConfig.lastVersion = version

	
	int handle = ModEvent.Create("DT_Updated") 	
	ModEvent.PushFloat(handle, version)	
	ModEvent.Send(handle)
	
EndFunction

function updateTo41()
	Game.getPlayer().RemoveShout(DTStorage.DT_TransformToPonyShaut)
	Game.getPlayer().RemoveShout(DTStorage.DT_TransformToBlindShaut)
	int i = 0
	while i < DTActor.getArrayCount()		
		DTAchievement.resetAllWithAchievementRelated(i)
		i+=1
	endwhile
endFunction

function updateTo39()
	DTConfig.effect_vaginalPlug_weight = 10
endFunction

function updateTo38()
	DTConfig.addBuffsAndDebuffs = true
endFunction

function updateTo37()
	DTConfig.training_speed_vaginalplug = 3
	DTConfig.training_speed_analplug = 3
	
	updateAlwyas()	
	int i = 0
	while i < DTActor.getArrayCount()		
		if DTActor.npcs_ref[i]!=none
			
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_VaginalPlug)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_AnalPlug)
			
			
			DTActor.updateFactions(i)
			
		endif
		i+=1
	endwhile
	
endFunction

function updateTo36()
	DTActor.count_steps = new Int[32]
	DTActor.count_weight = new Int[32]
	DTActor.count_days = new Int[32]
	DTActor.count_dmg = new Int[32]
	DTActor.count_dmgZad = new Int[32]
	DTActor.count_orgasm = new Int[32]	
	
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.count_steps[i] = 0
		DTActor.count_weight[i] = 0
		DTActor.count_days[i] = 0
		DTActor.count_dmg[i] = 0
		DTActor.count_dmgZad[i] = 0
		DTActor.count_orgasm[i] = 0
		i+=1
	endwhile
endFunction

function updateTo35()
int i = 0
	while i < DTActor.getArrayCount()		
		if DTActor.npcs_ref[i]!=none
		
		if DTConfig.sanguneDebucheryPack == true
		if StorageUtil.GetStringValue( DTActor.npcs_ref[i], "_SD_sDefaultStance") != "Standing"
			StorageUtil.SetStringValue( DTActor.npcs_ref[i] , "_SD_sDefaultStance","Standing")		
		endif	
	else
		if DTConfig.zazExtensionPack == true
			FNIS_aa.SetAnimGroup(DTActor.npcs_ref[i], "_mtidle",0,0,"ZazExtensionPack",true)
			FNIS_aa.SetAnimGroup(DTActor.npcs_ref[i], "_mt",0,0,"ZazExtensionPack",true)
			FNIS_aa.SetAnimGroup(DTActor.npcs_ref[i], "_mtx",0,0,"ZazExtensionPack",true)
		endIf
	endif
		
			DTActor.resetAllVisual(i)
			DTActor.updateFactions(i)
		endif
		i+=1
	endwhile

endFunction

function updateTo34()
	updateAlwyas()	
	int i = 0
	while i < DTActor.getArrayCount()		
		if DTActor.npcs_ref[i]!=none
			
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Boots)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Corset)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Harness)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Legscuffs)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Armscuffs)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Gag)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Collar)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Chastitybelt)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Chastitybra)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Gloves)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Armbinderyoke)
			DTActor.npcs_ref[i].AddToFaction(DTConfig.DT_Blindfold)
			
			DTActor.updateFactions(i)
			
		endif
		i+=1
	endwhile
endfunction

function updateTo33()
	int i = 0
	while i < DTActor.getArrayCount()		
		DTActor.achievementBlindSlut[i] = false	
		i+=1
	endwhile
endfunction


function updateTo32()
	DTConfig.effect_blindfold_eyes_close = 0.5
endfunction

function updateTo31()
	DTConfig.achievement_blindslut_enabled = true
	DTActor.achievementBlindSlut = new Bool[32]
	
	DTConfig.shadowShader = 0.8
	DTConfig.training_speed_blindfold = 3
	DTConfig.effect_blindfold_enabled = true
	
	DTActor.npcs_blindfold = new Float[32]
	
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_blindfold[i] = 0
		DTActor.achievementBlindSlut[i] = false	
		
		i+=1
	endwhile
	
	updateOnEveryLoad()
endFunction


function updateTo29()
	if DTConfig.bacPack == false
		DTConfig.bac_hooves = none
	else
		DTConfig.bac_hooves	= Game.GetFormFromFile(0x04004352, "bac.esp") as Keyword		
	endIf
endFunction

function updateTo28()
	DTConfig.ignoreAdditionNegativeEffects = false
endFunction

function updateTo27()
	DTConfig.mcmTatsChanged = false
	DTConfig.mcmBodyChanged = false
	
	bool modState = DTConfig.modEnabled
	DTConfig.modEnabled = false
	
	
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None
			DTActor.resetAllMagicEffects(i)
			DTActor.resetAchievementItems(i)
			DTActor.resetNeckScale(i)
			DTActor.resetOpenJaw(i)
			DTActor.resetWaist(i)
			DTActor.resetFeet(i)
			DTActor.resetOnAllFour(i)
			
			DTBody.clearAllBodyScales(DTActor.npcs_ref[i], i)
			DTBody.setActorWeight(DTActor.npcs_ref[i], DTActor.orgWeight[i])
			
		endif
		i+=1
	endwhile
	
	DTConfig.modEnabled = modState
	
	
endFunction

function updateTo26()
	DTConfig.mcmTatsChanged = false
	DTConfig.mcmBodyChanged = false
endFunction

function updateTo25()
	DTConfig.process_only_pc = true
	DTConfig.bodyChangeWeight = true
endFunction

function updateTo24()
	DTConfig.process_wildcard = false
	DTConfig.process_follower = true
	DTConfig.process_enemies = false
	DTConfig.process_neutral = false
	DTConfig.process_friends = false
	
endFunction

function updateTo23()

	DTConfig.effect_chastity_breast_visual = 0
	DTConfig.tats_days_enabled = false
	
	DTConfig.tats_item_enabled = false
	
	DTConfig.tats_item_corset = true
	DTConfig.tats_item_harness = true
	DTConfig.tats_item_chastity_belt = true
	DTConfig.tats_item_chastity_bra = true
	
	DTActor.lastKnowTatsSetGroup1 = new string[32]
	DTActor.npcs_daysInBondage = new int[32]
	DTActor.npcs_daysInBondageLastKnow = new int[32]
	int i = 0
	
	while i < DTActor.getArrayCount()			
		DTActor.lastKnowTatsSetGroup1[i] = "xxxx"
		DTActor.npcs_daysInBondage[i] = 0
		DTActor.npcs_daysInBondageLastKnow[i] = -1
		i+=1
	endwhile	
	
	DTCore.mcmResetAll()
endFunction

function updateTo22()

	DTConfig.effect_corset_waist_visualWithout = DTConfig.effect_corset_waist_visual / 2
	DTConfig.gameDaysCount = Game.QueryStat("Days Passed") 

	
	DTConfig.bodyScaleOrgasmEnabled = true
	if DTConfig.slifPack == false
		DTConfig.bodyScaleOrgasmEnabled = false
	endIf
	DTConfig.minOrgasmCount = 3
	DTConfig.bodyScaleFactor = 5
	DTConfig.bodyWithoutSexGrowth = true
	DTConfig.bodyMinBrests = 0.1
	DTConfig.bodyMaxBrests = 2.0
	DTConfig.bodyMinButt = 0.1
	DTConfig.bodyMaxButt = 2.5
	DTConfig.bodyMinBelly = 0.5
	DTConfig.bodyMaxBelly = 5

	
	
	int i = 0
	DTActor.orgasmCount = new int[32]
	DTActor.bodyPointer = new float[32]
	DTActor.orgWeight = new float[32]
	
	while i < DTActor.getArrayCount()			
		DTActor.orgasmCount[i] = 0	
		DTActor.bodyPointer[i] = 50
		if DTActor.npcs_ref[i] != None
			DTActor.orgWeight[i] = DTActor.npcs_ref[i].GetWeight()
		else
			DTActor.orgWeight[i] = 0
		endif
		
		i+=1
	endwhile	
	

	if DTConfig.slifPack == true
		debug.messagebox("SLIF MOD detected - i hope that You are not using old Devious Training support file from SLIF? Did You? Now Devious Training have native support. Please make sure that SLIF not overwrite this mod...")
	endif
	
	DTCore.mcmResetAll()
	
	DTConfig.enableSlif = false
	
	
endFunction

function updateTo21()
	DTConfig.achievement_ponygirl_cast_helpfull_spells = true
endFunction

function updateTo20()
	DTConfig.turnoffspeedattack = false
	int playerRefSlot = DTActor.isRegistered(DTConfig.playerRef)
	if playerRefSlot >=0
		if DTActor.achievementPonyGirl[playerRefSlot] == true
			;DTActor.npcs_ref[playerRefSlot].addSpell(DTStorage.DT_TransformToPony)
			
			; Game.TeachWord(DTStorage.DT_TransformPonyWord1)
			; Game.TeachWord(DTStorage.DT_TransformPonyWord2)
			; Game.TeachWord(DTStorage.DT_TransformPonyWord3)
			; DTActor.npcs_ref[playerRefSlot].AddShout(DTStorage.DT_TransformToPonyShaut)
		endif
	endif
	
	DTConfig.achievement_ponygirl_colorset = 0
	DTConfig.achievement_ponygirl_add_another_items = true
	DTCore.mcmResetAll()
	
endFunction

function updateTo19()
	int i = 0
	DTActor.npcs_isBusy = new Bool[32]
	while i < DTActor.getArrayCount()			
		DTActor.npcs_isBusy[i] = false		
		i+=1
	endwhile	
endFunction

function updateTo17()
	int i = 0
	DTActor.achievementPonyGirl = new Bool[32]
	DTActor.countHit = new Int[32]
	while i < DTActor.getArrayCount()
			
		DTActor.achievementPonyGirl[i] = false
		DTActor.countHit[i] = 0
		i+=1
	endwhile
	
	DTConfig.achievement_ponygirl_enabled = true
	DTConfig.achievement_ponygirl_equip_enabled = true
	DTConfig.achievement_ponygirl_equip_tied = true
	DTConfig.achievement_ponygirl_equip_always = false
	DTConfig.achievement_ponygirl_equip_force = true
	DTConfig.achievement_ponygirl_sound_tied = true
	DTConfig.achievement_ponygirl_sound_always = false
	

endFunction

function updateTo16()
	DTActor.npcs_armbinder = new Float[32]
	
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_armbinder[i] = 0	
		
		i+=1
	endwhile
	
	DTConfig.training_speed_armbinder = 3
	DTConfig.effect_armbinder_health = 60
	
	i = 0
	while i < DTActor.getArrayCount()
			
		DTActor.countHit[i] = 0
			
		i+=1
	endwhile
	
endFunction

function updateTo15()
	DTConfig.buffMult = 4
endFunction

function updateTo14()
	DTConfig.acceptBoots0 = none;	
endFunction

function updateTo13()
	DTConfig.acceptBoots1 = none;
	DTConfig.acceptBoots2 = none;
	DTConfig.acceptBoots3 = none;
endFunction

function updateTo12()
	DTConfig.training_speed_gloves = 3
endFunction
function updateTo11()

	DTConfig.fullProcessing = false
	DTConfig.updateOnlyWithCellChange = true
	DTConfig.effect_chastityBra_enabled = true
	DTConfig.effect_chastityBelt_enabled = true
	DTConfig.effect_chastityBelt_weight = 65
	DTConfig.effect_chastityBra_weight = 65
	
endFunction


function updateTo10()

DTActor.npcs_isCrowl = new Bool[32]

	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_isCrowl[i] = false	
		i+=1
	endwhile

endFunction


function updateTo09()

		
	DTActor.npcs_chastityBelt = new Float[32]
	DTActor.npcs_chastityBra = new Float[32]
	DTActor.npcs_analPlug = new Float[32]
	DTActor.npcs_vaginalPlug = new Float[32]
	DTActor.npcs_vaginalPiercing = new Float[32]
	DTActor.npcs_nipplePiercing = new Float[32]
	DTActor.npcs_gloves = new Float[32]
	
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_chastityBelt[i] = 0
		DTActor.npcs_chastityBra[i] = 0
		DTActor.npcs_analPlug[i] = 0
		DTActor.npcs_vaginalPlug[i] = 0
		DTActor.npcs_vaginalPiercing[i] = 0
		DTActor.npcs_nipplePiercing[i] = 0
		DTActor.npcs_gloves[i] = 0
		i+=1
	endwhile
	
	DTConfig.effect_values_enabled = true
	DTConfig.effect_arousal_enabled = true
	DTConfig.effect_arousal_behavior = 2
	DTConfig.process_only_pc = false
	
	DTConfig.training_speed_chastityBelt = 3
	DTConfig.training_speed_chastityBra = 3
	
	DTConfig.effect_collar_weight = 10
	
	DTConfig.preventCarryWeight = 1
	DTConfig.preventSpeedWalk = 1
endFunction

function updateTo08()
	DTConfig.ignore_duplicates = true
endFunction

function updateTo07()
	DTConfig.mcmWorking = false
endFunction

function updateTo06()
	DTConfig.effect_collar_enabled = true
	DTConfig.effect_collar_long_visual = 10
	DTConfig.training_speed_collar = 3
	
	DTActor.npcs_collar = new Float[32]

	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_collar[i] = 0				
		i+=1
	endwhile
	
	
endFunction

function updateTo05()
	
	DTConfig.allowChangeDeviousDevices = true
	
	if DTConfig.cursedLootPack == true
		DTConfig.allowChangecursedLootPack = true
	else
		DTConfig.allowChangecursedLootPack = false
	endif
	
	DTConfig.allowToReconfigureAutomatic = false
	DTActor.npcs_gag = new Float[32]
	DTActor.timeout = new Int[32]
	DTActor.toremove = new Bool[32]
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_gag[i] = 0		
		DTActor.timeout[i] = 0		
		DTActor.toremove[i] = false
		i+=1
	endwhile
	
	DTConfig.training_speed_gag = 3
	DTConfig.effect_gag_enabled = true
	DTConfig.effect_gag_enabled_talk = true
	DTConfig.effect_gag_enabled_mounth = true
	DTConfig.effect_gag_enabled_mounth_weight = 50
	
endFunction

function updateTo04()
	DTConfig.effect_arched_feet_crawl_visual = false
	DTConfig.DT_ArchedFeet = DTStorage.DT_ArchedFeet
endFunction

function updateTo03()
	DTActor.npcs_harness = new Float[32]
	DTActor.npcs_legcuffs = new Float[32]
	DTActor.npcs_armcuffs = new Float[32]
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_harness[i] = 0
		DTActor.npcs_legcuffs[i] = 0
		DTActor.npcs_armcuffs[i] = 0
		i+=1
	endwhile
	
	DTConfig.training_speed_harness = 3	
	DTConfig.effect_harness_enabled = true	
	DTConfig.effect_harness_weight = 10	
	
	DTConfig.training_speed_legcuffs = 3	
	DTConfig.training_speed_armcuffs = 3	
	
	DTConfig.effect_legcuffs_enabled = true
	DTConfig.effect_armcuffs_enabled = true
	
	DTConfig.effect_legcuffs_weight = 90
	DTConfig.effect_armcuffs_weight = 90
	
	DTConfig.effect_legcuffs_alert_weight = 10
	DTConfig.effect_armcuffs_alert_weight = 10
	DTConfig.scanerRange = 3000
	DTConfig.effect_alert_enabled = true
	
endFunction

function updateTo02()
	int i = 0	
	DTTools.log("	Create basic setup", 2, true)
	DTConfig.effect_shader_enabled = true
	
	DTConfig.effect_arched_feet_visual = true
	DTConfig.effect_boots_enabled = true
	DTConfig.effect_boots_weight = 10
endFunction

function updateTo01()
	int i = 0
	
	DTTools.log("	Create basic setup",2, true)
		DTConfig.updateInterval = 10.0
		DTConfig.allowedsex = 2
		DTConfig.scanerRange = 1500
		DTConfig.playerRef = Game.getPlayer()
		DTConfig.playerSlot = -1
		DTConfig.modEnabled = true
		DTConfig.showConsoleOutput = true
		DTConfig.showTraceOutput = true
		
		
		DTConfig.training_speed_corset = 3
		DTConfig.training_speed_corset_dec = 6
		DTConfig.effect_corset_waist_visual = 50
		DTConfig.effect_corset_enabled = true
		DTConfig.effect_corset_weight = 10
		
		DTConfig.training_speed_boots = 3
		DTConfig.training_speed_boots_dec = 6
		
		DTConfig.training_level_curve = 2
		DTConfig.training_level_model = 1

		DTConfig.effect_sound_enabled = true

	DTTools.log("	Create actor slots",2, true)

		DTActor.npcs_ref = new actor[32]
		DTActor.npcs_corset = new Float[32]
		DTActor.npcs_boots = new Float[32]
		
		DTActor.npcs_sound_pointer = new Int[32]		
		DTActor.npcs_sound1 = new Int[32]
		DTActor.npcs_sound2 = new Int[32]
		DTActor.npcs_sound3 = new Int[32]
		DTActor.npcs_sound4 = new Int[32]
		DTActor.npcs_sound5 = new Int[32]
		DTActor.npcs_sound6 = new Int[32]
		DTActor.npcs_sound7 = new Int[32]
		
		DTActor.countWalk = new Int[32]
		DTActor.countSprint = new Int[32]
		DTActor.countRun = new Int[32]
		DTActor.countJump = new Int[32]
		DTActor.countAttack = new Int[32]
		DTActor.countSwim = new Int[32]
		DTActor.countHorse = new Int[32]
		DTActor.countSneak = new Int[32]
		DTActor.countSpeak = new Int[32]
		DTActor.countSexOral = new Int[32]
		DTActor.countSexAnal = new Int[32]
		DTActor.countSexVaginal = new Int[32]
	
		i = 0
		while i < DTActor.getArrayCount()
			DTActor.npcs_ref[i] = None
			DTActor.npcs_corset[i] = 0
			DTActor.npcs_boots[i] = 0			
			
			DTActor.npcs_sound_pointer[i] = 0
			
			DTActor.countWalk[i] = 0
			DTActor.countSprint[i] = 0
			DTActor.countRun[i] = 0
			DTActor.countJump[i] = 0
			DTActor.countAttack[i] = 0
			DTActor.countSwim[i] = 0
			DTActor.countHorse[i] = 0
			DTActor.countSneak[i] = 0
			DTActor.countSpeak[i] = 0
			DTActor.countSexOral[i] = 0
			DTActor.countSexAnal[i] = 0
			DTActor.countSexVaginal[i] = 0
			
			i+=1
		endwhile
	
endFunction

function updateAlwyas()

	;proportions
		
	DTConfig.blindfold_min	= - 95
	DTConfig.blindfold_max	= 35
	
	
	DTConfig.armbinder_min	= - 75
	DTConfig.armbinder_max	= 20
	
	DTConfig.boots_min	= - 75
	DTConfig.boots_max	= 20
	DTConfig.corset_min	= -100
	DTConfig.corset_max	= 40
	
	DTConfig.harness_min	= -80
	DTConfig.harness_max	= 30
	
	DTConfig.legcuffs_min = -80
	DTConfig.legcuffs_max = 30

	DTConfig.armcuffs_min = -80
	DTConfig.armcuffs_max = 30
	
	DTConfig.gag_min = -50
	DTConfig.gag_max = 15	
	
	DTConfig.collar_min = -50	
	DTConfig.collar_max = 15	
	
	DTConfig.chastityBelt_max = 25
	DTConfig.chastityBelt_min = - 50
	DTConfig.chastityBra_max = 20
	DTConfig.chastityBra_min = - 50
	DTConfig.analPlug_max = 20
	DTConfig.analPlug_min = -50
	DTConfig.vaginalPlug_max = 20
	DTConfig.vaginalPlug_min = -50
	DTConfig.vaginalPiercing_max = 10
	DTConfig.vaginalPiercing_min = -40	
	DTConfig.nipplePiercing_max = 10
	DTConfig.nipplePiercing_min = -40
	DTConfig.gloves_max = 20
	DTConfig.gloves_min = -60
	
	;sounds
	debug.trace(DTConfig.fem_pony)
	DTConfig.fem_pony = new sound[4]
	DTConfig.fem_pony[0] = DTStorage.dt_fem_pony3
	DTConfig.fem_pony[1] = DTStorage.dt_fem_pony2
	DTConfig.fem_pony[2] = DTStorage.dt_fem_pony1
	DTConfig.fem_pony[3] = DTStorage.dt_fem_pony0		
	debug.trace(DTConfig.fem_pony)
	
	DTConfig.chastity_normal = new sound[4]
	DTConfig.chastity_normal[0] = DTStorage.DT_fem_chastity3
	DTConfig.chastity_normal[1] = DTStorage.DT_fem_chastity2
	DTConfig.chastity_normal[2] = DTStorage.DT_fem_chastity1
	DTConfig.chastity_normal[3] = DTStorage.DT_fem_chastity0		
	
	
	DTConfig.fem_moan_normal = new sound[4]
	DTConfig.fem_moan_normal[0] = DTStorage.dt_fem_moan_nogag3
	DTConfig.fem_moan_normal[1] = DTStorage.dt_fem_moan_nogag2
	DTConfig.fem_moan_normal[2] = DTStorage.dt_fem_moan_nogag1
	DTConfig.fem_moan_normal[3] = DTStorage.dt_fem_moan_nogag0	
	
	DTConfig.fem_moan_gaged = new sound[4]
	DTConfig.fem_moan_gaged[0] = DTStorage.dt_fem_moan_gag3
	DTConfig.fem_moan_gaged[1] = DTStorage.dt_fem_moan_gag2
	DTConfig.fem_moan_gaged[2] = DTStorage.dt_fem_moan_gag1
	DTConfig.fem_moan_gaged[3] = DTStorage.dt_fem_moan_gag0	
	
	DTConfig.fem_gasp_normal = new sound[4]
	DTConfig.fem_gasp_normal[0] = DTStorage.DT_fem_gasp_nogag3
	DTConfig.fem_gasp_normal[1] = DTStorage.DT_fem_gasp_nogag2
	DTConfig.fem_gasp_normal[2] = DTStorage.DT_fem_gasp_nogag1
	DTConfig.fem_gasp_normal[3] = DTStorage.DT_fem_gasp_nogag0	
	
	DTConfig.fem_breath_normal = new sound[4]
	DTConfig.fem_breath_normal[0] = DTStorage.DT_fem_breath_nogag0
	DTConfig.fem_breath_normal[1] = DTStorage.DT_fem_breath_nogag0
	DTConfig.fem_breath_normal[2] = DTStorage.DT_fem_breath_nogag0
	DTConfig.fem_breath_normal[3] = DTStorage.DT_fem_breath_nogag0
	
	DTConfig.fem_breath_gaged = new sound[4]
	DTConfig.fem_breath_gaged[0] = DTStorage.DT_fem_breath_gag3
	DTConfig.fem_breath_gaged[1] = DTStorage.DT_fem_breath_gag2
	DTConfig.fem_breath_gaged[2] = DTStorage.DT_fem_breath_gag1
	DTConfig.fem_breath_gaged[3] = DTStorage.DT_fem_breath_gag0	

	DTConfig.fem_pain_normal = new sound[4]
	DTConfig.fem_pain_normal[0] = DTStorage.dt_fem_pain_nogag3
	DTConfig.fem_pain_normal[1] = DTStorage.dt_fem_pain_nogag2
	DTConfig.fem_pain_normal[2] = DTStorage.dt_fem_pain_nogag1
	DTConfig.fem_pain_normal[3] = DTStorage.dt_fem_pain_nogag0

	DTConfig.fem_pain_gaged = new sound[4]
	DTConfig.fem_pain_gaged[0] = DTStorage.dt_fem_pain_gag3
	DTConfig.fem_pain_gaged[1] = DTStorage.dt_fem_pain_gag2
	DTConfig.fem_pain_gaged[2] = DTStorage.dt_fem_pain_gag1
	DTConfig.fem_pain_gaged[3] = DTStorage.dt_fem_pain_gag0
	
	
	DTConfig.sound_chain = new sound[3]
	DTConfig.sound_chain[0] = DTStorage.DT_fem_chain0
	DTConfig.sound_chain[1] = DTStorage.DT_fem_chain1
	DTConfig.sound_chain[2] = DTStorage.DT_fem_chain2
	
	
	
	
	;items
	
	DTConfig.vaginalPlugSpellDescr = new Spell[3]
	DTConfig.vaginalPlugSpellDescr[0] = DTStorage.DT_ITEMvaginalPlugDebuffDescr
	DTConfig.vaginalPlugSpellDescr[1] = DTStorage.DT_ITEMvaginalPlugBuffDescr
	DTConfig.vaginalPlugSpellDescr[2] = DTStorage.DT_ITEMvaginalPlugNoWear		
	
	DTConfig.analPlugSpellDescr = new Spell[3]
	DTConfig.analPlugSpellDescr[0] = DTStorage.DT_ITEManalPlugDebuffDescr
	DTConfig.analPlugSpellDescr[1] = DTStorage.DT_ITEManalPlugBuffDescr
	DTConfig.analPlugSpellDescr[2] = DTStorage.DT_ITEManalPlugNoWear	
	
	
	DTConfig.blindfoldSpellDescr = new Spell[3]
	DTConfig.blindfoldSpellDescr[0] = DTStorage.DT_ITEMBlindfoldDebuffDescr
	DTConfig.blindfoldSpellDescr[1] = DTStorage.DT_ITEMBlindfoldBuffDescr
	DTConfig.blindfoldSpellDescr[2] = DTStorage.DT_ITEMBlindfoldNoWear
	
	DTConfig.glovesSpellDescr = new Spell[3]
	DTConfig.glovesSpellDescr[0] = DTStorage.DT_ITEMGlovesDebuffDescr
	DTConfig.glovesSpellDescr[1] = DTStorage.DT_ITEMGlovesBuffDescr
	DTConfig.glovesSpellDescr[2] = DTStorage.DT_ITEMGlovesNoWear


	DTConfig.bootsSpellDescr = new Spell[3]
	DTConfig.bootsSpellDescr[0] = DTStorage.DT_ITEMBootsDebuffDescr
	DTConfig.bootsSpellDescr[1] = DTStorage.DT_ITEMBootsBuffDescr
	DTConfig.bootsSpellDescr[2] = DTStorage.DT_ITEMBootsNoWear

	DTConfig.corsetSpellDescr = new Spell[3]
	DTConfig.corsetSpellDescr[0] = DTStorage.DT_ITEMCorsetDebuffDescr
	DTConfig.corsetSpellDescr[1] = DTStorage.DT_ITEMCorsetBuffDescr
	DTConfig.corsetSpellDescr[2] = DTStorage.DT_ITEMCorsetNoWear		
	
	DTConfig.harnessSpellDescr = new Spell[3]
	DTConfig.harnessSpellDescr[0] = DTStorage.DT_ITEMHarnessDebuffDescr
	DTConfig.harnessSpellDescr[1] = DTStorage.DT_ITEMHarnessBuffDescr
	DTConfig.harnessSpellDescr[2] = DTStorage.DT_ITEMHarnessNoWear
	
	DTConfig.armCuffsSpellDescr = new Spell[3]
	DTConfig.armCuffsSpellDescr[0] = DTStorage.DT_ITEMarmCuffsDebuffDescr
	DTConfig.armCuffsSpellDescr[1] = DTStorage.DT_ITEMarmCuffsBuffDescr
	DTConfig.armCuffsSpellDescr[2] = DTStorage.DT_ITEMarmCuffsNoWear

	DTConfig.legCuffsSpellDescr = new Spell[3]
	DTConfig.legCuffsSpellDescr[0] = DTStorage.DT_ITEMlegCuffsDebuffDescr
	DTConfig.legCuffsSpellDescr[1] = DTStorage.DT_ITEMlegCuffsBuffDescr
	DTConfig.legCuffsSpellDescr[2] = DTStorage.DT_ITEMlegCuffsNoWear	
	
	DTConfig.gagSpellDescr = new Spell[3]
	DTConfig.gagSpellDescr[0] = DTStorage.DT_ITEMGagDebuffDescr
	DTConfig.gagSpellDescr[1] = DTStorage.DT_ITEMGagBuffDescr
	DTConfig.gagSpellDescr[2] = DTStorage.DT_ITEMGagNoWear
	
	DTConfig.collarSpellDescr = new Spell[3]
	DTConfig.collarSpellDescr[0] = DTStorage.DT_ITEMCollarDebuffDescr
	DTConfig.collarSpellDescr[1] = DTStorage.DT_ITEMCollarBuffDescr
	DTConfig.collarSpellDescr[2] = DTStorage.DT_ITEMCollarNoWear	
	
	DTConfig.chastityBeltSpellDescr = new Spell[3]
	DTConfig.chastityBeltSpellDescr[0] = DTStorage.DT_ITEMChastityBeltDebuffDescr
	DTConfig.chastityBeltSpellDescr[1] = DTStorage.DT_ITEMChastityBeltBuffDescr
	DTConfig.chastityBeltSpellDescr[2] = DTStorage.DT_ITEMChastityBeltNoWear	
	
	DTConfig.chastityBraSpellDescr = new Spell[3]
	DTConfig.chastityBraSpellDescr[0] = DTStorage.DT_ITEMChastityBraDebuffDescr
	DTConfig.chastityBraSpellDescr[1] = DTStorage.DT_ITEMChastityBraBuffDescr
	DTConfig.chastityBraSpellDescr[2] = DTStorage.DT_ITEMChastityBraNoWear	
	
	DTConfig.armbinderSpellDescr = new Spell[3]
	DTConfig.armbinderSpellDescr[0] = DTStorage.DT_ITEMArmbinderDebuffDescr
	DTConfig.armbinderSpellDescr[1] = DTStorage.DT_ITEMArmbinderBuffDescr
	DTConfig.armbinderSpellDescr[2] = DTStorage.DT_ITEMArmbinderNoWear
	
	
	;tec
	DTConfig.exponentialTable 	=	new Int[101]
	DTConfig.logarithmicTable	=	new Int[101]
	DTConfig.linearTable		=	new Int[101]

	int i = 0
	
	while i <= 100
			DTConfig.linearTable[i] 	 = DTTools.calcLinear(i as float) as int
			DTConfig.logarithmicTable[i] = DTTools.calcLogarithmic(i as float) as int
			DTConfig.exponentialTable[i] = DTTools.calcExponential(i as float) as int
		i = i + 1
		
	endwhile	
	
	DTConfig.ddKeywords = new Keyword[32]
	DTConfig.ddKeywords[0] = libs.zad_DeviousBoots
	DTConfig.ddKeywords[1] = libs.zad_DeviousCorset
	DTConfig.ddKeywords[2] = libs.zad_DeviousHarness	
	DTConfig.ddKeywords[3] = libs.zad_DeviousLegCuffs
	DTConfig.ddKeywords[4] = libs.zad_DeviousArmCuffs
	DTConfig.ddKeywords[5] = libs.zad_DeviousGag
	DTConfig.ddKeywords[6] = libs.zad_DeviousCollar
	DTConfig.ddKeywords[7] = libs.zad_DeviousBelt
	DTConfig.ddKeywords[8] = libs.zad_DeviousBra
	DTConfig.ddKeywords[9] = libs.zad_DeviousGloves
	DTConfig.ddKeywords[10] = libs.zad_DeviousPlugVaginal
	DTConfig.ddKeywords[11] = libs.zad_DeviousPlugAnal
	DTConfig.ddKeywords[12] = libs.zad_DeviousPiercingsNipple
	DTConfig.ddKeywords[13] = libs.zad_DeviousPiercingsVaginal
	DTConfig.ddKeywords[14] = libs.zad_DeviousYoke
	DTConfig.ddKeywords[15] = libs.zad_DeviousArmbinder
	DTConfig.ddKeywords[16] = libs.zad_DeviousBlindfold
	DTConfig.ddKeywords[17] = libs.zad_DeviousYokeBB
	DTConfig.ddKeywords[18] = libs.zad_DeviousStraitJacket
	DTConfig.ddKeywords[19] = libs.zad_DeviousArmbinderElbow
	
	
	
	

	DTConfig.allowedRaces = new Race[32]
	DTConfig.allowedRaces[0] = DTStorage.redguardRace
	DTConfig.allowedRaces[1] = DTStorage.orcRace
	DTConfig.allowedRaces[2] = DTStorage.nordRace
	DTConfig.allowedRaces[3] = DTStorage.khajiitRace
	DTConfig.allowedRaces[4] = DTStorage.imperialRace
	DTConfig.allowedRaces[5] = DTStorage.dunmerRace
	DTConfig.allowedRaces[6] = DTStorage.bretonRace
	DTConfig.allowedRaces[7] = DTStorage.bosmerRace
	DTConfig.allowedRaces[8] = DTStorage.argonianRace
	DTConfig.allowedRaces[9] = DTStorage.altmerRace
	DTConfig.allowedRaces[10] = DTStorage.redguardRaceVampire
	DTConfig.allowedRaces[11] = DTStorage.orcRaceVampire
	DTConfig.allowedRaces[12] = DTStorage.nordRaceVampire
	DTConfig.allowedRaces[13] = DTStorage.khajiitRaceVampire
	DTConfig.allowedRaces[14] = DTStorage.imperialRaceVampire
	DTConfig.allowedRaces[15] = DTStorage.dunmerRaceVampire
	DTConfig.allowedRaces[16] = DTStorage.bretonRaceVampire
	DTConfig.allowedRaces[17] = DTStorage.bosmerRaceVampire
	DTConfig.allowedRaces[18] = DTStorage.argonianRaceVampire
	DTConfig.allowedRaces[19] = DTStorage.altmerRaceVampire
	
	
	DTConfig.slotMask = new Int[65]
	DTConfig.slotMask[30] = 0x00000001
	DTConfig.slotMask[31] = 0x00000002
	DTConfig.slotMask[32] = 0x00000004
	DTConfig.slotMask[33] = 0x00000008
	DTConfig.slotMask[34] = 0x00000010
	DTConfig.slotMask[35] = 0x00000020
	DTConfig.slotMask[36] = 0x00000040
	DTConfig.slotMask[37] = 0x00000080
	DTConfig.slotMask[38] = 0x00000100
	DTConfig.slotMask[39] = 0x00000200
	DTConfig.slotMask[40] = 0x00000400
	DTConfig.slotMask[41] = 0x00000800
	DTConfig.slotMask[42] = 0x00001000
	DTConfig.slotMask[43] = 0x00002000
	DTConfig.slotMask[44] = 0x00004000
	DTConfig.slotMask[45] = 0x00008000
	DTConfig.slotMask[46] = 0x00010000
	DTConfig.slotMask[47] = 0x00020000
	DTConfig.slotMask[48] = 0x00040000
	DTConfig.slotMask[49] = 0x00080000
	DTConfig.slotMask[50] = 0x00100000
	DTConfig.slotMask[51] = 0x00200000
	DTConfig.slotMask[52] = 0x00400000
	DTConfig.slotMask[53] = 0x00800000
	DTConfig.slotMask[54] = 0x01000000
	DTConfig.slotMask[55] = 0x02000000
	DTConfig.slotMask[56] = 0x04000000
	DTConfig.slotMask[57] = 0x08000000
	DTConfig.slotMask[58] = 0x10000000
	DTConfig.slotMask[59] = 0x20000000
	DTConfig.slotMask[60] = 0x40000000
	DTConfig.slotMask[61] = 0x80000000
	
	DTConfig.DT_Boots = Game.GetFormFromFile(0x08023e6c, "DeviousTraining.esp") as Faction
	DTConfig.DT_Corset = Game.GetFormFromFile(0x08023e6d, "DeviousTraining.esp") as Faction
	DTConfig.DT_Harness = Game.GetFormFromFile(0x08023e6e, "DeviousTraining.esp") as Faction
	DTConfig.DT_Legscuffs = Game.GetFormFromFile(0x08023e6f, "DeviousTraining.esp") as Faction
	DTConfig.DT_Armscuffs = Game.GetFormFromFile(0x08023e70, "DeviousTraining.esp") as Faction
	DTConfig.DT_Gag = Game.GetFormFromFile(0x08023e71, "DeviousTraining.esp") as Faction
	DTConfig.DT_Collar = Game.GetFormFromFile(0x08023e72, "DeviousTraining.esp") as Faction
	DTConfig.DT_Chastitybelt = Game.GetFormFromFile(0x08023e73, "DeviousTraining.esp") as Faction
	DTConfig.DT_Chastitybra = Game.GetFormFromFile(0x08023e74, "DeviousTraining.esp") as Faction
	DTConfig.DT_Gloves = Game.GetFormFromFile(0x08023e75, "DeviousTraining.esp") as Faction
	DTConfig.DT_Armbinderyoke = Game.GetFormFromFile(0x08023e76, "DeviousTraining.esp") as Faction
	DTConfig.DT_Blindfold = Game.GetFormFromFile(0x08023e77, "DeviousTraining.esp") as Faction
	DTConfig.DT_AnalPlug = Game.GetFormFromFile (0x08026988, "DeviousTraining.esp") as Faction
	DTConfig.DT_VaginalPlug = Game.GetFormFromFile (0x08026989, "DeviousTraining.esp") as Faction
	
	
	DTConfig.zadWeapon = DTStorage.zadWeapon
	
	;	Enchantment crawlEnch =  Game.GetFormFromFile(0x0600438F, "ZazExtensionPack.esm") as Enchantment
	;Armor deformedLegs = DTStorage.DT_ArchedFeet 
	;deformedLegs.SetEnchantment(crawlEnch)
	
endFunction


function updateOnEveryLoad()
	DTConfig.sanguneDebucheryPack = false
	DTConfig.zazExtensionPack = false
	DTConfig.cursedLootPack = false
	
	if (Game.GetModbyName("ZazExtensionPack.esm") != 255)
		DTConfig.zazExtensionPack = true		
		DTTools.log("check for ZazExtensionPack OK!")		
	else
		DTConfig.zazExtensionPack = false
	endIf
	
	if (Game.GetModbyName("sanguinesDebauchery.esp") != 255)
		DTConfig.sanguneDebucheryPack = true		
		DTTools.log("check for sanguinesDebauchery OK!")
	else
		DTConfig.sanguneDebucheryPack = false
	endIf	
	
	if (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
		DTConfig.slifPack = true		
		DTTools.log("check for SexLab Inflation Framework OK!")
	else
		DTConfig.slifPack = false
	endIf	
	
	if (Game.GetModbyName("SLSO.esp") != 255)
		DTConfig.separateOrgasmPack = true		
		DTTools.log("check for SexLab Separate Orgasm OK!")
	else
		DTConfig.separateOrgasmPack = false
	endIf	

	if (Game.GetModbyName("bac.esp") != 255)
		DTConfig.bacPack = true		
		DTTools.log("check for Being a Cow OK!")
		DTConfig.bac_hooves	= Game.GetFormFromFile(0x04004352, "bac.esp") as Keyword
		DTConfig.bac_hooves_hand	= Game.GetFormFromFile(0x050417F2, "bac.esp") as Keyword
		
	else
		DTConfig.bacPack = false
	endIf	
	
	if (Game.GetModbyName("SlaveTats.esp") != 255)
		DTConfig.slaveTatsPack = true		
		DTTools.log("check for SlaveTats OK!")
	else
		DTConfig.slaveTatsPack = false
	endIf
	
	if (Game.GetModbyName("Deviously Cursed Loot.esp") != 255)
		DTConfig.cursedLootPack = true		
		DTTools.log("check for Deviously Cursed Loot OK!")
	else
		DTConfig.allowChangecursedLootPack = false
		DTConfig.cursedLootPack = false
	endIf
	
	
	;arched feet
	if DTConfig.zazExtensionPack == false && DTConfig.sanguneDebucheryPack == false
		DTConfig.effect_arched_feet_crawl_visual = false
	endif
	
	if DTConfig.allowToReconfigureAutomatic == true
		DTTools.reconfigureIntegration()
	endif
	
	DTCore.unregisterSexLabEvents()
	DTCore.registerSexLabEvents()
	;add sexlab events
	
	
	
endFunction


function resetAll()
	
endFunction
