Scriptname DT2Config extends Quest  


bool Property mcmTatsChanged Auto
bool Property mcmBodyChanged Auto

bool Property ignoreAdditionNegativeEffects Auto

bool Property tats_days_enabled Auto
Int Property gameDaysCount Auto

Int Property minOrgasmCount Auto

Float Property bodyScaleFactor Auto	;speed of inc/dec body parts
Bool Property bodyScaleOrgasmEnabled Auto
Bool Property bodyWithoutSexGrowth Auto
Bool Property bodyChangeWeight Auto
Float Property bodyMinBrests Auto
Float Property bodyMaxBrests Auto
Float Property bodyMinButt Auto
Float Property bodyMaxButt Auto
Float Property bodyMinBelly Auto
Float Property bodyMaxBelly Auto

bool Property tats_item_enabled Auto
bool Property tats_item_corset Auto
bool Property tats_item_harness Auto
bool Property tats_item_chastity_belt Auto
bool Property tats_item_chastity_bra Auto


Bool Property zazExtensionPack Auto
Bool Property sanguneDebucheryPack Auto
Bool Property cursedLootPack Auto 
Bool Property slifPack Auto
Bool Property separateOrgasmPack Auto
Bool Property slaveTatsPack Auto
Bool Property bacPack Auto

Bool Property enableSlif Auto

Bool Property allowChangeDeviousDevices Auto
Bool Property allowChangecursedLootPack Auto
Bool Property allowToReconfigureAutomatic Auto

Int Property crawlSource Auto	;TODO

Armor Property DT_ArchedFeet Auto

Bool Property achievement_ponygirl_enabled Auto
Bool Property achievement_ponygirl_equip_force Auto
Bool Property achievement_ponygirl_equip_enabled Auto
Bool Property achievement_ponygirl_equip_tied Auto
Bool Property achievement_ponygirl_equip_always Auto
Bool Property achievement_ponygirl_sound_tied Auto
Bool Property achievement_ponygirl_sound_always Auto
Int Property achievement_ponygirl_colorset Auto
Bool Property achievement_ponygirl_add_another_items Auto
Bool Property achievement_ponygirl_cast_helpfull_spells Auto

Bool Property achievement_blindslut_enabled Auto

Float Property lastVersion Auto
Float Property updateInterval Auto

Int Property buffMult Auto

Bool Property modEnabled Auto
Bool Property mcmWorking Auto

Bool Property showConsoleOutput Auto
Bool Property showTraceOutput Auto

Bool Property updateOnlyWithCellChange Auto
Bool Property fullProcessing Auto

Actor Property playerRef Auto

Int Property allowedsex Auto
Int Property scanerRange Auto
Int Property playerSlot Auto

Bool Property effect_sound_enabled Auto
Bool Property effect_shader_enabled Auto
Bool Property effect_alert_enabled Auto
Bool Property effect_values_enabled Auto	;magica/health/stamina
Bool Property effect_arousal_enabled Auto
Int Property effect_arousal_behavior Auto

Bool Property process_only_pc Auto	
Bool Property process_wildcard Auto			;force to process (mcm reset)
Bool Property process_follower Auto	
Bool Property process_enemies Auto	
Bool Property process_neutral Auto	
Bool Property process_friends Auto	
Bool Property addBuffsAndDebuffs Auto	

Bool Property ignore_duplicates Auto
Bool Property turnoffspeedattack Auto

Int Property training_level_curve Auto	
Int Property training_level_model Auto
Int Property preventCarryWeight Auto
Int Property preventSpeedWalk Auto

Int[] Property slotMask Auto
Armor Property acceptBoots0 Auto
Armor Property acceptBoots1 Auto
Armor Property acceptBoots2 Auto
Armor Property acceptBoots3 Auto

Keyword[] Property ddKeywords Auto

Keyword Property bac_hooves Auto		;normal hooves
Keyword Property bac_hooves1 Auto		;full hooves
Keyword Property bac_hooves2 Auto		;hooves with horse shoe
Keyword Property bac_hooves3 Auto		;hooves with armor

Keyword Property bac_hooves_hand Auto	;hand hooves
Keyword Property bac_hooves_hand1 Auto	;hand hooves with armor

Keyword Property zadWeapon Auto

Race[] Property allowedRaces Auto


Int[] Property exponentialTable Auto
Int[] Property logarithmicTable Auto
Int[] Property linearTable Auto


Spell[] Property bootsSpellDescr Auto
Spell[] Property corsetSpellDescr Auto
Spell[] Property harnessSpellDescr Auto
Spell[] Property armCuffsSpellDescr Auto
Spell[] Property legCuffsSpellDescr Auto
Spell[] Property gagSpellDescr Auto
Spell[] Property collarSpellDescr Auto
Spell[] Property chastityBeltSpellDescr Auto
Spell[] Property chastityBraSpellDescr Auto
Spell[] Property glovesSpellDescr Auto
Spell[] Property armbinderSpellDescr Auto
Spell[] Property blindfoldSpellDescr Auto
Spell[] Property analPlugSpellDescr Auto
Spell[] Property vaginalPlugSpellDescr Auto


Int Property effect_vaginalPlug_weight Auto

Int Property training_speed_armbinder Auto
Int Property effect_armbinder_health Auto

;corsetSpellDescr


Int Property training_speed_gloves Auto

Int Property training_speed_harness Auto
Bool Property effect_harness_enabled Auto
Int Property effect_harness_weight Auto

Int Property training_speed_legcuffs Auto
Bool Property effect_legcuffs_enabled Auto
Int Property effect_legcuffs_alert_weight Auto
Int Property effect_legcuffs_weight Auto


Int Property training_speed_chastityBelt Auto
Bool Property effect_chastityBelt_enabled Auto
Int Property effect_chastityBelt_weight Auto

Int Property training_speed_chastityBra Auto
Bool Property effect_chastityBra_enabled Auto
Int Property effect_chastityBra_weight Auto


Int Property training_speed_armcuffs Auto
Bool Property effect_armcuffs_enabled Auto
Int Property effect_armcuffs_alert_weight Auto
Int Property effect_armcuffs_weight Auto

int Property training_speed_vaginalplug Auto
int Property training_speed_analplug Auto


Int Property training_speed_gag Auto
Bool Property effect_gag_enabled Auto
Bool Property effect_gag_enabled_talk Auto
Bool Property effect_gag_enabled_mounth Auto
Int Property effect_gag_enabled_mounth_weight Auto

Int Property training_speed_corset Auto
Int Property training_speed_corset_dec Auto

Int Property effect_corset_waist_visual Auto
Int Property effect_corset_waist_visualWithout Auto
Float Property effect_chastity_breast_visual Auto
Bool Property effect_corset_enabled Auto
Int Property effect_corset_weight Auto

Bool Property effect_collar_enabled Auto
Int Property effect_collar_long_visual Auto
Int Property training_speed_collar Auto
Int Property effect_collar_weight Auto


Int Property training_speed_boots Auto
Int Property training_speed_boots_dec Auto
Bool Property effect_arched_feet_visual Auto
Bool Property effect_arched_feet_crawl_visual Auto
Bool Property effect_boots_enabled Auto
Int Property effect_boots_weight Auto


Bool Property effect_blindfold_enabled Auto
Float Property effect_blindfold_eyes_close Auto
Int Property training_speed_blindfold Auto

;sound
Sound[] Property fem_breath_normal Auto
Sound[] Property fem_breath_gaged Auto

Sound[] Property fem_pain_normal Auto
Sound[] Property fem_pain_gaged Auto

Sound[] Property fem_gasp_normal Auto
Sound[] Property fem_pony Auto

Sound[] Property fem_moan_normal Auto
Sound[] Property fem_moan_gaged Auto

Sound[] Property chastity_normal Auto


Sound[] Property sound_chain Auto

float Property boots_min Auto
float Property boots_max Auto
float Property corset_min Auto
float Property corset_max Auto
float Property harness_min Auto
float Property harness_max Auto
float Property legcuffs_min Auto
float Property legcuffs_max Auto
float Property armcuffs_min Auto
float Property armcuffs_max Auto
float Property gag_min Auto
float Property gag_max Auto
float Property collar_max Auto
float Property collar_min Auto
float Property chastityBelt_max Auto
float Property chastityBelt_min Auto
float Property chastityBra_max Auto
float Property chastityBra_min Auto
float Property analPlug_max Auto
float Property analPlug_min Auto
float Property vaginalPlug_max Auto
float Property vaginalPlug_min Auto
float Property vaginalPiercing_max Auto
float Property vaginalPiercing_min Auto
float Property nipplePiercing_max Auto
float Property nipplePiercing_min Auto
float Property gloves_max Auto
float Property gloves_min Auto
float Property armbinder_min Auto
float Property armbinder_max Auto
float Property blindfold_min Auto
float Property blindfold_max Auto 



float Property shadowShader  Auto


Faction Property DT_Boots Auto
Faction Property DT_Corset Auto
Faction Property DT_Harness Auto
Faction Property DT_Legscuffs Auto
Faction Property DT_Armscuffs Auto
Faction Property DT_Gag Auto
Faction Property DT_Collar Auto
Faction Property DT_Chastitybelt Auto
Faction Property DT_Chastitybra Auto
Faction Property DT_Gloves Auto
Faction Property DT_Armbinderyoke Auto
Faction Property DT_Blindfold Auto
Faction Property DT_VaginalPlug Auto
Faction Property DT_AnalPlug Auto