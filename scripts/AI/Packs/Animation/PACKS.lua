ANIMATIONPACK={

	AVAILABLE = {

		Basic = "Scripts/AI/Packs/Animation/Basic.lua",
		Trooper = "Scripts/AI/Packs/Animation/Trooper.lua",
		TeamLeader = "Scripts/AI/Packs/Animation/TeamLeader.lua",
		Alien = "Scripts/AI/Packs/Animation/Alien.lua",
		Leader = "Scripts/AI/Packs/Animation/Leader.lua",
		
--		Hawker = "Scripts/AI/Packs/Animation/Hawker.lua",
--		Sykes = "Scripts/AI/Packs/Animation/Sykes.lua",
--		Proto7 = "Scripts/AI/Packs/Animation/Proto7.lua",
	}
}



function ANIMATIONPACK:LoadAll()
	
	for name,filename in pairs(self.AVAILABLE) do	
--		AI.LogEvent("Preloading animationPack "..name)
		Script.LoadScript(filename,true,true);
	end
end