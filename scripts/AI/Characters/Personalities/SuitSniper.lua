-- SUIT SNIPER CHARACTER SCRIPT

AICharacter.SuitSniper = {

	Class = UNIT_CLASS_INFANTRY,
	TeamRole = GU_HUMAN_SNEAKER_SPECOP,
	
	Constructor = function(self,entity)
		AI.NotifyGroupTacticState(entity.id, 0, GN_INIT, 0);
		
		if ( entity.actor ~= nil ) then
			local flinch = 0.8 - (System.GetCVar("g_difficultyLevel") * 0.15);
			entity.actor:SetFlinchFactor(flinch);
		end
	end,
	
	AnyBehavior = {
		ENTERING_VEHICLE =				"EnteringVehicle",
		RETURN_TO_FIRST =					"FIRST",
		USE_MOUNTED_WEAPON = 			"",
		USE_MOUNTED_WEAPON_INIT = "UseMountedIdle",
		GO_TO_DUMB =							"Dumb",
		OnFallAndPlay =						"HBaseTranquilized",

		TO_ATTACK				= "SuitSniperAttack",
		TO_THREATENED		= "SuitSniperThreatened",
	},
	
	HBaseAlerted = {
			
	},
	
	HBaseTranquilized = {
		GO_TO_IDLE =							"SuitSniperIdle",
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
		ACT_GOTO = "SuitSniperIdle",
		ACT_FOLLOWPATH = "SuitSniperIdle",
	},

	UseMountedIdle = {
		USE_MOUNTED_WEAPON = "",
		--OnPlayerSeen = "UseMounted",
		--OnEnemyDamage = "UseMounted",
		--OnBulletRain = "UseMounted",
		TO_USE_MOUNTED = "UseMounted",
		TOO_FAR_FROM_WEAPON = "SuitSniperIdle",
		ACT_GOTO = "SuitSniperIdle",
		ACT_FOLLOWPATH = "SuitSniperIdle",
	},

	SuitSniperIdle = {
		-----------------------------------
		-- Vehicles related
		entered_vehicle = "InVehicle",
		exited_vehicle 	= "PREVIOUS",
	},

	SuitSniperThreatened = {
	},

	SuitSniperAttack = {
	},

	SuitSniperProtect = {
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
		GO_TO_IDLE =							"SuitSniperIdle",
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
