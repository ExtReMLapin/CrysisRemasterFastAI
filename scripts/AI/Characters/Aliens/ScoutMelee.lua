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
--  - 11/12/2004   : Created by Kirill Bulatsev
--  - 05/04/2005   : CXP Rush Clean up by Mikko Mononen
--  - 01/07/2005   : New naming convention.
--	- 29/11/2005   : Revised for new attack patterns by Tetsuji Iwasaki
--	- 15/01/2007   : branched as a melee scout by Tetsuji
--------------------------------------------------------------------------

AICharacter.ScoutMelee = {

	ScoutMeleeIdle = {
		TO_SCOUTMELEE_IDLE					= "",
		TO_SCOUTMELEE_ATTACK				= "ScoutMeleeAttack",
		TO_SCOUTMELEE_PATROL				= "ScoutMeleePatrol",
	},	
	ScoutMeleeAttack = {
		TO_SCOUTMELEE_IDLE					= "ScoutMeleeIdle",
		TO_SCOUTMELEE_ATTACK				= "",
		TO_SCOUTMELEE_PATROL				= "ScoutMeleePatrol",
	},
	ScoutMeleePatrol = {
		TO_SCOUTMELEE_IDLE					= "ScoutMeleeIdle",
		TO_SCOUTMELEE_ATTACK				= "ScoutMeleeAttack",
		TO_SCOUTMELEE_PATROL				= "",
	},

}
