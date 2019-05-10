Scriptname DT2WatchdogMain extends activemagiceffect  


DT2Actor Property DTActor Auto
DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto

Actor Property acActor Auto
Int Property Slot Auto
Bool Property Terminate Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Slot = DTActor.isRegistered(akTarget)
	
	if Slot == -1	
		self.Dispel()
	endIf
	
	Terminate = False
	acActor = akTarget
	
	if DTConfig.playerSlot == Slot
		RegisterForMenu("Dialogue Menu")
	endIf

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
	
endEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)
	
endEvent



event OnMenuOpen(String asMenuName)
	DTTools.log("menu:"+asMenuName)
	if asMenuName == "Dialogue Menu"	
		DTActor.countSpeak[Slot] = DTActor.countSpeak[Slot] + 1
	endif
endevent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	DTActor.countHit[Slot] = DTActor.countHit[Slot] + 1
endevent


Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	 
	if asEventName == "weaponSwing" || asEventName == "WeaponLeftSwing" || asEventName == "BowRelease" || asEventName == "BeginCastRight" || asEventName == "BeginCastLeft" 
		DTActor.countAttack[Slot] = DTActor.countAttack[Slot] + 1
	endif
 
	if asEventName == "JumpUp" || asEventName == "JumpDown"	
		DTActor.countJump[Slot] = DTActor.countJump[Slot] + 1
	endif
 
	if asEventName == "FootLeft" || asEventName == "FootRight"
		if DTTools.getIsRunning(acActor)
			;DTTools.log("IsRunning")
			DTActor.countRun[Slot] = DTActor.countRun[Slot] + 1
			
		endIf
	
		if DTTools.getIsSprinting(acActor)
			;DTTools.log("IsSprinting")
			DTActor.countSprint[Slot] = DTActor.countSprint[Slot] + 1
		endIf
	
		if DTTools.getIsWalking(acActor)
			;DTTools.log("isWalking")
			DTActor.countWalk[Slot] = DTActor.countWalk[Slot] + 1
		endIf
	endif
  
	if asEventName == "tailSneakLocomotion"
		;DTTools.log("IsSneaking")
		DTActor.countWalk[Slot] = DTActor.countWalk[Slot] + 1
	endif
	
	if asEventName == "SoundPlay.FSTSwimSwim"
		;DTTools.log("IsSwim")
		DTActor.countSwim[Slot] = DTActor.countSwim[Slot] + 1
	endif

	DTTools.log2("EVENT",asEventName)
endEvent