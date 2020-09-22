--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character SCRIPT for CarConvoy - this is non combat ground vehicle, capable of transporting, moving on path,
-- moving in convoy
--  
--------------------------------------------------------------------------
--  History:
--  - 29/11/2004   : Created by Kirill Bulatsev
--  - 17/07/2006   : This file is not under maintainance any more. Tetsuji
--------------------------------------------------------------------------

AICharacter.CarConvoy = {

	CarConvoyIdle = {
		-----------------------------------
	},

	CarIdle = {
		-----------------------------------
		GO_PATH = "Car_path",
		GO_FOLLOW = "Car_follow",
		OnFollowPath = "VehicleFollowPath",
		OnFollowPathLeader = "VehicleFollowPathLeader",
	},
	
	Car_path = {
		-----------------------------------
			DRIVER_OUT = "CarIdle",
			EVERYONE_OUT = "CarIdle",
	},
	Car_follow = {
		-----------------------------------
			DRIVER_OUT = "CarIdle",
			EVERYONE_OUT = "CarIdle",
			OnFollowPath = "VehicleFollowPath",
			OnFollowPathLeader = "VehicleFollowPathLeader",
	},
	
	VehicleFollowPath = {
		-----------------------------------
			DRIVER_OUT = "CarIdle",
			EVERYONE_OUT = "CarIdle",
			OnPlayerSeen = "",
			OnFollowPath = "VehicleFollowPath",
	},
	VehicleFollowPathLeader = {
		-----------------------------------
			DRIVER_OUT = "CarIdle",
			EVERYONE_OUT = "CarIdle",
			OnPlayerSeen = "",
			OnFollowPath = "VehicleFollowPath",
	},
}