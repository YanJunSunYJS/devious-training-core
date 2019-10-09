

;STANDARD MISC EVENT

	;NewEvent std DT event to notify everyone about:
	;orgasm,stdHit,zazHit
	
	;send event - zaz hit detected
	int handle = ModEvent.Create("DT_NewEvent")
	ModEvent.PushForm(handle, DTActor.npcs_ref[Slot] as Form)
	ModEvent.PushInt(handle, Slot)
	ModEvent.PushString(handle, "zazHit")
	ModEvent.PushInt(handle, DTActor.count_dmgZad[Slot])
	ModEvent.Send(handle)
	
		;TO RECIVE IN PLUGIN:
		
		Event eventNewEvent(Form akActorForm, int Slot ,String kind,int value)
			actor akActor = akActorForm as Actor
			;if kind == "zazHit"
			;	DTActor.processActor(Slot, "tats_hitsZad", value)
			;endif
		endEvent