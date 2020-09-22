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
--	- 15/01/2007   : branched as a MOAC scout by Tetsuji
--------------------------------------------------------------------------

AICharacter.ScoutMOAC = {

	ScoutMOACIdle = {
		TO_SCOUTMOAC_IDLE					= "",
		TO_SCOUTMOAC_ATTACK				= "ScoutMOACAttack",
		TO_SCOUTMOAC_PATROL				= "ScoutMOACPatrol",
	},	
	ScoutMOACAttack = {
		TO_SCOUTMOAC_IDLE					= "ScoutMOACIdle",
		TO_SCOUTMOAC_ATTACK				= "",
		TO_SCOUTMOAC_PATROL				= "ScoutMOACPatrol",
	},
	ScoutMOACPatrol = {
		TO_SCOUTMOAC_IDLE					= "ScoutMOACIdle",
		TO_SCOUTMOAC_ATTACK				= "ScoutMOACAttack",
		TO_SCOUTMOAC_PATROL				= "",
	},

}
