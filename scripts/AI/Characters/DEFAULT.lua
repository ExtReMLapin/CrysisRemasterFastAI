-- COVER CHARACTER SCRIPT

AICharacter.DEFAULT = {

	NoBehaviorFound = {

		-- BE CAREFUL: signals are processed here only if the current behaviour
		-- is not found below

		GOING_TO_TRIGGER = "RunToAlarm",

		-----------------------------------
		-- Vehicles related
		entered_vehicle = "InVehicle",
		entered_vehicle_gunner = "InVehicleGunner",
		

	--	CONVERSATION_REQUEST = "Idle_Talk",
	--	CONVERSATION_REQUEST_INPLACE = "Idle_Talk",
--		STARTING_CONVERSATION_INPLACE = "Idle_Talk",
--		CONVERSATION_FINISHED = "FIRST",


		--SWITCH_TO_MORTARGUY = "MountedGuy",

		IGNORE_ALL_ELSE         = "SharedReinforce",
		SWITCH_TO_RUN_TO_FRIEND = "RunToFriend",

		BackToJob			 = "FIRST",
		BackToPrevious = "PREVIOUS",

		GO_INTO_WAIT_STATE  = "SharedReinforce",

		SPECIAL_LEAD 	= "SpecialLead",
		SPECIAL_FOLLOW 	= "SpecialFollow",
		SPECIAL_DUMB	= "SpecialDumb",
		SPECIAL_HOLD	= "SpecialHold",
		SPECIAL_STOPALL	= "FIRST",

		START_SWIMMING  = "Swim",
		STOP_SWIMMING  = "PREVIOUS",

		RUSH_TARGET = "SpecialDumb",
		STOP_RUSH = "PREVIOUS",

		RETREAT_NOW	= "SharedRetreat",
		RETREAT_NOW_PHASE2	= "SharedRetreat",

--		START_CLIMBING = "ClimbLadder",
--		STOP_CLIMBING  = "PREVIOUS",
		
		ORDER_SEARCH = "",
		OnEndFollow = "Job_StandIdle",
		
		FASTKILL = "FastKill",
		
		ACT_DIALOG 			= "Dialog",
	},

	GroupSearch = {
		ORDER_SEARCH = "",
	},
	
	-----------------------------------
	-- Vehicles related
	InVehicle = {	
		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",
	},

	EnteringVehicle = {
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",
	},

	InVehicleGunner = {	
		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",
		controll_vehicleGunner = "InVehicleControlledGunner",
	},

	InVehicleControlledGunner = {	
		exited_vehicle_investigate = "Job_Investigate",
		exited_vehicle = "FIRST",
		do_exit_vehicle= "FIRST",
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

	UseMountedTranquilized = {
		OnFallAndPlayWakeUp = 		"UseMountedIdle",
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
	
	RunToAlarm = {
		EXIT_RUNTOALARM = "PREVIOUS",
	},

	RunToFriend = {
		OnPlayerSeen = "PREVIOUS",
		OnThreateningSoundHeard = "PREVIOUS",
		RETREAT_NOW	= "SharedRetreat",
		RETREAT_NOW_PHASE2	= "SharedRetreat",
		SWITCH_TO_MORTARGUY = "MountedGuy",
		FINISH_RUN_TO_FRIEND = "PREVIOUS",
	},

	DigIn = {	
		OnReload		= "PREVIOUS",
		OnReceivingDamage	= "PREVIOUS",
		TO_PREVIOUS 		= "PREVIOUS",
		RETREAT_NOW	= "SharedRetreat",
		RETREAT_NOW_PHASE2	= "SharedRetreat",

	},

--	Idle_Smoking = {
--		BackToJob			= "FIRST",
--	},


	SharedRetreat = 
	{
		STOP_RETREATING = "PREVIOUS",
	},

	SharedReinforce = 
	{
		JoinGroup	= "PREVIOUS",
		OFFER_JOIN_TEAM	= "PREVIOUS",
		RETURN_TO_PREVIOUS = "PREVIOUS",
		EXIT_WAIT_STATE = "FIRST",
	},


	LeanFire = {	
		OnReload		= "PREVIOUS",
		OnReceivingDamage	= "PREVIOUS",
		TO_PREVIOUS 		= "PREVIOUS",
		KEEP_FORMATION 		= "PREVIOUS",
		IGNORE_ALL_ELSE         = "SharedReinforce",
		RETREAT_NOW	= "SharedRetreat",
		RETREAT_NOW_PHASE2	= "SharedRetreat",

	},

	FastKill = {
		FASTKILL_EXIT  = "PREVIOUS",
		TO_SEEK =					"",
	},
		
	Dialog = {
		ACT_DIALOG_OVER	= "PREVIOUS",
	},

}