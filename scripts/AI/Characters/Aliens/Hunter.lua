--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Character SCRIPT for alien outdoors
--  
--------------------------------------------------------------------------
--  History:
--  - 09/05/2005   : Created by Mikko Mononen
--
--------------------------------------------------------------------------

AICharacter.Hunter = {

	HunterIdle = {
		OnPlayerSeen    				= "HunterAttack",
		OnEnemyDamage						= "HunterAttack",
	--	OnThreateningSoundHeard = "HunterAttack",
	--	GO_PATROL								= "HunterPatrol",
	--	GO_ATTACK								= "HunterAttack",
	},

	HunterAttack = {
		OnPlayerSeen    				= "",
--		OnNoHidingPlace 				= "",
		OnNoTarget							= "HunterIdle",
--		OnSoreDamage						= "HunterRecoil",
--		GO_ENEMY_LOST						= "HunterPatrol",
--		GO_RECOIL								= "HunterRecoil",
	},

	HunterPatrol = {
		OnPlayerSeen    				= "HunterAttack",
		OnEnemyDamage						= "HunterAttack",
		OnThreateningSoundHeard = "HunterAttack",
		GO_ENEMY_FOUND					= "HunterAttack",
		GO_ATTACK								= "HunterAttack",
--		GO_SEARCH    						= "HunterSearch",
--		GO_ESCORT								= "HunterEscort",
	},
}
