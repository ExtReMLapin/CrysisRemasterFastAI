	----------------------------------------
	-- from PipeManager
	----------------------------------------

	AI.CreateGoalPipe("runaway");
	AI.PushGoal("runaway","firecmd",0,0);
	AI.PushGoal("runaway","backoff",1,10);

-- restored
--	-- normal close distance attack
--	AI.CreateGoalPipe("close_attack");	
----	AI.PushGoal("close_attack","ignoreall",0,1);
----	AI.PushGoal("close_attack","acqtarget",0,"");
--	AI.PushGoal("close_attack","firecmd",0,1);	
--	AI.PushGoal("close_attack","bodypos",0,0);
--	AI.PushGoal("close_attack","run",0,1);
--	AI.PushGoal("close_attack","approach",1,10);
--	AI.PushGoal("close_attack","strafe",0,-1);		
--	AI.PushGoal("close_attack","timeout",1,1);
--	AI.PushGoal("close_attack","strafe",0,0);
----	AI.PushGoal("close_attack","backoff",1,12);
--	AI.PushGoal("close_attack","strafe",0,1);						
--	AI.PushGoal("close_attack","timeout",1,2);						
--	AI.PushGoal("close_attack","strafe",0,0);							
--	AI.PushGoal("close_attack","run",0,0);

	-- retreat
	AI.CreateGoalPipe("retreat");
	AI.PushGoal("retreat","ignoreall",0,1);
	AI.PushGoal("retreat","firecmd",0,1);
	AI.PushGoal("retreat","bodypos",0,0);
	AI.PushGoal("retreat","run",0,1);
	AI.PushGoal("retreat","acqtarget",0,"");
	AI.PushGoal("retreat","backoff",0,30);
	AI.PushGoal("retreat","strafe",0,-1);
	AI.PushGoal("retreat","timeout",0,2);
	AI.PushGoal("retreat","strafe",0,1);
	AI.PushGoal("retreat","timeout",0,1);
	AI.PushGoal("retreat","strafe",0,0);

	-- crouch and fire
	AI.CreateGoalPipe("crouchfire");
	AI.PushGoal("crouchfire","firecmd",0,1);
	AI.PushGoal("crouchfire","bodypos",0,1);
	AI.PushGoal("crouchfire","timeout",1,5);
	
	AI.CreateGoalPipe("investigatesound");
	AI.PushGoal("investigatesound","signal",1,1,"DoYouHearSomething",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("investigatesound","timeout",1,2);
	AI.PushGoal("investigatesound","firecmd",0,0);
	AI.PushGoal("investigatesound","approach",0,4);
	AI.PushGoal("investigatesound","lookaround",1,1);
	AI.PushGoal("investigatesound","branch",1,-1);
	AI.PushGoal("investigatesound","timeout",1,3);
	AI.PushGoal("investigatesound","lookaround",1,-1);
	AI.PushGoal("investigatesound","devalue",0);

	----------------------------------------
	-- from PipeManager2
	----------------------------------------

	AI.CreateGoalPipe("swim_to");
	AI.PushGoal("swim_to","firecmd",0,0);
	AI.PushGoal("swim_to","acqtarget",1,"");
	AI.PushGoal("swim_to","approach",1,2);
	AI.PushGoal("swim_to","devalue",0);
	AI.PushGoal("swim_to","signal",1,-1,"SWIM_TO_ANOTHER_SPOT",0);

	AI.CreateGoalPipe("swim_inplace");
	AI.PushGoal("swim_inplace","firecmd",0,0);
	AI.PushGoal("swim_inplace","timeout",1,2);
	AI.PushGoal("swim_inplace","signal",1,-1,"SWIM_TO_ANOTHER_SPOT",0);

	AI.CreateGoalPipe("get_gun");
	AI.PushGoal("get_gun","ignoreall",0,1);
	AI.PushGoal("get_gun","bodypos",0,0);
	AI.PushGoal("get_gun","signal",1,1,"GETTING_A_WEAPON",SIGNALID_READIBILITY);
	AI.PushGoal("get_gun","pathfind",1,"");
	AI.PushGoal("get_gun","run",0,1);
	AI.PushGoal("get_gun","trace",1,1);
	AI.PushGoal("get_gun","ignoreall",0,0);

	AI.CreateGoalPipe("simple_follow_target");
	AI.PushGoal("simple_follow_target","run",0,1);
	AI.PushGoal("simple_follow_target","firecmd",0,0);
	AI.PushGoal("simple_follow_target","approach",1,3);
	AI.PushGoal("simple_follow_target","timeout",1,0,1);


	AI.CreateGoalPipe("get_curious");
	AI.PushGoal("get_curious","timeout",1,0.5);
	AI.PushGoal("get_curious","signal",0,1,"SHARED_PLAY_CURIOUS_ANIMATION",0);
	AI.PushGoal("get_curious","timeout",1,0.2);

	AI.CreateGoalPipe("job_pickup_crate");
	AI.PushGoal("job_pickup_crate","approach_to_lastop");
	AI.PushGoal("job_pickup_crate","signal",1,1,"START_PICKUP_ANIM",0);
	AI.PushGoal("job_pickup_crate","timeout",1,1);
	AI.PushGoal("job_pickup_crate","signal",1,1,"BIND_CRATE_TO_ME",0);

	AI.CreateGoalPipe("job_drop_crate");
	AI.PushGoal("job_drop_crate","approach_to_lastop");
	AI.PushGoal("job_drop_crate","signal",1,1,"START_PUTDOWN_ANIM",0);
	AI.PushGoal("job_drop_crate","timeout",1,2);
	AI.PushGoal("job_drop_crate","signal",1,1,"FIND_PICKUP",0);

	AI.CreateGoalPipe("DRAW_GUN");
	AI.PushGoal("DRAW_GUN","signal",0,1,"SHARED_DRAW_GUN_ANIM",0);	
	AI.PushGoal("DRAW_GUN","timeout",1,0.4);	
	AI.PushGoal("DRAW_GUN","signal",0,1,"SHARED_REBIND_GUN_TO_HANDS",0);				

	AI.CreateGoalPipe("HOLSTER_GUN");
--	AI.PushGoal("HOLSTER_GUN","timeout",1,0,0.5);	
	AI.PushGoal("HOLSTER_GUN","firecmd",0,0);	
	AI.PushGoal("HOLSTER_GUN","signal",0,1,"SHARED_HOLSTER_GUN_ANIM",0);	
	--AI.PushGoal("HOLSTER_GUN","timeout",1,0.6);	
	AI.PushGoal("HOLSTER_GUN","signal",0,1,"SHARED_REBIND_GUN_TO_BACK",0);	

	----------------------------------------
	-- from PipeManagerCombat
	----------------------------------------

	AI.PushGoal("Shootspot","Trace_Anchor");
	AI.PushGoal("Shootspot","bodypos",0,0);
	AI.PushGoal("Shootspot","firecmd",0,1);
	AI.PushGoal("Shootspot","timeout",1,0.5,1);
	AI.PushGoal("Shootspot","bodypos",0,1);
	AI.PushGoal("Shootspot","firecmd",0,1);
	AI.PushGoal("Shootspot","timeout",1,0.5,3);

	AI.CreateGoalPipe("send_reinforcements");
	AI.PushGoal("send_reinforcements","signal",0,1,"JoinGroup",SIGNALFILTER_LASTOP);
	AI.PushGoal("send_reinforcements","run",1,1);
	AI.PushGoal("send_reinforcements","bodypos",1,0);
	AI.PushGoal("send_reinforcements","firecmd",1,1);
	AI.PushGoal("send_reinforcements","locate",1,"beacon");
	AI.PushGoal("send_reinforcements","acqtarget",1,"");
	AI.PushGoal("send_reinforcements","approach",1,1);
	AI.PushGoal("send_reinforcements","timeout",1,1);	
--	AI.PushGoal("send_reinforcements","signal",0,1,"SELECT_GROUPADVANCE",SIGNALFILTER_GROUPONLY);

	AI.CreateGoalPipe("SwatApproach");
	AI.PushGoal("SwatApproach","bodypos",0,1);
	AI.PushGoal("SwatApproach","run",0,1)
	AI.PushGoal("SwatApproach","hide",0,10,HM_NEAREST_TO_TARGET);
	AI.PushGoal("SwatApproach","signal",0,1,"CHOOSE_ATTACK",0);
	
	AI.CreateGoalPipe("SwatRoll_Left");
	AI.PushGoal("SwatRoll_Left","Trace_Anchor");
	AI.PushGoal("SwatRoll_Left","firecmd",0,0);
	AI.PushGoal("SwatRoll_Left","strafe",0,1);
	AI.PushGoal("SwatRoll_Left","signal",0,1,"SHARED_PLAYLEFTROLL");
	AI.PushGoal("SwatRoll_Left","timeout",1,1);
	AI.PushGoal("SwatRoll_Left","strafe",0,0);
	AI.PushGoal("SwatRoll_Left","firecmd",0,1);
	AI.PushGoal("SwatRoll_Left","timeout",1,60);

	AI.CreateGoalPipe("SwatRoll_Right");
	AI.PushGoal("SwatRoll_Right","Trace_Anchor");
	AI.PushGoal("SwatRoll_Right","firecmd",0,0);
	AI.PushGoal("SwatRoll_Right","strafe",0,-1);
	AI.PushGoal("SwatRoll_Right","signal",0,1,"SHARED_PLAYRIGHTROLL");
	AI.PushGoal("SwatRoll_Right","timeout",1,1);
	AI.PushGoal("SwatRoll_Right","strafe",0,0);
	AI.PushGoal("SwatRoll_Right","firecmd",0,1);
	AI.PushGoal("SwatRoll_Right","timeout",1,60);

	AI.CreateGoalPipe("Crouch_SwatRoll_Left");
	AI.PushGoal("Crouch_SwatRoll_Left","bodypos",0,1);
	AI.PushGoal("Crouch_SwatRoll_Left","SwatRoll_Left");
	
	AI.CreateGoalPipe("Crouch_SwatRoll_Right");
	AI.PushGoal("Crouch_SwatRoll_Right","bodypos",0,1);
	AI.PushGoal("Crouch_SwatRoll_Right","SwatRoll_Right");

	AI.CreateGoalPipe("LookForAlarm");
	AI.PushGoal("LookForAlarm","ignoreall",1,1);
	AI.PushGoal("LookForAlarm","signal",0,1,"FIND_ANCHOR",0);

	AI.CreateGoalPipe("NoAlarm");
	AI.PushGoal("NoAlarm","ignoreall",1,0);

	----------------------------------------
	-- from PMReusable
	----------------------------------------

	-----------------------------------------
	-- Investigate surroundings while remaining in formation if one exists		CHECK IF THIS CAN BE SAFELY REMOVED
	----------------------------------------------
	AI.CreateGoalPipe("formation_investigate");
	AI.PushGoal("formation_investigate","locate",0,"formation");
	AI.PushGoal("formation_investigate","acqtarget",0,"");
	AI.PushGoal("formation_investigate","approach",0,2);
	AI.PushGoal("formation_investigate","lookaround",1,3);
	AI.PushGoal("formation_investigate","branch",0,-1);
	AI.PushGoal("formation_investigate","lookaround",1,-1);
	AI.PushGoal("formation_investigate","lookaround",1,-1);

	---------------------------------------
	---
	--- CROWE PIPES
	---
	--------------------------------------

	AI.CreateGoalPipe("crowe_coordinating")
	--AI.PushGoal("crowe_coordinating","signal",1,1,"UNCONDITIONAL_JOIN",SIGNALFILTER_ANYONEINCOMM);
	AI.PushGoal("crowe_coordinating","run",0,1);
	AI.PushGoal("crowe_coordinating","firecmd",0,1);
	AI.PushGoal("crowe_coordinating","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("crowe_coordinating","hide",1,30,HM_NEAREST);

	-----------------------
	--
	-- TEAM LEADER FAKE GROUP
	--
	-------------------------

	AI.CreateGoalPipe("fake_takeUpPositions");
	AI.PushGoal("fake_takeUpPositions","firecmd",1,1);
	AI.PushGoal("fake_takeUpPositions","signal",0,1,"LO_LEFT_ADVANCE",SIGNALID_READIBILITY);
	AI.PushGoal("fake_takeUpPositions","signal",0,1,"OnActivate",SIGNALFILTER_HALFOFGROUP);
	AI.PushGoal("fake_takeUpPositions","timeout",1,1);
	AI.PushGoal("fake_takeUpPositions","minimize_exposure");
	AI.PushGoal("fake_takeUpPositions","timeout",1,5);
	AI.PushGoal("fake_takeUpPositions","signal",0,1,"LO_RIGHT_ADVANCE",SIGNALID_READIBILITY);
	AI.PushGoal("fake_takeUpPositions","signal",0,1,"OnActivate",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("fake_takeUpPositions","signal",0,1,"MINIMIZE_YOURSELF",0);
	
	-------------------------------
	
	AI.CreateGoalPipe("oleader_investigate");
	AI.PushGoal("oleader_investigate","form",0,"woodwalk");
	AI.PushGoal("oleader_investigate","signal",0,1,"MOVE_IN_FORMATION",SIGNALFILTER_GROUPONLY);
	AI.PushGoal("oleader_investigate","run",0,1);
	AI.PushGoal("oleader_investigate","approach",1,0.5);
	AI.PushGoal("oleader_investigate","timeout",0,3,7);
	AI.PushGoal("oleader_investigate","approach",1,0.5);
	AI.PushGoal("oleader_investigate","lookat",1,-90,90);
	AI.PushGoal("oleader_investigate","branch",0,-2);

	-----------------------
	--
	-- TEAM LEADER DEFENSE 1
	--
	------------------------

	AI.CreateGoalPipe("defend_point");
	AI.PushGoal("defend_point","form",0,"beacon");
	AI.PushGoal("defend_point","run",0,1);
	AI.PushGoal("defend_point","firecmd",0,1);
	AI.PushGoal("defend_point","hide",1,10,HM_NEAREST_TO_LASTOPRESULT_NOSAME);
	AI.PushGoal("defend_point","form",0,"test_attack");
	AI.PushGoal("defend_point","signal",1,1,"KEEP_FORMATION",SIGNALFILTER_SUPERGROUP);
	
	AI.CreateGoalPipe("defense_keepcovered");
	AI.PushGoal("defense_keepcovered","firecmd",0,1);
	AI.PushGoal("defense_keepcovered","locate",0,"beacon");
	AI.PushGoal("defense_keepcovered","acqtarget",0,"");
	AI.PushGoal("defense_keepcovered","locate",0,AIAnchorTable.AIANCHOR_PROTECT_THIS_POINT);
	AI.PushGoal("defense_keepcovered","hide",1,10,HM_NEAREST_TO_LASTOPRESULT_NOSAME);
	AI.PushGoal("defense_keepcovered","timeout",1,3,5);
	AI.PushGoal("defense_keepcovered","signal",1,1,"KEEP_FORMATION",SIGNALFILTER_SUPERGROUP);

	-----------------------
	--
	-- TEAM LEADER ATTACK
	--
	------------------------

	AI.CreateGoalPipe("leader_quickhide");
	AI.PushGoal("leader_quickhide","hide",1,10,HM_NEAREST);

	AI.CreateGoalPipe("reset_attack");
	AI.PushGoal("reset_attack","form",0,"beacon");
	AI.PushGoal("reset_attack","signal",1,1,"START_ATTACK",0);

	AI.CreateGoalPipe("respond_to_sighting");
	AI.PushGoal("respond_to_sighting","forget",0);
	AI.PushGoal("respond_to_sighting","acqtarget",0,"");
	AI.PushGoal("respond_to_sighting","form",0,"beacon");


	AI.CreateGoalPipe("fire_minimize");
	AI.PushGoal("fire_minimize","firecmd",0,1);
	AI.PushGoal("fire_minimize","run",0,1);
	AI.PushGoal("fire_minimize","hide",1,20,HM_NEAREST);
	AI.PushGoal("fire_minimize","run",0,0);

	AI.CreateGoalPipe("surrender_fake");
	AI.PushGoal("surrender_fake","firecmd",0,0);
	AI.PushGoal("surrender_fake","run",0,0);
	AI.PushGoal("surrender_fake","locate",0,"formation");
	AI.PushGoal("surrender_fake","acqtarget",0,"");
	AI.PushGoal("surrender_fake","approach",0,6);
	AI.PushGoal("surrender_fake","signal",0,1,"PLAY_SURRENDER",0);
	AI.PushGoal("surrender_fake","timeout",1,0.5);
	AI.PushGoal("surrender_fake","branch",0,-2);
	AI.PushGoal("surrender_fake","firecmd",0,1);
	AI.PushGoal("surrender_fake","timeout",1,120);


	-------------------------------
	--- SPLIT TEAM
	-------------------------------

	AI.CreateGoalPipe("split_team");
	AI.PushGoal("split_team","setup_combat");
	AI.PushGoal("split_team","signal",1,1,"INIT_TEAM_COUNTERS",0);	-- you are finished
	AI.PushGoal("split_team","signal",1,1,"SELECT_RED",SIGNALFILTER_HALFOFGROUP);	-- order half of group to select red
	AI.PushGoal("split_team","signal",1,1,"FORM_RED",SIGNALFILTER_SUPERGROUP);	-- order red to fall into formation
	AI.PushGoal("split_team","signal",1,1,"LO_SPLIT_LEFT",SIGNALID_READIBILITY);	
--	AI.PushGoal("split_team","timeout",1,1,1.5);
	AI.PushGoal("split_team","signal",1,1,"SELECT_BLACK",SIGNALFILTER_SUPERGROUP);	-- order the rest to select black
	AI.PushGoal("split_team","signal",1,1,"FORM_BLACK",SIGNALFILTER_SUPERGROUP);	-- order red to fall into formation
	AI.PushGoal("split_team","signal",1,1,"LO_SPLIT_RIGHT",SIGNALID_READIBILITY);	
--	AI.PushGoal("split_team","timeout",1,1,1.5);
	AI.PushGoal("split_team","firecmd",0,1);
	AI.PushGoal("split_team","run",0,1);
	AI.PushGoal("split_team","take_cover");
	AI.PushGoal("split_team","DropBeaconAt");
	AI.PushGoal("split_team","signal",1,1,"START_ATTACK",0);	-- you are finished

	AI.CreateGoalPipe("coordinate_red_attack");
	AI.PushGoal("coordinate_red_attack","form",0,"beacon");	-- drop a beacon where target was seen last
	AI.PushGoal("coordinate_red_attack","signal",1,1,"LO_LEFT_ADVANCE",SIGNALID_READIBILITY);	
	AI.PushGoal("coordinate_red_attack","signal",1,1,"PHASE_RED_ATTACK",SIGNALFILTER_SUPERGROUP);	
	AI.PushGoal("coordinate_red_attack","signal",1,1,"BLACK_COVER",SIGNALFILTER_SUPERGROUP);	
	AI.PushGoal("coordinate_red_attack","shoot_cover");
	AI.PushGoal("coordinate_red_attack","signal",1,1,"RELAX",0);		

	AI.CreateGoalPipe("coordinate_black_attack");
	AI.PushGoal("coordinate_black_attack","form",0,"beacon");	-- drop a beacon where target was seen last
	AI.PushGoal("coordinate_black_attack","signal",1,1,"LO_RIGHT_ADVANCE",SIGNALID_READIBILITY);	
	AI.PushGoal("coordinate_black_attack","signal",1,1,"PHASE_BLACK_ATTACK",SIGNALFILTER_SUPERGROUP);	
	AI.PushGoal("coordinate_black_attack","signal",1,1,"RED_COVER",SIGNALFILTER_SUPERGROUP)
	AI.PushGoal("coordinate_black_attack","shoot_cover");	
	AI.PushGoal("coordinate_black_attack","signal",1,1,"RELAX",0);	-- hide yourself	

	AI.CreateGoalPipe("re_split_team");
	AI.PushGoal("re_split_team","signal",1,1,"GROUP_MERGE",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("re_split_team","signal",1,1,"SELECT_RED",SIGNALFILTER_HALFOFGROUP);
	AI.PushGoal("re_split_team","signal",1,1,"SELECT_BLACK",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("re_split_team","reset_attack");

	AI.CreateGoalPipe("cover_red_form");
	AI.PushGoal("cover_red_form","setup_combat");
	AI.PushGoal("cover_red_form","firecmd",0,1);
	AI.PushGoal("cover_red_form","hide",1,20,HM_FRONTLEFTMOST_FROM_TARGET);

	AI.CreateGoalPipe("cover_black_form");
	AI.PushGoal("cover_black_form","setup_combat");
	AI.PushGoal("cover_black_form","firecmd",0,1);
	AI.PushGoal("cover_black_form","hide",1,20,HM_FRONTRIGHTMOST_FROM_TARGET);

	AI.CreateGoalPipe("cover_neutral_form");
	AI.PushGoal("cover_neutral_form","setup_combat");
	AI.PushGoal("cover_neutral_form","firecmd",0,1);
	AI.PushGoal("cover_neutral_form","hide",1,15,HM_NEAREST_TO_TARGET);
	
	AI.CreateGoalPipe("red_cover_pindown");
	AI.PushGoal("red_cover_pindown","signal",1,1,"ORDER_RECEIVED",SIGNALID_READIBILITY);
	AI.PushGoal("red_cover_pindown","left_cover_step_pindown");
	AI.PushGoal("red_cover_pindown","timeout",1,0,0.5);
	AI.PushGoal("red_cover_pindown","signal",0,1,"RED_IN_POSITION",SIGNALFILTER_SUPERGROUP);

	AI.CreateGoalPipe("black_cover_pindown");
	AI.PushGoal("black_cover_pindown","signal",1,1,"ORDER_RECEIVED",SIGNALID_READIBILITY);
	AI.PushGoal("black_cover_pindown","right_cover_step_pindown");
	AI.PushGoal("black_cover_pindown","timeout",1,0,0.5);
	AI.PushGoal("black_cover_pindown","signal",0,1,"BLACK_IN_POSITION",SIGNALFILTER_SUPERGROUP);

	----------------------------------------
	--- JOINING TEAM
	----------------------------------------

	AI.CreateGoalPipe("offer_join_team_to");
	AI.PushGoal("offer_join_team_to","signal",0,1,"JoinGroup",SIGNALFILTER_LASTOP);	
	AI.PushGoal("offer_join_team_to","timeout",1,0.5);
	AI.PushGoal("offer_join_team_to","signal",0,1,"wakeup",SIGNALFILTER_GROUPONLY);	
	AI.PushGoal("offer_join_team_to","signal",0,1,"HEADS_UP_GUYS",SIGNALFILTER_GROUPONLY);	

	AI.CreateGoalPipe("offer_join_team");
	AI.PushGoal("offer_join_team","signal",1,1,"OFFER_JOIN_TEAM",SIGNALFILTER_SPECIESONLY);

	----------------------------------------
	-- SNIPER
	----------------------------------------
		---------------
	--
	-- SNIPER 
	--
	----------------

	AI.CreateGoalPipe("sniper_potshot");
	AI.PushGoal("sniper_potshot","firecmd",0,0);
	AI.PushGoal("sniper_potshot","signal",1,1,"MAKE_ME_IGNORANT",0);
	AI.PushGoal("sniper_potshot","firecmd",0,0);
	AI.PushGoal("sniper_potshot","acqtarget",1,"");
	AI.PushGoal("sniper_potshot","timeout",1,0,0.5);
	AI.PushGoal("sniper_potshot","firecmd",0,2);
	AI.PushGoal("sniper_potshot","timeout",1,2,3);
	AI.PushGoal("sniper_potshot","firecmd",0,1);
	AI.PushGoal("sniper_potshot","signal",1,-1,"MAKE_ME_UNIGNORANT",0);
	AI.PushGoal("sniper_potshot","clear",1,1);


	AI.CreateGoalPipe("sniper_headdown");
	--AI.PushGoal("sniper_headdown","firecmd",0,0);
	--AI.PushGoal("sniper_headdown","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("sniper_headdown","timeout",1,1,5);
	AI.PushGoal("sniper_headdown","signal",0,1,"SNIPER_NORMALATTACK",0);

	AI.CreateGoalPipe("sniper_getdown");
	AI.PushGoal("sniper_getdown","firecmd",0,0);
	--AI.PushGoal("sniper_getdown","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("sniper_getdown","timeout",1,1);
	AI.PushGoal("sniper_getdown","bodypos",0,BODYPOS_CROUCH);
	
	AI.CreateGoalPipe("sniper_shootfast");	
	AI.PushGoal("sniper_shootfast","firecmd",0,1);
	--AI.PushGoal("sniper_shootfast","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("sniper_shootfast","timeout",1,2);
	AI.PushGoal("sniper_shootfast","signal",0,1,"SNIPER_NORMALATTACK",0);

	AI.CreateGoalPipe("sniper_aimalittle");
	AI.PushGoal("sniper_aimalittle","firecmd",0,0);
	--AI.PushGoal("sniper_aimalittle","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("sniper_aimalittle","timeout",1,0,1);
	AI.PushGoal("sniper_aimalittle","firecmd",0,1);
	AI.PushGoal("sniper_aimalittle","timeout",1,4);
	AI.PushGoal("sniper_aimalittle","signal",0,1,"SNIPER_NORMALATTACK",0);


	AI.CreateGoalPipe("sniper_relocate_to");
	AI.PushGoal("sniper_relocate_to","firecmd",0,0);
	AI.PushGoal("sniper_relocate_to","ignoreall",0,1);
	AI.PushGoal("sniper_relocate_to","acqtarget",0,"");
	AI.PushGoal("sniper_relocate_to","approach",1,2);
	AI.PushGoal("sniper_relocate_to","lookat",1,0,0);
	AI.PushGoal("sniper_relocate_to","ignoreall",0,0);
	AI.PushGoal("sniper_relocate_to","signal",0,1,"SNIPER_NORMALATTACK",0);

	AI.CreateGoalPipe("sniper_movealittle_r");
	AI.PushGoal("sniper_movealittle_r","firecmd",0,0);
	AI.PushGoal("sniper_movealittle_r","strafe",0,1);
	AI.PushGoal("sniper_movealittle_r","timeout",1,0.5);
	AI.PushGoal("sniper_movealittle_r","strafe",0,0);
	AI.PushGoal("sniper_movealittle_r","signal",0,1,"SNIPER_NORMALATTACK",0);
	
	---------------------
	--
	--  REAR GUARD
	-- 
	---------------------


	AI.CreateGoalPipe("rear_interested");
	AI.PushGoal("rear_interested","take_cover");
	AI.PushGoal("rear_interested","lookat",1,-90,90);
	AI.PushGoal("rear_interested","DropBeaconAt");


	AI.CreateGoalPipe("rear_target2close");
	AI.PushGoal("rear_target2close","request_cover");
	AI.PushGoal("rear_target2close","run",0,1);
	AI.PushGoal("rear_target2close","firecmd",0,1);
	AI.PushGoal("rear_target2close","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("rear_target2close","hide",1,10,HM_FARTHEST_FROM_TARGET);
	AI.PushGoal("rear_target2close","run",0,0);
	AI.PushGoal("rear_target2close","signal",0,1,"REAR_NORMALATTACK",0);

	AI.CreateGoalPipe("rear_comeout");
	AI.PushGoal("rear_comeout","firecmd",0,1);
	AI.PushGoal("rear_comeout","setup_combat");
	AI.PushGoal("rear_comeout","locate",0,"atttarget");
	AI.PushGoal("rear_comeout","pathfind",1,"");
	AI.PushGoal("rear_comeout","trace",1,0,1);
	AI.PushGoal("rear_comeout","clear",0,1);

	AI.CreateGoalPipe("rear_weaponAttack");
	AI.PushGoal("rear_weaponAttack","firecmd",0,1);
	AI.PushGoal("rear_weaponAttack","timeout",1,2,3);

	AI.CreateGoalPipe("rear_grenadeAttack");
	AI.PushGoal("rear_grenadeAttack","firecmd",0,0);
	AI.PushGoal("rear_grenadeAttack","throw_grenade");
	AI.PushGoal("rear_grenadeAttack","firecmd",0,1);
	AI.PushGoal("rear_grenadeAttack","timeout",1,2);


	AI.CreateGoalPipe("protect_spot");
	AI.PushGoal("protect_spot","firecmd",0,1);
	AI.PushGoal("protect_spot","run",0,1);
	AI.PushGoal("protect_spot","hide",1,10,HM_NEAREST_TO_LASTOPRESULT_NOSAME);
	AI.PushGoal("protect_spot","run",0,0);
	AI.PushGoal("protect_spot","firecmd",0,0);
	AI.PushGoal("protect_spot","signal",0,1,"REAR_NORMALATTACK",0);


	AI.CreateGoalPipe("rear_scramble");
	AI.PushGoal("rear_scramble","take_cover");
	AI.PushGoal("rear_scramble","signal",0,1,"REAR_NORMALATTACK");
	
	
	-------------------
	----
	---- SCOUT
	----
	--------------------

	AI.CreateGoalPipe("scout_find_threat");
	AI.PushGoal("scout_find_threat","timeout",1,1,2);
	AI.PushGoal("scout_find_threat","take_cover");

	AI.CreateGoalPipe("scout_threatening_sound");
	AI.PushGoal("scout_threatening_sound","take_cover");
	AI.PushGoal("scout_threatening_sound","setup_combat");
	AI.PushGoal("scout_threatening_sound","timeout",0,999);	 -- do the following bit forever (f.a. intents&purposes)
	AI.PushGoal("scout_threatening_sound","hide",1,15,HM_LEFTMOST_FROM_TARGET);
	AI.PushGoal("scout_threatening_sound","timeout",1,0,1);
	AI.PushGoal("scout_threatening_sound","branch",1,-2,1);	-- hide left as much as you can
	AI.PushGoal("scout_threatening_sound","hide",1,10,HM_NEAREST_TO_TARGET);
	AI.PushGoal("scout_threatening_sound","timeout",1,0,1);
	AI.PushGoal("scout_threatening_sound","branch",1,-5,1);	-- then try going left again
	AI.PushGoal("scout_threatening_sound","hide",1,15,HM_RIGHTMOST_FROM_TARGET);
	AI.PushGoal("scout_threatening_sound","timeout",1,0,1);
	AI.PushGoal("scout_threatening_sound","branch",1,-2,1);	-- hide right as much as you can
	AI.PushGoal("scout_threatening_sound","hide",1,10,HM_NEAREST_TO_TARGET);
	AI.PushGoal("scout_threatening_sound","timeout",1,0,1);
	AI.PushGoal("scout_threatening_sound","branch",1,-5,1);	-- then try going left again
	AI.PushGoal("scout_threatening_sound","branch",1,-12);	-- all over again


	
	AI.CreateGoalPipe("scout_interesting_sound");
	AI.PushGoal("scout_interesting_sound","take_cover");
	AI.PushGoal("scout_interesting_sound","setup_stealth");
	AI.PushGoal("scout_interesting_sound","timeout",0,99);
	AI.PushGoal("scout_interesting_sound","lookat",1,-90,90);
	AI.PushGoal("scout_interesting_sound","timeout",1,0,1);
	AI.PushGoal("scout_interesting_sound","DropBeaconAt");
	AI.PushGoal("scout_interesting_sound","take_cover");
	AI.PushGoal("scout_interesting_sound","branch",0,-4);	 	-- lookaround for 2 sec


	AI.CreateGoalPipe("scout_hunt_beacon");
	AI.PushGoal("scout_hunt_beacon","locate",0,"beacon");
	AI.PushGoal("scout_hunt_beacon","acqtarget",0,"");
	AI.PushGoal("scout_hunt_beacon","scout_hunt_run");

	AI.CreateGoalPipe("scout_hunt_run");
	AI.PushGoal("scout_hunt_run","setup_combat");
	AI.PushGoal("scout_hunt_run","run",0,1);
	AI.PushGoal("scout_hunt_run","hide",1,15,HM_FRONTLEFTMOST_FROM_TARGET);
	AI.PushGoal("scout_hunt_run","branch",0,-1,1);
	AI.PushGoal("scout_hunt_run","hide",1,15,HM_FRONTRIGHTMOST_FROM_TARGET);
	AI.PushGoal("scout_hunt_run","approach",1,0.5);
	AI.PushGoal("scout_hunt_run","devalue",0);


	AI.CreateGoalPipe("scout_hunt");
	AI.PushGoal("scout_hunt","setup_crouch");
	AI.PushGoal("scout_hunt","hide",1,10,HM_NEAREST_TO_TARGET);
	AI.PushGoal("scout_hunt","timeout",1,0,1.5);
	AI.PushGoal("scout_hunt","hide",1,15,HM_FRONTLEFTMOST_FROM_TARGET);
	AI.PushGoal("scout_hunt","timeout",1,0,2);
	AI.PushGoal("scout_hunt","branch",0,-4,1);	
	AI.PushGoal("scout_hunt","hide",1,15,HM_FRONTRIGHTMOST_FROM_TARGET);
	AI.PushGoal("scout_hunt","timeout",1,0,1);
	AI.PushGoal("scout_hunt","branch",0,-7,1);	
	AI.PushGoal("scout_hunt","timeout",1,0,2);	
	AI.PushGoal("scout_hunt","approach",1,0.5);	
	AI.PushGoal("scout_hunt","devalue",0);		

	AI.CreateGoalPipe("scout_group_hunt");
	AI.PushGoal("scout_group_hunt","setup_crouch");
	AI.PushGoal("scout_group_hunt","locate",0,"beacon");
	AI.PushGoal("scout_group_hunt","acqtarget",0,"");
	AI.PushGoal("scout_group_hunt","firecmd",0,2);
	AI.PushGoal("scout_group_hunt","hide",1,10,HM_NEAREST_TO_TARGET);
	AI.PushGoal("scout_group_hunt","timeout",1,0,1.5);
	AI.PushGoal("scout_group_hunt","hide",1,15,HM_FRONTLEFTMOST_FROM_TARGET);
	AI.PushGoal("scout_group_hunt","timeout",1,0,2);
	AI.PushGoal("scout_group_hunt","branch",0,-4,1);	
	AI.PushGoal("scout_group_hunt","hide",1,15,HM_FRONTRIGHTMOST_FROM_TARGET);
	AI.PushGoal("scout_group_hunt","timeout",1,0,1);
	AI.PushGoal("scout_group_hunt","branch",0,-7,1);	
	AI.PushGoal("scout_group_hunt","timeout",1,0,2);	
	AI.PushGoal("scout_group_hunt","approach",1,0.5);	
	AI.PushGoal("scout_group_hunt","devalue",0);		


	AI.CreateGoalPipe("scout_tooclose_attack_beacon")
	AI.PushGoal("scout_tooclose_attack_beacon","DropBeaconAt",0);
	AI.PushGoal("scout_tooclose_attack_beacon","scout_tooclose_attack",0);

	AI.CreateGoalPipe("scout_wait_and_hunt");
	AI.PushGoal("scout_wait_and_hunt","timeout",1,2,5);
	AI.PushGoal("scout_wait_and_hunt","signal",0,1,"START_HUNTING",0);

	AI.CreateGoalPipe("scout_tooclose_attack");
	AI.PushGoal("scout_tooclose_attack","firecmd",0,1);
	AI.PushGoal("scout_tooclose_attack","request_cover");
	AI.PushGoal("scout_tooclose_attack","run",0,1);
	AI.PushGoal("scout_tooclose_attack","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("scout_tooclose_attack","firecmd",0,0);
	AI.PushGoal("scout_tooclose_attack","hide",1,10,HM_FARTHEST_FROM_TARGET,1);
	AI.PushGoal("scout_tooclose_attack","firecmd",0,1);
--	AI.PushGoal("scout_tooclose_attack","hide",1,5,HM_NEAREST);
	AI.PushGoal("scout_tooclose_attack","run",0,0);
	AI.PushGoal("scout_tooclose_attack","reload");
	AI.PushGoal("scout_tooclose_attack","signal",0,1,"SCOUT_NORMALATTACK",0);
	
	AI.CreateGoalPipe("scout_firesome");
	AI.PushGoal("scout_firesome","firecmd",0,1);
	AI.PushGoal("scout_firesome","timeout",1,1);
	AI.PushGoal("scout_firesome","minimize_exposure");
	AI.PushGoal("scout_firesome","reload");
	AI.PushGoal("scout_firesome","signal",0,1,"SCOUT_NORMALATTACK",0);

	AI.CreateGoalPipe("scout_comeout");
	AI.PushGoal("scout_comeout","firecmd",0,1);
	AI.PushGoal("scout_comeout","approach",1,0.9);
	AI.PushGoal("scout_comeout","signal",0,1,"SCOUT_NORMALATTACK",0);

	AI.CreateGoalPipe("scout_quickhide");
	AI.PushGoal("scout_quickhide","hide",1,10,HM_NEAREST);
	AI.PushGoal("scout_quickhide","timeout",1,0.5);

	AI.CreateGoalPipe("scout_cover_NOW");
	AI.PushGoal("scout_cover_NOW","firecmd",0,1);
	AI.PushGoal("scout_cover_NOW","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("scout_cover_NOW","run",0,1);
	AI.PushGoal("scout_cover_NOW","hide",1,10,HM_NEAREST);
	AI.PushGoal("scout_cover_NOW","signal",1,1,"SCOUT_NORMALATTACK",0);

	AI.CreateGoalPipe("scout_attack_far");
	AI.PushGoal("scout_attack_far","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("scout_attack_far","firecmd",0,1);
	AI.PushGoal("scout_attack_far","run",0,1);
	AI.PushGoal("scout_attack_far","hide",1,10,HM_LEFTMOST_FROM_TARGET);
	AI.PushGoal("scout_attack_far","timeout",1,0,1);

	AI.CreateGoalPipe("scout_attack_left");
	AI.PushGoal("scout_attack_left","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("scout_attack_left","firecmd",0,1);
	AI.PushGoal("scout_attack_left","run",0,1);
	AI.PushGoal("scout_attack_left","hide",1,20,HM_FRONTLEFTMOST_FROM_TARGET);
	AI.PushGoal("scout_attack_left","timeout",1,0,1);

	AI.CreateGoalPipe("red_scout_attack");
	AI.PushGoal("red_scout_attack","locate",0,"beacon");
	AI.PushGoal("red_scout_attack","acqtarget",0,"");
	AI.PushGoal("red_scout_attack","scout_attack_left");
	AI.PushGoal("red_scout_attack","signal",1,1,"RED_IN_POSITION",SIGNALFILTER_SUPERGROUP);

	AI.CreateGoalPipe("scout_attack_right");
	AI.PushGoal("scout_attack_right","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("scout_attack_right","firecmd",0,1);
	AI.PushGoal("scout_attack_right","run",0,1);
	AI.PushGoal("scout_attack_right","hide",1,20,HM_FRONTRIGHTMOST_FROM_TARGET);
	AI.PushGoal("scout_attack_right","timeout",1,0,1);

	AI.CreateGoalPipe("black_scout_attack");
	AI.PushGoal("black_scout_attack","locate",0,"beacon");
	AI.PushGoal("black_scout_attack","acqtarget",0,"");
	AI.PushGoal("black_scout_attack","scout_attack_right");
	AI.PushGoal("black_scout_attack","signal",1,1,"BLACK_IN_POSITION",SIGNALFILTER_SUPERGROUP);

	
	AI.CreateGoalPipe("scout_approach");
	AI.PushGoal("scout_approach","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("scout_approach","run",0,1)
	AI.PushGoal("scout_approach","hide",1,10,HM_NEAREST_TO_TARGET);
	AI.PushGoal("scout_approach","timeout",1,0,2);
	AI.PushGoal("scout_approach","branch",0,-2,1);	
	-- try to get closer as long as there is cover to advance
	AI.PushGoal("scout_approach","signal",0,1,"SCOUT_HIDE_LEFT_OR_RIGHT",0);	
	AI.PushGoal("scout_approach","timeout",1,0,2);
	AI.PushGoal("scout_approach","signal",0,1,"SCOUT_HIDE_LEFT_OR_RIGHT",0);	
	AI.PushGoal("scout_approach","timeout",1,0,2);
	AI.PushGoal("scout_approach","branch",0,-7,1);	-- if you succeeded moving left, now try moving closer again
	-- if you get here, it means that you cannot move with cover anywhere
	AI.PushGoal("scout_approach","timeout",1,1,3);	-- think about it some time
	--AI.PushGoal("scout_approach","approach",1,0.5);	-- halve the distance to your target
	AI.PushGoal("scout_approach","signal",0,1,"ATTACK_ENEMY",0);
	
	AI.CreateGoalPipe("scout_aggresive_investigate");
	AI.PushGoal("scout_aggresive_investigate","firecmd",0,0)
	AI.PushGoal("scout_aggresive_investigate","bodypos",0,BODYPOS_CROUCH)
	AI.PushGoal("scout_aggresive_investigate","run",0,0)
	AI.PushGoal("scout_aggresive_investigate","timeout",1,0.5)
	AI.PushGoal("scout_aggresive_investigate","hide",1,10,HM_NEAREST_TO_TARGET)

	AI.CreateGoalPipe("scout_scramble_beacon");
	AI.PushGoal("scout_scramble_beacon","DropBeaconAt",0);
	AI.PushGoal("scout_scramble_beacon","scout_scramble",0);

	AI.CreateGoalPipe("scout_scramble");
	AI.PushGoal("scout_scramble","minimize_exposure");
	AI.PushGoal("scout_scramble","reload");
	AI.PushGoal("scout_scramble","signal",0,1,"SCOUT_NORMALATTACK",0);

	AI.CreateGoalPipe("scout_attack");
	--AI.PushGoal("scout_attack","firecmd",0,1);
	AI.PushGoal("scout_attack","signal",0,1,"fire_or_not",0);
	AI.PushGoal("scout_attack","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("scout_attack","reload");
	AI.PushGoal("scout_attack","approach",1,0.8);
	AI.PushGoal("scout_attack","timeout",1,30);


	AI.CreateGoalPipe("scout_form");
	AI.PushGoal("scout_form","locate",0,"formation");
	AI.PushGoal("scout_form","ignoreall",0,1);
	AI.PushGoal("scout_form","acqtarget",0,"");
	AI.PushGoal("scout_form","run",0,1);
	AI.PushGoal("scout_form","approach",1,2);
	AI.PushGoal("scout_form","ignoreall",0,0);
	
	-------------------------------------------
	
	AI.CreateGoalPipe("kneeling_left_attack");
	AI.PushGoal("kneeling_left_attack","firecmd",0,1);
	AI.PushGoal("kneeling_left_attack","strafe",0,-1);
	AI.PushGoal("kneeling_left_attack","timeout",1,0.5,1);
	AI.PushGoal("kneeling_left_attack","strafe",0,0);
	AI.PushGoal("kneeling_left_attack","timeout",1,0.5);
	AI.PushGoal("kneeling_left_attack","signal",0,1,"DEFAULT_GO_KNEEL",0);
	AI.PushGoal("kneeling_left_attack","timeout",1,2,4);
	AI.PushGoal("kneeling_left_attack","signal",0,1,"DEFAULT_UNKNEEL",0);

	AI.CreateGoalPipe("kneeling_right_attack");
	AI.PushGoal("kneeling_right_attack","firecmd",0,1);
	AI.PushGoal("kneeling_right_attack","strafe",0,1);
	AI.PushGoal("kneeling_right_attack","timeout",1,0.5,1);
	AI.PushGoal("kneeling_right_attack","strafe",0,0);
	AI.PushGoal("kneeling_right_attack","timeout",1,0.5);
	AI.PushGoal("kneeling_right_attack","signal",0,1,"DEFAULT_GO_KNEEL",0);
	AI.PushGoal("kneeling_right_attack","timeout",1,2,4);
	AI.PushGoal("kneeling_right_attack","signal",0,1,"DEFAULT_UNKNEEL",0);



	AI.CreateGoalPipe("advise_caution_to_team");
	AI.PushGoal("advise_caution_to_team","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("advise_caution_to_team","signal",0,1,"DISTURBANCE_NOTICE",SIGNALFILTER_GROUPONLY);
	AI.PushGoal("advise_caution_to_team","timeout",1,1);
	AI.PushGoal("advise_caution_to_team","bodypos",0,BODYPOS_STAND);

	-- later enhance with all kind of cool anims and sounds
	AI.CreateGoalPipe("request_cover");
	AI.PushGoal("request_cover","signal",0,1,"OnCoverRequested",SIGNALFILTER_GROUPONLY);

	AI.CreateGoalPipe("reload");
	AI.PushGoal("reload","signal",0,1,"SHARED_RELOAD",0);
	
		AI.CreateGoalPipe("stealth_idle");
	AI.PushGoal("stealth_idle","bodypos",0,BODYPOS_STEALTH);
	AI.PushGoal("stealth_idle","lookaround",1,-1);
	AI.PushGoal("stealth_idle","timeout",1,1);
	
	AI.CreateGoalPipe("stealth_surround");
--	AI.PushGoal("stealth_surround","signal",0,1,"FIRST_CONTACT",SIGNALID_READIBILITY);		
	AI.PushGoal("stealth_surround","bodypos",0,BODYPOS_STEALTH);		-- go into stealth mode
	AI.PushGoal("stealth_surround","timeout",1,1);		-- freeze for a sec
	AI.PushGoal("stealth_surround","lookaround",1,3);	-- try to locate source without moving
	AI.PushGoal("stealth_surround","lookaround",1,3);
	AI.PushGoal("stealth_surround","strafe",0,1);
	AI.PushGoal("stealth_surround","timeout",1,0.5);
	AI.PushGoal("stealth_surround","strafe",0,0);
	AI.PushGoal("stealth_surround","timeout",1,1);		-- freeze for a sec
	AI.PushGoal("stealth_surround","lookaround",1,3);	-- try to locate source without moving
	AI.PushGoal("stealth_surround","strafe",0,-1);
	AI.PushGoal("stealth_surround","timeout",1,1);
	AI.PushGoal("stealth_surround","strafe",0,0);
	AI.PushGoal("stealth_surround","timeout",1,1);		-- freeze for a sec
	AI.PushGoal("stealth_surround","lookaround",1,3);	-- try to locate source without moving
	AI.PushGoal("stealth_surround","hide",1,10,5);   	-- try to hide left of disturbance

	AI.CreateGoalPipe("flashlight_investigate");
	AI.PushGoal("flashlight_investigate","signal",1,1,"FLASHLIGHT_ON",0);
	AI.PushGoal("flashlight_investigate","lookat",1,0,0);
	AI.PushGoal("flashlight_investigate","timeout",1,0.5,1.5);
	AI.PushGoal("flashlight_investigate","lookat",1,-90,90);
	AI.PushGoal("flashlight_investigate","timeout",1,0.5,1.5);
	AI.PushGoal("flashlight_investigate","lookat",1,-90,90);
	AI.PushGoal("flashlight_investigate","timeout",1,0.5,1.5);
	AI.PushGoal("flashlight_investigate","signal",1,1,"FLASHLIGHT_OFF",0);
	
	AI.CreateGoalPipe("throw_flare");
	AI.PushGoal("throw_flare","locate",1,AIAnchorTable.AIANCHOR_THROW_FLARE);
	AI.PushGoal("throw_flare","ignoreall",1,1);
	AI.PushGoal("throw_flare","acqtarget",1,"");
	AI.PushGoal("throw_flare","unconditional_flare");
	AI.PushGoal("throw_flare","timeout",1,0.2);
	AI.PushGoal("throw_flare","ignoreall",1,0);
	AI.PushGoal("throw_flare","signal",1,1,"SWITCH_GRENADE_TYPE",0);

	AI.CreateGoalPipe("unconditional_flare");
	AI.PushGoal("unconditional_flare","signal",1,1,"GET_REINFORCEMENTS",SIGNALID_READIBILITY);
	AI.PushGoal("unconditional_flare","signal",1,1,"SHARED_GRANATE_THROW_ANIM",0);
	AI.PushGoal("unconditional_flare","timeout",1,1);
	AI.PushGoal("unconditional_flare","signal",1,-10,"grenate",0);

	AI.CreateGoalPipe("make_formation");
	AI.PushGoal("make_formation","form",0,"wedge");
	AI.PushGoal("make_formation","signal",1,1,"FOLLOW_ME",SIGNALFILTER_SUPERGROUP);

	AI.CreateGoalPipe("simple_follow");
	AI.PushGoal("simple_follow","approach",1,1);

	AI.CreateGoalPipe("follow_leader");
	AI.PushGoal("follow_leader","locate",0,"formation");
	AI.PushGoal("follow_leader","acqtarget",0,"");


	AI.CreateGoalPipe("stand_timer"); -- previously used in AI_Conversation not in place
	AI.PushGoal("stand_timer","acqtarget",1,"");
	AI.PushGoal("stand_timer","timeout",1,3);
	AI.PushGoal("stand_timer","clear",0,1);
	AI.PushGoal("stand_timer","timeout",1,1000);

	----------------------------------------
	AI.CreateGoalPipe("dodge_wrapper");
	--AI.PushGoal("dodge_wrapper","firecmd",1,1);
	--AI.PushGoal("dodge_wrapper","timeout",1,0.3,0.5);
	AI.PushGoal("dodge_wrapper","signal",1,1,"TRY_NEXT",0);

	AI.CreateGoalPipe("crowe_dodge_1");
	AI.PushGoal("crowe_dodge_1","strafe",1,-5);
	AI.PushGoal("crowe_dodge_1","signal",1,1,"TRY_NEXT",0);

	AI.CreateGoalPipe("crowe_dodge_3");
	AI.PushGoal("crowe_dodge_3","strafe",1,-3);
	AI.PushGoal("crowe_dodge_3","signal",1,1,"TRY_NEXT",0);

	AI.CreateGoalPipe("crowe_dodge_2");
	AI.PushGoal("crowe_dodge_2","strafe",1,3);
	AI.PushGoal("crowe_dodge_2","signal",1,1,"TRY_NEXT",0);

	AI.CreateGoalPipe("crowe_dodge_4");
	AI.PushGoal("crowe_dodge_4","strafe",1,5);
	AI.PushGoal("crowe_dodge_4","signal",1,1,"TRY_NEXT",0);

	--------------------------------------------
	-- From PipeManagerShared
	--------------------------------------------
			------------------------------ IGNORE ---------------------------
		AI.CreateGoalPipe("AIS_ignoreall");
		AI.PushGoal("AIS_ignoreall","ignoreall",1,1);
		
		AI.CreateGoalPipe("AIS_dont_ignore");
		AI.PushGoal("AIS_dont_ignore","ignoreall",1,0);
		AI.PushGoal("AIS_dont_ignore","signal",0,1,"AISF_GoOn",0);
		------------------------------------------------------------------		
		-------------------------------- DELAY ---------------------------
		-- Delay_1
		AI.CreateGoalPipe("AIS_Delay_1");
		AI.PushGoal("AIS_Delay_1","timeout",1,1);
		AI.PushGoal("AIS_Delay_1","signal",0,1,"AISF_GoOn",0);
		
		-- Delay_2
		AI.CreateGoalPipe("AIS_Delay_2");
		AI.PushGoal("AIS_Delay_2","timeout",1,2);
		AI.PushGoal("AIS_Delay_2","signal",0,1,"AISF_GoOn",0);
		
		-- Delay_3
		AI.CreateGoalPipe("AIS_Delay_3");
		AI.PushGoal("AIS_Delay_3","timeout",1,4);
		AI.PushGoal("AIS_Delay_3","signal",0,1,"AISF_GoOn",0);
		
		-- Delay_4
		AI.CreateGoalPipe("AIS_Delay_4");
		AI.PushGoal("AIS_Delay_4","timeout",1,6);
		AI.PushGoal("AIS_Delay_4","signal",0,1,"AISF_GoOn",0);
		
		-- Delay_5
		AI.CreateGoalPipe("AIS_Delay_5");
		AI.PushGoal("AIS_Delay_5","timeout",1,8);
		AI.PushGoal("AIS_Delay_5","signal",0,1,"AISF_GoOn",0);
	
		-- Delay_6
		AI.CreateGoalPipe("AIS_Delay_6");
		AI.PushGoal("AIS_Delay_6","timeout",1,10);
		AI.PushGoal("AIS_Delay_6","signal",0,1,"AISF_GoOn",0);
		
		-- Delay_7
		AI.CreateGoalPipe("AIS_Delay_7");
		AI.PushGoal("AIS_Delay_7","timeout",1,12);
		AI.PushGoal("AIS_Delay_7","signal",0,1,"AISF_GoOn",0);
		
		-- Delay_8
		AI.CreateGoalPipe("AIS_Delay_8");
		AI.PushGoal("AIS_Delay_8","timeout",1,14);
		AI.PushGoal("AIS_Delay_8","signal",0,1,"AISF_GoOn",0);