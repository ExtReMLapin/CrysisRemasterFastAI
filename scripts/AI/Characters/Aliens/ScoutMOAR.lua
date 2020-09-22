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
--	- 15/01/2007   : branched as a MOAR scout by Tetsuji
--------------------------------------------------------------------------

AICharacter.ScoutMOAR = {

	ScoutMOARIdle = {
		TO_SCOUTMOAR_IDLE					= "",
		TO_SCOUTMOAR_ATTACK				= "ScoutMOARAttack",
		TO_SCOUTMOAR_PATROL				= "ScoutMOARPatrol",
	},	
	ScoutMOARAttack = {
		TO_SCOUTMOAR_IDLE					= "ScoutMOARIdle",
		TO_SCOUTMOAR_ATTACK				= "",
		TO_SCOUTMOAR_PATROL				= "ScoutMOARPatrol",
	},
	ScoutMOARPatrol = {
		TO_SCOUTMOAR_IDLE					= "ScoutMOARIdle",
		TO_SCOUTMOAR_ATTACK				= "ScoutMOARAttack",
		TO_SCOUTMOAR_PATROL				= "",
	},

}
