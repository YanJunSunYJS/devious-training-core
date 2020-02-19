Scriptname DT2PlayerAlias extends ReferenceAlias   


DT2Main Property DTMain Auto
DT2Update Property DTUpdate Auto
DT2Core Property DTCore Auto

Event OnPlayerLoadGame()

	RegisterForMenu("Sleep/Wait Menu")
	RegisterForMenu("Loading Menu")
;	RegisterForMenu("MapMenu")

	Utility.wait(1)
	DTUpdate.Update(DTMain.getVersion())
	Utility.wait(1.5)
	DTCore.onLocationChangeExecute()



EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	Utility.wait(1.5)
	DTCore.onLocationChangeExecute()	
endEvent

Event OnMenuClose(String MenuName)
	Debug.Notification("Close: "+MenuName)
	debug.trace("close: "+MenuName)
	DTMain.turnOnMod(0)
EndEvent

Event OnMenuOpen(String MenuName)
	Debug.Notification("Open: "+MenuName)
	debug.trace("Open: "+MenuName)
	DTMain.turnOffMod()

EndEvent