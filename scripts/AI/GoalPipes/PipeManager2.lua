
function PipeManager:OnInit2()
	AI.LogEvent("INIT2CALLED");
	
	AI.CreateGoalPipe("hide_from_beacon");
	AI.PushGoal("hide_from_beacon","locate",0,"beacon");
	AI.PushGoal("hide_from_beacon","acqtarget",0,"");
	AI.PushGoal("hide_from_beacon","bodypos",0,BODYPOS_STAND);	
	AI.PushGoal("hide_from_beacon","run",0,1);
	AI.PushGoal("hide_from_beacon","hide",1,20,HM_NEAREST);

	AI.CreateGoalPipe("rush_player");
	AI.PushGoal("rush_player","locate",0,"player");
	AI.PushGoal("rush_player","acqtarget",1,"");
	AI.PushGoal("rush_player","run",0,2);
	AI.PushGoal("rush_player","timeout",1,0.2,0.8);
	AI.PushGoal("rush_player","firecmd",1,1);
	AI.PushGoal("rush_player","approach",1,5);
	AI.PushGoal("rush_player","firecmd",1,0);
	AI.PushGoal("rush_player","signal",1,1,"STOP_RUSH",0);


	AI.CreateGoalPipe("stunned");
	AI.PushGoal("stunned","firecmd",0,0);
	AI.PushGoal("stunned","signal",1,1,"MAKE_ME_IGNORANT",0);
	AI.PushGoal("stunned","signal",1,-1,"MAKE_STUNNED_ANIMATION",0);
	AI.PushGoal("stunned","timeout",1,0,0.5);
	AI.PushGoal("stunned","timeout",1,1,2);
	AI.PushGoal("stunned","signal",1,-1,"SHARED_UNBLINDED",0);
	AI.PushGoal("stunned","signal",1,-1,"MAKE_ME_UNIGNORANT",0);
	AI.PushGoal("stunned","firecmd",0,1);
	
	AI.CreateGoalPipe("any_idle_stand");
	AI.PushGoal("any_idle_stand","timeout",1,0,1);
	AI.PushGoal("any_idle_stand","signal",1,-1,"DECIDE_TO_BREAK_OR_NOT",0);

	AI.CreateGoalPipe("any_idle_reach_lastop");
	AI.PushGoal("any_idle_reach_lastop","devalue",1);
	AI.PushGoal("any_idle_reach_lastop","approach_to_lastop");
	AI.PushGoal("any_idle_reach_lastop","lookat",1,0,0);
	AI.PushGoal("any_idle_reach_lastop","timeout",1,1,2);
	AI.PushGoal("any_idle_reach_lastop","signal",1,-1,"ANCHOR_REACHED",0);


	AI.CreateGoalPipe("any_break_anim");
	AI.PushGoal("any_break_anim","signal",1,-1,"PLAY_BREAK_ANIMATION",0);
	AI.PushGoal("any_break_anim","timeout",1,0,1);

	AI.CreateGoalPipe("any_end_idle");
	AI.PushGoal("any_end_idle","timeout",1,0,1);
	AI.PushGoal("any_end_idle","signal",1,1,"BackToJob",0);

	AI.CreateGoalPipe("investigate_alarm");
	AI.PushGoal("investigate_alarm","lookat",1,-45,45);
	AI.PushGoal("investigate_alarm","timeout",1,0.5,1.5);
	AI.PushGoal("investigate_alarm","locate",0,"hidepoint");
	AI.PushGoal("investigate_alarm","acqtarget",0,"");
	AI.PushGoal("investigate_alarm","approach",1,0.5);
	AI.PushGoal("investigate_alarm","devalue",1);
	AI.PushGoal("investigate_alarm","lookat",1,-45,45);
	AI.PushGoal("investigate_alarm","timeout",1,0,1);
	AI.PushGoal("investigate_alarm","lookat",1,-45,45);
	AI.PushGoal("investigate_alarm","timeout",1,0,1);

	AI.CreateGoalPipe("run_to_beacon");
	AI.PushGoal("run_to_beacon","setup_combat");
	AI.PushGoal("run_to_beacon","locate",0,"beacon");
	AI.PushGoal("run_to_beacon","pathfind",1,"");
	AI.PushGoal("run_to_beacon","run",0,1);
	AI.PushGoal("run_to_beacon","trace",1,1);
	AI.PushGoal("run_to_beacon","run",0,0);


	AI.CreateGoalPipe("look_at_lastop");
	AI.PushGoal("look_at_lastop","lookat",1,0,0);

	AI.CreateGoalPipe("backoff_from_lastop");
	AI.PushGoal("backoff_from_lastop","ignoreall",0,1);
	AI.PushGoal("backoff_from_lastop","acqtarget",0,"");
	AI.PushGoal("backoff_from_lastop","run",0,1);
	AI.PushGoal("backoff_from_lastop","backoff",1,10);
	AI.PushGoal("backoff_from_lastop","run",0,0);
	AI.PushGoal("backoff_from_lastop","ignoreall",0,0);
	AI.PushGoal("backoff_from_lastop","devalue",0);	

	AI.CreateGoalPipe("backoff_from");
	AI.PushGoal("backoff_from","run",0,1);
	AI.PushGoal("backoff_from","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("backoff_from","backoff",1,5,2);
--	AI.PushGoal("backoff_from","branch",1,"END",IF_ACTIVE_GOALS);
--	AI.PushLabel("backoff_from","END");
--	AI.PushGoal("backoff_from","clear",0,0);

	AI.CreateGoalPipe("backoff_from_explosion");
	AI.PushGoal("backoff_from_explosion","run",0,1.5);
	AI.PushGoal("backoff_from_explosion","+bodypos",0,BODYPOS_STAND);
	AI.PushGoal("backoff_from_explosion","+backoff",1,12,0,AILASTOPRES_USE+AI_LOOK_FORWARD);
	AI.PushGoal("backoff_from_explosion","+timeout",1,5);
	AI.PushGoal("backoff_from_explosion","signal",1,1,"END_BACKOFF",0);

	AI.CreateGoalPipe("backoff_from_grenade");
	AI.PushGoal("backoff_from_grenade","run",0,1.5);
	AI.PushGoal("backoff_from_grenade","+bodypos",0,BODYPOS_STAND);
	AI.PushGoal("backoff_from_grenade","+backoff",1,5,0,AI_LOOK_FORWARD+AI_MOVE_BACKWARD);
	AI.PushGoal("backoff_from_grenade","+branch",1,"PATH_BACK_BAD",IF_NO_PATH);
	AI.PushGoal("backoff_from_grenade","+branch",1,"PATH_BACK_BAD",IF_PATH_LONGER_RELATIVE,9);
	AI.PushGoal("backoff_from_grenade","+branch",1,"SUCCESS",BRANCH_ALWAYS);
	AI.PushLabel("backoff_from_grenade","PATH_BACK_BAD");
	AI.PushGoal("backoff_from_grenade","+backoff",1,5,0,AI_LOOK_FORWARD+AI_MOVE_RIGHT);
	AI.PushGoal("backoff_from_grenade","+branch",1,"PATH_RIGHT_BAD",IF_NO_PATH);
	AI.PushGoal("backoff_from_grenade","+branch",1,"PATH_RIGHT_BAD",IF_PATH_LONGER_RELATIVE,9);
	AI.PushGoal("backoff_from_grenade","+branch",1,"SUCCESS",BRANCH_ALWAYS);
	AI.PushLabel("backoff_from_grenade","PATH_RIGHT_BAD");
	AI.PushGoal("backoff_from_grenade","+backoff",1,5,0,AI_LOOK_FORWARD+AI_MOVE_LEFT);
	AI.PushGoal("backoff_from_grenade","+branch",1,"BACKOFF_FAILED",IF_NO_PATH);
	AI.PushGoal("backoff_from_grenade","+branch",1,"BACKOFF_FAILED",IF_PATH_LONGER_RELATIVE,9);
	AI.PushLabel("backoff_from_grenade","SUCCESS");
	AI.PushGoal("backoff_from_grenade","+signal",1,1,"END_BACKOFF",0);
	AI.PushGoal("backoff_from_grenade","+branch",1,"END",BRANCH_ALWAYS);
	AI.PushLabel("backoff_from_grenade","BACKOFF_FAILED");
	AI.PushGoal("backoff_from_grenade","+signal",1,1,"BACKOFF_FAILED",0);
	AI.PushLabel("backoff_from_grenade","END");
	
	AI.CreateGoalPipe("investigate_grenade_launcher");
	AI.PushGoal("investigate_grenade_launcher","timeout",1,0.1,0,3);
	AI.PushGoal("investigate_grenade_launcher","devalue",0,1);
	AI.PushGoal("investigate_grenade_launcher","signal",1,1,"GO_TO_SEEK",0);
	
		
	AI.CreateGoalPipe("attack_get_in_range");	
	AI.PushGoal("attack_get_in_range","firecmd",0,1);	
	AI.PushGoal("attack_get_in_range","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("attack_get_in_range","run",0,1);
	AI.PushGoal("attack_get_in_range","approach",1,50);
	AI.PushGoal("attack_get_in_range","bodypos",0,BODYPOS_CROUCH);
--	AI.PushGoal("attack_get_in_range","strafe",0,-1);		
--	AI.PushGoal("attack_get_in_range","timeout",1,1);
--	AI.PushGoal("attack_get_in_range","strafe",0,0);
--	AI.PushGoal("attack_get_in_range","strafe",0,1);						
--	AI.PushGoal("attack_get_in_range","timeout",1,2);						
--	AI.PushGoal("attack_get_in_range","strafe",0,0);							

	AI.CreateGoalPipe("backoff_fire");	
	AI.PushGoal("backoff_fire","firecmd",0,1);	
	AI.PushGoal("backoff_fire","strafe",1,10,0);
	AI.PushGoal("backoff_fire","backoff",1,10,0,AI_BACKOFF_FROM_TARGET);
	AI.PushGoal("backoff_fire","firecmd",0,0);	

	AI.CreateGoalPipe("random_long_timeout");
	AI.PushGoal("random_long_timeout","timeout",1,4,8);

	AI.CreateGoalPipe("random_timeout");
	AI.PushGoal("random_timeout","timeout",1,2.5,4);

	AI.CreateGoalPipe("random_short_timeout");
	AI.PushGoal("random_short_timeout","firecmd",0,0);
	AI.PushGoal("random_short_timeout","timeout",1,1.5,3);

	AI.CreateGoalPipe("random_very_short_timeout");
	AI.PushGoal("random_very_short_timeout","firecmd",0,0);
	AI.PushGoal("random_very_short_timeout","timeout",1,0.2,0.6);


	-- to make sure not everybody reacts on fire at same time
	AI.CreateGoalPipe("random_fire_reaction");
	AI.PushGoal("random_fire_reaction","timeout",1,0.5,1.9);
	AI.PushGoal("random_fire_reaction","signal",0,1,"INCOMING_FIRE",0);	-- react on fire


	AI.CreateGoalPipe("setup_idle");	
	AI.PushGoal("setup_idle","firecmd",0,0);	
	AI.PushGoal("setup_idle","bodypos",0,BODYPOS_RELAX);	
	AI.PushGoal("setup_idle","run",0,0);	
	--AI.PushGoal("setup_idle","firecmd",0,0);	

	AI.CreateGoalPipe("setup_crouch");	
	AI.PushGoal("setup_crouch","bodypos",0,BODYPOS_CROUCH);	
	AI.PushGoal("setup_crouch","firecmd",0,1);	

	AI.CreateGoalPipe("setup_prone");	
	AI.PushGoal("setup_prone","bodypos",0,BODYPOS_PRONE);	
	AI.PushGoal("setup_prone","firecmd",0,1);	


	AI.CreateGoalPipe("crouch_cover");
	AI.PushGoal("crouch_cover","setup_crouch");
	AI.PushGoal("crouch_cover","timeout",1,1,1.5);

	AI.CreateGoalPipe("setup_stealth");	
	AI.PushGoal("setup_stealth","bodypos",0,BODYPOS_STEALTH);	
	AI.PushGoal("setup_stealth","run",0,0);	

	AI.CreateGoalPipe("setup_combat");	
--	AI.PushGoal("setup_combat","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("setup_combat","run",0,1);

	AI.CreateGoalPipe("do_it_crouched");
	AI.PushGoal("do_it_crouched","bodypos",1,BODYPOS_CROUCH);	

	AI.CreateGoalPipe("do_it_prone");
	AI.PushGoal("do_it_prone","bodypos",1,BODYPOS_PRONE);	

	AI.CreateGoalPipe("do_it_standing");
	AI.PushGoal("do_it_standing","bodypos",1,BODYPOS_STAND);	

	AI.CreateGoalPipe("do_it_stealth");
	AI.PushGoal("do_it_stealth","bodypos",1,BODYPOS_STEALTH);	

	AI.CreateGoalPipe("do_it_relaxed");
	AI.PushGoal("do_it_relaxed","bodypos",0,BODYPOS_RELAX);	

	AI.CreateGoalPipe("do_it_running");
	AI.PushGoal("do_it_running","run",0,1);
	
	AI.CreateGoalPipe("do_it_sprinting");
	AI.PushGoal("do_it_sprinting","run",0,2);

	AI.CreateGoalPipe("do_it_half_running");
	AI.PushGoal("do_it_half_running","run",0,0.5);

	AI.CreateGoalPipe("do_it_walking");
	AI.PushGoal("do_it_walking","run",0,0);

	
	AI.CreateGoalPipe("do_it_very_slow");
	AI.PushGoal("do_it_very_slow","run",0,-0.2);

	AI.CreateGoalPipe("do_it_super_slow");
	AI.PushGoal("do_it_super_slow","run",0,-0.3);

	AI.CreateGoalPipe("dig_in_attack");
	AI.PushGoal("dig_in_attack","firecmd",0,1);
	AI.PushGoal("dig_in_attack","bodypos",0,BODYPOS_CROUCH);
--	AI.PushGoal("dig_in_attack","signal",1,1,"SHARED_PLAY_GETDOWN_ANIM",0)
--	AI.PushGoal("dig_in_attack","signal",1,1,"CHECK_FOR_SAFETY",0)
	AI.PushGoal("dig_in_attack","timeout",1,0.5,1.5);
	AI.PushGoal("dig_in_attack","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("dig_in_attack","hide",1,20,HM_NEAREST);
--	AI.PushGoal("dig_in_attack","signal",1,1,"SHARED_PLAY_GETUP_ANIM",0)
	AI.PushGoal("dig_in_attack","signal",1,1,"CHECK_FOR_TARGET",0)
	AI.PushGoal("dig_in_attack","firecmd",0,1);
	AI.PushGoal("dig_in_attack","timeout",1,1,3);
	--AI.PushGoal("dig_in_attack","hide",1,20,HM_NEAREST);
	
	AI.CreateGoalPipe("dig_in_shoot_on_spot");
	AI.PushGoal("dig_in_shoot_on_spot","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("dig_in_shoot_on_spot","timeout",1,1,4);
	AI.PushGoal("dig_in_shoot_on_spot","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("dig_in_shoot_on_spot","timeout",1,0.5);
	AI.PushGoal("dig_in_shoot_on_spot","+firecmd",0,1);
	AI.PushGoal("dig_in_shoot_on_spot","+timeout",1,1.0,2.0);
	AI.PushGoal("dig_in_shoot_on_spot","+firecmd",0,0);
	AI.PushGoal("dig_in_shoot_on_spot","ignoreall",0,1);
	AI.PushGoal("dig_in_shoot_on_spot","hide",1,20,HM_NEAREST,1,10);
	AI.PushGoal("dig_in_shoot_on_spot","ignoreall",0,0);

		

	-----------------------------------------------------
	AI.CreateGoalPipe("observe_direction");
	AI.PushGoal("observe_direction","lookat",1,0,0);			-- look at passed object
	AI.PushGoal("observe_direction","timeout",1,1,2);			-- wait at most 1 second
	AI.PushGoal("observe_direction","signal",1,1,"DO_SOMETHING_IDLE",0);	-- do something (or not)
	AI.PushGoal("observe_direction","lookat",1,-90,90);			-- lookaround					
	AI.PushGoal("observe_direction","timeout",1,0.5,1.5);			
	AI.PushGoal("observe_direction","lookat",1,-90,90);			-- again look around			
	AI.PushGoal("observe_direction","timeout",1,0.5,1.5);			
	AI.PushGoal("observe_direction","signal",1,1,"RANDOM_IDLE_SOUND",SIGNALID_READIBILITY);

	-----------------------------------------------------
	AI.CreateGoalPipe("stand_only");
	--AI.PushGoal("stand_only","timeout",1,2,4);
	--AI.PushGoal("stand_only","signal",0,1,"DO_SOMETHING_IDLE",0);	-- do something (or not)

	-----------------------------------------------------
	AI.CreateGoalPipe("stand_and_talk");
	AI.PushGoal("stand_and_talk","timeout",1,8);
	AI.PushGoal("stand_and_talk","signal",0,1,"OnStartTalk",0);	

	-----------------------------------------------------
	AI.CreateGoalPipe("patrol_approach_to");
	AI.PushGoal("patrol_approach_to","setup_idle");
	AI.PushGoal("patrol_approach_to","pathfind",1,"");
--	AI.PushGoal("patrol_approach_to","signal",1,1,"RANDOM_IDLE_SOUND",SIGNALID_READIBILITY);	
	AI.PushGoal("patrol_approach_to","+trace",1,1);
	AI.PushGoal("patrol_approach_to","lookat",1,-45,45);
	AI.PushGoal("patrol_approach_to","+timeout",1,0.5,1.5);
--	AI.PushGoal("patrol_approach_to","lookat",1,-500);	-- turn off lookAt
	AI.PushGoal("patrol_approach_to","signal",0,1,"DO_SOMETHING_IDLE",0);	-- do something (or not)
	AI.PushGoal("patrol_approach_to","signal",0,1,"PatrolPath",0);	-- get next point in path

	-----------------------------------------------------
	AI.CreateGoalPipe("patrol_approach_no_idle");
	AI.PushGoal("patrol_approach_no_idle","setup_idle");
	AI.PushGoal("patrol_approach_no_idle","continuous",0,1);
	AI.PushGoal("patrol_approach_no_idle","+pathfind",1,"",1);
	AI.PushGoal("patrol_approach_no_idle","+trace",1,1);
--	AI.PushGoal("patrol_approach_no_idle","devalue",0);
	AI.PushGoal("patrol_approach_no_idle","continuous",0,1);
	AI.PushGoal("patrol_approach_no_idle","signal",0,1,"PatrolPath",0);	-- get next point in path

	-----------------------------------------------------
	AI.CreateGoalPipe("patrol_approach_running");
	AI.PushGoal("patrol_approach_running","run", 0, 1);
	AI.PushGoal("patrol_approach_running","continuous",0,1);
	AI.PushGoal("patrol_approach_running","+pathfind",1,"",1);
	AI.PushGoal("patrol_approach_running","+trace",1,1);
	AI.PushGoal("patrol_approach_running","signal",0,1,"PatrolPath",0);	-- get next point in path


	-----------------------------------------------------
	AI.CreateGoalPipe("avoid_vehicle");
	AI.PushGoal("avoid_vehicle", "acqtarget", 0, "");
	AI.PushGoal("avoid_vehicle", "ignoreall", 0, 1);
	AI.PushGoal("avoid_vehicle", "clear", 0, 0);
	AI.PushGoal("avoid_vehicle", "ignoreall", 0, 0);
	AI.PushGoal("avoid_vehicle", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("avoid_vehicle", "locate", 0, "refpoint");
	AI.PushGoal("avoid_vehicle", "approach", 0, 2, AILASTOPRES_USE);
	AI.PushLabel("avoid_vehicle", "WAIT");
		AI.PushGoal("avoid_vehicle", "timeout", 1, 0.1);
	AI.PushGoal("avoid_vehicle", "branch", 0, "WAIT");
	AI.PushGoal("avoid_vehicle", "signal", 0, 1, "OnRestoreVehicleDanger", 0);

	-----------------------------------------------------
	AI.CreateGoalPipe("avoid_vehicle_running");
	AI.PushGoal("avoid_vehicle_running", "acqtarget", 0, "");
	AI.PushGoal("avoid_vehicle_running", "ignoreall", 0, 1);
	AI.PushGoal("avoid_vehicle_running", "clear", 0, 0);
	AI.PushGoal("avoid_vehicle_running", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("avoid_vehicle_running", "run", 0, 1.5);
	AI.PushGoal("avoid_vehicle_running", "locate", 0, "refpoint");
	AI.PushGoal("avoid_vehicle_running", "approach", 0, 2, AILASTOPRES_USE+AILASTOPRES_LOOKAT);
	AI.PushLabel("avoid_vehicle_running", "WAIT");
		AI.PushGoal("avoid_vehicle_running", "timeout", 1, 0.1);
	AI.PushGoal("avoid_vehicle_running", "branch", 0, "WAIT");
	AI.PushGoal("avoid_vehicle_running", "run", 0, 1);
	AI.PushGoal("avoid_vehicle_running", "ignoreall", 0, 0);
	AI.PushGoal("avoid_vehicle_running", "signal", 0, 1, "OnRestoreVehicleDanger", 0);

	-----------------------------------------------------
	AI.CreateGoalPipe("acquire_lastop");
	AI.PushGoal("acquire_lastop", "acqtarget", 0, "");

	-----------------------------------------------------
	AI.CreateGoalPipe("patrol_run_to");
	AI.PushGoal("patrol_run_to","ignoreall",0,1);
	AI.PushGoal("patrol_run_to","+acqtarget",1,"");
	AI.PushGoal("patrol_run_to","+pathfind",1,"");
	AI.PushGoal("patrol_run_to","+run",1,1);
	AI.PushGoal("patrol_run_to","+trace",1,1);
	AI.PushGoal("patrol_run_to","ignoreall",0,0);
	AI.PushGoal("patrol_run_to","devalue",0);






	-----------------------------------------------------
	AI.CreateGoalPipe("investigate_to");
	AI.PushGoal("investigate_to","pathfind",1,"");
	AI.PushGoal("investigate_to","trace",0,1);
	AI.PushGoal("investigate_to","lookat",1,-90,90);
	AI.PushGoal("investigate_to","branch",1,-1);
	AI.PushGoal("investigate_to","lookat",1,0,0);
	AI.PushGoal("investigate_to","devalue",0);
	AI.PushGoal("investigate_to","lookat",1,-45,45);
	AI.PushGoal("investigate_to","timeout",1,0.5,1.5);
	
	AI.CreateGoalPipe("investigate_wrapper");
	AI.PushGoal("investigate_wrapper","timeout",1,0.5,1.5);
	AI.PushGoal("investigate_wrapper","signal",1,1,"TAKE_NEXT_INVESTIGATION_POINT",0);
	AI.PushGoal("investigate_wrapper","timeout",1,0.5,1.5);
	

	----------------------------------------------------
	AI.CreateGoalPipe("disturbance_let_it_go");
	AI.PushGoal("disturbance_let_it_go","setup_idle");
	AI.PushGoal("disturbance_let_it_go","timeout",1,1,2);
	AI.PushGoal("disturbance_let_it_go","signal",0,1,"DO_LETGO_ANIMATION",0);
	AI.PushGoal("disturbance_let_it_go","timeout",1,0,1);
	AI.PushGoal("disturbance_let_it_go","signal",0,1,"RETURN_TO_FIRST",0);

	----------------------------------------------------

	AI.CreateGoalPipe("take_cover");
	AI.PushGoal("take_cover","run",0,1);
	AI.PushGoal("take_cover","+hide",1,10,HM_NEAREST,1);
	AI.PushGoal("take_cover","run",0,0);

	AI.CreateGoalPipe("civ_hide");
	AI.PushGoal("civ_hide","run",0,1);
	AI.PushGoal("civ_hide","+hide",1,20,HM_NEAREST);
	AI.PushGoal("civ_hide","branch",1,"NOHIDE",IF_CANNOT_HIDE);
	AI.PushGoal("civ_hide","bodypos",1,BODYPOS_CROUCH);
	AI.PushGoal("civ_hide","signal",0,1,"END_HIDE",SIGNALFILTER_SENDER);
	AI.PushGoal("civ_hide","branch",1,"END",BRANCH_ALWAYS);
	AI.PushLabel("civ_hide","NOHIDE");
	AI.PushGoal("civ_hide","signal",0,1,"GO_TO_COWER",SIGNALFILTER_SENDER);
	AI.PushLabel("civ_hide","END");
	
	AI.CreateGoalPipe("civ_surrender");
	AI.PushGoal("civ_surrender","run",0,0);
	AI.PushGoal("civ_surrender","devalue",1,0);
	AI.PushGoal("civ_surrender","ignoreall",1,1);
	--AI.PushGoal("civ_surrender","bodypos",1,BODYPOS_CROUCH);
	--AI.PushGoal("civ_surrender", "animation", 1, AIANIM_ACTION, "surrenderKneel", 0.5, 25, 0.5 );
	AI.PushGoal("civ_surrender", "animation", 1, AIANIM_ACTION, "surrenderKneel" );
	AI.PushGoal("civ_surrender","signal",0,1,"surrender",SIGNALID_READIBILITY);

	AI.CreateGoalPipe("civ_cower");
	AI.PushGoal("civ_cower","run",0,1);
	AI.PushGoal("civ_cower","devalue",1,0);
	--AI.PushGoal("civ_cower","ignoreall",1,1);
	AI.PushGoal("civ_cower","bodypos",1,BODYPOS_RELAX);
	AI.PushGoal("civ_cower","+animation", 1, AIANIM_ACTION, "cower", -1);

	AI.CreateGoalPipe("civ_go_to_cower");
	AI.PushGoal("civ_go_to_cower","run",0,1);
	AI.PushGoal("civ_go_to_cower","devalue",1,0);
	--AI.PushGoal("civ_go_to_cower","ignoreall",1,1);
	AI.PushGoal("civ_go_to_cower","bodypos",1,BODYPOS_RELAX);
	AI.PushGoal("civ_go_to_cower","+animtarget", 0, 0, "cower", 0.5, 25, 0.5 );
	AI.PushGoal("civ_go_to_cower","+locate",1,"refpoint");
	AI.PushGoal("civ_go_to_cower","+approach",1,0.3,AILASTOPRES_USE);

	AI.CreateGoalPipe("civ_report_contact");
	AI.PushGoal("civ_report_contact","run",0,1);
	AI.PushGoal("civ_report_contact","stick",1,2,AILASTOPRES_USE,1);
	AI.PushGoal("civ_report_contact","branch",1,"END",IF_NO_PATH);
	AI.PushGoal("civ_report_contact","signal",0,1,"REPORT_CONTACT",SIGNALFILTER_NEARESTINCOMM);
	AI.PushGoal("civ_report_contact","signal",0,1,"reportcontact",SIGNALID_READIBILITY);
	AI.PushGoal("civ_report_contact", "animation", 1, AIANIM_SIGNAL, "signalFollow");
	AI.PushLabel("civ_report_contact", "END");
	AI.PushGoal("civ_report_contact","signal",0,1,"GO_TO_HIDE",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("go_to_cowering_civilian");
	AI.PushGoal("go_to_cowering_civilian","timeout",1,1,1.4);
	AI.PushGoal("go_to_cowering_civilian","run",0,1);
	AI.PushGoal("go_to_cowering_civilian","acqtarget",1,"");
	AI.PushGoal("go_to_cowering_civilian","approach",1,1);
	AI.PushGoal("go_to_cowering_civilian","branch",1,"END",IF_NO_PATH);
	--AI.PushGoal("go_to_cowering_civilian","bodypos",1,BODYPOS_CROUCH);
	AI.PushGoal("go_to_cowering_civilian","signal",0,1,"REPORT_ME",SIGNALFILTER_LASTOP);
	AI.PushGoal("go_to_cowering_civilian","timeout",1,4);
	--AI.PushGoal("go_to_cowering_civilian","signal",0,1,"INVESTIGATE_CIVILIAN_THREAT",SIGNALFILTER_SENDER);
	AI.PushGoal("go_to_cowering_civilian","acqtarget",1,"beacon");
	--AI.PushGoal("go_to_cowering_civilian","cv_seek_target_random");
	AI.PushGoal("go_to_cowering_civilian","signal",0,1,"GET_ALERTED",SIGNALFILTER_GROUPONLY);
	AI.PushGoal("go_to_cowering_civilian","signal",0,1,"CHECK_CIVILIAN_THREATEN",SIGNALFILTER_SENDER);
	AI.PushLabel("go_to_cowering_civilian", "END");
	
	AI.CreateGoalPipe("civ_report_contact_inplace");
	AI.PushGoal("civ_report_contact_inplace", "animation", 1, AIANIM_SIGNAL, "signalFollow");
	AI.PushGoal("civ_report_contact_inplace","timeout",1,0.8,1.3);
	AI.PushGoal("civ_report_contact_inplace","signal",0,1,"GO_TO_HIDE",SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("civ_captured");
	AI.PushGoal("civ_captured","run",0,1);
	AI.PushGoal("civ_captured","bodypos",1,BODYPOS_STAND);
	--AI.PushGoal("civ_captured","strafe",1,2,2);
	AI.PushGoal("civ_captured","locate", 1, "formation_special");
	AI.PushGoal("civ_captured","acqtarget", 1, "formationsight");
	AI.PushGoal("civ_captured","locate", 1, "formation_special");
	AI.PushGoal("civ_captured","approach",1,0.1,AILASTOPRES_USE);
	--AI.PushGoal("civ_captured","move",1,0.3,0.5,AILASTOPRES_USE);
	

	AI.CreateGoalPipe("short_timeout");
	AI.PushGoal("short_timeout","timeout",1,1,1.2);
	AI.PushGoal("short_timeout","signal",0,1,"END_TIMEOUT",SIGNALFILTER_SENDER);


	AI.CreateGoalPipe("shoot_cover");
	AI.PushGoal("shoot_cover","firecmd",0,2);
	AI.PushGoal("shoot_cover","run",0,1);
	AI.PushGoal("shoot_cover","+hide",1,10,HM_NEAREST);
	AI.PushGoal("shoot_cover","run",0,0);
	AI.PushGoal("shoot_cover","firecmd",0,0);

	


	AI.CreateGoalPipe("cover_threatened");
	AI.PushGoal("cover_threatened","DRAW_GUN"); 
	AI.PushGoal("cover_threatened","setup_combat");
	AI.PushGoal("cover_threatened","timeout",1,0.2,0.8); 
	AI.PushGoal("cover_threatened","signal",1,1,"DO_THREATENED_ANIMATION",0);
	AI.PushGoal("cover_threatened","take_cover");
	AI.PushGoal("cover_threatened","timeout",1,0.5,1); 

	AI.CreateGoalPipe("cover_investigate_threat");
	AI.PushGoal("cover_investigate_threat","firecmd",0,1);	
	AI.PushGoal("cover_investigate_threat","run",0,0);	
	AI.PushGoal("cover_investigate_threat","approach",1,0.7);	-- approach a little
	AI.PushGoal("cover_investigate_threat","timeout",1,0.5,1.5);	

	AI.CreateGoalPipe("comeout");
	AI.PushGoal("comeout","firecmd",0,1)
	AI.PushGoal("comeout","locate",0,"atttarget");
	AI.PushGoal("comeout","pathfind",1,"");
	AI.PushGoal("comeout","trace",1,0,1);

	AI.CreateGoalPipe("comeout_standfire");
	AI.PushGoal("comeout_standfire","comeout");
	AI.PushGoal("comeout_standfire","timeout",1,0.5,1.5);

	AI.CreateGoalPipe("comeout_crouchfire");
	AI.PushGoal("comeout_crouchfire","setup_crouch");
	AI.PushGoal("comeout_crouchfire","comeout");
	AI.PushGoal("comeout_crouchfire","timeout",1,0.5,1.5);
	AI.PushGoal("comeout_crouchfire","setup_combat");

	AI.CreateGoalPipe("just_shoot");
--	AI.PushGoal("just_shoot","firecmd",0,FIREMODE_CONTINUOUS);
	AI.PushGoal("just_shoot","firecmd",0,FIREMODE_BURST);	
	AI.PushGoal("just_shoot","timeout",1,1,2);

	AI.CreateGoalPipe("just_shoot_kill");
	AI.PushGoal("just_shoot_kill","firecmd",0,FIREMODE_KILL);	
	AI.PushGoal("just_shoot_kill","timeout",1,1);
	
	AI.BeginGoalPipe("just_shoot_advance");
		AI.PushGoal("approach",1,1);	-- advance to target
	AI.EndGoalPipe();
	
	AI.CreateGoalPipe("just_shoot_done");
	AI.PushGoal("just_shoot_done","firecmd",0,FIREMODE_OFF);	
	AI.PushGoal("just_shoot_done", "signal", 1, 1, "FASTKILL_EXIT", 0);	

	AI.CreateGoalPipe("dumb_shoot");
	AI.PushGoal("dumb_shoot","locate",0,"beacon");
	AI.PushGoal("dumb_shoot","acqtarget",0,"");
	AI.PushGoal("dumb_shoot","firecmd",0,FIREMODE_FORCED, AILASTOPRES_USE);
	AI.PushGoal("dumb_shoot","timeout",1,1);
	AI.PushGoal("dumb_shoot","firecmd",0,FIREMODE_OFF);	

	AI.CreateGoalPipe("dumb_shoot_timout");
	AI.PushGoal("dumb_shoot_timout","locate",0,"beacon");
--	AI.PushGoal("dumb_shoot_timout","acqtarget",0,"");
	AI.PushGoal("dumb_shoot_timout","firecmd",0,FIREMODE_FORCED, AILASTOPRES_USE);
	AI.PushGoal("dumb_shoot_timout","timeout",1,.7,1.2);
	AI.PushGoal("dumb_shoot_timout","firecmd",0,0);
	AI.PushGoal("dumb_shoot_timout","timeout",1,.5,1.1);


	AI.CreateGoalPipe("get_out_of_cover");
	AI.PushGoal("get_out_of_cover", "run", 0, 0);	
	AI.PushGoal("get_out_of_cover", "signal", 1, 1, "UNHIDE", 0);
	AI.PushGoal("get_out_of_cover", "timeout", 1, 0.3, 0.33);	
	AI.PushGoal("get_out_of_cover", "timeout", 1, 1, 1.3);	
	AI.PushGoal("get_out_of_cover","signal",0,1,"LOOK_FOR_TARGET",0);

	AI.CreateGoalPipe("get_out_of_cover_forget");
	AI.PushGoal("get_out_of_cover_forget", "run", 0, 0);	
	AI.PushGoal("get_out_of_cover_forget", "signal", 1, 1, "UNHIDE", 0);
	AI.PushGoal("get_out_of_cover_forget", "clear", 0, 1); -- 1 means forget att. target
	AI.PushGoal("get_out_of_cover_forget", "timeout", 1, 1, 1.3);	
	AI.PushGoal("get_out_of_cover_forget","signal",0,1,"LOOK_FOR_TARGET",0);

	AI.CreateGoalPipe("get_out_of_cover_timeout");
	AI.PushGoal("get_out_of_cover_timeout", "run", 0, 0);	
	AI.PushGoal("get_out_of_cover_timeout", "+approach", 0, 1);
	AI.PushGoal("get_out_of_cover_timeout", "+timeout", 1, .73, 1.1);
--	AI.PushGoal("get_out_of_cover_timeout", "firecmd", 0, 2);
	AI.PushGoal("get_out_of_cover_timeout", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("get_out_of_cover_timeout", "timeout", 1, 1, 1.3);	
	AI.PushGoal("get_out_of_cover_timeout","signal",0,1,"LOOK_FOR_TARGET",0);

	AI.CreateGoalPipe("seek_target");
	AI.PushGoal("seek_target","approach",1,1);
--	AI.PushGoal("seek_target","hide",1,20,HM_FRONTLEFTMOST_FROM_TARGET);
	AI.PushGoal("seek_target","signal",0,1,"LOOK_FOR_TARGET",0);

	AI.CreateGoalPipe("seek_target_random");
	AI.PushGoal("seek_target_random","locate", 0, "beacon");
	AI.PushGoal("seek_target_random","locate", 0, "hidepoint_lastop");
	AI.PushGoal("seek_target_random","+approach",0,3);	
	AI.PushGoal("seek_target_random","+lookat",0,-90,90,0,1);
	AI.PushGoal("seek_target_random","+timeout",1,1.1,1.3);
	AI.PushGoal("seek_target_random","+lookat",1,-890,90);
	AI.PushGoal("seek_target_random","+branch", 0, -3, IF_PATH_LONGER, 3);	
	AI.PushGoal("seek_target_random","clear",0,1);	-- 
--	AI.PushGoal("seek_target_random","hide",1,20,HM_RANDOM_AROUND_LASTOPRESULT);
--	AI.PushGoal("seek_target_random","timeout",1,.2,.3);	
	AI.PushGoal("seek_target_random","signal",0,1,"LOOK_FOR_TARGET",0);

	AI.CreateGoalPipe("seek_target_left");
	AI.PushGoal("seek_target_left","hide",1,20,HM_FRONTLEFTMOST_FROM_TARGET);
	AI.PushGoal("seek_target_left","signal",0,1,"LOOK_FOR_TARGET",0);
	
	AI.CreateGoalPipe("seek_target_left2");
	AI.PushGoal("seek_target_left2","hide",1,20,HM_LEFTMOST_FROM_TARGET);
	AI.PushGoal("seek_target_left2","signal",0,1,"LOOK_FOR_TARGET",0);

	AI.CreateGoalPipe("seek_target_right");
	AI.PushGoal("seek_target_right","hide",1,20,HM_FRONTRIGHTMOST_FROM_TARGET);
	AI.PushGoal("seek_target_right","signal",0,1,"LOOK_FOR_TARGET",0);
	
	AI.CreateGoalPipe("seek_target_right2");
	AI.PushGoal("seek_target_right2","hide",1,20,HM_RIGHTMOST_FROM_TARGET);
	AI.PushGoal("seek_target_right2","signal",0,1,"LOOK_FOR_TARGET",0);


	AI.CreateGoalPipe("confirm_targetloss");
	AI.PushGoal("confirm_targetloss","setup_stealth");
	AI.PushGoal("confirm_targetloss","locate",0,"beacon");
	AI.PushGoal("confirm_targetloss","acqtarget",0,"");
	AI.PushGoal("confirm_targetloss","approach",1,1);
	AI.PushGoal("confirm_targetloss","devalue",0);

	AI.CreateGoalPipe("look_around");
	AI.PushGoal("look_around","lookat",1,-180,180);
	AI.PushGoal("look_around","timeout",1,3,5);
	
	AI.CreateGoalPipe("look_around_quick");
	AI.PushGoal("look_around_quick","lookat",1,-180,180);
	AI.PushGoal("look_around_quick","timeout",1,1,2);
	

	AI.CreateGoalPipe("delayed_headsup");
	AI.PushGoal("delayed_headsup","lookat",1,-180,180);
	AI.PushGoal("delayed_headsup","timeout",1,3,4);
	AI.PushGoal("delayed_headsup","signal",0,1,"HEADS_UP_GUYS",SIGNALFILTER_GROUPONLY_EXCEPT);	

	AI.CreateGoalPipe("delayed_notarget");
	AI.PushGoal("delayed_notarget","lookat",1,-180,180);
	AI.PushGoal("delayed_notarget","timeout",1,3,4);
	AI.PushGoal("delayed_notarget","signal",0,1,"OnNoTarget",SIGNALFILTER_SENDER);	

	

	AI.CreateGoalPipe("getting_shot_at");
	AI.PushGoal("getting_shot_at","clear",0,1);	-- get to cover, nothing else matters
	AI.PushGoal("getting_shot_at","ignoreall",0,1);	-- get to cover, nothing else matters
	AI.PushGoal("getting_shot_at","take_cover");
	AI.PushGoal("getting_shot_at","DRAW_GUN");
	AI.PushGoal("getting_shot_at","setup_combat");	-- now regroup
	AI.PushGoal("getting_shot_at","signal",0,1,"INVESTIGATE_TARGET",0);

	AI.CreateGoalPipe("approach_beacon");
	AI.PushGoal("approach_beacon","locate",0,"beacon");
	AI.PushGoal("approach_beacon","+acqtarget",0,"");
	AI.PushGoal("approach_beacon","+approach",1,1);
	AI.PushGoal("approach_beacon","lookat",1,-180,180);
	AI.PushGoal("approach_beacon","lookat",1,-180,180);

	AI.CreateGoalPipe("shoot_from_spot");
	AI.PushGoal("shoot_from_spot","pathfind",1,"");
	AI.PushGoal("shoot_from_spot","+trace",1,0);
	AI.PushGoal("shoot_from_spot","timeout",1,3,5);

	AI.CreateGoalPipe("run_to_trigger");
	AI.PushGoal("run_to_trigger","setup_combat");
	AI.PushGoal("run_to_trigger","acqtarget",0,"");
	AI.PushGoal("run_to_trigger","pathfind",1,"");
	AI.PushGoal("run_to_trigger","run",0,1);
	AI.PushGoal("run_to_trigger","trace",1,1);
	AI.PushGoal("run_to_trigger","run",0,0);
	AI.PushGoal("run_to_trigger","ignoreall",0,0);
	AI.PushGoal("run_to_trigger","signal",1,-1,"EXIT_RUNTOALARM",0);
	AI.PushGoal("run_to_trigger","clear",0,1);

	AI.CreateGoalPipe("simple_approach_to")
	AI.PushGoal("simple_approach_to","acqtarget",0,"");
	AI.PushGoal("simple_approach_to","approach",1,3);
	AI.PushGoal("simple_approach_to","signal",1,1,"CONVERSATION_START",0);
	AI.PushGoal("simple_approach_to","clear",1,1);


	AI.CreateGoalPipe("approach_to_lastop");
	AI.PushGoal("approach_to_lastop","pathfind",1,"");
	AI.PushGoal("approach_to_lastop","trace",1,1);

	AI.CreateGoalPipe("lean_right_attack");
	AI.PushGoal("lean_right_attack","firecmd",0,1);
	AI.PushGoal("lean_right_attack","signal",1,1,"CLEAR_SUCCESS_FLAG",0);
	AI.PushGoal("lean_right_attack","signal",1,1,"LEAN_RIGHT_ANIM",0);
	AI.PushGoal("lean_right_attack","signal",1,1,"CHECK_SUCCESS_FLAG",0);
	AI.PushGoal("lean_right_attack","hide",1,10,HM_NEAREST);
	AI.PushGoal("lean_right_attack","signal",1,1,"TO_PREVIOUS",0);



	AI.CreateGoalPipe("lean_left_attack");
	AI.PushGoal("lean_left_attack","firecmd",0,1);
	AI.PushGoal("lean_left_attack","signal",1,1,"CLEAR_SUCCESS_FLAG",0);
	AI.PushGoal("lean_left_attack","signal",1,1,"LEAN_LEFT_ANIM",0);
	AI.PushGoal("lean_left_attack","signal",1,1,"CHECK_SUCCESS_FLAG",0);
	AI.PushGoal("lean_left_attack","hide",1,10,HM_NEAREST);
	AI.PushGoal("lean_left_attack","signal",1,1,"TO_PREVIOUS",0);

--	AI.CreateGoalPipe("goto_mounted_weapon");
--	AI.PushGoal("goto_mounted_weapon","signal",1,1,"MAKE_ME_IGNORANT",0)
--	AI.PushGoal("goto_mounted_weapon","acqtarget",1,"")
--	AI.PushGoal("goto_mounted_weapon","bodypos",0,BODYPOS_STAND)
--	AI.PushGoal("goto_mounted_weapon","run",1,1)
--	AI.PushGoal("goto_mounted_weapon","approach",1,1)
--	AI.PushGoal("goto_mounted_weapon","signal",1,-1,"USE_MOUNTED_WEAPON",0);
--
--
--	AI.CreateGoalPipe("use_mounted_weapon");
--	AI.PushGoal("use_mounted_weapon","firecmd",1,1)
--	AI.PushGoal("use_mounted_weapon","timeout",1,1,2)
--	AI.PushGoal("use_mounted_weapon","clear",1,1)

	AI.CreateGoalPipe("delay_headsup");
	AI.PushGoal("delay_headsup","DropBeaconAt");
	AI.PushGoal("delay_headsup","ignoreall",1,1);
	AI.PushGoal("delay_headsup","bodypos",1,BODYPOS_STAND);
	AI.PushGoal("delay_headsup","run",1,1);
	AI.PushGoal("delay_headsup","acqtarget",1,"");
	AI.PushGoal("delay_headsup","+signal",1,1,"GET_REINFORCEMENTS",SIGNALID_READIBILITY);
	AI.PushGoal("delay_headsup","+approach",1,1);
	AI.PushGoal("delay_headsup","signal",1,1,"wakeup",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("delay_headsup","signal",1,1,"HEADS_UP_GUYS",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("delay_headsup","signal",1,1,"CALL_REINFORCEMENTS",SIGNALID_READIBILITY);
	AI.PushGoal("delay_headsup","ignoreall",0,0);
	AI.PushGoal("delay_headsup","timeout",1,0.2);

	AI.CreateGoalPipe("hide_sometime");
	AI.PushGoal("hide_sometime","take_cover");
	AI.PushGoal("hide_sometime","timeout",1,1,3);

	AI.CreateGoalPipe("search_for_target");
	AI.PushGoal("search_for_target","setup_stealth");
	AI.PushGoal("search_for_target","run",0,0);
	AI.PushGoal("search_for_target","firecmd",0,0);
	AI.PushGoal("search_for_target","locate",0,"beacon");
	AI.PushGoal("search_for_target","pathfind",1,"");
	AI.PushGoal("search_for_target","trace",1,1);
	AI.PushGoal("search_for_target","locate",0,"hidepoint");
	AI.PushGoal("search_for_target","acqtarget",1,"");
	AI.PushGoal("search_for_target","approach",1,3);
	AI.PushGoal("search_for_target","devalue",0);	
	AI.PushGoal("search_for_target","timeout",1,1,3);
	AI.PushGoal("search_for_target","lookat",1,-90,90);
	AI.PushGoal("search_for_target","timeout",1,1,3);
	AI.PushGoal("search_for_target","lookat",1,-90,90);

	AI.CreateGoalPipe("walk_to_target");
	AI.PushGoal("walk_to_target","firecmd",0,0);
	AI.PushGoal("walk_to_target","run",0,0);
	AI.PushGoal("walk_to_target","approach",1,1.5);

	AI.CreateGoalPipe("go_to_sleep");
	AI.PushGoal("go_to_sleep","walk_to_target");
	AI.PushGoal("go_to_sleep","lookat",1,0,0);
	AI.PushGoal("go_to_sleep","timeout",1,2,2.5);
	AI.PushGoal("go_to_sleep","signal",1,1,"LAY_DOWN",0);
	
	AI.CreateGoalPipe("sleep");
	AI.PushGoal("sleep","timeout",1,10);

	AI.CreateGoalPipe("practice_shot");
	AI.PushGoal("practice_shot","firecmd",0,0);
	AI.PushGoal("practice_shot","acqtarget",0,"");
	AI.PushGoal("practice_shot","signal",1,1,"DO_SOMETHING_SPECIAL",0);
	AI.PushGoal("practice_shot","timeout",1,0.5,1.5);
	AI.PushGoal("practice_shot","setup_combat");
	AI.PushGoal("practice_shot","firecmd",0,2);
	AI.PushGoal("practice_shot","timeout",1,2,4);



	AI.CreateGoalPipe("pause_shooting");
	AI.PushGoal("pause_shooting","firecmd",0,0);
	AI.PushGoal("pause_shooting","timeout",1,0.5,1.5);
	AI.PushGoal("pause_shooting","firecmd",0,1);

	AI.CreateGoalPipe("stop_fire");
	AI.PushGoal("stop_fire","firecmd",1,0);

	AI.CreateGoalPipe("start_fire");
	AI.PushGoal("start_fire","firecmd",1,1);

	AI.CreateGoalPipe("long_timeout");
	AI.PushGoal("long_timeout","timeout",1,10,12);
	AI.PushGoal("long_timeout","signal",1,1,"END_TIMEOUT",0);

	AI.CreateGoalPipe("medium_timeout");
	AI.PushGoal("medium_timeout","timeout",1,4,6);
	AI.PushGoal("medium_timeout","signal",1,1,"END_TIMEOUT",0);


	AI.CreateGoalPipe("medium_timeout_ignoring");
	AI.PushGoal("medium_timeout_ignoring","ignoreall",0,1);		
	AI.PushGoal("medium_timeout_ignoring","timeout",1,4,6);
	AI.PushGoal("medium_timeout_ignoring","ignoreall",0,0);
	
end



