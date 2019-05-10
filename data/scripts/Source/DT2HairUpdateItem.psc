Scriptname DT2HairUpdateItem extends ObjectReference  

DT2Tools Property DTTools Auto

event OnLoad()
	DTTools.log("DT2HairUpdateItem::(OnLoad)Update hair color",1)
	Game.UpdateHairColor()
	
endEvent


Event OnEquipped(Actor akActor)

	DTTools.log("DT2HairUpdateItem::(OnEquipped)Update hair color",1)
	Game.UpdateHairColor()
	

endEvent

