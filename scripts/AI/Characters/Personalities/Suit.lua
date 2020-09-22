-- COVER CHARACTER SCRIPT

AICharacter.Suit = {

	Class = UNIT_CLASS_INFANTRY,
	
	Constructor = function(self,entity)
	end,
	
	AnyBehavior = {
		ENTERING_VEHICLE =				"EnteringVehicle",
		RETURN_TO_FIRST =					"FIRST",
		USE_MOUNTED_WEAPON = 			"",
		USE_MOUNTED_WEAPON_INIT = "UseMountedIdle",
		GO_TO_DUMB =							"Dumb",
		OnFallAndPlay =						"HBaseTranquilized",

		TO_ATTACK				= "SuitAttack",
		TO_PROTECT			= "SuitProtect",
		TO_THREATENED		= "SuitThreatened",
	},
	
	HBaseAlerted = {
			
	},
	
	HBaseTranquilized = {
		GO_TO_IDLE =							"SuitIdle",
		RESUME_FOLLOWING =				"",
		ENTERING_VEHICLE =				"",
		USE_MOUNTED_WEAPON =			"",
		OnPlayerSeen =						"",
		OnTankSeen =							"",
		OnHeliSeen =							"",
		OnBulletRain =						"",
		OnGrenadeSeen =						"",
		OnInterestingSoundHeard =	"",
		OnThreateningSoundHeard =	"",
		entered_vehicle	=					"",
		exited_vehicle =					"",
		exited_vehicle_investigate = "",
		OnSomethingSeen =					"",
		GO_TO_AVOIDEXPLOSIVES =   "",
	},
	
	UseMounted = {
		ORDER_HIDE = "",
		ORDER_FIRE = "",
		USE_MOUNTED_WEAPON = "",
		ACT_GOTO = "SuitIdle",
		ACT_FOLLOWPATH = "SuitIdle",
	},

	UseMountedIdle = {
		USE_MOUNTED_WEAPON = "",
		--OnPlayerSeen = "UseMounted",
		--OnEnemyDamage = "UseMounted",
		--OnBulletRain = "UseMounted",
		TO_USE_MOUNTED = "UseMounted",
		TOO_FAR_FROM_WEAPON = "SuitIdle",
		ACT_GOTO = "SuitIdle",
		ACT_FOLLOWPATH = "SuitIdle",
	},

	SuitIdle = {
		-----------------------------------
		-- Vehicles related
		entered_vehicle = "InVehicle",
		exited_vehicle 	= "PREVIOUS",
	},

	SuitThreatened = {
	},

	SuitAttack = {
	},

	SuitProtect = {
	},

	
	-- Vehicles related signals
	-- there are some cases that you have to mask signals when you add in AnyBehavior.
	-- these charactors also should be supported for cover2/Sneaker/Camper 10/07/2006 tetsuji

	EnteringVehicle = {
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",
		TO_ATTACK				= "",
		TO_ATTACK_GROUP	= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_THREATENED_STANDBY = "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		entered_vehicle = "InVehicle",
		entered_vehicle_gunner = "InVehicleGunner",
		OnFallAndPlay    = "InVehicleTranquilized",
	},


	InVehicle = {

		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",

		OnPlayerSeen =						"InVehicleAlerted",
		OnTankSeen =							"",
		OnHeliSeen =							"",
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
		TO_ATTACK_GROUP	= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_THREATENED_STANDBY = "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_AVOID_TANK		= "",

		controll_vehicle = "InVehicleControlled",

		OnFallAndPlay    = "InVehicleTranquilized",
	},
	
	InVehicleAlerted = {
		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",

		OnPlayerSeen =						"",
		OnTankSeen =							"",
		OnHeliSeen =							"",
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
		TO_ATTACK_GROUP	= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_THREATENED_STANDBY = "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_AVOID_TANK		= "",

		controll_vehicle = "InVehicleControlled",
		OnFallAndPlay    = "InVehicleTranquilized",
	},

	InVehicleGunner = {

		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",

		OnPlayerSeen =						"",
		OnTankSeen =							"",
		OnHeliSeen =							"",
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
		TO_ATTACK_GROUP	= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_THREATENED_STANDBY = "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_AVOID_TANK		= "",

		controll_vehicleGunner = "InVehicleControlledGunner",

		OnFallAndPlay    = "InVehicleTranquilized",
	},

	InVehicleControlledGunner = {	
		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",

		OnPlayerSeen =						"",
		OnTankSeen =							"",
		OnHeliSeen =							"",
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
		TO_ATTACK_GROUP	= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_THREATENED_STANDBY = "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_AVOID_TANK		= "",

		OnFallAndPlay    = "InVehicleTranquilized",
	},

	InVehicleControlled = {	
		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",

		OnPlayerSeen =						"",
		OnTankSeen =							"",
		OnHeliSeen =							"",
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
		TO_ATTACK_GROUP	= "",
		TO_HIDE					= "",
		TO_THREATENED		= "",
		TO_THREATENED_STANDBY = "",
		TO_INTERESTED		= "",
		TO_SEEK					= "",
		TO_SEARCH				= "",
		TO_AVOID_TANK		= "",

		OnFallAndPlay    = "InVehicleTranquilized",
	},

	Dumb = {
		GO_TO_IDLE =							"SuitIdle",
		RESUME_FOLLOWING =				"",
		ENTERING_VEHICLE =				"",
		USE_MOUNTED_WEAPON =			"",
		OnPlayerSeen =						"",
		OnTankSeen =							"",
		OnHeliSeen =							"",
		OnBulletRain =						"",
		OnGrenadeSeen =						"",
		OnInterestingSoundHeard =	"",
		OnThreateningSoundHeard =	"",
		entered_vehicle	=					"",
		exited_vehicle =					"",
		exited_vehicle_investigate = "",
		OnSomethingSeen =					"",
	},
}
