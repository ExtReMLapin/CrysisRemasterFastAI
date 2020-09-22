-- CIVILIAN CHARACTER
-- Civilian has a species, he's scared by enemy but 
-- he is unarmed and hides in presence of them
-- he can help his comrades to spot the enemy
-- History:
--	created by: Luciano Morpurgo

AICharacter.Civilian = {

	Class = UNIT_CLASS_CIVILIAN,
	
	AnyBehavior = {
		OnPlayerSeen    	= "CivilianAlert",
		OnInterestingSoundHeard = "",
		OnSomethingSeen		= "",
		OnThreateningSoundHeard = "CivilianAlert",
		OnDamage	= "",
		OnEnemyDamage	= "CivilianHide",
		OnFriendlyDamage	= "",

		OnGroupMemberDied	= "",
		OnExplosionDanger		= "HBaseGrenadeRun",
		INCOMING_FIRE		= "CivilianHide",
		GET_ALERTED = "",
		SURRENDER = "CivilianSurrender",
		GO_TO_HIDE = "CivilianHide",
		GO_TO_COWER= "CivilianCower",
		ENTERING_VEHICLE = "EnteringVehicle",
		entered_vehicle = "InVehicle",
		exited_vehicle 	= "PREVIOUS",

	},


	CivilianIdle = {
		END_TIMEOUT = "CivilianHide",
--		OnBulletRain		= "CivilianCower",
--		OnEnemyDamage		= "CivilianCower",
--		OnNearMiss		= "CivilianCower",
		
	},

	CivilianAlert = {
		OnPlayerSeen    	= "",
		OnBulletRain		= "",
		OnEnemyDamage		= "",
	},

	CivilianSurrender = {
		OnPlayerSeen    	= "",
		SURRENDER = "",
		SET_FREE = "CivilianHide",
	},


	HBaseGrenadeRun = {
		OnPlayerSeen    	= "",
	},
	
	CivilianHide = {	
		OnPlayerSeen    	= "",
		OnNoHidingPlace    	= "CivilianCower",
	},
	
	CivilianCower = {	
		OnPlayerSeen    	= "",
	},

	EnteringVehicle = {
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",
		TO_ATTACK				= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_ATTACK				= "",
		entered_vehicle = "InVehicle",
		entered_vehicle_gunner = "InVehicle",
	},
	
	InVehicle = {

		exited_vehicle_investigate = "FIRST",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",

		OnPlayerSeen =						"",
		OnInterestingSoundHeard =	"",
		OnSomethingSeen =					"",
		GET_ALERTED =							"",
		OnBulletRain =						"",
		OnEnemyDamage	=						"",
		OnDamage =								"",
		OnGroupMemberDied	=				"",
		INCOMING_FIRE =						"",
		HEADS_UP_GUYS =						"",
		GO_TO_HIDE =							"",

		TO_ATTACK				= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_ATTACK				= "",

	},
	
	InVehicleGunner = {

		exited_vehicle_investigate = "FIRST",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",

		OnPlayerSeen =						"",
		OnInterestingSoundHeard =	"",
		OnSomethingSeen =					"",
		GET_ALERTED =							"",
		OnBulletRain =						"",
		OnEnemyDamage	=						"",
		OnDamage =								"",
		OnGroupMemberDied	=				"",
		INCOMING_FIRE =						"",
		HEADS_UP_GUYS =						"",
		GO_TO_HIDE =							"",

		TO_ATTACK				= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_ATTACK				= "",

		controll_vehicleGunner = "",

	},

	
}