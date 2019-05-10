Scriptname DT2EffectCrawl extends activemagiceffect  

int property mtIdleBase auto
int property mtBase auto
int property mtxBase auto



;zbfxMain Property zbfx  Auto  
;DT2Config Property DTConfig Auto

function Trace(string text)
	Debug .Trace("$$ CRAWL :" + text)
endfunction

event OnEffectStart(Actor akTarget, Actor akCaster)
int modID = FNIS_aa.GetAAModID("zbx", "ZazExtensionPack", true)
		mtIdleBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtidle(),"ZazExtensionPack",true) 
		mtBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mt(),"ZazExtensionPack",true) 
		mtxBase = FNIS_aa.GetGroupBaseValue(modID,FNIS_aa._mtx(),"ZazExtensionPack",true)

	bool b1 = FNIS_aa.SetAnimGroup(akTarget, "_mtidle", mtIdleBase, 0, "ZazExtensionPack",true)
	bool b2 = FNIS_aa.SetAnimGroup(akTarget, "_mt", mtBase, 0, "ZazExtensionPack",true)
	bool b3 = FNIS_aa.SetAnimGroup(akTarget, "_mtx", mtxBase, 0, "ZazExtensionPack",true)
	Trace(akTarget.GetDisplayName() + " is crawling - " + b1 + "," + b2 + "," + b3)
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	FNIS_aa.SetAnimGroup(akTarget, "_mtidle",0,0,"ZazExtensionPack",true)
	FNIS_aa.SetAnimGroup(akTarget, "_mt",0,0,"ZazExtensionPack",true)
	FNIS_aa.SetAnimGroup(akTarget, "_mtx",0,0,"ZazExtensionPack",true)
	Trace(akTarget.GetDisplayName() + " stops crawling")
endevent
