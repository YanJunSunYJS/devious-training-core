Scriptname DT2AlertEnemies extends activemagiceffect  


DT2Config Property DTConfig Auto
DT2Actor Property DTActor Auto
DT2Tools Property DTTools Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)



	
	
	Actor[] actors
	actors = DTTools.getActors(akTarget)
	
	
	int i = actors.length
	while i > 0
		i -= 1
		
		if actors[i]!=None && isValid(actors[i])
			if actors[i].IsHostileToActor(akTarget) == true &&  actors[i].IsInCombat() == false && actors[i].GetRelationshipRank(akTarget) < -1
				actors[i].SetAlert() 
				actors[i].SendAssaultAlarm()
				actors[i].SetLookAt(akTarget)			
			endIf
		endif
	endWhile
	
endEvent



bool function isValid(Actor acActor)
	if acActor==None
		return false
	endIf
	
	if acActor.isDead() == true || acActor.IsChild() == true || acActor.IsGhost() == true
		return false
	endIf
	
	
	
	
	
	return true
endFunction