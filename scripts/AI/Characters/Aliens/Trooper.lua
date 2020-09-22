--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character script for Trooper Drone
--  
--------------------------------------------------------------------------
--  History:
--  - 1/7/2005   : Created by Mikko Mononen
--
--------------------------------------------------------------------------

AICharacter.Trooper = {

	Constructor = function(self,entity)
		entity.AI.FireMode = 0;
		if(not AI.GetLeader(entity.id)) then
			AI.SetLeader(entity.id);
		end
	end,
	
	AnyBehavior = {
		RETURN_TO_FIRST			= "FIRST",
		ORDER_FORM				= "TrooperForm",
		ORDER_MOVE				= "TrooperMove",
		MOVE							= "TrooperMove",
		JOIN_TEAM					= "TrooperGroupIdle",
		ORDER_APPROACH = "TrooperApproach",
		ORDER_SEARCH = "TrGroupSearch",
		ORDER_COVER_SEARCH = "TrGroupCoverSearch",
		ORDER_HIDE_AROUND = "TrooperGroupCombat",--"TrooperHideShoot"
		ORDER_FLANK				= "TrooperAttackFlank",
		ORDER_FIRE 				= "TrooperGroupFire",
		GO_TO_THREATENED	= "TrooperThreatened",
		GO_TO_INTERESTED = "TrooperInterested",
		GO_TO_AMBUSH			= "TrooperAmbush",
		GO_TO_DUMB				= "TrooperDumb",
		GO_TO_SEARCH			= "TrooperSearch",
		GO_TO_ATTACK			= "TrooperAttack",
		GO_TO_DEFENSE			= "TrooperDefend",
		GO_TO_MOAR				= "TrooperAttackMoar",
		GO_TO_DODGE				= "TrooperDodge",
		GO_TO_RETREAT			= "TrooperRetreat",
		GO_TO_GRABBED			= "TrooperGrabbedByScout",
		GO_TO_IDLE				= "TrooperIdle",
		GO_TO_ATTACK_JUMP	= "TrooperAttackJump",
		OnAttackChase			= "TrooperChase",
		DODGE_GRENADE			= "TrooperDodgeGrenade",
		OnExplosionDanger	= "TrooperAvoidExplosion",
		PURSUE						= "TrooperAttackPursue",
		OnAttackShootSpot		= "TrooperShootOnSpot",
		GO_TO_ON_ROCK	= "TrooperShootOnRock",
		GO_TO_ON_WALL	= "TrooperShootOnWall",
		OnAttackSwitchPosition = "TrooperAttackSwitchPosition",
		OnSpecialAction = "TrooperAttackSpecialAction",
		GO_TO_SPECIAL_ACTION= "TrooperAttackSpecialAction",
--		OnSpecialAction = "TrooperAttackSwitchPosition",
--		GO_TO_SPECIAL_ACTION= "TrooperAttackSwitchPosition",
		OnFallAndPlay =						"HBaseTranquilized",	

--		GO_TO_ALERTED = "TrooperIdleAlerted",
	},

	TrooperChase = {
		OnAttackChase = "",
--		OnAttackSwitchPosition = "",
	},

	TrooperRetreat = {
		OnAttackChase = "",
		OnAttackShootSpot = "",
		OnAttackSwitchPosition = "",
		GO_TO_ATTACK = "TrooperAttack",
		RETREAT_OK = "TrooperHide",
		REGROUP = "TrooperAttack",
	},

	TrooperHide = {
		OnAttackChase = "",
		OnAttackShootSpot = "",
		OnAttackSwitchPosition = "",
		REGROUP = "TrooperAttack",
	},

	
	TrGroupSearch = {
		ORDER_SEARCH = "",
	},

	TrGroupCoverSearch = {
	},


	

	TrooperIdle = {
		--OnInterestingSoundHeard = "TrooperInterested",
		--GET_ALERTED	 				= "TrooperAlert",
--		HEADS_UP_GUYS				= "TrooperAttack",
	},
	
	TrooperInterested = {	
		OnPlayerSeen    		= "TrooperAttack",
		--OnThreateningSoundHeard = "TrooperThreatened",
--		OnBulletRain				= "TrooperAlert",
		--OnGroupMemberDied		= "TrooperAlert",
		--OnObjectSeen				= "TrooperAlert",
		RETURN_TO_FIRST			= "FIRST",
	},

	TrooperThreatened = {
		OnPlayerSeen    		= "TrooperAttack",
		--OnNoTarget					= "TrooperAlert",
		RETURN_TO_FIRST			= "FIRST",
	},

	TrooperAlert = {
		OnPlayerSeen    		= "TrooperAttack",
		OnInterestingSoundHeard  = "",
		OnThreateningSoundHeard  = "",
	},

	TrooperAttack = {
		GO_TO_SEARCH			= "TrooperSearch",
		GO_TO_INTERESTED = "",
		GO_TO_THREATENED = "",
		--OnAttackShootSpot = "",
	},

	TrooperAttackSwitchPosition = {
--		OnNoTarget					= "TrooperSearch",
--		LOOK_FOR_TARGET			= "TrooperSearch",
		GO_TO_JUMP = "",
		GO_TO_MELEE				= "TrooperAttackSwitchPositionMelee",
		OnAttackSwitchPosition = "",
		GO_TO_SWITCH_POSITION = "TrooperAttackSwitchPosition",

		--OnPlayerLooking = "",
		--OnPlayerLooking = "TrooperDodge",
	},

	TrooperAttackSwitchPositionMelee = {
		END_MELEE = "TrooperAttackSwitchPosition",
		MELEE_FAILED = "TrooperAttackSwitchPosition",
		OnAttackShootSpot = "",
		OnAttackSwitchPosition = "",
		OnLand = "TrooperAttackSwitchPosition",
		BackToSwitchPosition = "TrooperAttackSwitchPosition",
	},

	TrooperAttackSpecialAction = {
		--END_MELEE = "TrooperAttackSwitchPosition",
		MELEE_FAILED = "TrooperAttackSwitchPosition",
		--GO_TO_MELEE				= "TrooperAttackSwitchPositionMelee",

		OnAttackShootSpot = "",
		OnAttackSwitchPosition = "",
		OnLand = "",
		OnSpecialAction = "",
		BackToSwitchPosition = "TrooperAttackSwitchPosition",
	},


	TrooperShootOnSpot = {
		GO_TO_MELEE				= "TrooperAttackSwitchPositionMelee",

	},

	TrooperShootOnRock = {
		OnSpecialAction = "",
		OnAttackSwitchPosition = "",
		GO_TO_SWITCH_POSITION = "TrooperAttackSwitchPosition",
--		GO_TO_SPECIAL_ACTION= "TrooperAttackSpecialAction",
	},

	TrooperShootOnWall = {
		OnSpecialAction = "",
		OnAttackSwitchPosition = "",
		GO_TO_SWITCH_POSITION = "TrooperAttackSwitchPosition",
	--	GO_TO_SPECIAL_ACTION= "TrooperAttackSpecialAction",
	},



	TrooperAttackMoar = {
		OnAttackSwitchPosition = "",
		OnAttackShootSpot = "",
		GO_TO_MOAR				= "",
		GO_TO_ON_SPOT = "TrooperShootOnSpot",
		OnSpecialAction = "",
	},
	
	TrooperAttackPursue = {
--		OnNoTarget					= "TrooperSearch",
--		LOOK_FOR_TARGET			= "TrooperSearch",
	},

	TrooperGrabbedByScout= {
		GO_TO_INTERESTED = "",
		--GO_TO_ATTACK = "",
		OnAttackSwitchPosition = "",
		GO_TO_SWITCH_POSITION = "TrooperAttackSwitchPosition",
		OnAttackShootSpot = "",
		GO_TO_MOAR				= "",
		GO_TO_ON_SPOT = "TrooperShootOnSpot",
		GO_TO_SPECIAL_ACTION = "TrooperAttackSpecialAction",
		OnSpecialAction = "",
		GO_TO_ON_ROCK = "",
		GO_TO_ON_WALL = "",
		ORDER_SEARCH = "",
		ORDER_COVER_SEARCH = "",
		GO_TO_SEARCH = "TrGroupSearch",
		GO_TO_MELEE = "",
		GO_TO_DODGE = "",
		GO_TO_ATTACK_JUMP	= "",
		OnAttackChase			= "",
		OnExplosionDanger	= "",
		PURSUE						= "",
		OnFallAndPlay =		"",	
		GRABBED_TO_INTERESTED = "TrooperInterested",
		GRABBED_TO_ATTACK = "TrooperAttack",
		--ORDER_SEARCH = "",
	},

	-- Search job, use idle transitions.	
	TrooperSearch = {	
		OnPlayerSeen = "TrooperAttack",
		HIDESPOT_NOT_FOUND = "TrooperIdle",
		GO_TO_IDLE = "TrooperIdle",
		SpotReached = "TrooperAttack",
	},

	TrooperDumb = {	
		GO_TO_SEARCH = "TrooperSearch",
		DODGE							= "",
		DODGE_GRENADE			= "",
		OnExplosionDanger	= "",
	},
	
	TrooperDodge = {	
		DODGE_FAILED = "TrooperAttackSwitchPosition",
		DODGE_FINISHED = "TrooperAttackSwitchPosition",
		OnAttackSwitchPosition = "",
		OnAttackShootSpot		= "",
		END_DODGE_FORWARD= "TrooperAttackSpecialAction",
	},

	TrooperAvoidExplosion = {
		DODGE							= "",
		DODGE_GRENADE			= "",
		OnExplosionDanger	= "",
		PURSUE = "",
	},
		
	TrooperAttackJump = {
--		OnLand = "TrooperAttackSwitchPosition",
		OnAttackSwitchPosition = "",
		OnSpecialAction = "",
		OnAttackShootSpot = "",
		JUMP_ON_ROCK = "",		
		JUMP_ON_WALL = "",		
		GO_TO_SWITCH_POSITION = "TrooperAttackSwitchPosition",
--		GO_TO_SPECIAL_ACTION= "TrooperAttackSpecialAction",
		GO_TO_ON_SPOT = "TrooperShootOnSpot",
	},

	HBaseTranquilized = {
		GO_TO_IDLE =							"TrooperIdle",
		OnFallAndPlayWakeUp = 		"TrooperAttack",
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

	--- Old behaviors--------------------------------------------------------------------------------
	
	TrooperLure = {
		JOIN_TEAM					= "",
		GO_TO_AMBUSH			= "",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},
	
	TrooperAvoidExplosion2 = {
		DODGE							= "",
		DODGE_GRENADE			= "",
		OnExplosionDanger	= "",
		PURSUE = "",
		OnAttackSwitchPosition = "",
		BackToSwitchPosition = "TrooperAttackSwitchPosition",
		
	},
	TrooperForm = {
--		ORDER_ATTACK_FORMATION = "TrooperAttackFormation",
		ORDER_FLANK				= "TrooperAttackFlank",
		GO_TO_DUMB				= "TrooperGroupDumb",
--		OnLeaderDied = "TrooperBerserk",
	},

	TrooperMove = {
--		ORDER_ATTACK_FORMATION = "TrooperAttackFormation",
		ORDER_FLANK				= "TrooperAttackFlank",
		GO_TO_DUMB				= "TrooperGroupDumb",
--		OnLeaderDied = "TrooperBerserk",
	},

--	TrooperAttackFormation = {
--		OnLeaderDied = "TrooperAttack",
--		ORDER_FLANK				= "TrooperAttackFlank",
----		ORDER_HIDE_AROUND = "TrGroupCombat",
--	},

	TrooperHideShoot = {
	},
	
	TrooperGroupCombat = {
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	TrooperGroupFire = {
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	TrooperCollectiveFire1 = {

	},

	TrooperCollectiveFire2 = {

	},

	
	TrooperAmbush = {
		JOIN_TEAM = "",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},
	
	TrooperGroupIdle = {
		ORDER_MOVE				= "TrooperMove",
		ORDER_FORM				= "TrooperForm",
		GO_TO_INTERESTED  = "TrooperGroupInterested",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	TrooperGroupInterested = {
		ORDER_MOVE				= "TrooperMove",
		ORDER_FORM				= "TrooperForm",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},
	TrooperApproach = {
			ORDER_APPROACH = "",

	},
	
	TrooperAttackFlank = {
			--OnLeaderDied = "TrooperBerserk",
	},

	TrooperJump = {
		OnPlayerSeen = "TrooperAttack",
		JUMP_TO = "PREVIOUS",
	},
	

}

