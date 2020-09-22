-- All the characters defined

AICharacter = {

	INTERNAL = {
		-- automatially assigned to player
		Player		= "Scripts/AI/Characters/Personalities/Player.lua",
	},

	AVAILABLE = {

	-- hardcoding behavior for video recording
		Demo		= "Scripts/AI/Characters/Personalities/Demo.lua",
		Demo1		= "Scripts/AI/Characters/Personalities/Demo1.lua",
	-- hardcoding behavior for video recording

		SuperDumb		= "Scripts/AI/Characters/Personalities/SuperDumb.lua",
		
		Cover2	= "Scripts/AI/Characters/Personalities/Cover2.lua",
		Camper	= "Scripts/AI/Characters/Personalities/Camper.lua",

		WatchTowerGuard	= "Scripts/AI/Characters/Personalities/WatchTowerGuard.lua",

		FriendlyNPC	= "Scripts/AI/Characters/Personalities/FriendlyNPC.lua",
		FollowerNPC	= "Scripts/AI/Characters/Personalities/FollowerNPC.lua",

--		Flanker	= "Scripts/AI/Characters/Personalities/Sneaker.lua",				
		Sneaker	= "Scripts/AI/Characters/Personalities/Sneaker.lua",		
		Sniper	= "Scripts/AI/Characters/Personalities/Sniper.lua",				
		Leader	= "Scripts/AI/Characters/Personalities/Leader.lua",
		Suit	= "Scripts/AI/Characters/Personalities/Suit.lua",
		SuitSniper	= "Scripts/AI/Characters/Personalities/SuitSniper.lua",
		SuitHurricane	= "Scripts/AI/Characters/Personalities/SuitHurricane.lua",
		SuitBoss	= "Scripts/AI/Characters/Personalities/SuitBoss.lua",
		
--		SquadInfantry		= "Scripts/AI/Characters/Personalities/Squad/SquadInfantry.lua",
--		SquadEngineer		= "Scripts/AI/Characters/Personalities/Squad/SquadEngineer.lua",

		--------------------------------------------------
		--------------------------------------------------	

		--------------------------------------------------
		--- here are vehicles
		--------------------------------------------------
		--------------------------------------------------
		-- cars
		CarConvoy				=	"SCRIPTS/AI/Characters/vehicles/CarConvoy.lua",
		Car							=	"SCRIPTS/AI/Characters/vehicles/Car.lua",
		--------------------------------------------------
		-- tanks
		Tank						=	"SCRIPTS/AI/Characters/vehicles/Tank.lua",		
		TankClose 			= "SCRIPTS/AI/Characters/vehicles/TankClose.lua",		
		TankFixed 			= "SCRIPTS/AI/Characters/vehicles/TankFixed.lua",		
		Warrior 				= "SCRIPTS/AI/Characters/vehicles/Warrior.lua",		
		AAA							=	"SCRIPTS/AI/Characters/vehicles/Aaa.lua",		
		APC							=	"SCRIPTS/AI/Characters/vehicles/Apc.lua",		
		--------------------------------------------------
		-- boats/ships
		Boat						=	"SCRIPTS/AI/Characters/vehicles/Boat.lua",
		PatrolBoat			=	"SCRIPTS/AI/Characters/vehicles/PatrolBoat.lua",
		--------------------------------------------------
		-- helicopters
		Heli						=	"SCRIPTS/AI/Characters/vehicles/Heli.lua",		
		HeliAggressive	=	"SCRIPTS/AI/Characters/vehicles/HeliAggressive.lua",		
		--------------------------------------------------
		-- vtol
		Vtol						=	"SCRIPTS/AI/Characters/vehicles/Vtol.lua",		
		
		GuardNeue	=	"SCRIPTS/AI/Characters/aliens/GuardNeue.lua",

		--------------------------------------------------
		-- exosuits and drones
		Trooper		=	"SCRIPTS/AI/Characters/aliens/Trooper.lua",
		TrooperLeader		=	"SCRIPTS/AI/Characters/aliens/TrooperLeader.lua",
		Scout		=	"SCRIPTS/AI/Characters/aliens/Scout.lua",
		ScoutMelee		=	"SCRIPTS/AI/Characters/aliens/ScoutMelee.lua",
		ScoutMOAC		=	"SCRIPTS/AI/Characters/aliens/ScoutMOAC.lua",
		ScoutMOAR		=	"SCRIPTS/AI/Characters/aliens/ScoutMOAR.lua",
		Hunter		=	"SCRIPTS/AI/Characters/aliens/Hunter.lua",

		--------------------------------------------------
		--------------------------------------------------
		--------------------------------------------------
		--- here are civilians
		--------------------------------------------------

		Hostage		= "Scripts/AI/Characters/Personalities/Hostage.lua",
		Prisoner	= "Scripts/AI/Characters/Personalities/Prisoner.lua",		
		Civilian	= "Scripts/AI/Characters/Personalities/Civilian.lua",

		---PUT TEMP STUFF HERE
		--------------------------------------------------

	
	},
	
}

AI.LogEvent("LOADED AI CHARACTERS");

Script.LoadScript("Scripts/AI/Characters/DEFAULT.lua",true,true);


function AICharacter:LoadAll()
	
	for name,filename in pairs(self.AVAILABLE) do	
		AI.LogEvent("Preloading character "..name);
		Script.LoadScript(filename,true,true);
	end

	for name,filename in pairs(self.INTERNAL) do	
		AI.LogEvent("Preloading character "..name);
		Script.LoadScript(filename,true,true);
	end

end
