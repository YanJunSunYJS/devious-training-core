Scriptname DT2MCM extends SKI_ConfigBase

DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Actor Property DTActor Auto
DT2Storage Property DTStorage Auto
DT2Descriptor Property DTDescriptor Auto
DT2Main Property DTMain Auto
DT2Core Property DTCore Auto
DT2Update Property DTUpdate Auto
DT2Expert Property DTExpert Auto
Event OnGameReload()
	parent.OnGameReload()
	Return
EndEvent

Event OnVersionUpdate(Int ver)
	OnConfigInit()
	Return
EndEvent

Int Function GetVersion()
  OnConfigInit()
  Return (DTMain.getVersion()*100) as int
EndFunction


Event OnConfigClose()
	
	if DTConfig.mcmWorking == true
		return
	endIf
	
	

	DTConfig.mcmWorking = true
	;Utility.Wait(DTConfig.updateInterval / 10)
	DTMain.turnOffMod()
	Utility.Wait(DTConfig.updateInterval / 20)
	
	DTTools.log("Apply changes from MCM - START")

	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i] != None
			if DTTools.isCorrectType(DTActor.npcs_ref[i]) == false || DTTools.isValid(DTActor.npcs_ref[i])
				if i != DTConfig.playerSlot
					DTActor.toremove[i] = true
				endif
			endif
	
			if DTActor.toremove[i] == true
				DTConfig.process_wildcard = true
				bool mcmTatsChanged = DTConfig.mcmTatsChanged
				bool mcmBodyChanged = DTConfig.mcmBodyChanged
				DTActor.unregisterActor(i)
				DTConfig.mcmTatsChanged = mcmTatsChanged
				DTConfig.mcmBodyChanged = mcmBodyChanged
				DTConfig.process_wildcard = false
			endif
		endif
		i = i + 1
	endWhile


	if DTConfig.lastVersion == 0
		DTConfig.process_wildcard = true
		DTCore.removeAllActors()
		DTConfig.process_wildcard = false
		if DTConfig.modEnabled==true
			DTUpdate.Update(getVersion())
		endif
	endIf
	
	if DTConfig.modEnabled==true
		;Utility.Wait(DTConfig.updateInterval / 4)	
		DTConfig.process_wildcard = true
		DTCore.mcmResetAll()
		DTConfig.process_wildcard = false
		DTCore.sendStatus("enable")
		
	else
		;Utility.Wait(DTConfig.updateInterval / 4)	
		DTConfig.process_wildcard = true
		DTCore.resetAll()
		DTConfig.process_wildcard = false
		DTCore.sendStatus("disable")
		;DTCore.resetAll()
		;Utility.Wait(DTConfig.updateInterval / 2)
		;DTCore.resetAll()
	endif
	
	DTTools.log("Apply changes from MCM - END")
	
	
	if DTConfig.modEnabled==true
		;DTStorage.Semaphor = false
		DTMain.turnOnMod(0.01)
	endif	
	DTConfig.mcmWorking = false
	debug.notification("Devious Training: Processing finish!")
endEvent

Event OnConfigInit()
	;DTStorage.Semaphor = true 
	generalEnabled = 0
	
	if DTConfig.modEnabled == true
		generalEnabled  = 1
	endif
	
	if DTConfig.lastVersion == 0
		generalEnabled  = 0
	endif

	
	if DTConfig.mcmWorking==true
		;debug.messagebox("Mod is still processing!\n\nPlease close menu and wait a moment\n\n...and try again")
		generalEnabled  = 0
	endIf
	
	actorlist = new int[32]
	actorListString = new String[32]

	actorPointer = DTConfig.playerSlot
	
	needToApplyChanges = false
	
	npcslistinfo = new int[64]
	ModName = "Devious Training II"
	
	colorset = new string[3]
	colorset[0] = "Black "
	colorset[1] = "White "
	colorset[2] = "Red "
	
	arousalBehavior = new string[4]
	arousalBehavior[0] = "Always up"
	arousalBehavior[1] = "Always down"
	arousalBehavior[2] = "Trained up else down"
	arousalBehavior[3] = "Untrained up else down"
	
	carryWeightLimit = new string[4]
	carryWeightLimit[0] = "Disabled"
	carryWeightLimit[1] = "over 150 units"
	carryWeightLimit[2] = "over 300 units"
	carryWeightLimit[3] = "over 450 units"
	
	speedWalkLimit = new string[4]
	speedWalkLimit[0] = "Disabled"
	speedWalkLimit[1] = "over 50% speed"
	speedWalkLimit[2] = "over 65% speed"
	speedWalkLimit[3] = "over 80% speed"
	
	
	selectAction = new string[3]
	selectAction[0] = "Select"
	selectAction[1] = "Yes"
	selectAction[2] = "No"
	
	selectActionYesNo = new string[3]	
	selectActionYesNo[0] = "Yes"
	selectActionYesNo[1] = "No"
	
	buffPower = new string[3]
	buffPower[0] = "Low"
	buffPower[1] = "Normal"
	buffPower[2] = "Extreme"
	
	speedValues = new string[7]
	speedValues[0] = "Disabled"
	speedValues[1] = "Very slow"
	speedValues[2] = "Slow"
	speedValues[3] = "Normal"
	speedValues[4] = "Fast"
	speedValues[5] = "Very fast"
	speedValues[6] = "Ultra"
	
	buffMult = new string[5]
	buffMult[0] = "No buffs/debuffs"
	buffMult[1] = "x 0.25"
	buffMult[2] = "x 0.50"
	buffMult[3] = "x 0.75"
	buffMult[4] = "x 1.00"
	
	progressCurve = new String[3]
	progressCurve[0] = "Linear"
	progressCurve[1] = "Exponential"
	progressCurve[2] = "Logarithmic"
	
	regresModel = new String[5]
	regresModel[0] = "Always"
	regresModel[1] = "In DEBUFF stage"
	regresModel[2] = "In BUFF stage"
	regresModel[3] = "If NOT Master Level"
	regresModel[4] = "Never"
	
	

	Pages = new String[6]
	Pages[0] = "General settings"
	Pages[1] = "Items and training"
	Pages[2] = "Body effects"	;;TODO
	Pages[2] = "Achievements"
	Pages[2] = "Actors"
	Pages[3] = "Actors stats"
	Pages[4] = "Utilities"
	Return
EndEvent

Event OnPageReset(string page)
	
	
	
	OnConfigInit()
	SetCursorFillMode(TOP_TO_BOTTOM)
		
	DTMain.turnOffMod()
	
	;if mcmWorkInt==1
	;	mcmWorkInt=0
	;else
	;	mcmWorkInt=1
	;endif
  
	if DTConfig.mcmWorking == true
		debug.messagebox("Please wait\nMod still working to apply your latest changes. \nClose MCM and wait a moment...\n\nIf its Your first run:\nmake sure that you uninstalled old version of this mod [1.x].")
	endif
	
	if (page == "")
	
		LoadCustomContent("DeviousTraining/DT.dds", 176, 23)
		return
	else
		UnloadCustomContent()
	endIf
  
	int mcmWorkInt = 1;
	if DTConfig.mcmWorking == true
		mcmWorkInt = 0
	endif
	

  
	if (page == "General settings" || page == "")
		SetTitleText("General settings, version:"+DTMain.getDisplayVersion())
		
		AddHeaderOption("Mod status")
			modEnabled = AddToggleOption("Mod active",DTConfig.modEnabled,getEnableFlag(mcmWorkInt))
		AddEmptyOption()              
		AddHeaderOption("Leveling")
			training_level_curve  = AddMenuOption("Leveling curve", progressCurve[DTConfig.training_level_curve as int],getEnableFlag(generalEnabled))
			training_level_model  = AddMenuOption("Allow to regress", regresModel[DTConfig.training_level_model as int],getEnableFlag(generalEnabled))
			training_buffMult  = AddMenuOption("(de)Buffs Mult", buffMult[DTConfig.buffMult as int],getEnableFlag(generalEnabled))
		AddEmptyOption()
		AddHeaderOption("Effects")
			effect_sound_enabled  = AddToggleOption("Sound effects",DTConfig.effect_sound_enabled,getEnableFlag(generalEnabled))
			effect_shader_enabled = AddToggleOption("Shader effects",DTConfig.effect_shader_enabled,getEnableFlag(generalEnabled))
			effect_alert_enabled = AddToggleOption("Sound's alerts enemies",DTConfig.effect_alert_enabled,getEnableFlag(generalEnabled))
			effect_values_enabled = AddToggleOption("Affect Stamina/Health/Magica",DTConfig.effect_values_enabled,getEnableFlag(generalEnabled))
			effect_arousal_enabled = AddToggleOption("Affect arousal",DTConfig.effect_arousal_enabled,getEnableFlag(generalEnabled))
			effect_arousal_behavior  = AddMenuOption("Arousal calc model", arousalBehavior[DTConfig.effect_arousal_behavior as int],getEnableFlag(generalEnabled * DTConfig.effect_arousal_enabled as int))			
		
		
		
		SetCursorPosition(1)		
		AddHeaderOption("Integration")
		
			allowToReconfigureAutomatic = AddToggleOption("Enable auto reconfiguration",DTConfig.allowToReconfigureAutomatic,getEnableFlag(generalEnabled))
			reconfigureNow			    = AddMenuOption("Reconfigure now!", selectAction[0],getEnableFlag(generalEnabled))
			AddEmptyOption()
			allowChangeDeviousDevices = AddToggleOption("Reconfig: Devious Devices",DTConfig.allowChangeDeviousDevices,getEnableFlag(generalEnabled))
			allowChangecursedLootPack = AddToggleOption("Reconfig: Cursed Loot",DTConfig.allowChangecursedLootPack,getEnableFlag(DTConfig.cursedLootPack as int * generalEnabled ))
		
			AddEmptyOption()
			;only as info
			static1 = AddToggleOption("zazExtensionPack found:",DTConfig.zazExtensionPack,OPTION_FLAG_DISABLED)
			static2 = AddToggleOption("Sangune Debauchery found:",DTConfig.sanguneDebucheryPack,OPTION_FLAG_DISABLED)
			static1 = AddToggleOption("SLIF found:",DTConfig.slifPack,OPTION_FLAG_DISABLED)
			static2 = AddToggleOption("Slave Tats found:",DTConfig.slaveTatsPack,OPTION_FLAG_DISABLED)
			static1 = AddToggleOption("SexLab Separate orgasm found:",DTConfig.separateOrgasmPack,OPTION_FLAG_DISABLED)
			static2 = AddToggleOption("Being a Cow found:",DTConfig.bacPack,OPTION_FLAG_DISABLED)
		
		AddEmptyOption()
		AddHeaderOption("Solutions")
		
			turnoffspeedattack = AddToggleOption("Turn off speed attack",DTConfig.turnoffspeedattack,getEnableFlag(generalEnabled))
			ignoreAdditionNegativeEffects = AddToggleOption("Ignore negative effects when trained",DTConfig.ignoreAdditionNegativeEffects,getEnableFlag(generalEnabled))
			
			ignore_duplicates = AddToggleOption("Resolve corset & harness",DTConfig.ignore_duplicates,getEnableFlag(generalEnabled))
			process_only_pc = AddToggleOption("Process PC",DTConfig.process_only_pc,OPTION_FLAG_DISABLED)
			process_follower = AddToggleOption("Process Followers",DTConfig.process_follower,getEnableFlag(generalEnabled))
			process_friends = AddToggleOption("Process friendly NPC",DTConfig.process_friends,getEnableFlag(generalEnabled))
			process_neutral = AddToggleOption("Process neutral NPC",DTConfig.process_neutral,getEnableFlag(generalEnabled))
			process_enemies = AddToggleOption("Process enemy NPC",DTConfig.process_enemies,getEnableFlag(generalEnabled))
			
			
			
			
			updateOnlyWithCellChange = AddToggleOption("Update nodes only with cell change",DTConfig.updateOnlyWithCellChange,getEnableFlag(generalEnabled))
			fullProcessing = AddToggleOption("Process all NPC (experimental)",DTConfig.fullProcessing,getEnableFlag(generalEnabled))
			AddEmptyOption()
			addBuffsAndDebuffs = AddToggleOption("Enable processing",DTConfig.addBuffsAndDebuffs,getEnableFlag(generalEnabled))
			AddEmptyOption()
			preventCarryWeight  = AddMenuOption("Try to keep CarryWeight:", carryWeightLimit[DTConfig.preventCarryWeight as int],getEnableFlag(generalEnabled))			
			preventSpeedWalk    = AddMenuOption("Try to keep SpeedWalk:", speedWalkLimit[DTConfig.preventSpeedWalk as int],getEnableFlag(generalEnabled))			
		
		
	endIf
	
	if (page == "Items and training")
	
		int itemEnabled1 = 0 
		int itemEnabled2 = 0
		int itemEnabled3 = 0
		AddHeaderOption("Boots & Heels")
			training_speed_boots  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_boots as int],getEnableFlag(generalEnabled))			
			
			if DTConfig.training_speed_boots > 0
				itemEnabled1 = 1
			endif
				effect_boots_enabled = AddToggleOption("Enable boots effects",DTConfig.effect_boots_enabled,getEnableFlag(generalEnabled * itemEnabled1))
				
				AddHeaderOption("  BOOTS THAT WORKS LIKE DD:")
				
					Armor thisArmor = DTConfig.playerRef.GetWornForm(DTConfig.slotMask[37]) as Armor
					string tmpbootsname
					string tmpactionname
					
					tmpbootsname = DTConfig.acceptBoots0.GetName()
					tmpactionname = "  PICK BOOTS: "+thisArmor.GetName()
					if tmpbootsname != ""
						tmpactionname = "  REMOVE: "+tmpbootsname+" FROM LIST"
					endif
					
					effect_bootsAllow0 = AddTextOption("", tmpactionname,getEnableFlag(generalEnabled * itemEnabled1))
				
				if DTConfig.effect_boots_enabled == true
					itemEnabled2 = 1				
				endif
				
				effect_boots_weight = AddSliderOption("Max event probability",DTConfig.effect_boots_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
				
				;REMOVE effect_arched_feet_visual = AddToggleOption("Arched feet effect",DTConfig.effect_arched_feet_visual,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2 * notIntLikeBool(DTConfig.achievement_ponygirl_enabled as int * DTConfig.achievement_ponygirl_equip_enabled as int) ))
				if DTConfig.effect_arched_feet_visual== true
					itemEnabled3 = 1
				endif
				
				
				;REMOVE AddEmptyOption()
				;REMOVE 	AddHeaderOption("  BOOTS THAT PREVENTS ARCHED FEET:")
				
					
				;REMOVE 	tmpbootsname = DTConfig.acceptBoots1.GetName()
				;REMOVE 	tmpactionname = "  PICK BOOTS: "+thisArmor.GetName()
				;REMOVE 	if tmpbootsname != ""
				;REMOVE 		tmpactionname = "  REMOVE: "+tmpbootsname+" FROM LIST"
				;REMOVE 	endif
					
				;REMOVE 	effect_bootsAllow1 = AddTextOption("", tmpactionname,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled3))
					
				;REMOVE 	tmpbootsname = DTConfig.acceptBoots2.GetName()
				;REMOVE 	tmpactionname = "  PICK BOOTS: "+thisArmor.GetName()
				;REMOVE 	if tmpbootsname != ""
				;REMOVE 		tmpactionname = "  REMOVE: "+tmpbootsname+" FROM LIST"
				;REMOVE 	endif
					
				;REMOVE 	effect_bootsAllow2 = AddTextOption("", tmpactionname,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled3))
					
				;REMOVE 	tmpbootsname = DTConfig.acceptBoots3.GetName()
				;REMOVE 	tmpactionname = "  PICK BOOTS: "+thisArmor.GetName()
				;REMOVE 	if tmpbootsname != ""
				;REMOVE 		tmpactionname = "  REMOVE: "+tmpbootsname+" FROM LIST"
				;REMOVE 	endif
					
				;REMOVE 	effect_bootsAllow3 = AddTextOption("", tmpactionname,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled3))
				
				AddEmptyOption()
				
				
				
				if DTConfig.sanguneDebucheryPack == true || DTConfig.zazExtensionPack == true
					
				else
					itemEnabled3 = 0
				endif
				
				;REMOVE  effect_arched_feet_crawl_visual = AddToggleOption("Crawl if arched feet",DTConfig.effect_arched_feet_crawl_visual,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2 * itemEnabled3))
			
		AddEmptyOption()		

		itemEnabled1 = 0 
		itemEnabled2 = 0
		itemEnabled3 = 0
		AddHeaderOption("Armbinder and Yoke")
			training_speed_armbinder  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_armbinder as int],getEnableFlag(generalEnabled))			
			if DTConfig.training_speed_armbinder > 0
				itemEnabled1 = 1
			endif
			effect_armbinder_health = AddSliderOption("Slow time health threshold",DTConfig.effect_armbinder_health,"{0}",getEnableFlag(generalEnabled * itemEnabled1))
	
		AddEmptyOption()		
		
		itemEnabled1 = 0 
		itemEnabled2 = 0
		itemEnabled3 = 0
		AddHeaderOption("Gloves ")
			training_speed_gloves  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_gloves as int],getEnableFlag(generalEnabled))			
			
	
		AddEmptyOption()		
		
		itemEnabled1 = 0 
		itemEnabled2 = 0
		
		AddHeaderOption("Corset ")
			training_speed_corset  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_corset as int],getEnableFlag(generalEnabled))			
			if DTConfig.training_speed_corset > 0
				itemEnabled1 = 1
			endif
				effect_corset_enabled = AddToggleOption("Enable corset effects",DTConfig.effect_corset_enabled,getEnableFlag(generalEnabled * itemEnabled1))
				if DTConfig.effect_corset_enabled == true
					itemEnabled2 = 1
				endif
				effect_corset_weight = AddSliderOption("Max event probability",DTConfig.effect_corset_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
				;REMOVE effect_corset_waist_visual = AddSliderOption("Waist scaling",DTConfig.effect_corset_waist_visual,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
				;REMOVE effect_corset_waist_visualWithout = AddSliderOption("Waist scaling without corset",DTConfig.effect_corset_waist_visualWithout,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
			
			
		AddEmptyOption()
		
		itemEnabled1 = 0 
		itemEnabled2 = 0
		
		AddHeaderOption("Harness ")
		training_speed_harness  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_harness as int],getEnableFlag(generalEnabled))						
		if DTConfig.training_speed_harness > 0
			itemEnabled1 = 1
		endif
			effect_harness_enabled = AddToggleOption("Enable harness effects",DTConfig.effect_harness_enabled,getEnableFlag(generalEnabled * itemEnabled1))
			if DTConfig.effect_harness_enabled == true
				itemEnabled2 = 1
			endif
			effect_harness_weight = AddSliderOption("Max event probability",DTConfig.effect_harness_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
		
		
		SetCursorPosition(1)	
		itemEnabled1 = 0 
		itemEnabled2 = 0
		
		
		AddHeaderOption("Leg Cuffs")
		training_speed_legcuffs  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_legcuffs as int],getEnableFlag(generalEnabled))						
		if DTConfig.training_speed_legcuffs > 0
			itemEnabled1 = 1
		endif
			effect_legcuffs_enabled = AddToggleOption("Jingle chain enabled",DTConfig.effect_legcuffs_enabled,getEnableFlag(generalEnabled * itemEnabled1))
			if DTConfig.effect_legcuffs_enabled == true
				itemEnabled2 = 1
			endif

				effect_legcuffs_weight = AddSliderOption("Jingle probability",DTConfig.effect_legcuffs_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
				effect_legcuffs_alert_weight = AddSliderOption("Jingle alert probability",DTConfig.effect_legcuffs_alert_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2 * DTConfig.effect_alert_enabled as int))
			
		
		
		AddEmptyOption()
		
		itemEnabled1 = 0 
		itemEnabled2 = 0		
		
		AddHeaderOption("Arm Cuffs")
		training_speed_armcuffs  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_armcuffs as int],getEnableFlag(generalEnabled))			
		if DTConfig.training_speed_armcuffs > 0
			itemEnabled1 = 1
		endif
			effect_armcuffs_enabled = AddToggleOption("Jingle chain enabled",DTConfig.effect_armcuffs_enabled,getEnableFlag(generalEnabled * itemEnabled1))
			if DTConfig.effect_armcuffs_enabled == true
				itemEnabled2 = 1
			endif
				effect_armcuffs_weight = AddSliderOption("Jingle probability",DTConfig.effect_armcuffs_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
				effect_armcuffs_alert_weight = AddSliderOption("Jingle alert probability",DTConfig.effect_armcuffs_alert_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2 * DTConfig.effect_alert_enabled as int))
				
			AddEmptyOption()
		
		itemEnabled1 = 0 
		itemEnabled2 = 0
		itemEnabled3 = 0
		AddHeaderOption("Blindfold")
			training_speed_blindfold  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_blindfold as int],getEnableFlag(generalEnabled))			
			if DTConfig.training_speed_blindfold > 0
				itemEnabled1 = 1
			endif
			effect_blindfold_enabled = AddToggleOption("Shader controll",DTConfig.effect_blindfold_enabled,getEnableFlag(generalEnabled * itemEnabled1))
			
			;REMOVE effect_blindfold_eyes_close = AddSliderOption("Eye's open deform.",DTConfig.effect_blindfold_eyes_close,"{1}",getEnableFlag(generalEnabled * itemEnabled1))
			
			
			;effect_armbinder_health = AddSliderOption("Slow time health threshold",DTConfig.effect_armbinder_health,"{0}",getEnableFlag(generalEnabled * itemEnabled1))
	
		AddEmptyOption()		
		
		
		AddEmptyOption()
		itemEnabled1 = 0 
		itemEnabled2 = 0		
		itemEnabled3 = 0
		
		AddHeaderOption("Gag ")
		
			training_speed_gag  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_gag as int],getEnableFlag(generalEnabled))			
			
			if DTConfig.training_speed_gag > 0		
				itemEnabled1 = 1
			endif
			
			effect_gag_enabled = AddToggleOption("Gag effects enabled",DTConfig.effect_gag_enabled,getEnableFlag(generalEnabled * itemEnabled1))
			
			if DTConfig.effect_gag_enabled == true
				itemEnabled2 = 1
			endif
			
			if DTConfig.allowChangeDeviousDevices == true || DTConfig.allowChangecursedLootPack == true
				itemEnabled3 = 1
			endif
			
			effect_gag_enabled_talk = AddToggleOption("Allow to talk if trained",DTConfig.effect_gag_enabled_talk,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2 * itemEnabled3))
			
			;REMOVE effect_gag_enabled_mounth = AddToggleOption("Deformed mounth effect",DTConfig.effect_gag_enabled_mounth,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))

			;REMOVE itemEnabled3 = 0
			;REMOVE if DTConfig.effect_gag_enabled_mounth == true
			;REMOVE 	itemEnabled3 = 1
			;REMOVE endif
			
			;REMOVE effect_gag_enabled_mounth_weight = AddSliderOption("Deformed max scale",DTConfig.effect_gag_enabled_mounth_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2 * itemEnabled3))
				
			
		
		
		AddEmptyOption()
		itemEnabled1 = 0 
		itemEnabled2 = 0		
		itemEnabled3 = 0

		
		AddHeaderOption("Collar ")
		
			training_speed_collar  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_collar as int],getEnableFlag(generalEnabled))				
			if DTConfig.training_speed_collar > 0	
				itemEnabled1 = 1
			endif
		
			effect_collar_enabled = AddToggleOption("Collar effects enabled",DTConfig.effect_collar_enabled,getEnableFlag(generalEnabled * itemEnabled1))
		
			if DTConfig.effect_collar_enabled == true
				itemEnabled2 = 1
			endif
			effect_collar_weight = AddSliderOption("Max event probability",DTConfig.effect_collar_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
			

			;REMOVE effect_collar_long_visual = AddSliderOption("Neck scaling",DTConfig.effect_collar_long_visual,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
		

		AddEmptyOption()
		itemEnabled1 = 0 
		itemEnabled2 = 0		
		itemEnabled3 = 0		
		AddHeaderOption("Chastity Belt ")
			training_speed_chastityBelt  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_chastityBelt as int],getEnableFlag(generalEnabled))		
			if DTConfig.training_speed_chastityBelt > 0	
				itemEnabled1 = 1
			endif			
			
			effect_chastityBelt_enabled = AddToggleOption("Chastity belt effects enabled",DTConfig.effect_chastityBelt_enabled,getEnableFlag(generalEnabled * itemEnabled1))
			if DTConfig.effect_chastityBelt_enabled == true
				itemEnabled2 = 1
			endif
			
			effect_chastityBelt_weight = AddSliderOption("Jingle probability",DTConfig.effect_chastityBelt_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
			

		AddEmptyOption()
		itemEnabled1 = 0 
		itemEnabled2 = 0		
		itemEnabled3 = 0		
		AddHeaderOption("Chastity Bra ")
			training_speed_chastityBra  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_chastityBra as int],getEnableFlag(generalEnabled))						
			if DTConfig.training_speed_chastityBra > 0	
				itemEnabled1 = 1
			endif			
			
			effect_chastityBra_enabled = AddToggleOption("Chastity bra effects enabled",DTConfig.effect_chastityBra_enabled,getEnableFlag(generalEnabled * itemEnabled1))
			if DTConfig.effect_chastityBra_enabled == true
				itemEnabled2 = 1
			endif
			;REMOVE effect_chastity_breast_visual = AddSliderOption("Breast size mod if trained",DTConfig.effect_chastity_breast_visual,"{1}",getEnableFlag(DTConfig.slifPack as int * generalEnabled * itemEnabled1 * itemEnabled2))
			effect_chastityBra_weight = AddSliderOption("Jingle probability",DTConfig.effect_chastityBra_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
		
		AddEmptyOption()
		
		AddHeaderOption("Anal Plug ")
		training_speed_analplug  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_analplug as int],getEnableFlag(generalEnabled))	
		
		AddEmptyOption()
		
		AddHeaderOption("Vaginal Plug ")
		training_speed_vaginalplug  = AddMenuOption("Training speed", speedValues[DTConfig.training_speed_vaginalplug as int],getEnableFlag(generalEnabled))
		itemEnabled1 = 0 		
		if DTConfig.training_speed_vaginalplug > 0
				itemEnabled1 = 1
		endif
		if itemEnabled1 > 0
			effect_vaginalPlug_weight = AddSliderOption("Moan probability",DTConfig.effect_vaginalPlug_weight,"{0}",getEnableFlag(generalEnabled * itemEnabled1))
		endif
	endIf
	
	if (page == "Body effects123")
		AddHeaderOption("Body changes")
		enableSlif = AddToggleOption("Enable SLIF to manage the weights",DTConfig.enableSlif,getEnableFlag(generalEnabled * DTConfig.slifPack as int))
		AddEmptyOption()
		AddHeaderOption("Orgasm and Body changes")
		
		bodyScaleOrgasmEnabled= AddToggleOption("Enabled body scaling on orgasm",DTConfig.bodyScaleOrgasmEnabled,getEnableFlag(generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		minOrgasmCount = AddSliderOption("Min. orgasm count required",DTConfig.minOrgasmCount,"{0}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		bodyScaleFactor = AddSliderOption("Weight growth/loss speed",DTConfig.bodyScaleFactor,"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		bodyWithoutSexGrowth= AddToggleOption("Orgasms reduce body weight", DTConfig.bodyWithoutSexGrowth,getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		AddEmptyOption()
		bodyMinBrests = AddSliderOption("Min breasts size",DTConfig.bodyMinBrests,"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		bodyMaxBrests = AddSliderOption("Max breasts size",DTConfig.bodyMaxBrests,"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		bodyMinButt = AddSliderOption("Min butt size",DTConfig.bodyMinButt,"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		bodyMaxButt = AddSliderOption("Max butt size",DTConfig.bodyMaxButt,"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		bodyMinBelly = AddSliderOption("Min belly size",DTConfig.bodyMinBelly,"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		bodyMaxBelly = AddSliderOption("Max belly size",DTConfig.bodyMaxBelly,"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int))
		
		AddEmptyOption()
		
		bodyPointer = AddSliderOption("Current player weight",DTActor.bodyPointer[DTConfig.playerSlot],"{1}",getEnableFlag(DTConfig.bodyScaleOrgasmEnabled as Int * generalEnabled * DTConfig.slifPack as Int * DTConfig.enableSlif as Int)) 
		
		
		SetCursorPosition(1)		
		AddHeaderOption("Tats")
		tats_days_enabled= AddToggleOption("Days in bondage (tats counter)",DTConfig.tats_days_enabled,getEnableFlag(generalEnabled * DTConfig.slaveTatsPack as Int))
		AddEmptyOption()
		tats_item_enabled = AddToggleOption("Enable body marks",DTConfig.tats_item_enabled,getEnableFlag(generalEnabled * DTConfig.slaveTatsPack as Int))
		tats_item_chastity_belt = AddToggleOption("...from chastity belt",DTConfig.tats_item_chastity_belt,getEnableFlag(DTConfig.tats_item_enabled as int * generalEnabled * DTConfig.slaveTatsPack as Int))
		tats_item_chastity_bra= AddToggleOption("...from chastity bra",DTConfig.tats_item_chastity_bra,getEnableFlag(DTConfig.tats_item_enabled as int * generalEnabled * DTConfig.slaveTatsPack as Int))
		tats_item_corset= AddToggleOption("...from corset",DTConfig.tats_item_corset,getEnableFlag(DTConfig.tats_item_enabled as int * generalEnabled * DTConfig.slaveTatsPack as Int))
		tats_item_harness= AddToggleOption("...from harness",DTConfig.tats_item_harness,getEnableFlag(DTConfig.tats_item_enabled as int * generalEnabled * DTConfig.slaveTatsPack as Int))
	endIf
	
	if (page == "Achievements")
		AddHeaderOption("Blind slut")
	
		achievement_blindslut_enabled = AddToggleOption("Enable achievement",DTConfig.achievement_blindslut_enabled,getEnableFlag(generalEnabled))
		
		AddEmptyOption()
		AddHeaderOption("Pony Girl")
		;enabled
		
		int itemEnabled1 = 0 
		int itemEnabled2 = 0
		int itemEnabled3 = 0
		
		achievement_ponygirl_enabled = AddToggleOption("Enable achievement",DTConfig.achievement_ponygirl_enabled,getEnableFlag(generalEnabled))
		
		if DTConfig.achievement_ponygirl_enabled == true
			itemEnabled1 = 1
		endIf
		
		AddEmptyOption()	
		
		achievement_ponygirl_equip_enabled = AddToggleOption("Use extra pony items",DTConfig.achievement_ponygirl_equip_enabled,getEnableFlag(generalEnabled * itemEnabled1))

		if DTConfig.achievement_ponygirl_equip_enabled == true
			itemEnabled2 = 1
		endIf
		
		achievement_ponygirl_equip_tied = AddToggleOption("Extra items: equip in pony mode",DTConfig.achievement_ponygirl_equip_tied,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
		achievement_ponygirl_equip_always = AddToggleOption("Extra items: equip always",DTConfig.achievement_ponygirl_equip_always,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
		achievement_ponygirl_equip_force = AddToggleOption("Force equip items if possible",DTConfig.achievement_ponygirl_equip_force,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
		
		AddEmptyOption()	
		
		achievement_ponygirl_sound_tied = AddToggleOption("Sound effects: enable in pony mode",DTConfig.achievement_ponygirl_sound_tied,getEnableFlag(generalEnabled * itemEnabled1))
		achievement_ponygirl_sound_always = AddToggleOption("Sound effects: enable always",DTConfig.achievement_ponygirl_sound_always,getEnableFlag(generalEnabled * itemEnabled1))
		
		AddEmptyOption()
		AddHeaderOption("Pony Girl Shaut")
		achievement_ponygirl_cast_helpfull_spells = AddToggleOption("Auto cast spells",DTConfig.achievement_ponygirl_cast_helpfull_spells,getEnableFlag(generalEnabled * itemEnabled1))
		achievement_ponygirl_add_another_items = AddToggleOption("Equip well trained DDevices",DTConfig.achievement_ponygirl_add_another_items,getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled2))
		if DTConfig.achievement_ponygirl_add_another_items == true
			itemEnabled3 = 1
		endIf
		SetCursorPosition(1)
		AddHeaderOption("Items settings")
		AddEmptyOption()
		achievement_ponygirl_colorset  = AddMenuOption("Item color set", colorset[DTConfig.achievement_ponygirl_colorset as int],getEnableFlag(generalEnabled * itemEnabled1 * itemEnabled3))		
	endif
	
	if (page == "Actors")
		SetCursorFillMode(LEFT_TO_RIGHT)
		
			int i = 0
			while i < DTActor.getArrayCount()
				if DTActor.npcs_ref[i] != None 		
					if DTActor.toremove[i] == true				
						actorlist[i] = AddTextOption("Actor: "+DTActor.npcs_ref[i].GetLeveledActorBase().GetName(), "UNDO",getEnableFlag(generalEnabled))		
					else
						actorlist[i] = AddTextOption("Actor: "+DTActor.npcs_ref[i].GetLeveledActorBase().GetName(), "REMOVE",getEnableFlag(generalEnabled))		
					endif
				endif
			
				i+=1
			endWhile
			
			
	
	endif
	
	if page == "Actors stats"
			
		
		int i = 0
		while i < DTActor.getArrayCount()
			if DTActor.npcs_ref[i] != none
				actorListString[i] = DTActor.npcs_ref[i].GetLeveledActorBase().GetName()
			endif
			
			i+=1
		endWhile
	
		actorStats = AddMenuOption("Select Actor", actorListString[actorPointer as int],getEnableFlag(generalEnabled))	
		AddEmptyOption()
		
		
		if DTActor.isRegistered(DTActor.npcs_ref[actorPointer]) == -1
			AddHeaderOption("Please select actor")
		else		
		
		resetActorButton = AddTextOption("Reset progress", "Click!")
		AddEmptyOption()
		;TODO :AddTextOption
			AddTextOption("Boots status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_boots, DTConfig.boots_min, DTConfig.boots_max)),OPTION_FLAG_DISABLED)
			;AddHeaderOption("Boots status: "+DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_boots, DTConfig.boots_min, DTConfig.boots_max)))
			AddTextOption("Corset status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_corset, DTConfig.corset_min, DTConfig.corset_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Harness status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_harness, DTConfig.harness_min,DTConfig.harness_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Leg cuffs status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_legcuffs,  DTConfig.legcuffs_min, DTConfig.legcuffs_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Arm cuffs status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_armcuffs,  DTConfig.armcuffs_min, DTConfig.armcuffs_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Gag status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_gag,  DTConfig.gag_min, DTConfig.gag_max)),OPTION_FLAG_DISABLED)
			
			AddTextOption("Blindfold status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_blindfold,  DTConfig.blindfold_min, DTConfig.blindfold_max)),OPTION_FLAG_DISABLED)
			
			AddTextOption("Collar status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_collar,  DTConfig.collar_min, DTConfig.collar_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Chastity Belt status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_chastityBelt,  DTConfig.chastityBelt_min, DTConfig.chastityBelt_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Chastity Bra status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_chastityBra,  DTConfig.chastityBra_min, DTConfig.chastityBra_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Gloves status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_gloves,  DTConfig.gloves_min, DTConfig.gloves_max)),OPTION_FLAG_DISABLED)
			AddTextOption("Armbinder/Yoke status: ",DTExpert.levelToName(DTTools.getCurrentTrainingStage(actorPointer, DTActor.npcs_armbinder,  DTConfig.armbinder_min, DTConfig.armbinder_max)),OPTION_FLAG_DISABLED)
		
			AddEmptyOption()
			
			AddTextOption("Steps count: ",DTActor.count_steps[actorPointer] ,OPTION_FLAG_DISABLED)
			AddTextOption("Count of hits: ",DTActor.count_dmg[actorPointer] ,OPTION_FLAG_DISABLED)
			AddTextOption("Count of whips: ",DTActor.count_dmgZad[actorPointer] ,OPTION_FLAG_DISABLED)
			AddTextOption("Count of orgasm: ",DTActor.count_orgasm[actorPointer] ,OPTION_FLAG_DISABLED)
			AddTextOption("Days in training: ",DTActor.count_days[actorPointer] ,OPTION_FLAG_DISABLED)
		endif
		
	
	endif
	
	if page == "Utilities"
		AddHeaderOption("Debug")
			showConsoleOutput = AddToggleOption("Console output",DTConfig.showConsoleOutput,getEnableFlag(generalEnabled))			
			showTraceOutput   = AddToggleOption("Papyrus.log output",DTConfig.showTraceOutput,getEnableFlag(generalEnabled))			
		AddEmptyOption()	
		AddHeaderOption("Mod status")
			resetMod	    = AddMenuOption("Reset mod (and actors)", selectAction[0],getEnableFlag(generalEnabled))			
			uninstallMod	= AddMenuOption("Uninstall mod", selectAction[0],getEnableFlag(mcmWorkInt))			
	endif

EndEvent




Event OnOptionSelect(Int Menu)
	if Menu == modEnabled
		if  DTConfig.modEnabled == true			
			;SetTitleText("Clear actors...")
			;DTCore.resetAll()
			SetTitleText("Turn off... (wait)")
			DTConfig.modEnabled = false
			DTMain.turnOffMod()				
		else
			SetTitleText("Turn on... (check updates)")
			DTConfig.modEnabled = true
			;DTUpdate.Update(getVersion())
			
			;SetTitleText("Turn on... (processing)")			
			;DTCore.onLocationChangeExecute(false)			
		endIf
		needToApplyChanges = true
		SetToggleOptionValue(Menu,  DTConfig.modEnabled)
		ForcePageReset()
		return
	endIf	
	
	
	if Menu == achievement_blindslut_enabled
		if  DTConfig.achievement_blindslut_enabled == true
			DTConfig.achievement_blindslut_enabled = false
		else			
			DTConfig.achievement_blindslut_enabled = true	
			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_blindslut_enabled)
		ForcePageReset()
		return
	endIf		
	if Menu == achievement_ponygirl_enabled
		if  DTConfig.achievement_ponygirl_enabled == true
			DTConfig.achievement_ponygirl_enabled = false
		else			
			DTConfig.achievement_ponygirl_enabled = true	
			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_enabled)
		ForcePageReset()
		return
	endIf	
	if Menu == achievement_ponygirl_equip_enabled
		if  DTConfig.achievement_ponygirl_equip_enabled == true
			DTConfig.achievement_ponygirl_equip_enabled = false
		else			
			DTConfig.achievement_ponygirl_equip_enabled = true				
			if DTConfig.effect_arched_feet_visual == false
				debug.messagebox("Arched feet in boots menu is enabled!")
				DTConfig.effect_arched_feet_visual = true
			endif
			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_equip_enabled)
		ForcePageReset()
		return
	endIf	
	if Menu == achievement_ponygirl_sound_tied
		if  DTConfig.achievement_ponygirl_sound_tied == true
			DTConfig.achievement_ponygirl_sound_tied = false
		else			
			DTConfig.achievement_ponygirl_sound_tied = true				
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_sound_tied)
		ForcePageReset()
		return
	endIf	
	if Menu == achievement_ponygirl_sound_always
		if  DTConfig.achievement_ponygirl_sound_always == true
			DTConfig.achievement_ponygirl_sound_always = false
		else			
			DTConfig.achievement_ponygirl_sound_always = true				
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_sound_always)
		ForcePageReset()
		return
	endIf		
	if Menu == achievement_ponygirl_cast_helpfull_spells
		if  DTConfig.achievement_ponygirl_cast_helpfull_spells == true
			DTConfig.achievement_ponygirl_cast_helpfull_spells = false
		else			
			DTConfig.achievement_ponygirl_cast_helpfull_spells = true				
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_cast_helpfull_spells)
		ForcePageReset()
		return
	endIf	
	if Menu == achievement_ponygirl_equip_tied
		if  DTConfig.achievement_ponygirl_equip_tied == true
			DTConfig.achievement_ponygirl_equip_tied = false
		else			
			DTConfig.achievement_ponygirl_equip_tied = true				
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_equip_tied)
		ForcePageReset()
		return
	endIf		
	
	if Menu == achievement_ponygirl_equip_always
		if  DTConfig.achievement_ponygirl_equip_always == true
			DTConfig.achievement_ponygirl_equip_always = false
		else			
			DTConfig.achievement_ponygirl_equip_always = true				
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_equip_always)
		ForcePageReset()
		return
	endIf		
	if Menu == achievement_ponygirl_equip_force
		if  DTConfig.achievement_ponygirl_equip_force == true
			DTConfig.achievement_ponygirl_equip_force = false
		else			
			DTConfig.achievement_ponygirl_equip_force = true				
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_equip_force)
		ForcePageReset()
		return
	endIf	
	if Menu == achievement_ponygirl_add_another_items
		if  DTConfig.achievement_ponygirl_add_another_items == true
			DTConfig.achievement_ponygirl_add_another_items = false
		else			
			DTConfig.achievement_ponygirl_add_another_items = true				
		endIf
		SetToggleOptionValue(Menu,  DTConfig.achievement_ponygirl_add_another_items)
		ForcePageReset()
		return
	endIf	
	
	
	if Menu == effect_boots_enabled
		if  DTConfig.effect_boots_enabled == true
			DTConfig.effect_boots_enabled = false
		else			
			DTConfig.effect_boots_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_boots_enabled)
		ForcePageReset()
		return
	endIf	
	

	if Menu == effect_corset_enabled
		if  DTConfig.effect_corset_enabled == true
			DTConfig.effect_corset_enabled = false
		else			
			DTConfig.effect_corset_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_corset_enabled)
		ForcePageReset()
		return
	endIf
	if Menu == effect_harness_enabled
		if  DTConfig.effect_harness_enabled == true
			DTConfig.effect_harness_enabled = false
		else			
			DTConfig.effect_harness_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_harness_enabled)
		ForcePageReset()
		return
	endIf	
	if Menu == effect_legcuffs_enabled
		if  DTConfig.effect_legcuffs_enabled == true
			DTConfig.effect_legcuffs_enabled = false
		else			
			DTConfig.effect_legcuffs_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_legcuffs_enabled)
		ForcePageReset()
		return
	endIf	
	if Menu == effect_armcuffs_enabled
		if  DTConfig.effect_armcuffs_enabled == true
			DTConfig.effect_armcuffs_enabled = false
		else			
			DTConfig.effect_armcuffs_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_armcuffs_enabled)
		ForcePageReset()
		return
	endIf		
	
	if Menu == effect_blindfold_enabled
		if  DTConfig.effect_blindfold_enabled == true
			DTConfig.effect_blindfold_enabled = false
		else			
			DTConfig.effect_blindfold_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_blindfold_enabled)
		ForcePageReset()
		return
	endIf	
	
	if Menu == effect_collar_enabled
		if  DTConfig.effect_collar_enabled == true
			DTConfig.effect_collar_enabled = false
			needToApplyChanges = true
		else			
			DTConfig.effect_collar_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_collar_enabled)
		ForcePageReset()
		return
	endIf			
	if Menu == effect_chastityBelt_enabled
		if  DTConfig.effect_chastityBelt_enabled == true
			DTConfig.effect_chastityBelt_enabled = false
			needToApplyChanges = true
		else			
			DTConfig.effect_chastityBelt_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_chastityBelt_enabled)
		ForcePageReset()
		return
	endIf	
	if Menu == effect_chastityBra_enabled
		if  DTConfig.effect_chastityBra_enabled == true
			DTConfig.effect_chastityBra_enabled = false
			needToApplyChanges = true
		else			
			DTConfig.effect_chastityBra_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_chastityBra_enabled)
		ForcePageReset()
		return
	endIf		
	if Menu == effect_gag_enabled
		if  DTConfig.effect_gag_enabled == true
			DTConfig.effect_gag_enabled = false
			needToApplyChanges = true
		else			
			DTConfig.effect_gag_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_gag_enabled)
		ForcePageReset()
		return
	endIf	
	if Menu == effect_gag_enabled_talk
		if  DTConfig.effect_gag_enabled_talk == true
			DTConfig.effect_gag_enabled_talk = false
		else			
			DTConfig.effect_gag_enabled_talk = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_gag_enabled_talk)
		ForcePageReset()
		return
	endIf
	if Menu == effect_gag_enabled_mounth
		if  DTConfig.effect_gag_enabled_mounth == true
			DTConfig.effect_gag_enabled_mounth = false
			needToApplyChanges = true
		else			
			DTConfig.effect_gag_enabled_mounth = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_gag_enabled_mounth)
		ForcePageReset()
		return
	endIf	
	
	if Menu == turnoffspeedattack
		if  DTConfig.turnoffspeedattack == true
			DTConfig.turnoffspeedattack = false
		else			
			DTConfig.turnoffspeedattack = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.turnoffspeedattack)		
	endIf	
	
	if Menu == ignoreAdditionNegativeEffects
		if  DTConfig.ignoreAdditionNegativeEffects == true
			DTConfig.ignoreAdditionNegativeEffects = false
		else			
			DTConfig.ignoreAdditionNegativeEffects = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.ignoreAdditionNegativeEffects)		
	endIf	
	if Menu == ignore_duplicates
		if  DTConfig.ignore_duplicates == true
			DTConfig.ignore_duplicates = false
		else			
			DTConfig.ignore_duplicates = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.ignore_duplicates)		
	endIf
	if Menu == fullProcessing
		if  DTConfig.fullProcessing == true
			DTConfig.fullProcessing = false
		else			
			DTConfig.fullProcessing = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.fullProcessing)		
	endIf		
	if Menu == addBuffsAndDebuffs
		if  DTConfig.addBuffsAndDebuffs == true
			DTConfig.addBuffsAndDebuffs = false
		else			
			DTConfig.addBuffsAndDebuffs = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.addBuffsAndDebuffs)		
	endIf	
	
	if Menu == tats_days_enabled
		if  DTConfig.tats_days_enabled == true
			DTConfig.tats_days_enabled = false
		else			
			DTConfig.tats_days_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.tats_days_enabled)		
		ForcePageReset()
	endIf	

	if Menu == tats_item_enabled
		if  DTConfig.tats_item_enabled == true
			DTConfig.tats_item_enabled = false
		else			
			DTConfig.tats_item_enabled = true			
		endIf
		DTConfig.mcmTatsChanged = true
		SetToggleOptionValue(Menu,  DTConfig.tats_item_enabled)		
		ForcePageReset()
	endIf		
	
	if Menu == tats_item_chastity_belt
		if  DTConfig.tats_item_chastity_belt == true
			DTConfig.tats_item_chastity_belt = false
		else			
			DTConfig.tats_item_chastity_belt = true			
		endIf
		DTConfig.mcmTatsChanged = true
		SetToggleOptionValue(Menu,  DTConfig.tats_item_chastity_belt)				
	endIf	
	
	if Menu == tats_item_chastity_bra
		if  DTConfig.tats_item_chastity_bra == true
			DTConfig.tats_item_chastity_bra = false
		else			
			DTConfig.tats_item_chastity_bra = true			
		endIf
		DTConfig.mcmTatsChanged = true
		SetToggleOptionValue(Menu,  DTConfig.tats_item_chastity_bra)				
	endIf	
		if Menu == tats_item_corset
		if  DTConfig.tats_item_corset == true
			DTConfig.tats_item_corset = false
		else			
			DTConfig.tats_item_corset = true			
		endIf
		DTConfig.mcmTatsChanged = true
		SetToggleOptionValue(Menu,  DTConfig.tats_item_corset)				
	endIf	
		if Menu == tats_item_harness
		if  DTConfig.tats_item_harness == true
			DTConfig.tats_item_harness = false
		else			
			DTConfig.tats_item_harness = true			
		endIf
		DTConfig.mcmTatsChanged = true
		SetToggleOptionValue(Menu,  DTConfig.tats_item_harness)				
	endIf	
	if Menu == enableSlif
		if  DTConfig.enableSlif == true
			DTConfig.enableSlif = false
		else			
			DTConfig.enableSlif = true			
		endIf		
		SetToggleOptionValue(Menu,  DTConfig.enableSlif)		
		ForcePageReset()
	endIf		
	if Menu == bodyScaleOrgasmEnabled
		if  DTConfig.bodyScaleOrgasmEnabled == true
			DTConfig.bodyScaleOrgasmEnabled = false
		else			
			DTConfig.bodyScaleOrgasmEnabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.bodyScaleOrgasmEnabled)		
		ForcePageReset()
	endIf		
	if Menu == bodyWithoutSexGrowth
		if  DTConfig.bodyWithoutSexGrowth == true
			DTConfig.bodyWithoutSexGrowth = false
		else			
			DTConfig.bodyWithoutSexGrowth = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.bodyWithoutSexGrowth)				
	endIf		
	

	if Menu == updateOnlyWithCellChange
		if  DTConfig.updateOnlyWithCellChange == true
			DTConfig.updateOnlyWithCellChange = false
		else			
			DTConfig.updateOnlyWithCellChange = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.updateOnlyWithCellChange)		
	endIf	
	if Menu == process_only_pc
		if  DTConfig.process_only_pc == true
			DTConfig.process_only_pc = false
		else			
			DTConfig.process_only_pc = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.process_only_pc)		
	endIf	
	if Menu == process_follower
		if  DTConfig.process_follower == true
			DTConfig.process_follower = false
		else			
			DTConfig.process_follower = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.process_follower)		
	endIf		
	if Menu == process_enemies
		if  DTConfig.process_enemies == true
			DTConfig.process_enemies = false
		else			
			DTConfig.process_enemies = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.process_enemies)		
	endIf	
	if Menu == process_neutral
		if  DTConfig.process_neutral == true
			DTConfig.process_neutral = false
		else			
			DTConfig.process_neutral = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.process_neutral)		
	endIf	
	if Menu == process_friends
		if  DTConfig.process_friends == true
			DTConfig.process_friends = false
		else			
			DTConfig.process_friends = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.process_friends)		
	endIf	
	
	if Menu == effect_sound_enabled
		if  DTConfig.effect_sound_enabled == true
			DTConfig.effect_sound_enabled = false
		else			
			DTConfig.effect_sound_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_sound_enabled)		
	endIf		
	if Menu == effect_shader_enabled
		if  DTConfig.effect_shader_enabled == true
			DTConfig.effect_shader_enabled = false
		else			
			DTConfig.effect_shader_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_shader_enabled)		
	endIf	
	
	if Menu == effect_alert_enabled
		if  DTConfig.effect_alert_enabled == true
			DTConfig.effect_alert_enabled = false
		else			
			DTConfig.effect_alert_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_alert_enabled)		
	endIf		
	
	if Menu == effect_values_enabled
		if  DTConfig.effect_values_enabled == true
			DTConfig.effect_values_enabled = false
		else			
			DTConfig.effect_values_enabled = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.effect_values_enabled)		
	endIf	
	
	if Menu == effect_arousal_enabled
		if  DTConfig.effect_arousal_enabled == true
			DTConfig.effect_arousal_enabled = false
		else			
			DTConfig.effect_arousal_enabled = true			
		endIf
		ForcePageReset()
		SetToggleOptionValue(Menu,  DTConfig.effect_arousal_enabled)		
	endIf	
	
	if Menu == effect_arched_feet_visual
		SetTitleText("Wait...")
		if  DTConfig.effect_arched_feet_visual == true
			DTConfig.effect_arched_feet_visual = false
			needToApplyChanges = true
		else			
			DTConfig.effect_arched_feet_visual = true			
		endIf
		ForcePageReset()
		SetToggleOptionValue(Menu,  DTConfig.effect_arched_feet_visual)		
	endIf	
	
	
	if Menu == effect_arched_feet_crawl_visual
		SetTitleText("Wait...")
		if  DTConfig.effect_arched_feet_crawl_visual == true
			DTConfig.effect_arched_feet_crawl_visual = false
			DTConfig.DT_ArchedFeet = DTStorage.DT_ArchedFeet
			needToApplyChanges = true
		else			
			DTConfig.effect_arched_feet_crawl_visual = true	
			DTConfig.DT_ArchedFeet = DTStorage.DT_ArchedFeetNoHDT
			needToApplyChanges = true
		endIf
		ForcePageReset()
		SetToggleOptionValue(Menu,  DTConfig.effect_arched_feet_crawl_visual)		
	endIf
	
	if Menu == allowChangeDeviousDevices
		if  DTConfig.allowChangeDeviousDevices == true
			DTConfig.allowChangeDeviousDevices = false			
		else			
			DTConfig.allowChangeDeviousDevices = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.allowChangeDeviousDevices)		
	endIf
	if Menu == allowChangecursedLootPack
		if  DTConfig.allowChangecursedLootPack == true
			DTConfig.allowChangecursedLootPack = false			
		else			
			DTConfig.allowChangecursedLootPack = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.allowChangecursedLootPack)		
	endIf
	if Menu == allowToReconfigureAutomatic
		if  DTConfig.allowToReconfigureAutomatic == true
			DTConfig.allowToReconfigureAutomatic = false			
		else			
			DTConfig.allowToReconfigureAutomatic = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.allowToReconfigureAutomatic)		
	endIf	
	
	if Menu == showConsoleOutput
		if  DTConfig.showConsoleOutput == true
			DTConfig.showConsoleOutput = false			
		else			
			DTConfig.showConsoleOutput = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.showConsoleOutput)		
	endIf	
	if Menu == showTraceOutput
		if  DTConfig.showTraceOutput == true
			DTConfig.showTraceOutput = false			
		else			
			DTConfig.showTraceOutput = true			
		endIf
		SetToggleOptionValue(Menu,  DTConfig.showTraceOutput)		
	endIf
	
	
	
	;actors
	int i = 0
	while i < DTActor.getArrayCount()
		if Menu == actorlist[i]
			if DTActor.npcs_ref[i]!=None
				if DTActor.toremove[i]==false
					DTActor.toremove[i]=true
					SetTextOptionValue(Menu, "UNDO")
					DTTools.log("SLOT "+i+" is removed:on")
				else
					DTActor.toremove[i]=false
					SetTextOptionValue(Menu, "REMOVE")
					DTTools.log("SLOT "+i+" is removed:off")
				endif
			endif
		endIf
		i+=1
	endWhile

	if Menu == resetActorButton
		SetTextOptionValue(resetActorButton, "START")
		ForcePageReset()
		Actor tmpActor = DTActor.npcs_ref[actorPointer]
		SetTextOptionValue(resetActorButton, "Unregister...")
		ForcePageReset()
		DTActor.unregisterActor(actorPointer)
		SetTextOptionValue(resetActorButton, "Register...")
		ForcePageReset()
		DTActor.registerActor(tmpActor)
		SetTextOptionValue(resetActorButton, "Click!")
		ForcePageReset()
	endif
	
	if Menu == effect_bootsAllow0
		Armor thisArmor = DTConfig.playerRef.GetWornForm(DTConfig.slotMask[37]) as Armor
		if DTConfig.acceptBoots0.getName()==""
			DTConfig.acceptBoots0 = thisArmor
		else
			DTConfig.acceptBoots0 = None
		endif
		ForcePageReset()	
	endif	
	
	if Menu == effect_bootsAllow1
		Armor thisArmor = DTConfig.playerRef.GetWornForm(DTConfig.slotMask[37]) as Armor
		if DTConfig.acceptBoots1.getName()==""
			DTConfig.acceptBoots1 = thisArmor
		else
			DTConfig.acceptBoots1 = None
		endif
		ForcePageReset()	
	endif
	if Menu == effect_bootsAllow2
		Armor thisArmor = DTConfig.playerRef.GetWornForm(DTConfig.slotMask[37]) as Armor
		if DTConfig.acceptBoots2.getName()==""
			DTConfig.acceptBoots2 = thisArmor
		else
			DTConfig.acceptBoots2 = None
		endif
		ForcePageReset()	
	endif	
	if Menu == effect_bootsAllow3
		Armor thisArmor = DTConfig.playerRef.GetWornForm(DTConfig.slotMask[37]) as Armor
		if DTConfig.acceptBoots3.getName()==""
			DTConfig.acceptBoots3 = thisArmor
		else
			DTConfig.acceptBoots3 = None
		endif
		ForcePageReset()	
	endif	
endEvent



;scroll
Event OnOptionSliderOpen(Int Menu)
	sliderSetupOpenInt(Menu,effect_corset_waist_visual,DTConfig.effect_corset_waist_visual,0,65,1);
	sliderSetupOpenInt(Menu,effect_corset_waist_visualWithout,DTConfig.effect_corset_waist_visualWithout,0,65,1);
	sliderSetupOpenInt(Menu,effect_armbinder_health,DTConfig.effect_armbinder_health,0,80,1);
	sliderSetupOpenInt(Menu,effect_corset_weight,DTConfig.effect_corset_weight,0,80,1);
	sliderSetupOpenInt(Menu,effect_harness_weight,DTConfig.effect_harness_weight,0,80,1);
	sliderSetupOpenInt(Menu,effect_legcuffs_weight,DTConfig.effect_legcuffs_weight,0,100,1);
	sliderSetupOpenInt(Menu,effect_legcuffs_alert_weight,DTConfig.effect_legcuffs_alert_weight,0,80,1);	
	sliderSetupOpenInt(Menu,effect_armcuffs_weight,DTConfig.effect_armcuffs_weight,0,100,1);
	sliderSetupOpenInt(Menu,effect_vaginalPlug_weight,DTConfig.effect_vaginalPlug_weight,0,100,1);
	sliderSetupOpenInt(Menu,effect_armcuffs_alert_weight,DTConfig.effect_armcuffs_alert_weight,0,80,1);
	sliderSetupOpenInt(Menu,effect_gag_enabled_mounth_weight,DTConfig.effect_gag_enabled_mounth_weight,1,120,1);
	sliderSetupOpenInt(Menu,effect_boots_weight,DTConfig.effect_boots_weight,0,80,1);
	sliderSetupOpenInt(Menu,effect_collar_weight,DTConfig.effect_collar_weight,0,80,1);
	sliderSetupOpenInt(Menu,effect_chastityBelt_weight,DTConfig.effect_chastityBelt_weight,0,80,1);
	sliderSetupOpenInt(Menu,effect_chastityBra_weight,DTConfig.effect_chastityBra_weight,0,80,1);
	sliderSetupOpenFloat(Menu,effect_chastity_breast_visual,DTConfig.effect_chastity_breast_visual,-3,3);
	sliderSetupOpenFloat(Menu,effect_blindfold_eyes_close,DTConfig.effect_blindfold_eyes_close,-1,1);
	sliderSetupOpenInt(Menu,effect_collar_long_visual,DTConfig.effect_collar_long_visual,0,35,1);
	
	sliderSetupOpenInt(Menu,minOrgasmCount,DTConfig.minOrgasmCount,1,20,1);
	sliderSetupOpenFloat(Menu,bodyScaleFactor,DTConfig.bodyScaleFactor,0.1,20);
	sliderSetupOpenFloat(Menu,bodyMinBrests,DTConfig.bodyMinBrests,0.1,15);
	sliderSetupOpenFloat(Menu,bodyMaxBrests,DTConfig.bodyMaxBrests,0.1,15);
	sliderSetupOpenFloat(Menu,bodyMinButt,DTConfig.bodyMinButt,0.1,15);
	sliderSetupOpenFloat(Menu,bodyMaxButt,DTConfig.bodyMaxButt,0.1,15);
	sliderSetupOpenFloat(Menu,bodyMinBelly,DTConfig.bodyMinBelly,0.1,15);
	sliderSetupOpenFloat(Menu,bodyMaxBelly,DTConfig.bodyMaxBelly,0.1,15);
	
	sliderSetupOpenFloat(Menu,bodyPointer,DTActor.bodyPointer[DTConfig.playerSlot],0,100);
	
	
EndEvent


Event OnOptionSliderAccept(Int Menu, Float Val)
	if Menu == minOrgasmCount
		DTConfig.minOrgasmCount = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif		
	if Menu == bodyScaleFactor
		DTConfig.bodyScaleFactor = Val as Int
		SetSliderOptionValue(Menu,Val,"{1}")		
	endif		
	
	if Menu == bodyMinBrests
		DTConfig.bodyMinBrests = Val
		SetSliderOptionValue(Menu,Val,"{1}")
		
		if DTConfig.bodyMinBrests > DTConfig.bodyMaxBrests
			DTConfig.bodyMinBrests = DTConfig.bodyMaxBrests
			SetSliderOptionValue(Menu,DTConfig.bodyMinBrests,"{1}")
		endIf
		
	endif		
	if Menu == bodyMaxBrests
		DTConfig.bodyMaxBrests = Val 
		SetSliderOptionValue(Menu,Val,"{1}")
		if DTConfig.bodyMaxBrests < DTConfig.bodyMinBrests
			DTConfig.bodyMaxBrests = DTConfig.bodyMinBrests
			SetSliderOptionValue(Menu,DTConfig.bodyMaxBrests,"{1}")
		endIf		
	endif	

	if Menu == bodyMinButt
		DTConfig.bodyMinButt = Val
		SetSliderOptionValue(Menu,Val,"{1}")
		
		if DTConfig.bodyMinButt > DTConfig.bodyMaxButt
			DTConfig.bodyMinButt = DTConfig.bodyMaxButt
			SetSliderOptionValue(Menu,DTConfig.bodyMinButt,"{1}")
		endIf
		
	endif		
	if Menu == bodyMaxButt
		DTConfig.bodyMaxButt = Val 
		SetSliderOptionValue(Menu,Val,"{1}")
		if DTConfig.bodyMaxButt < DTConfig.bodyMinButt
			DTConfig.bodyMaxButt = DTConfig.bodyMinButt
			SetSliderOptionValue(Menu,DTConfig.bodyMaxButt,"{1}")
		endIf		
	endif	
	
	if Menu == bodyMinBelly
		DTConfig.bodyMinBelly = Val
		SetSliderOptionValue(Menu,Val,"{1}")
		
		if DTConfig.bodyMinBelly > DTConfig.bodyMaxBelly
			DTConfig.bodyMinBelly = DTConfig.bodyMaxBelly
			SetSliderOptionValue(Menu,DTConfig.bodyMinBelly,"{1}")
		endIf
		
	endif		
	if Menu == bodyMaxBelly
		DTConfig.bodyMaxBelly = Val 
		SetSliderOptionValue(Menu,Val,"{1}")
		if DTConfig.bodyMaxBelly < DTConfig.bodyMinBelly
			DTConfig.bodyMaxBelly = DTConfig.bodyMinBelly
			SetSliderOptionValue(Menu,DTConfig.bodyMaxBelly,"{1}")
		endIf		
	endif		
	
	
	if Menu == bodyPointer
		DTActor.bodyPointer[DTConfig.playerSlot] = Val as float
		SetSliderOptionValue(Menu,Val,"{1}")
		
	endif		
	
	if Menu == effect_corset_waist_visual
	
		if Val < DTConfig.effect_corset_waist_visualWithout
			DTConfig.effect_corset_waist_visualWithout = Val as Int
			SetSliderOptionValue(effect_corset_waist_visualWithout,DTConfig.effect_corset_waist_visualWithout as int,"{0}")
		endif
	
		DTConfig.effect_corset_waist_visual = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
		needToApplyChanges = true
	endif	
	
	if Menu == effect_corset_waist_visualWithout
		if Val > DTConfig.effect_corset_waist_visual
			Val = DTConfig.effect_corset_waist_visual
		endif
		DTConfig.effect_corset_waist_visualWithout = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
		needToApplyChanges = true
	endif		
	if Menu == effect_collar_long_visual
		DTConfig.effect_collar_long_visual = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")
		needToApplyChanges = true
	endif		
	if Menu == effect_boots_weight
		DTConfig.effect_boots_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif		
	if Menu == effect_chastityBelt_weight
		DTConfig.effect_chastityBelt_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif			
	if Menu == effect_chastity_breast_visual
		DTConfig.effect_chastity_breast_visual = Val as Float
		SetSliderOptionValue(Menu,Val,"{1}")		
	endif		
	if Menu == effect_blindfold_eyes_close
		DTConfig.effect_blindfold_eyes_close = Val as Float
		SetSliderOptionValue(Menu,Val,"{1}")		
	endif	
	if Menu == effect_chastityBra_weight
		DTConfig.effect_chastityBra_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif			
	if Menu == effect_collar_weight
		DTConfig.effect_collar_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif			
	if Menu == effect_armbinder_health
		DTConfig.effect_armbinder_health = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif			
	if Menu == effect_corset_weight
		DTConfig.effect_corset_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif		
	if Menu == effect_harness_weight
		DTConfig.effect_harness_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif		
	if Menu == effect_legcuffs_weight
		DTConfig.effect_legcuffs_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif	
	if Menu == effect_legcuffs_alert_weight
		DTConfig.effect_legcuffs_alert_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif		
	if Menu == effect_armcuffs_weight
		DTConfig.effect_armcuffs_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif	
	if Menu == effect_vaginalPlug_weight
		DTConfig.effect_vaginalPlug_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif	
	if Menu == effect_armcuffs_alert_weight
		DTConfig.effect_armcuffs_alert_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")		
	endif		
	if Menu == effect_gag_enabled_mounth_weight
		DTConfig.effect_gag_enabled_mounth_weight = Val as Int
		SetSliderOptionValue(Menu,Val,"{0}")	
		needToApplyChanges = true
	endif		
EndEvent


;dropdown

event OnOptionMenuOpen(int Menu)
	if (Menu == preventCarryWeight)
		SetMenuDialogStartIndex(DTConfig.preventCarryWeight as int)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(carryWeightLimit)
	endIf
	if (Menu == preventSpeedWalk)
		SetMenuDialogStartIndex(DTConfig.preventSpeedWalk as int)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(speedWalkLimit)
	endIf		
	
	if (Menu == training_level_curve)
		SetMenuDialogStartIndex(DTConfig.training_level_curve as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(progressCurve)
	endIf	
	if (Menu == training_buffMult)
		SetMenuDialogStartIndex(DTConfig.buffMult as int)
		SetMenuDialogDefaultIndex(4)
		SetMenuDialogOptions(buffMult)
	endIf		
	if (Menu == training_level_model)
		SetMenuDialogStartIndex(DTConfig.training_level_model as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(regresModel)
	endIf	
	
	if (Menu == achievement_ponygirl_colorset)
		SetMenuDialogStartIndex(DTConfig.achievement_ponygirl_colorset as int)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(colorset)
	endIf		
	if (Menu == effect_arousal_behavior)
		SetMenuDialogStartIndex(DTConfig.effect_arousal_behavior as int)
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(arousalBehavior)
	endIf		
	if (Menu == training_speed_boots)
		SetMenuDialogStartIndex(DTConfig.training_speed_boots as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
	endIf		
	if (Menu == training_speed_armbinder)
		SetMenuDialogStartIndex(DTConfig.training_speed_armbinder as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
	endIf	
	if (Menu == training_speed_gloves)
		SetMenuDialogStartIndex(DTConfig.training_speed_gloves as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
	endIf	
	if (Menu == training_speed_corset)
		SetMenuDialogStartIndex(DTConfig.training_speed_corset as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	if (Menu == training_speed_harness)
		SetMenuDialogStartIndex(DTConfig.training_speed_harness as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	if (Menu == training_speed_legcuffs)
		SetMenuDialogStartIndex(DTConfig.training_speed_legcuffs as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	if (Menu == training_speed_armcuffs)
		SetMenuDialogStartIndex(DTConfig.training_speed_armcuffs as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf			
	if (Menu == training_speed_blindfold)
		SetMenuDialogStartIndex(DTConfig.training_speed_blindfold as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	if (Menu == training_speed_gag)
		SetMenuDialogStartIndex(DTConfig.training_speed_gag as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	if (Menu == training_speed_collar)
		SetMenuDialogStartIndex(DTConfig.training_speed_collar as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	
	if (Menu == training_speed_chastityBelt)
		SetMenuDialogStartIndex(DTConfig.training_speed_chastityBelt as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	if (Menu == training_speed_chastityBra)
		SetMenuDialogStartIndex(DTConfig.training_speed_chastityBra as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf	
	if (Menu == training_speed_analplug)
		SetMenuDialogStartIndex(DTConfig.training_speed_analplug as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf	
	if (Menu == training_speed_vaginalplug)
		SetMenuDialogStartIndex(DTConfig.training_speed_vaginalplug as int)
		SetMenuDialogDefaultIndex(3)
		SetMenuDialogOptions(speedValues)
		return
	endIf		
	if (Menu == reconfigureNow)
		SetMenuDialogStartIndex(1)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(selectActionYesNo)
	endIf		
	
	if (Menu == resetMod)
		debug.messagebox("If you will select YES...\nYou will set all default setting and you will clear all progress!")
		SetMenuDialogStartIndex(1)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(selectActionYesNo)
	endIf		
	if (Menu == uninstallMod)
		debug.messagebox("If you will select YES...\nYou will clear all progress and stop this mod!\nIf you want you can always turn mod again.")
		SetMenuDialogStartIndex(1)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(selectActionYesNo)
	endIf	
	
	if (Menu == actorStats)
		SetMenuDialogStartIndex(actorPointer)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(actorListString)
	endIf
	
endEvent


event OnOptionMenuAccept(int Menu, int a_index)

	if (Menu == preventCarryWeight)
		DTConfig.preventCarryWeight = a_index as int
		SetMenuOptionValue(Menu, carryWeightLimit[DTConfig.preventCarryWeight as int])
	endIf		
	if (Menu == preventSpeedWalk)
		DTConfig.preventSpeedWalk = a_index as int
		SetMenuOptionValue(Menu, speedWalkLimit[DTConfig.preventSpeedWalk as int])
	endIf			
	
	if (Menu == training_level_curve)
		DTConfig.training_level_curve = a_index as int
		SetMenuOptionValue(Menu, progressCurve[DTConfig.training_level_curve as int])
	endIf	
	if (Menu == training_buffMult)
		DTConfig.buffMult = a_index as int
		SetMenuOptionValue(Menu, buffMult[DTConfig.buffMult as int])
	endIf		
	if (Menu == training_level_model)
		DTConfig.training_level_model = a_index as int
		SetMenuOptionValue(Menu, regresModel[DTConfig.training_level_model as int])
	endIf		
	if (Menu == achievement_ponygirl_colorset)
		DTConfig.achievement_ponygirl_colorset = a_index as int
		SetMenuOptionValue(Menu, colorset[DTConfig.achievement_ponygirl_colorset as int])		
		return
	endIf		
	if (Menu == effect_arousal_behavior)
		DTConfig.effect_arousal_behavior = a_index as int
		SetMenuOptionValue(Menu, arousalBehavior[DTConfig.effect_arousal_behavior as int])		
		return
	endIf		
	if (Menu == training_speed_armbinder)
		DTConfig.training_speed_armbinder = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_armbinder as int])
		needToApplyChanges = true
		ForcePageReset()
		return
	endIf		
	if (Menu == training_speed_gloves)
		DTConfig.training_speed_gloves = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_gloves as int])
		needToApplyChanges = true
		ForcePageReset()
		return
	endIf			
	if (Menu == training_speed_boots)
		DTConfig.training_speed_boots = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_boots as int])
		needToApplyChanges = true
		ForcePageReset()
		return
	endIf		
	if (Menu == training_speed_corset)
		DTConfig.training_speed_corset = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_corset as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf		
	if (Menu == training_speed_harness)
		DTConfig.training_speed_harness = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_harness as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf		
	if (Menu == training_speed_legcuffs)
		DTConfig.training_speed_legcuffs = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_legcuffs as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf		
	if (Menu == training_speed_armcuffs)
		DTConfig.training_speed_armcuffs = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_armcuffs as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf		
	if (Menu == training_speed_blindfold)
		DTConfig.training_speed_blindfold = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_blindfold as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf		
	if (Menu == training_speed_gag)
		DTConfig.training_speed_gag = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_gag as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf	
	if (Menu == training_speed_collar)
		DTConfig.training_speed_collar = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_collar as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf		
	if (Menu == training_speed_chastityBelt)
		DTConfig.training_speed_chastityBelt = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_chastityBelt as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf	
	if (Menu == training_speed_chastityBra)
		DTConfig.training_speed_chastityBra = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_chastityBra as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf	
	if (Menu == training_speed_analplug)
		DTConfig.training_speed_analplug = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_analplug as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf		
	if (Menu == training_speed_vaginalplug)
		DTConfig.training_speed_vaginalplug = a_index as int
		SetMenuOptionValue(Menu, speedValues[DTConfig.training_speed_vaginalplug as int])
		needToApplyChanges = true
		ForcePageReset()
		return		
	endIf			
	if (Menu == reconfigureNow)
		if a_index == 0
			DTTools.reconfigureIntegration()
			SetMenuOptionValue(Menu, selectAction[0])					
		endIf
	endIf		
	
	if (Menu == resetMod)
		if a_index == 0	
			;SetTitleText("Clear actors...")
			;DTCore.resetAll()
			;SetTitleText("Remove actors...")
			
			;SetTitleText("Reset")
			DTConfig.modEnabled = true	
			DTConfig.lastVersion = 0
			;DTUpdate.Update(getVersion())
			ForcePageReset()
			SetMenuOptionValue(Menu, selectAction[0])					
		endIf
	endIf	
	if (Menu == uninstallMod)
		if a_index == 0
			;SetTitleText("Clear actors...")
			;DTCore.resetAll()
			;SetTitleText("Remove actors...")
			;DTCore.removeAllActors()
			;SetTitleText("Reset")
			DTConfig.modEnabled = false	
			DTConfig.lastVersion = 0			
			ForcePageReset()
			SetMenuOptionValue(Menu, selectAction[0])	
			DTCore.sendStatus("uninstall")			
		endIf
	endIf
	if (Menu == actorStats)
		actorPointer = a_index as int
		SetMenuOptionValue(Menu, actorListString[actorPointer])
		ForcePageReset()
	endif
	
endEvent


event OnOptionHighlight(int a_option)
	{Called when the user highlights an option}
	
	
	
	if a_option == effect_sound_enabled
		SetInfoText("Enable all avaliable sounds in this mod. Screams, groans, moans, breaths, jingles etc.")
	endIf

	if a_option == effect_shader_enabled
		SetInfoText("Enable all avaliable visual/shader effects.")
	endIf

	if a_option == effect_alert_enabled
		SetInfoText("Enable interaction with world - your screams or jingles (sounds) can alert Your enemies.")
	endIf	
	
	if a_option == ignore_duplicates
		SetInfoText("If you stuck in harness as well trained corset user you will get debuffs from corset (you wear harness right?). This option prevent it - it work's in both sides.")
	endIf
	
	if a_option == allowToReconfigureAutomatic
		SetInfoText("Allow to change values in other mod's to gain expiriance. Userful to prevent duplicate debuffs. Adding few more options. (Recomended)")
	endIf

	if a_option == reconfigureNow
		SetInfoText("Run reconfigure procedure now.")
	endIf
	if a_option == effect_arched_feet_crawl_visual
		SetInfoText("You need ZazExtensionPack or Sanguine Debuchery to enable it.")
	endif

	if a_option == achievement_ponygirl_enabled
		SetInfoText("Enable this achievement.")
	endIf
	
	if a_option == achievement_ponygirl_equip_enabled
		SetInfoText("Add to gameplay additional items with pony play related.")
	endIf
	
	if a_option == achievement_ponygirl_equip_tied
		SetInfoText("Equip items if you are binded like a pony girl. Current items will be not removed.")
	endIf

	if a_option == achievement_ponygirl_equip_always
		SetInfoText("Equip items always (if its possible. Current items will be not removed.")
	endIf

	if a_option == achievement_ponygirl_equip_force
		SetInfoText("Try to unequip items that use your pony girl outfit slots to apply pony play items.")
	endIf
	
	if a_option == achievement_ponygirl_sound_tied
		SetInfoText("Add extra sounds effects when you are binded like a pony girl. ")
	endIf

	if a_option == achievement_ponygirl_sound_always
		SetInfoText("Add extra sounds effects to your gameplay. ")
	endIf
	
endEvent


function sliderSetupOpenInt(Int Menu, Int IntName,Int ConfValue, int rangeStart = 0, int rangeStop = 100, int interval = 1)
	if (Menu == IntName)
		SetSliderDialogStartValue(ConfValue)
		SetSliderDialogRange(rangeStart,rangeStop)
		SetSliderDialogInterval(interval)
	endIf
endFunction

function sliderSetupOpenFloat(Int Menu, Int IntName,Float ConfValue, float rangeStart = 0.0, float rangeStop = 100.0, float interval = 0.1)
	if (Menu == IntName)
		SetSliderDialogStartValue(ConfValue)
		SetSliderDialogRange(rangeStart,rangeStop)
		SetSliderDialogInterval(interval)
	endIf
endFunction

int function notIntLikeBool(int in)
	if in == 1
		return 0
	endIf
	return 1
endFunction

int function getEnableFlag(int in)

	if in == 1
		return OPTION_FLAG_NONE
	endif
	
	return OPTION_FLAG_DISABLED
endFunction

int modEnabled
int training_level_curve
int training_level_model


int training_speed_boots
int effect_boots_enabled
int effect_boots_weight
int effect_arched_feet_crawl_visual
int effect_arched_feet_visual
int training_speed_corset
int effect_corset_enabled
int effect_corset_weight
int effect_corset_waist_visual
int effect_corset_waist_visualWithout
int training_speed_harness
int effect_harness_enabled
int effect_harness_weight
int training_speed_collar
int effect_collar_weight
int effect_collar_enabled
int effect_collar_long_visual
int training_speed_gloves

int training_speed_gag
int effect_gag_enabled_talk
int effect_gag_enabled
int effect_gag_enabled_mounth
int effect_gag_enabled_mounth_weight


int effect_armcuffs_alert_weight
int effect_armcuffs_enabled
int effect_armcuffs_weight
int training_speed_armcuffs

int effect_legcuffs_alert_weight
int effect_legcuffs_enabled
int effect_legcuffs_weight
int training_speed_legcuffs
int training_speed_chastityBra
int training_speed_chastityBelt

int effect_chastityBelt_weight
int effect_chastityBra_weight
int effect_chastityBelt_enabled
int effect_chastityBra_enabled
int effect_chastity_breast_visual

int training_speed_blindfold
int effect_blindfold_enabled

int ignoreAdditionNegativeEffects
int turnoffspeedattack
int ignore_duplicates
int process_only_pc
int process_follower
int process_enemies
int process_neutral
int process_friends
int effect_sound_enabled
int effect_shader_enabled
int effect_alert_enabled
int effect_values_enabled
int effect_arousal_enabled
int effect_arousal_behavior
int effect_vaginalPlug_weight

int static1
int static2

int allowChangeDeviousDevices
int allowChangecursedLootPack
int allowToReconfigureAutomatic
int reconfigureNow
int showConsoleOutput
int showTraceOutput
int preventCarryWeight
int preventSpeedWalk
int updateOnlyWithCellChange


int[] actorlist

int[] npcslistinfo
string[] buffPower
string[] speedValues
string[] buffMult
string[] progressCurve
string[] regresModel
string[] selectAction
string[] selectActionYesNo
string[] arousalBehavior
string[] carryWeightLimit
string[] speedWalkLimit
string[] colorset
bool needToApplyChanges

int resetMod
int uninstallMod

int generalEnabled
int fullProcessing

int effect_bootsAllow0
int effect_bootsAllow1
int effect_bootsAllow2
int effect_bootsAllow3

int training_buffMult
int training_speed_armbinder
int effect_armbinder_health


int achievement_blindslut_enabled
int achievement_ponygirl_enabled
int achievement_ponygirl_equip_enabled
int achievement_ponygirl_equip_tied
int achievement_ponygirl_equip_always
int achievement_ponygirl_equip_force
int achievement_ponygirl_add_another_items
int achievement_ponygirl_sound_tied
int achievement_ponygirl_sound_always
int achievement_ponygirl_colorset
int achievement_ponygirl_cast_helpfull_spells
int enableSlif
int effect_blindfold_eyes_close

int	bodyScaleOrgasmEnabled 
int minOrgasmCount
int bodyScaleFactor
int bodyWithoutSexGrowth
int bodyMinBrests
int bodyMaxBrests
int bodyMinButt
int bodyMaxButt
int bodyMinBelly
int bodyMaxBelly
int addBuffsAndDebuffs

int tats_item_enabled
int tats_days_enabled
int	tats_item_corset
int	tats_item_harness
int	tats_item_chastity_belt
int	tats_item_chastity_bra

int actorStats
int actorPointer
string[] actorListString

int training_speed_analplug
int training_speed_vaginalplug

int bodyPointer

int resetActorButton