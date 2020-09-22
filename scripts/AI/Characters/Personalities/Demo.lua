-- CAMPER CHARACTER SCRIPT
-- This suposed to be a very careful soldier, tends to prone/crouch a lot;
-- stays in cover a lot, does not move much
--
--History:
--	created by: Kirill Bulatsev 
--
AICharacter.Demo = {

	Class = UNIT_CLASS_INFANTRY,
	
	AnyBehavior = {
		ENTERING_VEHICLE = "EnteringVehicle",
		OnExplosionDanger		= "HBaseGrenadeRun",
		RETURN_TO_FIRST = "FIRST",
		USE_MOUNTED_WEAPON = "UseMounted",
		ATTACK_TANK_RPG = "HBaseAttackTankRpg",
		ATTACK_TANK_GRENADES = "HBaseAttackTankGrenades",
		HIDE_FROM_TANK = "CamperHide",
	},

	DemoIdle = {
		HEADS_UP_GUYS		= "CamperUnderFire",	
		OnPlayerSeen    	= "DemoShoot",
		OnInterestingSoundHeard = "DemoShoot",
--		OnSomethingSeen		= "DemoShoot",
		GET_ALERTED	 = "",
		NORMAL_THREAT_SOUND 	= "DemoShoot",
--		OnThreateningSoundHeard = "CoverThreatened",

		OnBulletRain		= "",
		OnEnemyDamage	= "",
--		OnDamage	= "CamperAlert",
		OnGroupMemberDiedNearest 	= "",
--		GRENADE		= "HBaseGrenadeRun",

		OnSomebodyDied	= "",
		OnGrenadeSeen		= "",
		INCOMING_FIRE		= "",
		-----------------------------------


		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
--		exited_vehicle = "PREVIOUS",
	},
	
	
--	MountedGuy = {
--		SELECT_RED		= "CoverRedIdle",
--		SELECT_BLACK		= "CoverBlackIdle",
--		CONVERSATION_FINISHED   = "MountedGuy",
--	},

	HBaseAttackTankRpg = {
		OnPlayerSeen    	= "CamperAttack",
		OnSomethingSeen   = "CamperAlert",
		OnThreateningSoundHeard  = "CamperAttack",
		OnInterstingSoundHeard  = "CamperAlert",
		OnCloseContact = "CamperAttack",
	},

	CamperNoTarget = {
		OnPlayerSeen    	= "CamperAttack",
		GO_ATTACK    	= "CamperAttack",
		OnInterstingSoundHeard  = "",
		OnThreateningSoundHeard  = "",

		HEADS_UP_GUYS		= "CamperUnderFire",	

		OnEnemyDamage	= "CamperUnderFire",
		OnDamage	= "CamperUnderFire",

		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
		
		-- pre combat
	},


	CamperAlert = {
		OnPlayerSeen    	= "CamperAttack",
		GO_ATTACK    	= "CamperAttack",
		OnInterstingSoundHeard  = "",
		OnThreateningSoundHeard  = "",

		HEADS_UP_GUYS		= "CamperUnderFire",	

		OnEnemyDamage	= "CamperUnderFire",
		OnDamage	= "CamperUnderFire",

		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
		
		-- pre combat
	},

	CamperHide = {
		REFPOINT_REACHED = "CamperAlert",
		SWITCH_TO_ATTACK = "CamperAttack",
--		OnLowHideSpot	= "DigIn",
	},

	CamperAttack = {
--		OnNoHidingPlace = "CoverHold",
		OnNoTarget		= "CamperNoTarget",
		OnEnemyMemory = "CamperPeek",
		OnLowHideSpot = "HBaseLowHide",
		BACKOFF = "HBaseBackOff",
		
		-----------------------------------
		-- Vehicles related
--		entered_vehicle = "InVehicle",
		--OnLowHideSpot	= "DigIn",
		LEFT_LEAN_ENTER		= "LeanFire",
		RIGHT_LEAN_ENTER	= "LeanFire",
	},

	HBaseBackOff= {
--		REFPOINT_REACHED = "CoverAttack",
		BACKOFF_DONE = "CamperAttack",
		BACKOFF = "",
	},

	HBaseLowHide = {
--		OnNoHidingPlace = "CoverHold",
		BACKOFF = "HBaseBackOff",

		DONT_SEE_TARGET = "CamperPeek",
		OnNoTarget		= "CamperNoTarget",
--		SpotCompromized	= "CamperAttack",	
--		OnEnemyMemory = "CamperPeek",
		OnEnemyMemory = "",	
		
		LEFT_LEAN_ENTER		= "LeanFire",
		RIGHT_LEAN_ENTER	= "LeanFire",
	},


	CamperPeek = {
		OnPlayerSeen    	= "CamperAttack",
		OnNoTarget		= "CamperNoTarget",
		
		OnInterestingSoundHeard = "",
		OnSomethingSeen		= "",
		GET_ALERTED	 = "CamperAttack",
		HOLD_POSITION		= "CamperAttack",
--		NORMAL_THREAT_SOUND 	= "CamperAlert",
--		OnThreateningSoundHeard = "CoverThreatened",

		OnEnemyDamage	= "CamperUnderFire",
--		OnDamage	= "CamperAlert",
--		GRENADE		= "HBaseGrenadeRun",
		INCOMING_FIRE		= "CamperUnderFire",
	},


	CamperUnderFire = {
		OnPlayerSeen    	= "CamperAttack",	
	},

	CheckDead= {
		OnBulletRain		= "",	-- don't react on bullets rain - keep going
		HEADS_UP_GUYS		= "CamperUnderFire",
		be_alerted		= "CamperUnderFire",
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

}
