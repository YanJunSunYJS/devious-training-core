Scriptname DT2Descriptor extends Quest  

DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Actor Property DTActor Auto
DT2Storage Property DTStorage Auto
DT2Expert Property DTExpert Auto


Float function processBoots(int slot, float minRange, float maxRange)
Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_boots[slot] < 0
		clearSpells(DTConfig.bootsSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_boots[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.bootsSpellDescr, acActor)

	if DTConfig.training_speed_boots == 0
		return 0
	endif	
	
	;change
	;if ( acActor.WornHasKeyword(DTConfig.ddKeywords[0])==false && str <= 0)
	if ( DTExpert.okBoots(slot)==false && str <= 0)
		return 0
	endif
	
	
	;change
	if ( DTExpert.okBoots(slot)==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf
	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	
	;change
	acActor.addSpell(DTConfig.bootsSpellDescr[spellLevel],false)
		
	return str

endFunction




Float function processArmbinder(int slot, float minRange, float maxRange)
Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_armbinder[slot] < 0
		clearSpells(DTConfig.armbinderSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_armbinder[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.armbinderSpellDescr, acActor)

	if DTConfig.training_speed_armbinder == 0
		return 0
	endif	
	
	;change
	;if ( acActor.WornHasKeyword(DTConfig.ddKeywords[0])==false && str <= 0)
	if ( DTExpert.okArmbinder(slot)==false && str <= 0)
		return 0
	endif
	
	
	;change
	if ( DTExpert.okArmbinder(slot)==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf
	

	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf	
	
	;change
	acActor.addSpell(DTConfig.armbinderSpellDescr[spellLevel],false)
		
	return str

endFunction


Float function processCorset(int slot, float minRange, float maxRange)
	Actor acActor = DTActor.npcs_ref[slot]
	
	if DTConfig.ignore_duplicates == true && acActor.WornHasKeyword(DTConfig.ddKeywords[2])
		clearSpells(DTConfig.corsetSpellDescr, acActor)
		return 0
	endif
	
	;change 
	if DTActor.npcs_corset[slot] < 0
		clearSpells(DTConfig.corsetSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_corset[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.corsetSpellDescr, acActor)

	if DTConfig.training_speed_corset == 0
		return 0
	endif	
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[1])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[1])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	;change
	acActor.addSpell(DTConfig.corsetSpellDescr[spellLevel],false)
		
	return str

endFunction



Float function processHarness(int slot, float minRange, float maxRange)
	Actor acActor = DTActor.npcs_ref[slot]
	
	if DTConfig.ignore_duplicates == true && acActor.WornHasKeyword(DTConfig.ddKeywords[1])
		clearSpells(DTConfig.harnessSpellDescr, acActor)
		return 0
	endif
	
	;change 
	if DTActor.npcs_harness[slot] < 0
		clearSpells(DTConfig.harnessSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_harness[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.harnessSpellDescr, acActor)

	if DTConfig.training_speed_harness == 0
		return 0
	endif	
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[2])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[2])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	;change
	acActor.addSpell(DTConfig.harnessSpellDescr[spellLevel],false)
		
	return str

endFunction


Float function processLegCuffs(int slot, float minRange, float maxRange)
Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_legcuffs[slot] < 0
		clearSpells(DTConfig.legCuffsSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_legcuffs[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.legCuffsSpellDescr, acActor)
	
	if DTConfig.training_speed_legcuffs == 0
		return 0
	endif	
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[3])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[3])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	;change
	acActor.addSpell(DTConfig.legCuffsSpellDescr[spellLevel],false)
		
	return str

endFunction



Float function processArmCuffs(int slot, float minRange, float maxRange)
Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_armcuffs[slot] < 0
		clearSpells(DTConfig.armCuffsSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_armcuffs[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.armCuffsSpellDescr, acActor)
	
	if DTConfig.training_speed_armcuffs == 0
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[4])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[4])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	;change
	acActor.addSpell(DTConfig.armCuffsSpellDescr[spellLevel],false)
		
	return str

endFunction


Float function processGag(int slot, float minRange, float maxRange)
Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_gag[slot] < 0
		clearSpells(DTConfig.gagSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_gag[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.gagSpellDescr, acActor)

	if DTConfig.training_speed_gag == 0
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[5])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[5])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	;change
	acActor.addSpell(DTConfig.gagSpellDescr[spellLevel],false)
		
	return str

endFunction




Float function processGloves(int slot, float minRange, float maxRange)
	Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_gloves[slot] < 0
		clearSpells(DTConfig.glovesSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_gloves[slot]  ), minRange  ,  maxRange)
	;DTTools.log("Gloves spell level str:"+str);		
	;DTTools.log("Gloves spell level ranges:"+minRange+" "+maxRange);		
	
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.glovesSpellDescr, acActor)

	if DTConfig.training_speed_gloves == 0
		return 0
	endif
	
	;change
	if ( DTExpert.okGloves(slot)==false && str <= 0)
		return 0
	endif
	
	;change
	if ( DTExpert.okGloves(slot)==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	;change
	
	;DTTools.log("Gloves spell level:"+spellLevel);
	acActor.addSpell(DTConfig.glovesSpellDescr[spellLevel],false)
		
	return str

endFunction



Float function processCollar(int slot, float minRange, float maxRange)
Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_collar[slot] < 0
		clearSpells(DTConfig.collarSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_collar[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.collarSpellDescr, acActor)
	
	if DTConfig.training_speed_collar == 0
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[6])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[6])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf	

	
	;change
	acActor.addSpell(DTConfig.collarSpellDescr[spellLevel],false)
		
	return str

endFunction



Float function processChastityBelt(int slot, float minRange, float maxRange)
	Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_chastityBelt[slot] < 0
		clearSpells(DTConfig.chastityBeltSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_chastityBelt[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.chastityBeltSpellDescr, acActor)
	
	if DTConfig.training_speed_chastityBelt == 0
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[7])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[7])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf

	
	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf
	
	;change
	acActor.addSpell(DTConfig.chastityBeltSpellDescr[spellLevel],false)
		
	return str

endFunction


Float function processChastityBra(int slot, float minRange, float maxRange)
	Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_chastityBra[slot] < 0
		clearSpells(DTConfig.chastityBraSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_chastityBra[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.chastityBraSpellDescr, acActor)
	
	if DTConfig.training_speed_chastityBra == 0
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[8])==false && str <= 0)
		return 0
	endif
	
	;change
	if ( acActor.WornHasKeyword(DTConfig.ddKeywords[8])==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf


	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf

	
	;change
	acActor.addSpell(DTConfig.chastityBraSpellDescr[spellLevel],false)
		
	return str

endFunction




Float function processBlindfold(int slot, float minRange, float maxRange)
Actor acActor = DTActor.npcs_ref[slot]
	;change 
	if DTActor.npcs_blindfold[slot] < 0
		clearSpells(DTConfig.blindfoldSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_blindfold[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.blindfoldSpellDescr, acActor)

	if DTConfig.training_speed_blindfold == 0
		return 0
	endif	
	
	;change
	;if ( acActor.WornHasKeyword(DTConfig.ddKeywords[0])==false && str <= 0)
	if ( DTExpert.okBlindfold(slot)==false && str <= 0)
		return 0
	endif
	
	
	;change
	if ( DTExpert.okBlindfold(slot)==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf
	

	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf	
	
	;change
	acActor.addSpell(DTConfig.blindfoldSpellDescr[spellLevel],false)
		
	return str

endFunction


Float function processAnalPlug(int slot, float minRange, float maxRange)
	Actor acActor = DTActor.npcs_ref[slot]
	;change 	
	if DTActor.npcs_analPlug[slot] < 0
		clearSpells(DTConfig.analPlugSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_analPlug[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.analPlugSpellDescr, acActor)

	if DTConfig.training_speed_analplug == 0
		return 0
	endif	
	
	;change
	;if ( acActor.WornHasKeyword(DTConfig.ddKeywords[0])==false && str <= 0)
	if ( DTExpert.okAnalPlug(slot)==false && str <= 0)
		return 0
	endif
	
	
	;change
	if ( DTExpert.okAnalPlug(slot)==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf
	

	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf	
	
	;change
	acActor.addSpell(DTConfig.analPlugSpellDescr[spellLevel],false)
		
	return str

endFunction


Float function processVaginalPlug(int slot, float minRange, float maxRange)
	Actor acActor = DTActor.npcs_ref[slot]
	;change 	
	if DTActor.npcs_vaginalPlug[slot] < 0
		clearSpells(DTConfig.vaginalPlugSpellDescr, acActor)
		return 0
	endif
	
	;change
	float str = DTTools.rescaleToRange( DTTools.getAdvancedLevel( DTActor.npcs_vaginalPlug[slot]  ), minRange  ,  maxRange)
			
	
	
	int spellLevel = 0 
	
	if str>=0
		spellLevel = 1
	endIf
	
	
	;change
	clearSpells(DTConfig.vaginalPlugSpellDescr, acActor)

	if DTConfig.training_speed_vaginalplug == 0
		return 0
	endif	
	
	;change
	;if ( acActor.WornHasKeyword(DTConfig.ddKeywords[0])==false && str <= 0)
	if ( DTExpert.okVaginalPlug(slot)==false && str <= 0)
		return 0
	endif
	
	
	;change
	if ( DTExpert.okVaginalPlug(slot)==false && str > 0)
		str = str * -1
		spellLevel = 2
		if str <= minRange
			return 0
		endIf
	endIf
	

	 if DTConfig.ignoreAdditionNegativeEffects == true && spellLevel == 2
		return 0
	endIf	
	
	;change
	acActor.addSpell(DTConfig.vaginalPlugSpellDescr[spellLevel],false)
		
	return str

endFunction

function clearSpells(Spell[] spellList,Actor acActor)

	int i = spellList.length
	while i > 0
		i -= 1
		if acActor.hasSpell(spellList[i])
			acActor.removeSpell(spellList[i])
		endIf
	endWhile
	
endFunction