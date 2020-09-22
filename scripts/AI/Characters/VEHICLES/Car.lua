--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2005.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character SCRIPT for basic Car (4 wheeled vehicle) 
-- this is non combat ground vehicle
--  
--------------------------------------------------------------------------
--  History:
--  - 17/05/2005   : Created by Luciano Morpurgo
--
--------------------------------------------------------------------------

AICharacter.Car = {

	AnyBehavior = {
		STOP_VEHICLE = "CarIdle",
	},
	
	CarIdle = {
		-----------------------------------
		GO_PATH            = "Vehicle_Path",
		FOLLOW             = "Car_follow",
		ACT_GOTO           = "CarGoto",
		EVERYONE_OUT       = "",
		STOP_VEHICLE 			 = "",
		DRIVER_OUT         = "",
		VEHICLE_GOTO_DONE  = "",
		OnFollowPath       = "VehicleFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",
		OnPlayerSeen       = "CarAlerted",
		TO_CAR_SKID				 = "CarSkid",
	},

	CarAlerted = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",
		EVERYONE_OUT       = "",
		STOP_VEHICLE 			 = "CarIdle",
		DRIVER_OUT         = "CarIdle",
		VEHICLE_GOTO_DONE  = "",
		OnFollowPath       = "",
		OnFollowPathLeader = "",
		OnPlayerSeen       = "",
		TO_CAR_SKID				 = "CarSkid",
		-----------------------------------
		OnNoTarget         = "CarIdle",
	},

	CarGoto = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "Car_follow",
		ACT_GOTO           = "",
		EVERYONE_OUT       = "CarIdle",
		STOP_VEHICLE 			 = "CarIdle",
		DRIVER_OUT         = "CarIdle",
		VEHICLE_GOTO_DONE  = "CarIdle",
		OnFollowPath       = "",
		OnFollowPathLeader = "",
		OnPlayerSeen       = "CarAlerted",
		TO_CAR_SKID				 = "CarSkid",
	},
	
	Car_path = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",
		EVERYONE_OUT       = "CarIdle",
		STOP_VEHICLE 			 = "CarIdle",
		DRIVER_OUT         = "CarIdle",
		VEHICLE_GOTO_DONE  = "",
		OnFollowPath       = "",
		OnFollowPathLeader = "",
		OnPlayerSeen       = "",
		TO_CAR_SKID				 = "CarSkid",
	},

	Car_follow = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "CarGoto",
		EVERYONE_OUT       = "CarIdle",
		STOP_VEHICLE 			 = "CarIdle",
		DRIVER_OUT         = "CarIdle",
		VEHICLE_GOTO_DONE  = "",
		OnFollowPath       = "VehicleFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",
		OnPlayerSeen       = "",
		TO_CAR_SKID				 = "CarSkid",
	},
	
	VehicleFollowPath = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",
		EVERYONE_OUT       = "CarIdle",
		STOP_VEHICLE 			 = "CarIdle",
		DRIVER_OUT         = "CarIdle",
		VEHICLE_GOTO_DONE  = "",
		OnFollowPath       = "VehicleFollowPath",
		OnFollowPathLeader = "",
		OnPlayerSeen       = "",
		TO_CAR_SKID				 = "CarSkid",
	},

	VehicleFollowPathLeader = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",
		EVERYONE_OUT       = "CarIdle",
		STOP_VEHICLE 			 = "CarIdle",
		DRIVER_OUT         = "CarIdle",
		VEHICLE_GOTO_DONE  = "",
		OnFollowPath       = "VehicleFollowPath",
		OnFollowPathLeader = "",
		OnPlayerSeen       = "",
		TO_CAR_SKID				 = "CarSkid",
	},

	CarSkid = {
		-----------------------------------
		GO_PATH            = "",
		FOLLOW             = "",
		ACT_GOTO           = "",
		EVERYONE_OUT       = "CarIdle",
		STOP_VEHICLE 			 = "CarIdle",
		DRIVER_OUT         = "CarIdle",
		VEHICLE_GOTO_DONE  = "",
		OnFollowPath       = "",
		OnFollowPathLeader = "",
		OnPlayerSeen       = "",

		TO_CAR_IDLE        = "CarIdle",
		TO_CAR_SKID				 = "",
	},

}
