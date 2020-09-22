--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2005.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character SCRIPT for basic Boat (small, armed) 
--  
--------------------------------------------------------------------------
--  History:
--  -  25/07/2005  : Created by Kirill Bulatsev
--
--------------------------------------------------------------------------

AICharacter.Boat = {

	AnyBehavior = {
		STOP_VEHICLE = "BoatIdle",
	},

	BoatIdle = {
		STOP_VEHICLE      = "",
		EVERYONE_OUT      = "",
		DRIVER_OUT        = "",
		OnPlayerSeen      = "",
		ACT_GOTO          = "BoatGoto",
		FOLLOW            = "",
		TO_BOAT_ALERT     = "";
		TO_BOAT_ATTACK    = "";
		VEHICLE_GOTO_DONE = "",
	},

	BoatGoto = {
		STOP_VEHICLE      = "BoatIdle",
		EVERYONE_OUT      = "BoatIdle",
		DRIVER_OUT        = "BoatIdle",
		OnPlayerSeen      = "",
		ACT_GOTO          = "",
		FOLLOW            = "",
		TO_BOAT_ALERT     = "";
		TO_BOAT_ATTACK    = "";
		VEHICLE_GOTO_DONE = "BoatIdle",
	},

	BoatAttack = {
		STOP_VEHICLE      = "BoatIdle",
		EVERYONE_OUT      = "BoatIdle",
		DRIVER_OUT        = "BoatIdle",
		OnPlayerSeen      = "",
		ACT_GOTO          = "",
		FOLLOW            = "",
		TO_BOAT_ALERT     = "";
		TO_BOAT_ATTACK    = "";
		VEHICLE_GOTO_DONE = "",
	},

	BoatAlert = {
		STOP_VEHICLE      = "BoatIdle",
		EVERYONE_OUT      = "BoatIdle",
		DRIVER_OUT        = "BoatIdle",
		OnPlayerSeen      = "",
		ACT_GOTO          = "",
		FOLLOW            = "",
		TO_BOAT_ALERT     = "";
		TO_BOAT_ATTACK    = "";
		VEHICLE_GOTO_DONE = "",
	},

}