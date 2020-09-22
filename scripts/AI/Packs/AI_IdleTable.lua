-- Generic Idle Behaviour Sequence table
-- Created by Luciano Morpurgo (see Job_GenericIdle.lua)

-- Template:

--	SequenceX = { -- name of the Sequence to execute
--		Ignorant =			use GenericPlaySequence behavior instead of GenericIdle
--										difference is in that GenericPlaySequence ignors signals which could stop animation
--										optional (default is 0)
--										0 - allow default processing of signals | 1 - make him ignorant (no default processing)
--		{ --Step 1
-------- all the entries are optional
--			AnchorType =  anchor type to reach; the guy will reach this anchor and will orientate
--										himself like it
--			Run	= 				0 - walk; 1 - Run (default 0)
--			AnimStart = 	start animation name or table (*) (played when the anchor is reached)
--			AnimLoop = 		loop animation name or table (*), 
--			AnimEnd = 		end animation name or table (*),
--			Loop=					number of loops for animation - a number <0 means indefinite loops
--			SeqLoopStart =1 : tags the beginning of a loop in the Sequence; the steps from 
--										this one until the next one containing the "SeqLoop" entry
--										will be looped;
--			SeqLoop = 	number of Sequence loops to play; the sequence will replay from
--										the last step in which SeqLoopStart has been defined; 
--										a number <=0 means indefinite Sequence loop;
--										nested loops are NOT possible
--			SoundStart = 	name of start sound (played when the anchor is reached)
--			SoundLoop = 	name of loop sound (played in after the AnimStart has ended )
--			SoundEnd = 		name of ending sound 
--			SoundSynch = 	true/false ; if true, the SoundLoop is syncronized with animation loop
--										if false or if the AnimLoop is not defined, the SoundLoop loops 
--										according to its duration	(default = true); 
--			EndLoopSignal = this signal is sent to the sender after the loop animation is done
--		},		
--		{ --Step 2 
--			--etc
--		},
--	}, -- end of SequenceX

-- (*) animation can be either a single name, or a table of names,probability pairs:
--		AnimStart = "smoke_start",
--		AnimLoop = {"smoke_loop_01",30, "smoke_loop_02",30, "smoke_loop_03",40},
-- 	if it's a table, the animation will be chosen randomly depending on the probability (in percentage)
--	if it's AnimLoop, the animation will be chosen at each loop
--------------------------
AI_IdleTable = {
	
	
	FixWheel_Smoke = {
		{	AnchorType=AIAnchorTable.IDLE_FIX_WHEEL, --Sequence 1, Step 1
			Run = 0,
			AnimStart = "fixwheel_start",
			AnimLoop = {"fixwheel_loop",80,"fixwheel_idle_01",20},
			AnimEnd = "fixwheel_end",
			SeqLoopStart = 1,
			Loop=8,
		},
		{	AnchorType=AIAnchorTable.IDLE_SMOKE, --Sequence 1, Step 2
			AnimStart = "smoking_start",
			AnimLoop = {"smoking_idle",60, "smoking_01",13, "smoking_02",13, "smoking_03",14},
			AnimEnd = {"smoking_end_01",50,"smoking_end_02",50},
			Loop=8,
			SeqLoop = -1,
		},
	},
	
	
	Idle_Smoke = {
		{	AnchorType=AIAnchorTable.IDLE_SMOKE, --Sequence 1, Step 1
			AnimStart = "smoking_start",
			AnimLoop = {"smoking_idle",60, "smoking_01",13, "smoking_02",13, "smoking_03",14},
			AnimEnd = {"smoking_end_01",50,"smoking_end_02",50},
--			SoundStart = "Sounds/Weapons/Trails/whiz2.wav",
--			SoundLoop = "Sounds/Weapons/Trails/whiz1.wav",
--			SoundEnd = "Sounds/Weapons/Trails/whiz4.wav",
			--SoundSynch = false,
			Loop=1,
			SeqLoop = -1,
		},
	},
	
	IDLE_SMOKE = {
		{	AnchorType=AIAnchorTable.IDLE_SMOKE, --Sequence 1, Step 1
			AnimStart = "smoking_start",
			AnimLoop = {"smoking_idle",60, "smoking_01",13, "smoking_02",13, "smoking_03",14},
			AnimEnd = {"smoking_end_01",50,"smoking_end_02",50},
--			SoundStart = "Sounds/Weapons/Trails/whiz2.wav",
--			SoundLoop = "Sounds/Weapons/Trails/whiz1.wav",
--			SoundEnd = "Sounds/Weapons/Trails/whiz4.wav",
			--SoundSynch = false,
			Loop=-1,
			SeqLoop = -1,
		},
	},
	
	
	ACTION_INVESTIGATE_AREA = {
		WithWeapon = 1,
		{	AnchorType=AIAnchorTable.ACTION_INVESTIGATE_AREA, --Sequence 1, Step 1
--			AnimStart = "smoking_start",
--			AnimLoop = {"smoking_idle",60, "smoking_01",13, "smoking_02",13, "smoking_03",14},
--			AnimEnd = {"smoking_end_01",50,"smoking_end_02",50},
--			SoundStart = "Sounds/Weapons/Trails/whiz2.wav",
--			SoundLoop = "Sounds/Weapons/Trails/whiz1.wav",
--			SoundEnd = "Sounds/Weapons/Trails/whiz4.wav",
			--SoundSynch = false,
--			Loop=-1,
			SeqLoop = 1,
			Run = 1,
			EndLoopSignal = "SEARCH_AROUND",
		},
	},
	
	
	USE_RADIO_ALARM = {
		Ignorant = 1,
		{	AnchorType = AIAnchorTable.USE_RADIO_ALARM,
			AnimLoop = "radio_reinforcements_01", 
			Loop = 1,
			SeqLoop = 1,
			Run = 1,
			EndLoopSignal = "RETURN_TO_FIRST",
		},
	},
	
	USE_BROKEN_RADIO_ALARM = {
		Ignorant = 1,
		{	AnchorType = AIAnchorTable.USE_BROKEN_RADIO_ALARM,
			AnimLoop = "smoking_03", 
			Loop = 1,
			SeqLoop = 1,
			Run = 1,
			EndLoopSignal = "RETURN_TO_FIRST",
		},
	},
	
	
	IDLE_FIX_GENERATOR = {
		{	AnchorType = AIAnchorTable.IDLE_FIX_GENERATOR,
			AnimStart = "repair_start",
                        AnimLoop = "repair_loop", 
			AnimEnd = "repair_end",
                        Loop = 7,
		--	SeqLoop = 1,
			Run = 0,
		--	EndLoopSignal = "BackToJob",
		},
		{	AnchorType = AIAnchorTable.IDLE_MISSION_TALK_INPLACE,
			AnimLoop = "stand_idle", 
			Loop = 1,
			SeqLoop = 1,
			Run = 0,
			EndLoopSignal = "BackToPrevious",
		},
	},

}