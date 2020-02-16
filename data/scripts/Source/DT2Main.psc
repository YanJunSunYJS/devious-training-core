Scriptname DT2Main extends Quest  


;todo
;actor list
;description buffs debugffs
;harness waist

DT2Config Property DTConfig Auto
DT2Update Property DTUpdate Auto 
DT2Core Property DTCore Auto 
DT2Storage Property DTStorage Auto
DT2Tools Property DTTools Auto


; --- --- -- - GET FLOAT NUMBER WITH CURRENT VERSION - -- --- --- ;
; return number, important during update (compare with current know version number)

Float function getVersion()
	return 4.1
endFunction



; --- --- -- - GET STRING NUMBER WITH CURRENT VERSION (MCM) - -- --- --- ;
; return number, only to show in MCM

String function getDisplayVersion()
	return "3.0"
endFunction


; --- --- -- - INIT ALL MOD HERE - -- --- --- ;
;

Event OnInit()
	;dirty try to handle old version...
	
	if StorageUtil.HasIntValue(Game.getPlayer(), "dtstoragemod_enabled") == true
		Debug.messageBox("Devious Training: It's seems that You still using old version of this mod. This installation will be stopped until old version is not uninstalled. (Visit MCM -> Devious Training -> Utilities -> Uninstal (Yes)")
		
		while (StorageUtil.HasIntValue(Game.getPlayer(), "dtstoragemod_enabled") == true)
			DTConfig.mcmWorking = true
			debug.notification("Devious Training: Waiting for user action.")
			Utility.wait(5)
			
		endWhile
		DTConfig.mcmWorking = false
		Debug.messageBox("Devious Training: Much better, now I can install new version :)")
		
	endIf

	
	;start setup, turn on log etc...

	;init
	DTConfig.modEnabled = true
	DTConfig.showConsoleOutput = false
	DTConfig.showTraceOutput = false
	DTConfig.lastVersion = 0
	DTUpdate.Update(getVersion())
	turnOnMod(DTConfig.updateInterval / 2)
endEvent


; --- --- -- - PERIOD UPDATE - -- --- --- ;
; return number, only to show in MCM

Event OnUpdate()
	if DTConfig.modEnabled == true
	DTTools.log("Update start")
		if DTStorage.Semaphor == false
			DTTools.log("Update inside")
			DTStorage.Semaphor = true 
			; in this function i process all what possible
			DTCore.Process()
			DTStorage.Semaphor = false
		endif
		RegisterForSingleUpdate(DTConfig.updateInterval)
	else
		turnOffMod()
	endIf
endEvent


; --- --- -- - STOP MOD - -- --- --- ;
; just unregister updates (don't need to remove spells, MCM remove spells
; TODO: send event to other plugins (?)

function turnOffMod()
	UnregisterForUpdate()
endFunction


; --- --- -- - START MOD - -- --- --- ;
; reneable period updates
; TODO: send event to other plugins (?)

function turnOnMod(float time = 0.0)
	if time==0
		time = DTConfig.updateInterval
	endIf
	RegisterForSingleUpdate(time)
endFunction



function forceToUpdate()
	UnregisterForUpdate()
	RegisterForSingleUpdate(0.5)
endFunction


;add new item
;1) updater - add keyword in updatealways keys array
;2) create set of 3megiceffects and spells buff,debuff and nowear
;3) add spells to storage file
;4) add spell array to config
;5) fill arrayspell with spells in updater
;6) add array remove support in adctor unregister



;story of battle
;	29.01.2017 - reduced update visual in core
;	29.01.2017 - added SLIF support
;	29.01.2017 - bugfix related with ponyboots
;	29.01.2017 - added waist scale without corset
;	29.01.2017 - added sexlab separate orgasm and slavetats detection
;	29.01.2017 - added sexlab orgasm hooks
;	30.01.2017 - added body weight growth/loss related with orgasm count