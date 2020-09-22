-- the prisoner - do nothing

AICharacter.Prisoner = {

	Class = UNIT_CLASS_CIVILIAN,
	
	AnyBehavior = {
		RESUME_FOLLOWING	= "",
		ORDER_HIDE = "",
		ORDER_FIRE = "",
		ORDER_HOLD	 = "",
		ORDER_MOVE	 = "",		
		ORDER_FORM		="",
		ORDER_FOLLOW_HIDE ="",
		-----------------------------------
		-- Vehicles related
		entered_vehicle = "InVehicle",
		exited_vehicle 	= "PREVIOUS",
		ENTERING_VEHICLE = "EnteringVehicle",
	},


	UnderFire = {
		OnPlayerSeen		 = "",
		OnThreateningSoundHeard  = "",
		RETURN_TO_FIRST		 = "FIRST",
	},

	PrisonerIdle = {
		OnPlayerSeen    	= "",
		OnInterestingSoundHeard = "",
		OnSomethingSeen		= "",
		OnThreateningSoundHeard = "HostageHide",


		OnBulletRain		= "HostageHide",
		OnDamage	= "HostageHide",
		OnEnemyDamage	= "HostageHide",
		OnFriendlyDamage	= "HostageHide",

		OnGroupMemberDied	= "",
		OnGrenadeSeen		= "HostageHide",
		INCOMING_FIRE		= "HostageHide",
	},

	HostageHide = {	
	},

	HostageThreatened = {
		OnPlayerSeen    	= "",
		OnGrenadeSeen		= "",
		back_to			= "FIRST",
	},


	
	EnteringVehicle = {
--		REFPOINT_REACHED = "InVehicle",
		entered_vehicle	= "InVehicle",
		exited_vehicle	= "PrisonerIdle",
	},

}