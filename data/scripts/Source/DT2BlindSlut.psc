Scriptname DT2BlindSlut extends activemagiceffect  

Sound Property DT_msc_heartbit Auto

DT2Actor Property DTActor Auto
DT2Config Property DTConfig Auto
DT2Tools Property DTTools Auto
DT2Expert Property DTExpert Auto

Actor Property acActor Auto
Int Property Slot Auto
Bool Property Terminate Auto
Bool Property trig Auto

zadLibs Property zadl Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
DTTools.log("add blindslut spell")
	Slot = DTActor.isRegistered(akTarget)
	
	if Slot == -1	
		self.Dispel()
	endIf
	
	Terminate = False
	acActor = akTarget
	trig = false
	RegisterForSingleUpdate(2.5)
endEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)
DTTools.log("Remove blindslut spell")
	Terminate = true
endEvent

Event onUpdate()

	if Terminate == true
	DTTools.log("removing spell by request")
		self.Dispel()
		return
		
	endif
	
	if DTExpert.okBlindfold(Slot) == false
		DTTools.log("removing spell by lite")
		self.Dispel()
		Terminate = true
	return
	endif
	
	zadl.ToggleCompass(true)
	DTTools.log("update of arc blind")
	
	float maxRad = 7000.0
	Actor[] actors
	actors = DTTools.getActors(acActor,maxRad)
	DTTools.log("Check for"+actors)

	int i = actors.length
	float dist = maxRad + 1
	while i > 0
		i -= 1
		if actors[i]!=None
			
			DTTools.log("Check for"+actors[i])
			if actors[i] != acActor && actors[i].IsHostileToActor(acActor) &&  actors[i].isDead() == false && actors[i].IsChild() == false 
				DTTools.log("Check for"+actors[i]+"OK")
					float d = acActor.GetDistance( actors[i] )
					d = d * 1.5
					if acActor.HasLOS(actors[i]) || actors[i].HasLOS(acActor)
						d = d / 1.5
					endif
					if dist > d  
						dist = d
					endif
					DTTools.log("Check for"+actors[i]+" "+dist)
			endIf
			
		endif
	endWhile
	
	; 2000 = 100
	; x    = ?
	;
	; dist * 100 / 3000
	
if dist<maxRad+1

	if trig == false
		trig = true
		debug.notification("I think I heard something...")
	endif
	float soundstr = dist * 100 / maxRad
		
	int inst = DT_msc_heartbit.play(acActor)
	Sound.SetInstanceVolume(inst, 1 - (soundstr/100))
else
trig = false
endif
RegisterForSingleUpdate(2.5)

endEvent