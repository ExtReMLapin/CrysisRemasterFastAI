--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2005.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character SCRIPT for basic PatrolBoat (small, armed) 
--  
--------------------------------------------------------------------------
--  History:
--  -  25/07/2005  : Created by Kirill Bulatsev
--
--------------------------------------------------------------------------

AICharacter.PatrolBoat = {

	AnyBehavior = {
		STOP_VEHICLE = "PatrolBoatIdle",
	},

	PatrolBoatIdle = {
		STOP_VEHICLE      = "",
		EVERYONE_OUT      = "",
		DRIVER_OUT        = "",
		OnPlayerSeen      = "PatrolBoatAttack2",
		OnSomethingSeen   = "PatrolBoatAttack2",
		ACT_GOTO          = "PatrolBoatGoto",
		TO_PATROLBOAT_ALERT     = "",
		TO_PATROLBOAT_ATTACK    = "PatrolBoatAttack",
		TO_PATROLBOAT_ATTACK2   = "PatrolBoatAttack2",
		VEHICLE_GOTO_DONE = "",
	},

	PatrolBoatGoto = {
		STOP_VEHICLE      = "PatrolBoatIdle",
		EVERYONE_OUT      = "PatrolBoatIdle",
		DRIVER_OUT        = "PatrolBoatIdle",
		OnPlayerSeen      = "PatrolBoatAttack2",
		OnSomethingSeen   = "PatrolBoatAttack2",
		ACT_GOTO          = "",
		FOLLOW            = "",
		TO_PATROLBOAT_ALERT     = "",
		TO_PATROLBOAT_ATTACK    = "PatrolBoatAttack",
		TO_PATROLBOAT_ATTACK2   = "PatrolBoatAttack2",
		VEHICLE_GOTO_DONE = "PatrolBoatIdle",
	},

	PatrolBoatAttack = {
		STOP_VEHICLE      = "PatrolBoatIdle",
		EVERYONE_OUT      = "PatrolBoatIdle",
		DRIVER_OUT        = "PatrolBoatIdle",
		OnPlayerSeen      = "",
		OnSomethingSeen   = "",
		ACT_GOTO          = "",
		FOLLOW            = "",
		TO_PATROLBOAT_ALERT     = "PatrolBoatAlert",
		TO_PATROLBOAT_ATTACK    = "",
		TO_PATROLBOAT_ATTACK2   = "PatrolBoatAttack2",
		VEHICLE_GOTO_DONE = "",
	},

	PatrolBoatAttack2 = {
		STOP_VEHICLE      = "PatrolBoatIdle",
		EVERYONE_OUT      = "PatrolBoatIdle",
		DRIVER_OUT        = "PatrolBoatIdle",
		OnPlayerSeen      = "",
		OnSomethingSeen   = "",
		ACT_GOTO          = "",
		FOLLOW            = "",
		TO_PATROLBOAT_ALERT     = "PatrolBoatAlert",
		TO_PATROLBOAT_ATTACK    = "PatrolBoatAttack",
		TO_PATROLBOAT_ATTACK2   = "",
		VEHICLE_GOTO_DONE = "",
	},

	PatrolBoatAlert = {
		STOP_VEHICLE      = "PatrolBoatIdle",
		EVERYONE_OUT      = "PatrolBoatIdle",
		DRIVER_OUT        = "PatrolBoatIdle",
		OnPlayerSeen      = "",
		OnSomethingSeen   = "",
		ACT_GOTO          = "",
		FOLLOW            = "",
		TO_PATROLBOAT_ALERT     = "",
		TO_PATROLBOAT_ATTACK    = "PatrolBoatAttack",
		TO_PATROLBOAT_ATTACK2   = "PatrolBoatAttack2",
		VEHICLE_GOTO_DONE = "",
	},

}