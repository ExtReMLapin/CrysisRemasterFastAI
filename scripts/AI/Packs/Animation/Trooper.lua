

ANIMATIONPACK.Trooper = {

---------------------------------------------------------------------------------
	FOLLOW_ME = {
				{
				PROBABILITY = 1000,
				animationName = "combat_signalFollow_rifle_01",
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
		  },

---------------------------------------------------------------------------------
	I_SEE_YOU = {
				{
				PROBABILITY = 1000,
				animationName = "first_contact",
				duration = 1.5,
				layer = 0,
				blend_time = 0.13,
				},
		  },
---------------------------------------------------------------------------------
	IDLE_TO_INTERESTED= {
				{
				PROBABILITY = 1000,
				animationName = "first_contact",
				duration = 1.5,
				layer = 0,
				blend_time = 0.13,
				},
		  },
---------------------------------------------------------------------------------
	REBOOT= {
				{
				PROBABILITY = 1000,
				animationName = "reboot",
				Persistent = 1,
				},
		  },
------------------------------------------------------------------------------------
	END_REBOOT = {
	--clears any persistent readability animation
				{
				PROBABILITY = 1000,
				animationName = "none",
				Persistent = 1,
				}
			},

		  
---------------------------------------------------------------------------------
--	IDLE_TO_THREATENED= {
--				{
--				PROBABILITY = 1000,
--				animationName = "threaten",
--				--Persistent = 1,
--				},
--		  },

---------------------------------------------------------------------------------
	I_HEAR_YOU = {
				{
				PROBABILITY = 1000,
				animationName = "sSoundheard",
				duration = 1.5,
				layer = 0,
				blend_time = 0.13,
				},
		  },
------------------------------------------------------------------------------------
	FIRST_CONTACT = {
	--The enemy has some kind of contact with a target, but has yet to establish whether it is a hostile or a friendly one.	
				{
				PROBABILITY = 100,
				animationName = "first_contact",
				duration = 0,
				layer = 1,
				blend_time = 0.3,
				}
			},
------------------------------------------------------------------------------------
	FIRST_HOSTILE_CONTACT = {
	--The enemy has some kind of contact with a target, but has yet to establish whether it is a hostile or a friendly one.	
				{
				PROBABILITY = 100,
				animationName = "first_contact",
				duration = 0,
				layer = 1,
				blend_time = 0.3,
				}
			},
------------------------------------------------------------------------------------
	ENEMY_TARGET_LOST = {
	--The enemy lost the contact with his immediate hostile target.
				{
				PROBABILITY = 100,
				animationName = "enemy_target_lost",
				duration = 0,
				layer = 1,
				blend_time = 0.3,
				}
			},
------------------------------------------------------------------------------------
	CALL_REINFORCEMENTS = {
	--The enemy lost the contact with his immediate hostile target.
				{
				PROBABILITY = 500,
				animationName = "reinforcements_wave1",
				duration = 0,
				layer = 4,
				blend_time = 0.3,
				},

				{
				PROBABILITY = 500,
				animationName = "reinforcements_wave2",
				duration = 0,
				layer = 4,
				blend_time = 0.3,
				}
			},
------------------------------------------------------------------------------------
	STOP_MOVING = {
	--The enemy lost the contact with his immediate hostile target.
				{
				PROBABILITY = 1000,
				animationName = "stand_signal_rifle_wait",
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				}
			},
------------------------------------------------------------------------------------
	MELEE = {
	--The enemy lost the contact with his immediate hostile target.
				{
				PROBABILITY = 1000,
				animationName = "meleeAttack",
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				}
			},
------------------------------------------------------------------------------------
	FIREMODE0 = {
	--Select fire mode 1 animation
				{
				PROBABILITY = 1000,
				animationName = "fireMode01",
				--Persistent = 1,
				}
			},
------------------------------------------------------------------------------------
	FIREMODE1 = {
	--Select fire mode 2 animation
				{
				PROBABILITY = 1000,
				animationName = "fireMode02",
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				}
			},

------------------------------------------------------------------------------------
	clear = {
	--clears any persistent readability animation
				{
				PROBABILITY = 1000,
				animationName = "none",
				Persistent = 1,
				}
			},
			


}