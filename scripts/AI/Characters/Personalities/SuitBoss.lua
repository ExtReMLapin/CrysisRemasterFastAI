-- COVER CHARACTER SCRIPT

AICharacter.SuitBoss = {

	Class = UNIT_CLASS_INFANTRY,

	selfCollisionDamageMult = 0.25,

	Constructor = function(self,entity)
--		AI.Signal(SIGNALFILTER_SENDER,1,"ConstructorCover2",entity.id);
	end,
	
	AnyBehavior = {
		ENTERING_VEHICLE =				"EnteringVehicle",
		RETURN_TO_FIRST =					"FIRST",
		USE_MOUNTED_WEAPON = 			"UseMounted",
		USE_MOUNTED_WEAPON_INIT = "UseMountedIdle",
		GO_TO_DUMB =							"Dumb",
		GO_TO_AVOIDEXPLOSIVES =   "Cover2AvoidExplosives",
		GO_TO_CHECKDEAD =					"CheckDead",
		TRANQUILIZED =						"HBaseTranquilized",

		TO_ATTACK				= "SuitBossP1",
		TO_PHASE_1B			= "SuitBossP1b",
		TO_PHASE_2			= "SuitBossP2",
		TO_PHASE_3			= "SuitBossP3",
		
		TO_ATTACK_GROUP	= "Cover2AttackGroup",
		TO_RUSH_ATTACK	= "Cover2RushAttack",
		TO_HIDE					= "SuitHide",
		TO_AVOID_TANK		= "Cover2AvoidTank",
		TO_RPG_ATTACK		= "Cover2RPGAttack",
		TO_THREATENED		= "Cover2Threatened",
		TO_THREATENED_STANDBY = "Cover2ThreatenedStandby",
		TO_INTERESTED		= "Cover2Interested",
		TO_SEEK					= "Cover2Seek",
		TO_SEARCH				= "Cover2Search",
		TO_RELOAD				= "SuitReload",
		TO_STEALTH			= "", --"SuitStealth",
		HIDE_DONE				= "SuitBossP1",
		
		TO_STATIC 			= "HBaseStaticShooter"
	},
	
	HBaseAlerted = {
			
	},
	
	HBaseTranquilized = {
		GO_TO_IDLE =							"SuitIdle",
		FALL_AND_PLAY_WAKEUP = 		"HBaseAlerted",
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
		GO_TO_SEEK =							"",
		GO_TO_IDLE = 							"",
		GO_TO_SEARCH =						"",
		GO_TO_ATTACK =						"",
		GO_TO_AVOIDEXPLOSIVES =   "",
		GO_TO_ALERT =							"",
		GO_TO_CHECKDEAD =					"",
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
	

	Cover2AvoidExplosives = {
		GO_TO_IDLE =							"SuitIdle",
		RESUME_FOLLOWING =				"",
		ENTERING_VEHICLE =				"",
		USE_MOUNTED_WEAPON =			"",
		OnPlayerSeen =						"",
		OnBulletRain =						"",
		OnGrenadeSeen =						"",
		OnInterestingSoundHeard =	"",
		OnThreateningSoundHeard =	"",
		OnSomethingSeen =					"",
		OnNoTarget = 							"",
	},

	SuitIdle = {
	
		OnPlayerSeen    = "",
		OnInterestingSoundHeard = "",
		OnSomethingSeen	= "",
		OnThreateningSoundHeard = "",
		OnBulletRain		= "",
		OnNearMiss			= "",
		OnEnemyDamage		= "",
		OnGroupMemberDiedNearest 	= "",
		OnSomebodyDied	= "",
		GET_ALERTED	 		= "",
		HEADS_UP_GUYS		= "",
		OnExplosionDanger		= "HBaseGrenadeRun",
		-----------------------------------
		-- Vehicles related
		entered_vehicle = "InVehicle",
		exited_vehicle 	= "PREVIOUS",
	},

	Cover2Interested = {
	},

	Cover2Threatened = {
	},
	
	SuitHide = {
	},
	
	Cover2AvoidTank = {
	},

	Cover2RPGAttack= {
	},
	
	Cover2Seek = {
	},

	Cover2Search = {
	},

	SuitBossP1 = {
		TO_RELOAD				= "",
	},

	SuitBossP1b = {
		TO_RELOAD				= "",
	},

	SuitReload = {
	},
	
	SuitStealth = {
		OnEnemyDamage	=					"SuitBossP1",	
	},

	Cover2AttackGroup = {
	},
	
	CheckDead= {
		OnPlayerSeen =						"SuitBossP1",
		OnThreateningSoundHeard =	"Cover2Threatened",
		OnInterestingSoundHeard =	"",
		OnSomethingSeen	=					"",
		OnBulletRain =						"SuitHide",
		GET_ALERTED =							"SuitBossP1",
		SEEK_KILLER =							"Cover2Threatened",
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
		TRANQUILIZED    = "InVehicleTranquilized",
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

		TRANQUILIZED    = "InVehicleTranquilized",
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
		TRANQUILIZED    = "InVehicleTranquilized",
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

		TRANQUILIZED    = "InVehicleTranquilized",
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

		TRANQUILIZED    = "InVehicleTranquilized",
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

		TRANQUILIZED    = "InVehicleTranquilized",
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
