--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character script for Trooper Leader Drone
--  
--------------------------------------------------------------------------
--  History:
--  - 8/2/2006   : Created by Luciano Morpurgo
--
--------------------------------------------------------------------------

AICharacter.TrooperLeader = {

	Constructor = function(self,entity)
		entity.AI.FireMode = 0;
		entity.AI.bIsLeader = true;
	end,
	
	AnyBehavior = {
		RETURN_TO_FIRST			= "FIRST",
		ORDER_FORM				= "TrooperForm",
		ORDER_MOVE				= "TrooperMove",
		MOVE							= "TrooperMove",
		ORDER_APPROACH = "TrooperApproach",
		ORDER_SEARCH = "TrGroupSearch",
		ORDER_COVER_SEARCH = "TrGroupCoverSearch",
		ORDER_HIDE_AROUND = "TrooperLeaderAttack",
		ORDER_FLANK				= "TrooperAttackFlank",
		ORDER_FIRE 				= "TrooperLeaderFire",
		GO_TO_AMBUSH			= "TrooperAmbush",
		GO_TO_DUMB				= "TrooperDumb",
		DODGE							= "TrooperDodge",
		ORDER_COORDINATED_FIRE1 = "TrooperLeaderCollectiveFire",
		ORDER_COORDINATED_FIRE2 = "TrooperCollectiveFire2",
	},



	TrooperApproach = {
			ORDER_APPROACH = "",
	},
	
	TrooperAttackFlank = {
	},

	TrooperJump = {
		OnPlayerSeen = "TrooperAttack",
		JUMP_TO = "PREVIOUS",
	},
	
	TrGroupSearch = {
		ORDER_SEARCH = "",
	},

	TrGroupCoverSearch = {
	},

	TrooperLure = {
		JOIN_TEAM					= "",
		GO_TO_AMBUSH			= "",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	TrooperForm = {
		ORDER_FLANK				= "TrooperAttackFlank",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	TrooperMove = {
		ORDER_FLANK				= "TrooperAttackFlank",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	
	TrooperLeaderAttack = {
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	TrooperLeaderFire = {
		GO_TO_DUMB				= "TrooperGroupDumb",
	},
	

	TrooperLeaderIdle = {
		ORDER_MOVE				= "TrooperMove",
		ORDER_FORM				= "TrooperForm",
		GO_TO_INTERESTED  = "TrooperGroupInterested",
		GO_TO_DUMB				= "TrooperGroupDumb",
--		OnEnemySeenByUnit = "TrooperLeaderPreAttack",
	},
	
	TrooperLeaderPreAttack = {
		ORDER_MOVE				= "TrooperMove",
		ORDER_FORM				= "TrooperForm",
		GO_TO_INTERESTED  = "TrooperGroupInterested",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},

	TrooperLeaderCollectiveFire = 
	{ 
	},


	TrooperAmbush = {
		JOIN_TEAM = "",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},
	
--	TrooperGroupIdle = {
--		ORDER_MOVE				= "TrooperMove",
--		ORDER_FORM				= "TrooperForm",
--		GO_TO_INTERESTED  = "TrooperGroupInterested",
--		GO_TO_DUMB				= "TrooperGroupDumb",
--	},

	TrooperGroupInterested = {
		ORDER_MOVE				= "TrooperMove",
		ORDER_FORM				= "TrooperForm",
		GO_TO_DUMB				= "TrooperGroupDumb",
	},
	

	TrooperCollectiveFire2 = {

	},
	
	TrooperDodge = {	
		GO_TO_GROUP_ATTACK = "TrooperLeaderAttack",
	},
}

