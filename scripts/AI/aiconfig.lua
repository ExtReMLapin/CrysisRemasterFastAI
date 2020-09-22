-- AICONFIG 
-- Used to load/reload everything related to ai

AI.LogEvent("[AISYSTEM] AIConfig starts  -------------------------------------");

--Script.LoadScript( "SCRIPTS/Entities/AI/BasicAI.lua", true, true);

Script.LoadScript("Scripts/AI/anchor.lua", true, true);
Script.LoadScript("Scripts/AI/pathfindProperties.lua", true, true);
Script.LoadScript("Scripts/AI/Characters/AICharacter.lua", true, true);
Script.LoadScript("Scripts/AI/Logic/AI_BoredManager.lua", true, true);
Script.LoadScript("Scripts/AI/Behaviors/Personalities/SHARED/Idles/Idle_Any.lua", true, true);

Script.LoadScript("Scripts/AI/GoalPipes/PipeManager.lua", true, true);
Script.LoadScript("Scripts/AI/Behaviors/AIBehaviour.lua", true, true);
Script.LoadScript("Scripts/AI/Logic/IdleManager.lua", true, true);


Script.LoadScript("Scripts/AI/Formations/FormationManager.lua", true, true);

--Script.LoadScript("Scripts/AI/TrackPatterns/TrackPatternManager.lua", true, true);

Script.LoadScript("Scripts/AI/Packs/Animation/PACKS.lua", true, true);
--Script.LoadScript("Scripts/AI/Packs/Sound/PACKS.lua");
--Script.LoadScript("Scripts/AI/Packs/Sound/dialog_template.lua");

--	SOUNDPACK:LoadAll();
	ANIMATIONPACK:LoadAll();	
	AIBehaviour:LoadAll();
	AICharacter:LoadAll();

--Script.LoadScript("Scripts/AI/Logic/AI_Conversation.lua");
--Script.LoadScript("Scripts/AI/Logic/AI_ConvManager.lua");
Script.LoadScript("Scripts/AI/Logic/SideSelector.lua", true, true);
Script.LoadScript("Scripts/AI/Logic/SoundPackRandomizer.lua", true, true);
Script.LoadScript("Scripts/AI/Logic/AI_Utils.lua", true, true);

--Script.LoadScript("Scripts/AI/Packs/Conversations/Idle.lua", true, true);
--Script.LoadScript("Scripts/AI/Packs/Conversations/Critical.lua", true, true);
Script.LoadScript("Scripts/AI/Packs/AI_IdleTable.lua", true, true);


Script.LoadScript("SCRIPTS/AI/Logic/NOCOVER.lua", true, true);

Script.LoadScript("SCRIPTS/AI/Logic/BlackBoard.lua", true, true);


--Script.LoadScript("SCRIPTS/Default/Entities/Weapons/AIWeapons.lua", true, true);

if (PipeManager) then
	PipeManager:OnInit();
end

if (FormationManager) then
	FormationManager:OnInit();
end

if (TrackPatternManager) then
	TrackPatternManager:OnInit();
end


-- SETTING UP THE PLAYER ASSESMENT MULTIPLIER
-- should be in the range [0,1] BUT can be bigger - forcing something be very important (grenades)
-- if multiplayer is more than 1, object will not be ignored with "igoreall" goal
AI.SetAssesmentMultiplier(AIOBJECT_PLAYER,1.0);	-- let's make squadmqtes prefferd enemies
AI.SetAssesmentMultiplier(AIOBJECT_ATTRIBUTE,1.0);
--AI.SetAssesmentMultiplier(AIOBJECT_GRENADE, 100); -- grenade is very important
--AI.SetAssesmentMultiplier(AIOBJECT_GRENADE, 0); -- grenade handeled on collision
AI.SetAssesmentMultiplier(AIOBJECT_RPG, 100); -- grenade is very important

--------------------------------------------------
--define combat classes
AICombatClasses = {};

--this will reset all existing combat classes
AI.AddCombatClass();	

--	ATTENTION!!! DON'T make the scale multiplyer 0 unlees you really need this class to be ignored
AICombatClasses.Player = 0;
AICombatClasses.PlayerRPG = 1;
AICombatClasses.Infantry = 2;
AICombatClasses.InfantryRPG	= 3;
AICombatClasses.Tank = 4;
AICombatClasses.TankHi = 5;
AICombatClasses.Heli = 6;
AICombatClasses.VehicleGunner	= 7;
AICombatClasses.Hunter = 8;
AICombatClasses.Civilian = 9;
AICombatClasses.Car = 10;
AICombatClasses.Warrior = 11;
AICombatClasses.AAA = 12;
AICombatClasses.BOAT = 13;
AICombatClasses.APC = 14;
AICombatClasses.Squadmate = 15;
AICombatClasses.Scout = 16;
AICombatClasses.ascensionScout = 17;
AICombatClasses.ascensionVTOL = 18;
AICombatClasses.ascensionScout2 = 19;
																							--		0			1			2			3			4			5			6			7			8			9			10		11		12		13		14		15		16		17		18		19
AI.AddCombatClass(AICombatClasses.Player,					{	1.0,	1.0,	1.0,	1.0,	1.1,	1.1,	1.0,	1.0,	2.0,	0.0,	0.0,	0.0,	1.0,	1.0,	1.0,	0.1,	1.0,	1.0,	0.0,	0.0,   } );																								
AI.AddCombatClass(AICombatClasses.PlayerRPG,			{	1.0,	1.0,	1.0,	1.0,	1.5,	1.5,	1.0,	1.0,	2.0,	0.0,	1.2,	0.0,	1.2,	1.0,	1.2,	0.1,	1.0,	1.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.Infantry,				{	1.0,	1.0,	1.0,	1.0,	1.1,	1.1,	1.0,	1.0,	2.0,	0.0,	0.0,	0.0,	1.0,	1.0,	1.0,	0.1,	1.0,	1.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.InfantryRPG,		{	1.0,	1.0,	1.0,	1.0,	1.5,	1.5,	1.0,	1.0,	2.0,	0.0,	1.2,	0.0,	1.2,	1.0,	1.2,	0.1,	1.0,	1.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.Tank,						{	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,	0.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,   }, "OnTankSeen" );	
AI.AddCombatClass(AICombatClasses.TankHi,					{	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,	0.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,   }, "OnTankSeen" );	
AI.AddCombatClass(AICombatClasses.Heli,						{	1.0,	1.0,	1.0,	1.0,	0.9,	0.9,	1.0,	1.0,	1.0,	0.0,	1.0,	0.0,	0.9,	1.0,	0.9,	1.0,	1.0,	1.0,	0.0,	1.0,   }, "OnHeliSeen" );	
AI.AddCombatClass(AICombatClasses.VehicleGunner,	{	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,	0.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,   } );	-- for the vehicle gunner. 1.5 means, I want to set the same priority as the player.
AI.AddCombatClass(AICombatClasses.Hunter,					{	1.0,	1.2,	0.8,	1.0,	2.0,	2.0,	2.0,	1.0,	2.0,	0.0,	1.0,	0.0,	2.0,	2.0,	2.0,	0.8,	1.5,	0.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.Civilian,				{	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	0.5,	0.0,	1.0,	1.0,	1.0,	0.1,	1.0,	0.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.Car,						{	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.Warrior,				{	0.05,	0.2,	0.05,	0.2,	0.2,	1.5,	2.0,	1.5,	0.05,	0.05,	1.5,	1.5,	1.5,	0.2,	1.5,	0.05,	0.05,	0.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.AAA,						{	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,	0.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,   }, "OnTankSeen" );	
AI.AddCombatClass(AICombatClasses.BOAT,						{	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,	0.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,   }, "OnBoatSeen" );	
AI.AddCombatClass(AICombatClasses.APC,						{	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,	0.0,	1.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	1.0,   }, "OnTankSeen" );	
AI.AddCombatClass(AICombatClasses.Squadmate,			{	1.0,	1.0,	1.0,	1.0,	1.1,	1.1,	1.0,	1.0,	2.0,	0.0,	0.0,	0.0,	1.0,	1.0,	1.0,	1.0,	1.0,	0.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.Scout,					{	1.0,  1.0,  0.7,	0.7,	0.9,	0.9,	1.0,	0.7,	1.0,	0.0,	1.0,	0.0,	0.9,	0.9,	0.9,	0.7,	1.0,	1.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.ascensionScout,	{	1.0,	1.0,	0.0,	0.5,	0.5,  0.0,	1.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.ascensionVTOL,	{	1.0,	1.0,	0.0,	0.0,	0.0, 	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,   } );	
AI.AddCombatClass(AICombatClasses.ascensionScout2,{	1.0,	1.0,	0.0,	0.7,	0.7,  0.0,	1.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,	0.0,   } );	

--define combat classes over
--------------------------------------------------

-- MAKE MUTANTS TWICE MORE SCARY THAN OTHER SPECIES
--AI:SetSpeciesThreatMultiplier(100,1.8);

function AIReset()
	AISideSelector:Reset();
	AIBlackBoard_Reset();
--	AIBlackBoard:Reset();	
end

function AI:ResetAI()
	System.Log( "[AI] Reseting AI" );
	AISideSelector:Reset();
	AIBlackBoard_Reset();
	Script.LoadScript("Scripts/AI/Packs/Animation/PACKS.lua", true, true);
	ANIMATIONPACK:LoadAll();
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManager.lua", true, true);
	PipeManager:OnInit();
end

--AISerializer = {};

function AI:OnSave(save)
	save.AIBlackBoard = AIBlackBoard;
	save.AISideSelector = AISideSelector;
end

function AI:OnLoad(saved)
	AIBlackBoard_Reset();
	AISideSelector:Reset();
	merge(AIBlackBoard,saved.AIBlackBoard);
	merge(AISideSelector,saved.AISideSelector);
end

AI.LogEvent("[AISSYSTEM] CONFIG SCRIPT FILE LOADED. --------------------------")
