--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character SCRIPT for Tank
--  
--------------------------------------------------------------------------
--  History:
--  - 06/02/2005   : Created by Kirill Bulatsev
--  - 10/07/2006   : Dulplicated for the special tank by Tetsuji
--  
--------------------------------------------------------------------------

AICharacter.Warrior = {
	
	Constructor = function(self,entity)	
--		entity.AI.DesiredFireDistance[1] = 30; -- main gun
--		entity.AI.DesiredFireDistance[2] = 6; -- secondary machine gun
		entity.AI.weaponIdx = 1; --temp: select main gun by default
	end,
	
	AnyBehavior = {
		STOP_VEHICLE = "WarriorIdle",
	},
	
	WarriorIdle = {
		-----------------------------------
		FOLLOW              = "WarriorFollow",
		ACT_GOTO            = "WarriorGoto",

		EVERYONE_OUT        = "",
		STOP_VEHICLE 			  = "",
		DRIVER_OUT          = "",
		VEHICLE_GOTO_DONE   = "",

		TO_WARRIOR_ATTACK = "";
	
		OnPlayerSeen        = "WarriorAttack",		

	},
	
	WarriorFollow = {
		-----------------------------------
		FOLLOW              = "",
		ACT_GOTO            = "WarriorGoto",

		EVERYONE_OUT        = "WarriorIdle",
		STOP_VEHICLE 			  = "WarriorIdle",
		DRIVER_OUT          = "WarriorIdle",
		VEHICLE_GOTO_DONE   = "WarriorIdle",

		TO_WARRIOR_ATTACK = "";
	
		OnPlayerSeen        = "WarriorAttack",		

	},

	WarriorGoto = {
		-----------------------------------
		FOLLOW              = "WarriorFollow",
		ACT_GOTO            = "",

		EVERYONE_OUT        = "WarriorIdle",
		STOP_VEHICLE 			  = "WarriorIdle",
		DRIVER_OUT          = "WarriorIdle",
		VEHICLE_GOTO_DONE   = "WarriorIdle",

		TO_WARRIOR_ATTACK = "";
	
		OnPlayerSeen        = "WarriorAttack",		

	},

	WarriorAttack = {
		-----------------------------------
		FOLLOW              = "",
		ACT_GOTO            = "",

		EVERYONE_OUT        = "WarriorIdle",
		STOP_VEHICLE 			  = "WarriorIdle",
		DRIVER_OUT          = "WarriorIdle",
		VEHICLE_GOTO_DONE   = "WarriorIdle",

		TO_WARRIOR_ATTACK = "";
	
		OnPlayerSeen        = "",		

	},

	
}
