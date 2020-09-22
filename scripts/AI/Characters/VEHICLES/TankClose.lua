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

AICharacter.TankClose = {
	
	Constructor = function(self,entity)	
--		entity.AI.DesiredFireDistance[1] = 30; -- main gun
--		entity.AI.DesiredFireDistance[2] = 6; -- secondary machine gun
		entity.AI.weaponIdx = 1; --temp: select main gun by default
	end,
	
	AnyBehavior = {
		STOP_VEHICLE = "TankCloseIdle",
	},
	
	TankCloseIdle = {
		-----------------------------------
		FOLLOW              = "TankCloseFollow",
		ACT_GOTO            = "TankCloseGoto",

		EVERYONE_OUT        = "",
		STOP_VEHICLE 			  = "",
		DRIVER_OUT          = "",
		VEHICLE_GOTO_DONE   = "",

		TO_TANKCLOSE_ATTACK   	= "TankCloseAttack",
		TO_TANKCLOSE_GOTOPATH 	= "TankCloseGotoPath",
		TO_TANKCLOSE_SWITCHPATH = "TankCloseSwitchPath",
		TO_TANKCLOSE_RUNAWAY = "TankCloseRunAway",
		TO_TANKCLOSE_IDLE				= "",

		OnPlayerSeen        = "",		

	},
	
	TankCloseFollow = {
		-----------------------------------
		FOLLOW              = "",
		ACT_GOTO            = "TankCloseGoto",

		EVERYONE_OUT        = "TankCloseIdle",
		STOP_VEHICLE 			  = "TankCloseIdle",
		DRIVER_OUT          = "TankCloseIdle",
		VEHICLE_GOTO_DONE   = "TankCloseIdle",

		TO_TANKCLOSE_ATTACK   	= "",
		TO_TANKCLOSE_GOTOPATH 	= "",
		TO_TANKCLOSE_SWITCHPATH = "",
		TO_TANKCLOSE_RUNAWAY = "",
		TO_TANKCLOSE_IDLE				= "",
	
		OnPlayerSeen        = "TankCloseAttack",		

	},

	TankCloseGoto = {
		-----------------------------------
		FOLLOW              = "TankCloseFollow",
		ACT_GOTO            = "",

		EVERYONE_OUT        = "TankCloseIdle",
		STOP_VEHICLE 			  = "TankCloseIdle",
		DRIVER_OUT          = "TankCloseIdle",
		VEHICLE_GOTO_DONE   = "TankCloseIdle",

		TO_TANKCLOSE_ATTACK   	= "",
		TO_TANKCLOSE_GOTOPATH 	= "",
		TO_TANKCLOSE_SWITCHPATH = "TankCloseSwitchPath",
		TO_TANKCLOSE_RUNAWAY 		= "TankCloseRunAway",
		TO_TANKCLOSE_IDLE				= "",
	
		OnPlayerSeen        = "TankCloseAttack",		

	},

	TankCloseAttack = {
		-----------------------------------
		FOLLOW              = "",
		ACT_GOTO            = "",

		EVERYONE_OUT        = "TankCloseIdle",
		STOP_VEHICLE 			  = "TankCloseIdle",
		DRIVER_OUT          = "TankCloseIdle",
		VEHICLE_GOTO_DONE   = "TankCloseIdle",

		TO_TANKCLOSE_ATTACK   	= "",
		TO_TANKCLOSE_GOTOPATH 	= "",
		TO_TANKCLOSE_SWITCHPATH = "TankCloseSwitchPath",
		TO_TANKCLOSE_RUNAWAY 		= "TankCloseRunAway",
		TO_TANKCLOSE_IDLE				= "",
	
		OnPlayerSeen        = "",		

	},

	TankCloseGotoPath = {
		-----------------------------------
		FOLLOW              = "",
		ACT_GOTO            = "",

		EVERYONE_OUT        = "TankCloseIdle",
		STOP_VEHICLE 			  = "TankCloseIdle",
		DRIVER_OUT          = "TankCloseIdle",
		VEHICLE_GOTO_DONE   = "TankCloseIdle",

		TO_TANKCLOSE_ATTACK   	= "",
		TO_TANKCLOSE_GOTOPATH 	= "",
		TO_TANKCLOSE_SWITCHPATH = "TankCloseSwitchPath",
		TO_TANKCLOSE_RUNAWAY 		= "TankCloseRunAway",
		TO_TANKCLOSE_IDLE				= "TankCloseIdle",

		OnPlayerSeen        = "TankCloseAttack",

	},

	TankCloseSwitchPath = {
		-----------------------------------
		FOLLOW              = "",
		ACT_GOTO            = "",

		EVERYONE_OUT        = "TankCloseIdle",
		STOP_VEHICLE 			  = "TankCloseIdle",
		DRIVER_OUT          = "TankCloseIdle",
		VEHICLE_GOTO_DONE   = "TankCloseIdle",

		TO_TANKCLOSE_ATTACK   = "TankCloseAttack",
		TO_TANKCLOSE_GOTOPATH = "",
		TO_TANKCLOSE_SWITCHPATH = "",
		TO_TANKCLOSE_RUNAWAY 		= "TankCloseRunAway",
		TO_TANKCLOSE_IDLE			= "TankCloseIdle",

		OnPlayerSeen        = "",

	},

	TankCloseRunAway = {
		-----------------------------------
		FOLLOW              = "",
		ACT_GOTO            = "",

		EVERYONE_OUT        = "TankCloseIdle",
		STOP_VEHICLE 			  = "TankCloseIdle",
		DRIVER_OUT          = "TankCloseIdle",
		VEHICLE_GOTO_DONE   = "TankCloseIdle",

		TO_TANKCLOSE_ATTACK   = "",
		TO_TANKCLOSE_GOTOPATH = "",
		TO_TANKCLOSE_SWITCHPATH = "",
		TO_TANKCLOSE_RUNAWAY 		= "",
		TO_TANKCLOSE_IDLE			= "TankCloseIdle",

		OnPlayerSeen        = "",

	},


}
