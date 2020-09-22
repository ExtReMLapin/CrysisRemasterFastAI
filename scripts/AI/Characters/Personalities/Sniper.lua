----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: SNIPER CHARACTER SCRIPT
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 30:nov:2005   : Created by Kirill Bulatsev
--
----------------------------------------------------------------------------------------------------´



AICharacter.Sniper = {

	Class = UNIT_CLASS_INFANTRY,
	
	AnyBehavior = {
		RETURN_TO_FIRST = "FIRST",
		USE_MOUNTED_WEAPON = "UseMounted",
		USE_MOUNTED_WEAPON_INIT = "UseMountedIdle",
		OnExplosionDanger		= "HBaseGrenadeRun",
		GRENADE = "HBaseGrenadeRun",
--		GO_TO_ALERT = "SniperAlert",

	},

	SniperIdle = {
		on_spot = "SniperSnipe",
			
--		HEADS_UP_GUYS		= "SniperHide",	
--		OnPlayerSeen    	= "SniperSnipe",
--		OnInterestingSoundHeard = "",
--		OnSomethingSeen		= "",
--		GET_ALERTED	 = "SniperHide",
--		NORMAL_THREAT_SOUND 	= "SniperMove",
--		OnThreateningSoundHeard = "CoverThreatened",

--		OnBulletRain		= "SniperHide",
--		OnEnemyDamage	= "SniperHide",
--		OnDamage	= "CamperAlert",
--		OnGroupMemberDiedNearest 	= "",

--		OnSomebodyDied	= "SniperAlert",
--		OnGrenadeSeen		= "SniperAlert",
--		INCOMING_FIRE		= "SniperHide",
		-----------------------------------


		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
--		exited_vehicle = "PREVIOUS",
	},
	
	

	SniperAlert = {
		OnPlayerSeen    	= "SniperMove",
		OnInterstingSoundHeard  = "",
		OnThreateningSoundHeard  = "",

		HEADS_UP_GUYS		= "SniperMove",	

		OnEnemyDamage	= "SniperHide",
		OnDamage	= "SniperHide",
		SniperCloseContact = "CamperAttack",		

		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
		
		-- pre combat
	},

	SniperSnipe= {
--		OnNoHidingPlace = "CoverHold",
		OnNoTarget		= "",
		relocate = "SniperMove",
		SniperCloseContact = "CamperAttack",
		
		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
		--OnLowHideSpot	= "DigIn",
	},

	SniperMove= {
		on_spot = "SniperSnipe",
		SniperCloseContact = "CamperAttack",
		OnEnemyDamage = "CamperAttack",
	},

	SniperHide= {
		SniperCloseContact = "CamperAttack",

--		OnNoHidingPlace = "CoverHold",
--		OnNoTarget		= "CamperAlert",
		
		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
		--OnLowHideSpot	= "DigIn",

	},

	CamperAttack= {
		OnTargetFleeing = "SniperMove",
	},

	UseMounted = {
		ORDER_HIDE = "",
		ORDER_FIRE = "",
		USE_MOUNTED_WEAPON = "",
		ACT_GOTO = "SniperIdle",
		ACT_FOLLOWPATH = "SniperIdle",
	},

	UseMountedIdle = {
		USE_MOUNTED_WEAPON = "",
		--OnPlayerSeen = "UseMounted",
		--OnEnemyDamage = "UseMounted",
		--OnBulletRain = "UseMounted",
		TO_USE_MOUNTED = "UseMounted",
		TOO_FAR_FROM_WEAPON = "SniperIdle",
		ACT_GOTO = "SniperIdle",
		ACT_FOLLOWPATH = "SniperIdle",
	},

	HBaseGrenadeRun = {
		GRENADE_RUN_OVER = "CoverAlert",
		RESUME_FOLLOWING	= "",
		ORDER_HIDE = "",
		ENTERING_VEHICLE = "",
		ORDER_USE_RPG = "",
		USE_MOUNTED_WEAPON = "",
		ORDER_FIRE = "",
		OnPlayerSeen    	= "",
		OnBulletRain		= "",
		OnGrenadeSeen		= "",
		OnInterestingSoundHeard = "",
		OnThreateningSoundHeard = "",
		entered_vehicle	="",
		exited_vehicle	="",
		exited_vehicle_investigate = "",
		ORDER_HOLD	 = "",
		ORDER_FORM		="",
		ORDER_FOLLOW_HIDE		="",
		ORDER_MOVE	 = "",	
		ORDER_ENTER_VEHICLE = "",	
		ORDER_PLANT_BOMB = "",	
		OnSomethingSeen			="",
		OnExplosionDanger = "",
		
	},


	-- JOBS
	Job_WalkFollow = {
		ORDER_FOLLOW = "",
	},

	InVehicleTranquilized = {
		OnFallAndPlayWakeUp = 		"PREVIOUS",
		OnFallAndPlay			= "",
		RESUME_FOLLOWING =				"",
		ENTERING_VEHICLE =				"",
		USE_MOUNTED_WEAPON =			"",
		OnPlayerSeen =						"",
		OnBulletRain =						"",
		OnGrenadeSeen =						"",
		OnInterestingSoundHeard =	"",
		OnThreateningSoundHeard =	"",
		entered_vehicle	=					"",
		exited_vehicle =					"",
		exited_vehicle_investigate = "",
		OnSomethingSeen =					"",
		GO_TO_SEEK =							"",
		GO_TO_IDLE = 							"",
		GO_TO_SEARCH =						"",
		GO_TO_ATTACK =						"",
		GO_TO_AVOIDEXPLOSIVES =   "",
		GO_TO_ALERT =							"",
		GO_TO_CHECKDEAD =					"",
	},


}
