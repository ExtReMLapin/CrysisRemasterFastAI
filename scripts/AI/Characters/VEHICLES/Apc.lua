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
--
--------------------------------------------------------------------------

AICharacter.APC = {
	
	Constructor = function(self,entity)	
--		entity.AI_DesiredFireDistance[1] = 30; -- main gun
--		entity.AI_DesiredFireDistance[2] = 6; -- secondary machine gun
		entity.AI.weaponIdx = 1; --temp: select main gun by default
	end,
	
	AnyBehavior = {
		STOP_VEHICLE = "TankIdle",
	},

	APCIdle = {
		-----------------------------------
		GO_PATH            = "Vehicle_Path",
		FOLLOW             = "TankFollow",
		ACT_GOTO           = "TankGoto",

		EVERYONE_OUT       = "",
		STOP_VEHICLE 			 = "",
		DRIVER_OUT         = "",
		VEHICLE_GOTO_DONE  = "",

		OnFollowPath       = "TankFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "",
		TO_TANK_MOVE       = "",
	
		OnPlayerSeen       = "TankAttack",		
		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	

	},
		
	TankIdle = {
		-----------------------------------
		GO_PATH            = "Vehicle_Path",
		FOLLOW             = "TankFollow",
		ACT_GOTO           = "TankGoto",

		EVERYONE_OUT       = "",
		STOP_VEHICLE 			 = "",
		DRIVER_OUT         = "",
		VEHICLE_GOTO_DONE  = "",

		OnFollowPath       = "TankFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "",
		TO_TANK_MOVE       = "",
	
		OnPlayerSeen       = "TankAttack",		
		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	

	},
	
	TankFollow = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "TankGoto",

		EVERYONE_OUT       = "TankIdle",	
		STOP_VEHICLE 			 = "TankIdle",	
		DRIVER_OUT         = "TankIdle",
		VEHICLE_GOTO_DONE  = "TankIdle",

		OnFollowPath       = "TankFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "",
		TO_TANK_MOVE       = "",
	
		OnPlayerSeen       = "TankAttack",		
		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	

	},

	TankGoto = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "TankFollow",
		ACT_GOTO           = "",

		EVERYONE_OUT       = "TankIdle",	
		STOP_VEHICLE 			 = "TankIdle",	
		DRIVER_OUT         = "TankIdle",
		VEHICLE_GOTO_DONE  = "TankIdle",

		OnFollowPath       = "TankFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "",
		TO_TANK_MOVE       = "",
	
		OnPlayerSeen       = "TankAttack",		
		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	

	},

	TankFollowPath = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",

		EVERYONE_OUT       = "TankIdle",	
		STOP_VEHICLE 			 = "TankIdle",	
		DRIVER_OUT         = "TankIdle",
		VEHICLE_GOTO_DONE  = "TankIdle",

		OnFollowPath       = "TankFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "",
		TO_TANK_MOVE       = "",
	
		OnPlayerSeen       = "TankAttack",
		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	
	
	},
	

	TankAttack = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",

		EVERYONE_OUT       = "TankIdle",	
		STOP_VEHICLE 			 = "TankIdle",	
		DRIVER_OUT         = "TankIdle",
		VEHICLE_GOTO_DONE  = "",

		OnFollowPath       = "",
		OnFollowPathLeader = "",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "",
		TO_TANK_MOVE       = "TankMove",
	
		OnPlayerSeen       = "",
		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	
	
	},

	TankMove = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",

		EVERYONE_OUT       = "TankIdle",	
		STOP_VEHICLE 			 = "TankIdle",	
		DRIVER_OUT         = "TankIdle",
		VEHICLE_GOTO_DONE  = "",

		OnFollowPath       = "",
		OnFollowPathLeader = "",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "TankAlert",
		TO_TANK_ATTACK     = "TankAttack",
		TO_TANK_MOVE       = "",
	
		OnPlayerSeen       = "",
		TO_TANK_EMERGENCYEXIT = "TankEmergencyExit",	
		TO_TANK_IDLE = "TankIdle",	

	},

	TankAlert = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",

		EVERYONE_OUT       = "TankIdle",	
		STOP_VEHICLE 			 = "TankIdle",	
		DRIVER_OUT         = "TankIdle",
		VEHICLE_GOTO_DONE  = "",

		OnFollowPath       = "",
		OnFollowPathLeader = "",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "TankAttack",
		TO_TANK_MOVE       = "",
	
		OnPlayerSeen       = "",
		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	

	},

	TankEmergencyExit = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",

		EVERYONE_OUT       = "TankIdle",	
		STOP_VEHICLE 			 = "TankIdle",	
		DRIVER_OUT         = "TankIdle",
		VEHICLE_GOTO_DONE  = "",

		OnFollowPath       = "",
		OnFollowPathLeader = "",

		TO_TANK_ALERT      = "",
		TO_TANK_ALERT2     = "",
		TO_TANK_ATTACK     = "TankAttack",
		TO_TANK_MOVE       = "",

		OnPlayerSeen       = "",

		TO_TANK_EMERGENCYEXIT = "",	
		TO_TANK_IDLE = "TankIdle",	

	},
	
}
