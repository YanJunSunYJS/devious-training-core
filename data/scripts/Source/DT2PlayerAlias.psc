Scriptname DT2PlayerAlias extends ReferenceAlias   


DT2Main Property DTMain Auto
DT2Update Property DTUpdate Auto
DT2Core Property DTCore Auto

Event OnPlayerLoadGame()
	Utility.wait(1)
	DTUpdate.Update(DTMain.getVersion())
	Utility.wait(1.5)
	DTCore.onLocationChangeExecute()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	Utility.wait(1.5)
	DTCore.onLocationChangeExecute()	
endEvent