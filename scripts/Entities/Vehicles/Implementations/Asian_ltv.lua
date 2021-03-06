--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2006.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Implementation of Asian LTV
--  
--------------------------------------------------------------------------
--  History:
--  - 31-03-2006   : Created by Michael Rauh
--
--------------------------------------------------------------------------


--------------------------------------------------------------------------


--------------------------------------------------------------------------
Asian_ltv =
{
	
	Properties = 
	{	
		bDisableEngine = 0,
		material = "",
		bFrozen = 0,
		Modification = "",
		FrozenModel = "",
		soclasses_SmartObjectClass = "",
	},
	
	Client = {},
	Server = {},
}



--------------------------------------------------------------------------


Asian_ltv.AIProperties = 
{
	-- AI attributes
  AIType = AIOBJECT_CAR,
  PropertiesInstance = 
  {
    aibehavior_behaviour = "CarIdle",
  },
  Properties = 
  {
    aicharacter_character = "Car",
  },
  AIMovementAbility = 
  {
		walkSpeed = 7.0,
		runSpeed = 15.0,
		sprintSpeed = 25.0,
		maneuverSpeed = 7.0,
		maneuverTrh = 0.0,
	  minTurnRadius = 4,
    maxTurnRadius = 15,    
    pathType = AIPATH_CAR,
		pathLookAhead = 8,
		pathRadius = 2,
		pathSpeedLookAheadPerSpeed = 3.0,
		cornerSlowDown = 0.75,
		pathFindPrediction = 1.0,
    velDecay = 130,
		resolveStickingInTrace = 0,
		pathRegenIntervalDuringTrace = 4.0,
		avoidanceRadius = 10.0,
  },     
	hidesUser=0,    
}

