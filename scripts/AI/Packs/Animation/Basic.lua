

ANIMATIONPACK.Basic = {

	IN_POSITION_FRONT = {
				{
				PROBABILITY = 1000,
				animationName = "combat_signalInposition_rifle_front_01",
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
		  },
---------------------------------------------------------------------------------
	IN_POSITION_LEFT = {
				{
				PROBABILITY = 1000,
				animationName = "combat_signalInposition_rifle_left_01",
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
		  },
---------------------------------------------------------------------------------
	IN_POSITION_RIGHT = {
				{
				PROBABILITY = 1000,
				animationName = "combat_signalInposition_rifle_right_01",
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
		  },
---------------------------------------------------------------------------------
	IN_POSITION_BACK = {
				{
				PROBABILITY = 1000,
				animationName = "combat_signalInposition_rifle_right_01", -- "right" animation is actually "back"
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
		  },
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

	HIDE_END_EFFECT = {
				{
				PROBABILITY = 1000,
				animationName = "rollfwd",
				duration = 1.5,
				layer = 4,
				blend_time = 0.13,
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
	IDLE_TO_THREATENED= {
				{
				PROBABILITY = 1000,
				animationName = "first_contact",
				duration = 1.5,
				layer = 0,
				blend_time = 0.13,
				},
		  },
---------------------------------------------------------------------------------
	I_NO_SEE_YOU = {
				{
				PROBABILITY = 1000,
				animationName = "enemy_target_lost",
				duration = 1.5,
				layer = 0,
				blend_time = 0.13,
				},
		  },
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
---------------------------------------------------------------------------------
	THREATEN = {
				{
				PROBABILITY = 1000,
				animationName = "first_contact",
				duration = 1.5,
				layer = 0,
				blend_time = 0.13,
				},
		  },
-----------------------------------------------------------------------------------
	ACT_SURPRISED = {
	--AI reacts to unexpected event such as player seen
				{
				PROBABILITY = 100,
				animationName = "suprise01",
				duration = 0,
				layer = 1,
				blend_time = 0.3,
				},
				{
				PROBABILITY = 100,
				animationName = "suprise02",
				duration = 0,
				layer = 1,
				blend_time = 0.3,
				},
				{
				PROBABILITY = 100,
				animationName = "suprise03",
				duration = 0,
				layer = 1,
				blend_time = 0.3,
				},

			 },
------------------------------------------------------------------------------------
	RESPOND_DOWN = {
	--Team member responds to one of their team members down, eg call for help
				{
				PROBABILITY = 100,
				animationName = "suprise01",
				duration = 0,
				layer = 1,
				blend_time = 0.3,
				}
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
--------------------------------------------------------------------------
-- CXP related stuff
--------------------------------------------------------------------------
	CONVOY_SPOTTED = {
				{
				PROBABILITY = 1000,
				animationName = "stand_rifle_talk_pointing",
				Volume = 255,
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
	
	},
	
	OUTPOST_SIGHTED = {
				{
				PROBABILITY = 1000,
				animationName = "stand_rifle_talk_pointing",
				Volume = 255,
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
	
	},
		
	HAWKER_INTRO  = {
				{
				PROBABILITY = 1000,
				animationName = "special_hawker_intro_m01",
				Volume = 255,
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
	},

	SYKES_INTRO  = {
				{
				PROBABILITY = 1000,
				animationName = "special_sykes_intro_m01",
				Volume = 255,
				duration = 0,
				layer = 6,
				blend_time = 0.3,
				},
	},

	bulletrain  = {
			{
				PROBABILITY = 250,
				animationName = "flinch",
			},
	},

	melee_weapon_punch = {
			{
				PROBABILITY = 1000,
				animationName = "weaponPunch",
			},
	},

--	flashbang_hit  = {
--			{
--				PROBABILITY = 1000,
--				animationName = "blinded",
--			},
--	},

--	smoke_hit  = {
--			{
--				PROBABILITY = 1000,
--				animationName = "choke",
--			},
--	},

	signalAdvance  = {
			{
				PROBABILITY = 1000,
				animationName = "signalAdvance",
			},
	},

	signalMove  = {
			{
				PROBABILITY = 1000,
				animationName = "signalMove",
			},
	},


}