-- FP HOSTAGE CHARACTER

AICharacter.Hostage = {

	Class = UNIT_CLASS_CIVILIAN,

	Constructor = function(self,entity)
		AIBehaviour.HostageIdle:Constructor(entity);
	end,
		
	AnyBehavior = {
		RESUME_FOLLOWING	= "HostageFollow",
		ORDER_HIDE = "HostageHideSquad",
		ORDER_HIDE_FIRE = "HostageHideSquad",
		ENTERING_VEHICLE = "EnteringVehicle",
		ORDER_FIRE = "",
		ORDER_FOLLOW_FIRE = "HostageHideSquad",
		ORDER_FORM		="HostageFollow",
		ORDER_FOLLOW	="HostageFollow",
		RETRIEVE_OBJECT	="HostageRetrieve",
		ORDER_FOLLOW_HIDE ="HostageFollowHide",
		GO_TO_DUMB = "Dumb",
		GO_TO_PREVIOUS = "PREVIOUS",
		OnExplosionDanger		= "HBaseGrenadeRun",
	},

	
	HostageIdle = {
		OnPlayerSeen    	= "",
		OnInterestingSoundHeard = "",
		OnSomethingSeen		= "",
		ORDER_HIDE = "",
	--	OnThreateningSoundHeard = "HostageHide",


--		OnBulletRain		= "HostageHide",
--		OnDamage	= "HostageHide",
--		OnEnemyDamage	= "HostageHide",
--		OnFriendlyDamage	= "HostageHide",
--
--		OnGroupMemberDied	= "",
--		OnGrenadeSeen		= "HostageHide",
--		INCOMING_FIRE		= "HostageHide",
--
--		ORDER_HOLD	 = "HostageHideSquad",
--		ORDER_MOVE	 = "HostageMove",		
		
	},


	HostageFollow = {	
		OnPlayerSeen			="",
		-----------------------------------
		--odresr here

		--ORDER_FORM		="HostageFollow",--do not remove this, needed for following while in combat
		ORDER_FORM		="",
		ORDER_FOLLOW  ="",
		FOLLOW_ME_HERE = "HostageFollowed",
		ORDER_FOLLOW_HIDE ="HostageFollowHide",
		GO_TO_HIDE = "HostageHide",
		OnEnemyDamage = "HostageHide",
--		ORDER_USE	 = "HostageUse",
	},

	HostageHide = {	
		ORDER_FORM		="HostageFollow",
		ORDER_HOLD = "HostageHide",
		ORDER_FOLLOW_HIDE ="HostageFollowHide",
	},

	HostageFollowed = {	
		REFPOINT_REACHED = "HostageIdle",
		ENTERING_VEHICLE = "",
	},
	
	HostageHideSquad = {	
		--ORDER_FOLLOW		="HostageFollow",
		ORDER_FOLLOW		="HostageFollow",
		ORDER_FORM  ="HostageFollow",
		GO_TO_FOLLOW		="HostageFollow",
		ORDER_FOLLOW_HIDE ="HostageFollowHide",
		--ORDER_FOLLOW_FIRE = "HostageFollow",
	},

	HostageRetrieve = {
		OnExplosionDanger = "",
		IGNORE_THREATS = "Dumb",
	},
--	HostageMove = {	
--		ORDER_HOLD	 = "HostageHide",
--		ORDER_FORM		="HostageFollow",
--		ORDER_MOVE	 = "HostageMove",		
--		ORDER_FOLLOW_HIDE ="HostageFollowHide",
--	},

	CivilianCower = {
	
	},

	EnteringVehicle = {
--		REFPOINT_REACHED = "InVehicle",
		entered_vehicle	= "InVehicle",
		exited_vehicle	= "HostageFollow",
	},

	HostageTied = {
		ORDER_FORM		="HostageFollow",
		ORDER_FOLLOW_HIDE ="HostageFollowHide",
	},

	HBaseGrenadeRun = {
		GRENADE_END_REACTION = "",
		GRENADE_END_REACTION_GROUP = "",
		ORDER_HIDE = "",
		USE_MOUNTED_WEAPON = "",
		ORDER_FIRE = "",
		OnPlayerSeen    	= "",
		OnBulletRain		= "",
		OnInterestingSoundHeard = "",
		OnThreateningSoundHeard = "",
		entered_vehicle	="",
		exited_vehicle	="",
		exited_vehicle_investigate = "",
		OnSomethingSeen			="",
		OnExplosionDanger = "",
		END_BACKOFF = "",
		OnExplosion = "",
	},
	
		Dumb = {
		GO_TO_IDLE =							"HostageIdle",
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
	},
}