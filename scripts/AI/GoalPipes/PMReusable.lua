
function PipeManager:InitReusable()

	AI.CreateGoalPipe("stance_relaxed");
	AI.PushGoal("stance_relaxed", "bodypos", 0, 3);

	AI.CreateGoalPipe("stance_stand");
	AI.PushGoal("stance_stand", "bodypos", 0, 0);

	AI.CreateGoalPipe("protect_vehicle");
	AI.PushGoal("protect_vehicle","run",0,0);
	AI.PushGoal("protect_vehicle","approach",0,1.1,AILASTOPRES_USE);
	AI.PushGoal("protect_vehicle","devalue",0);
	AI.PushGoal("protect_vehicle","timeout",0,5,15);
	AI.PushGoal("protect_vehicle","firecmd",0,0);
	AI.PushGoal("protect_vehicle","bodypos",0,BODYPOS_STAND);
	AI.PushLabel("protect_vehicle","WAIT");
		AI.PushGoal("protect_vehicle","lookaround",1,60);
		AI.PushGoal("protect_vehicle","timeout",1,0.2,0.4);
		AI.PushGoal("protect_vehicle","lookaround",1,5);
		AI.PushGoal("protect_vehicle","timeout",1,0.2,0.4);
		AI.PushGoal("protect_vehicle","lookaround",1,5);
		AI.PushGoal("protect_vehicle","timeout",1,0.2,0.4);
		AI.PushGoal("protect_vehicle","lookaround",1,5);
		AI.PushGoal("protect_vehicle","timeout",1,0.2,0.4);
		AI.PushGoal("protect_vehicle","lookaround",1,5);
		AI.PushGoal("protect_vehicle","timeout",1,0.2,0.4);
	AI.PushGoal("protect_vehicle","branch",0,"WAIT");
	AI.PushGoal("protect_vehicle","clear",0,0);	
	AI.PushGoal("protect_vehicle","signal",1,1,"SELECT_RANDOM_ANCHOR",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("protect_vehicle_attack");
	AI.PushGoal("protect_vehicle_attack","clear",0,0);
	AI.PushGoal("protect_vehicle_attack","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("protect_vehicle_attack","firecmd",0,1);
	AI.PushGoal("protect_vehicle_attack","timeout",1,1.0,1.6);
	AI.PushGoal("protect_vehicle_attack","throw_grenade");
	AI.PushGoal("protect_vehicle_attack","firecmd",0,0);
	AI.PushGoal("protect_vehicle_attack","+run",0,1);
	AI.PushGoal("protect_vehicle_attack","+bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("protect_vehicle_attack","+hide",1,25,HM_BEHIND_VEHICLES,1);  [mikko] Hide method deprecated.
	AI.PushGoal("protect_vehicle_attack","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("protect_vehicle_attack","firecmd",0,1);
	AI.PushGoal("protect_vehicle_attack","timeout",1,0.2,0.4);
	AI.PushGoal("protect_vehicle_attack","timeout",1,0.2,0.4);
	AI.PushGoal("protect_vehicle_attack","timeout",1,0.2,0.4);
	AI.PushGoal("protect_vehicle_attack","timeout",1,0.2,0.4);
	AI.PushGoal("protect_vehicle_attack","timeout",1,0.2,0.4);
	AI.PushGoal("protect_vehicle_attack","approach",0,0);
	AI.PushGoal("protect_vehicle_attack","+bodypos",0,BODYPOS_STAND);
	AI.PushGoal("protect_vehicle_attack","+timeout",1,1.5,2.5);
	
	AI.CreateGoalPipe("look_at_lastop");
	AI.PushGoal("look_at_lastop","lookat",1,0,0,1);
	
	AI.CreateGoalPipe("short_look_at_lastop");
	AI.PushGoal("short_look_at_lastop","lookat",1,0,0,1);
	AI.PushGoal("short_look_at_lastop","+timeout",1,1.1,1.4);
	AI.PushGoal("short_look_at_lastop","+lookat",1,-500);

	AI.CreateGoalPipe("ignore_all_lookat_refpoint");
	AI.PushGoal("ignore_all_lookat_refpoint","ignoreall",0,1); 
	AI.PushGoal("ignore_all_lookat_refpoint","locate",0,"refpoint");
	AI.PushGoal("ignore_all_lookat_refpoint","acqtarget",0,"");

	
	AI.CreateGoalPipe("stop_formation_delay");
	AI.PushGoal("stop_formation_delay", "continuous", 0, 1);
	AI.PushGoal("stop_formation_delay","timeout",1,1.5,2);
	AI.PushGoal("stop_formation_delay", "continuous", 0, 0);
	AI.PushGoal("stop_formation_delay","signal",1,1,"STOP_MOVING",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("short_wait");
	AI.PushGoal("short_wait","timeout",1,0.3);

	AI.CreateGoalPipe("wait_few_seconds");
	AI.PushGoal("wait_few_seconds","timeout",1,1.5,3);
	AI.PushGoal("wait_few_seconds","signal",1,1,"END_WAIT",SIGNALFILTER_SENDER);

	AI.BeginGoalPipe("fire_pause");
		AI.PushGoal("firecmd",0,FIREMODE_OFF);
		AI.PushGoal("timeout",1,.2);
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
	AI.EndGoalPipe();	


	AI.CreateGoalPipe("do_nothing");
	AI.PushGoal("do_nothing","firecmd",0,0);	

	AI.CreateGoalPipe("clear_devalued");
	AI.PushGoal("clear_devalued", "devalue", 1,0,1);

	AI.CreateGoalPipe("clear_all");
	AI.PushGoal("clear_all", "clear", 0,1);

	AI.CreateGoalPipe("clear_goalpipes");
	AI.PushGoal("clear_goalpipes", "clear", 0);

	AI.CreateGoalPipe("devalue_target");
	AI.PushGoal("devalue_target", "devalue", 0,1);

	AI.CreateGoalPipe("continuous_move");
	AI.PushGoal("continuous_move", "continuous", 0,1);

	AI.CreateGoalPipe("not_continuous_move");
	AI.PushGoal("not_continuous_move", "continuous", 0,0);

	AI.CreateGoalPipe("acquire_target");
	AI.PushGoal("acquire_target","acqtarget",0,""); 

	AI.CreateGoalPipe("ignore_all");
	AI.PushGoal("ignore_all","ignoreall",0,1); 

	AI.CreateGoalPipe("ignore_none");
	AI.PushGoal("ignore_none","ignoreall",0,0); 


	AI.CreateGoalPipe("look_at_player");
	AI.PushGoal("look_at_player", "locate", 0, "player");
	AI.PushGoal("look_at_player", "acqtarget", 0, "");

	AI.CreateGoalPipe("look_at_player_5sec");
	AI.PushGoal("look_at_player_5sec", "locate", 0, "player");
	AI.PushGoal("look_at_player_5sec", "+lookat", 0,0,0,true);
	AI.PushGoal("look_at_player_5sec", "+timeout",1,4.6,5.3);
	AI.PushGoal("look_at_player_5sec", "+lookat", 0,-500);

	AI.CreateGoalPipe("look_at_player_2sec");
	AI.PushGoal("look_at_player_2sec", "locate", 0, "player");
	AI.PushGoal("look_at_player_2sec", "+lookat", 0,0,0,true);
	AI.PushGoal("look_at_player_2sec", "+timeout",1,1.7,2.3);
	AI.PushGoal("look_at_player_2sec", "+lookat", 0,-500);


	AI.CreateGoalPipe("shoot_and_wait");
--	AI.PushGoal("shoot_and_wait","locate",0,"refpoint");
	AI.PushGoal("shoot_and_wait","acqtarget",0,"");
	AI.PushGoal("shoot_and_wait","ignoreall",0,1);
	AI.PushGoal("shoot_and_wait","signal",1,1,"SHOOT_NOW",SIGNALFILTER_SENDER);
	AI.PushGoal("shoot_and_wait","timeout",1,1.5);
	AI.PushGoal("shoot_and_wait","run",0,1);
	AI.PushGoal("shoot_and_wait","ignoreall",0,0);
	AI.PushGoal("shoot_and_wait","signal",1,1,"SHOOT_DONE",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("hold");
	AI.PushGoal("hold","timeout",1,1,2);
	AI.PushGoal("hold","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("hold","signal",1,1,"LOOK_LEFT",SIGNALFILTER_SENDER);
	AI.PushGoal("hold","timeout",1,1);
	AI.PushGoal("hold","signal",1,1,"LOOK_RIGHT",SIGNALFILTER_SENDER);
	
			
	AI.CreateGoalPipe("reserve_spot");
	AI.PushGoal("reserve_spot","locate",0,"formation");
	AI.PushGoal("reserve_spot","acqtarget",0,"");
	AI.PushGoal("reserve_spot","approach",1,3);

	AI.CreateGoalPipe("shoot_the_beacon");
	--AI.PushGoal("shoot_the_beacon","signal",1,1,"MAKE_ME_IGNORANT",0);
	AI.PushGoal("shoot_the_beacon","locate",1,"beacon");
	AI.PushGoal("shoot_the_beacon","acqtarget",1,"");
	AI.PushGoal("shoot_the_beacon","firecmd",0,2);
	AI.PushGoal("shoot_the_beacon","timeout",1,2,4);
	AI.PushGoal("shoot_the_beacon","firecmd",0,1);
	--AI.PushGoal("shoot_the_beacon","signal",1,-1,"MAKE_ME_UNIGNORANT",0);

	AI.CreateGoalPipe("bomb_the_beacon");
	--AI.PushGoal("bomb_the_beacon","signal",1,1,"MAKE_ME_IGNORANT",0);
	AI.PushGoal("bomb_the_beacon","locate",1,"beacon");
	AI.PushGoal("bomb_the_beacon","acqtarget",1,"");
	AI.PushGoal("bomb_the_beacon","firecmd",1,0);
	AI.PushGoal("bomb_the_beacon","throw_grenade");
	--AI.PushGoal("bomb_the_beacon","signal",1,-1,"MAKE_ME_UNIGNORANT",0);


	AI.CreateGoalPipe("friend_circle");
	AI.PushGoal("friend_circle","strafe",1,3);

	AI.CreateGoalPipe("scared_shoot");
	AI.PushGoal("scared_shoot","firecmd",1,2);
	AI.PushGoal("scared_shoot","firecmd",1,2);
	AI.PushGoal("scared_shoot","signal",1,1,"AI_AGGRESSIVE",SIGNALID_READIBILITY);
	AI.PushGoal("scared_shoot","form",1,"beacon");
	AI.PushGoal("scared_shoot","locate",1,"beacon");
	AI.PushGoal("scared_shoot","timeout",1,0.5,2);
	AI.PushGoal("scared_shoot","firecmd",1,1);

	AI.CreateGoalPipe("retaliate_damage");
	AI.PushGoal("retaliate_damage","devalue",0,1);
	AI.PushGoal("retaliate_damage","acqtarget",0,"");
--	AI.PushGoal("retaliate_damage","clear",0,1);




	AI.CreateGoalPipe("hide_forward");
	AI.PushGoal("hide_forward","hide",1,30,HM_NEAREST_TO_TARGET);

	AI.CreateGoalPipe("dumb_wrapper");
	AI.PushGoal("dumb_wrapper","timeout",1,1);
	AI.PushGoal("dumb_wrapper","signal",1,-1,"DO_SOMETHING_IDLE",0);

	AI.CreateGoalPipe("hold_spot");
	AI.PushGoal("hold_spot","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("hold_spot","locate",1,AIAnchorTable.SPECIAL_HOLD_SPOT);
	AI.PushGoal("hold_spot","ignoreall",0,1);
	AI.PushGoal("hold_spot","acqtarget",0,"");
	AI.PushGoal("hold_spot","run",1,1);
	AI.PushGoal("hold_spot","approach",1,1);
	AI.PushGoal("hold_spot","ignoreall",0,0);
	AI.PushGoal("hold_spot","lookat",1,-45,45);
	AI.PushGoal("hold_spot","timeout",1,0.5,2);

	AI.CreateGoalPipe("retreat_back");
	AI.PushGoal("retreat_back","ignoreall",0,1);
	AI.PushGoal("retreat_back","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("retreat_back","timeout",1,0.2,0.6);
	AI.PushGoal("retreat_back","signal",1,1,"REGISTER_AS_RETREATER",0);
	AI.PushGoal("retreat_back","signal",1,1,"PROVIDE_COVERING_FIRE",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("retreat_back","firecmd",0,0);
	AI.PushGoal("retreat_back","run",0,1);
	AI.PushGoal("retreat_back","hide",1,35,HM_FARTHEST_FROM_TARGET,1);
	AI.PushGoal("retreat_back","firecmd",0,1);
	AI.PushGoal("retreat_back","signal",1,1,"RETREATED_SAFE",0);
	AI.PushGoal("retreat_back","ignoreall",0,0);

	AI.CreateGoalPipe("retreat_back_phase2");
	AI.PushGoal("retreat_back_phase2","ignoreall",0,1);
	AI.PushGoal("retreat_back_phase2","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("retreat_back_phase2","timeout",1,0.2,0.6);
	AI.PushGoal("retreat_back_phase2","signal",1,1,"REGISTER_AS_RETREATER",0);
	AI.PushGoal("retreat_back_phase2","firecmd",0,0);
	AI.PushGoal("retreat_back_phase2","run",0,1);
	AI.PushGoal("retreat_back_phase2","hide",1,35,HM_FARTHEST_FROM_TARGET,1);
	AI.PushGoal("retreat_back_phase2","firecmd",0,1);
	AI.PushGoal("retreat_back_phase2","signal",1,1,"RETREATED_SAFE_PHASE2",0);
	AI.PushGoal("retreat_back_phase2","ignoreall",0,0);

	AI.CreateGoalPipe("retreat_to_spot");
	AI.PushGoal("retreat_to_spot","ignoreall",0,1);
	AI.PushGoal("retreat_to_spot","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("retreat_to_spot","timeout",1,0.2,0.6);
	AI.PushGoal("retreat_to_spot","signal",1,1,"REGISTER_AS_RETREATER",0);
	AI.PushGoal("retreat_to_spot","signal",1,1,"PROVIDE_COVERING_FIRE",SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("retreat_to_spot","firecmd",0,0);
	AI.PushGoal("retreat_to_spot","run",0,1);
	AI.PushGoal("retreat_to_spot","hide",1,35,HM_NEAREST_TO_LASTOPRESULT,1);
	AI.PushGoal("retreat_to_spot","firecmd",0,1);
	AI.PushGoal("retreat_to_spot","signal",1,1,"RETREATED_SAFE",0);
	AI.PushGoal("retreat_to_spot","ignoreall",0,0);

	AI.CreateGoalPipe("retreat_to_spot_phase2");
	AI.PushGoal("retreat_to_spot_phase2","ignoreall",0,1);
	AI.PushGoal("retreat_to_spot_phase2","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("retreat_to_spot_phase2","timeout",1,0.2,0.6);
	AI.PushGoal("retreat_to_spot_phase2","signal",1,1,"REGISTER_AS_RETREATER",0);
	AI.PushGoal("retreat_to_spot_phase2","firecmd",0,0);
	AI.PushGoal("retreat_to_spot_phase2","run",0,1);
	AI.PushGoal("retreat_to_spot_phase2","hide",1,35,HM_NEAREST_TO_LASTOPRESULT,1);
	AI.PushGoal("retreat_to_spot_phase2","firecmd",0,1);
	AI.PushGoal("retreat_to_spot_phase2","signal",1,1,"RETREATED_SAFE_PHASE2",0);
	AI.PushGoal("retreat_to_spot_phase2","ignoreall",0,0);

	
	AI.CreateGoalPipe("shoot_to");
	AI.PushGoal("shoot_to","ignoreall",0,1);
	AI.PushGoal("shoot_to","acqtarget",0,"");
	AI.PushGoal("shoot_to","firecmd",0,2);
	AI.PushGoal("shoot_to","timeout",1,0.5,1.5);
	AI.PushGoal("shoot_to","firecmd",0,1);
	AI.PushGoal("shoot_to","ignoreall",0,0);

	AI.CreateGoalPipe("special_hold_position");
	AI.PushGoal("special_hold_position","take_cover");
	AI.PushGoal("special_hold_position","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("special_hold_position","take_cover");
	AI.PushGoal("special_hold_position","lookat",1,-90,90);
	AI.PushGoal("special_hold_position","take_cover");
	AI.PushGoal("special_hold_position","lookat",1,-90,90);
	AI.PushGoal("special_hold_position","clear",0,1);


	AI.CreateGoalPipe("check_it_out");
	AI.PushGoal("check_it_out","bodypos",0,BODYPOS_STEALTH);
	AI.PushGoal("check_it_out","lookat",1,-90,90);
	AI.PushGoal("check_it_out","lookat",1,-90,90);
	AI.PushGoal("check_it_out","bodypos",0,BODYPOS_STAND);

	-- use this pipe when you want to change behaviour and then issue the same signal in the new behaviour
	AI.CreateGoalPipe("force_reevaluate");
	--AI.PushGoal("force_reevaluate","timeout",1,0.5);
	AI.PushGoal("force_reevaluate","clear",0,1);

	-- new improved crouch should be used instead of directly calling bodypos
	AI.CreateGoalPipe("goto_crouch");
	AI.PushGoal("goto_crouch","signal",0,1,"DEFAULT_CURRENT_TO_CROUCH",0);
	AI.PushGoal("goto_crouch","timeout",1,1.5);
	AI.PushGoal("goto_crouch","bodypos",0,BODYPOS_CROUCH);

	-- new improved prone should be used instead of directly calling bodypos
	AI.CreateGoalPipe("goto_prone");
	AI.PushGoal("goto_prone","signal",0,1,"DEFAULT_CURRENT_TO_PRONE",0);
	AI.PushGoal("goto_prone","timeout",1,1.5);
	AI.PushGoal("goto_prone","bodypos",0,BODYPOS_PRONE);

	AI.CreateGoalPipe("lookat_beacon");
	AI.PushGoal("lookat_beacon","locate",0,"beacon");
	AI.PushGoal("lookat_beacon","acqtarget",0,"");
	AI.PushGoal("lookat_beacon","timeout",1,1,1.5);
	AI.PushGoal("lookat_beacon","lookat",1,-90,90);
	AI.PushGoal("lookat_beacon","lookat",1,-90,90);

	-- new improved prone should be used instead of directly calling bodypos
	AI.CreateGoalPipe("goto_stand");
	AI.PushGoal("goto_stand","signal",0,1,"DEFAULT_CURRENT_TO_STAND",0);
	AI.PushGoal("goto_stand","timeout",1,1.5);
	AI.PushGoal("goto_stand","bodypos",0,BODYPOS_STAND);


	AI.CreateGoalPipe("grenade_react");
--	AI.PushGoal("grenade_react", "clear", 0, 1);
	AI.PushGoal("grenade_react", "locate", 0, "atttarget");
	AI.PushGoal("grenade_react", "devalue", 0);	-- make sure not to react on the same grenade twice
	AI.PushGoal("grenade_react", "ignoreall", 0, 1);
--	AI.PushGoal("grenade_react", "locate", 0, 150, 5);	-- is the grenade in radius of 5 meters
	AI.PushGoal("grenade_react", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("grenade_react", "run", 0, 3);
	
	AI.PushGoal("grenade_react", "hide", 1, 40, HM_NEAREST_BACKWARDS, true);
	AI.PushGoal("grenade_react", "ignoreall", 0, 0);
	AI.PushGoal("grenade_react", "branch", 1, "HIDE_OK", IF_CAN_HIDE);
	-- OnNoHidingPlace will be processed instead, end signal GRENADE_RUN_OVER won't be sent
	AI.PushGoal("grenade_react", "branch", 1, "END", BRANCH_ALWAYS);
	AI.PushLabel("grenade_react","HIDE_OK");
	AI.PushGoal("grenade_react", "signal", 1, 1, "GRENADE_RUN_OVER", 0);
	AI.PushLabel("grenade_react","END");


	AI.CreateGoalPipe("grenade_seen");
	AI.PushGoal("grenade_seen","signal",1,1,"GRENADE_SEEN",SIGNALID_READIBILITY);	
	AI.PushGoal("grenade_seen", "ignoreall", 0, 1);
	AI.PushGoal("grenade_seen", "branch", 0, "STANDING", IF_STANCE_IS, BODYPOS_STAND);
	AI.PushGoal("grenade_seen", "locate", 0, 150, 5);	-- is the grenade in radius of 5 meters
	AI.PushGoal("grenade_seen", "branch", 0, "STAY_DOWN", IF_NO_LASTOP);		-- the grenade is far enought -> prone and wait

		AI.PushGoal("grenade_seen", "bodypos", 0, BODYPOS_STAND);
		AI.PushGoal("grenade_seen", "branch", 0, "STANDING", BRANCH_ALWAYS);	-- the grenade is too close -> stand up and run

		-- execute this block if stance isn't standing and the grenade isn't too close
		AI.PushLabel("grenade_seen", "STAY_DOWN");
		AI.PushGoal("grenade_seen", "bodypos", 0, BODYPOS_PRONE);
		AI.PushGoal("grenade_seen", "clear", 0, 1);
		AI.PushGoal("grenade_seen", "timeout", 1, 2.5, 3.1);
		AI.PushGoal("grenade_seen", "bodypos", 0, BODYPOS_CROUCH);
		AI.PushGoal("grenade_seen", "branch", 0, "EXIT", BRANCH_ALWAYS);

		-- execute this block if stance is standing or the grenade is too close
		AI.PushLabel("grenade_seen", "STANDING");
		AI.PushGoal("grenade_seen", "run", 0, 1);
		AI.PushGoal("grenade_seen", "hide", 0, 40, HM_NEAREST, true);
		AI.PushGoal("grenade_seen", "branch", 0, "CAN_HIDE", IF_CAN_HIDE);
			AI.PushGoal("grenade_seen", "backoff", 0, 5); -- just backoff if can't hide
		AI.PushLabel("grenade_seen", "CAN_HIDE");
		AI.PushGoal("grenade_seen", "devalue", 0);
		AI.PushGoal("grenade_seen", "timeout", 1, 0.8);
		AI.PushGoal("grenade_seen", "clear", 0, 0);
		AI.PushGoal("grenade_seen", "bodypos", 0, BODYPOS_PRONE);
		AI.PushGoal("grenade_seen", "timeout", 1, 1.5, 2.3);
		AI.PushGoal("grenade_seen", "bodypos", 0, BODYPOS_STAND);

	AI.PushLabel("grenade_seen", "EXIT");
	AI.PushGoal("grenade_seen", "ignoreall", 0, 0);
	AI.PushGoal("grenade_seen", "devalue", 1);
	AI.PushGoal("grenade_seen", "signal", 1, 1, "GRENADE_RUN_OVER", 0);


	AI.CreateGoalPipe("throw_grenade_at_beacon");
--	AI.PushGoal("throw_grenade_at_beacon","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("throw_grenade_at_beacon","locate",0,"beacon");
	AI.PushGoal("throw_grenade_at_beacon","acqtarget",0,"");
	AI.PushGoal("throw_grenade_at_beacon", "signal", 1, 1, "SMART_THROW_GRENADE", 0);

	AI.CreateGoalPipe("throw_grenade");
	AI.PushGoal("throw_grenade", "firecmd", 0, 0);
	AI.PushGoal("throw_grenade", "signal", 1, 1, "SMART_THROW_GRENADE", 0);
--	AI.PushGoal("throw_grenade", "timeout", 1, 2);
--	AI.PushGoal("throw_grenade", "signal", 1, 1, "SHARED_THROW_GRENADE_DONE", 0);

	-------------------------------------------------------
	AI.CreateGoalPipe("throw_grenade_execute");
	AI.PushGoal("throw_grenade_execute", "ignoreall", 0, 1);
	AI.PushGoal("throw_grenade_execute", "firecmd", 0, 0);
	AI.PushGoal("throw_grenade_execute", "timeout", 1, .6);
	AI.PushGoal("throw_grenade_execute", "firecmd", 0, FIREMODE_SECONDARY);
	AI.PushGoal("throw_grenade_execute", "timeout", 1, 3);
	AI.PushGoal("throw_grenade_execute", "firecmd", 0, FIREMODE_OFF);
	AI.PushGoal("throw_grenade_execute", "ignoreall", 0, 0);
	AI.PushGoal("throw_grenade_execute", "signal", 1, 1, "THROW_GRENADE_DONE", 0);	

	AI.BeginGoalPipe("fire_mounted_weapon");
		AI.PushGoal("signal",0,1,"SET_MOUNTED_WEAPON_PERCEPTION",0);
		AI.PushLabel("LOOP");
		AI.PushGoal("firecmd", 0, FIREMODE_BURST_DRAWFIRE);
		AI.PushGoal("timeout", 1, 2,3);
		AI.PushGoal("signal", 1, 1, "CheckTargetInRange", 0);
		AI.PushGoal("timeout", 1, 2,3);
		AI.PushGoal("signal", 1, 1, "CheckTargetInRange", 0);
		AI.PushGoal("timeout", 1, 2,3);
		AI.PushGoal("signal", 1, 1, "CheckTargetInRange", 0);
		AI.PushGoal("timeout", 1, 2,3);
		AI.PushGoal("signal", 1, 1, "CheckTargetInRange", 0);
		AI.PushGoal("firecmd", 0, 0);
		AI.PushGoal("timeout", 1, 0.3, 1);
		AI.PushGoal("signal", 1, 1, "CheckTargetInRange", 0);
		AI.PushGoal("branch",1,"LOOP",BRANCH_ALWAYS);
	AI.EndGoalPipe();	

	AI.CreateGoalPipe("mounted_weapon_blind_fire");
	AI.PushGoal("mounted_weapon_blind_fire", "firecmd", 0, FIREMODE_FORCED);
	AI.PushGoal("mounted_weapon_blind_fire", "timeout", 1, 1.3, 1.8);
	AI.PushGoal("mounted_weapon_blind_fire", "firecmd", 0, 0);
	AI.PushGoal("mounted_weapon_blind_fire", "timeout", 1, 0.2, 0.4);
	AI.PushGoal("mounted_weapon_blind_fire", "signal", 1, 1, "CheckTargetInRange", 0);

	AI.CreateGoalPipe("cv_look_interested");
	AI.PushGoal("cv_look_interested","timeout",1,0.5,1.5);
	AI.PushGoal("cv_look_interested","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("cv_look_interested","lookat",0,0,0,1);
	AI.PushGoal("cv_look_interested","timeout",1,0.8, 1.2);
	AI.PushGoal("cv_look_interested","clear", 0, 0);
	AI.PushGoal("cv_look_interested","lookaround",1,90,2,5,10,AI_BREAK_ON_LIVE_TARGET);
	AI.PushGoal("cv_look_interested","signal",0,1,"INVESTIGATE_DONE",0);

	AI.BeginGoalPipe("mounted_weapon_look_around");
		AI.PushGoal("signal",0,1,"SET_MOUNTED_WEAPON_PERCEPTION",0);
		AI.PushGoal("locate",1,"refpoint");	
		AI.PushGoal("lookaround",1,30,2.2,10005,10010,AI_BREAK_ON_LIVE_TARGET + AILASTOPRES_USE);
		--AI.PushGoal("lookat",1,30,2.2,5,10,1);
	AI.EndGoalPipe();		
	
	AI.BeginGoalPipe("mounted_weapon_carpet_fire");
		AI.PushGoal("firecmd", 0, FIREMODE_FORCED);
		AI.PushGoal("locate",1,"atttarget");
		AI.PushGoal("lookaround",1,30,2.2,5,10,AI_BREAK_ON_LIVE_TARGET + AILASTOPRES_USE);
		AI.PushGoal("firecmd", 0, 0);
		AI.PushGoal("timeout", 1, 0.2, 0.4);
		--AI.PushGoal("signal", 1, 1, "CheckTargetInRange", 0);
	AI.EndGoalPipe();		

	
	AI.CreateGoalPipe("look_at_refpoint_if_no_target");
--	AI.PushGoal("look_at_refpoint_if_no_target","branch",1,"LOOKAT",IF_NO_ENEMY_TARGET);
--	AI.PushGoal("look_at_refpoint_if_no_target","branch",1,"END",BRANCH_ALWAYS);
--	AI.PushLabel("look_at_refpoint_if_no_target","LOOKAT");
--	AI.PushGoal("look_at_refpoint_if_no_target","acqtarget",1,"refpoint");
--	AI.PushGoal("look_at_refpoint_if_no_target","lookat",1,0,0,1);	
--	AI.PushGoal("look_at_refpoint_if_no_target","timeout",1,10.7);
--	AI.PushGoal("look_at_refpoint_if_no_target","lookat",1,-500);
--	AI.PushLabel("look_at_refpoint_if_no_target","END");
	AI.PushGoal("look_at_refpoint_if_no_target", "signal", 1, 1, "SHARED_USE_THIS_MOUNTED_WEAPON", 0);
	

	AI.CreateGoalPipe("grenade_run_hide");
	AI.PushGoal("grenade_run_hide","firecmd",0,0);
	AI.PushGoal("grenade_run_hide","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("grenade_run_hide","run",0,1);
	AI.PushGoal("grenade_run_hide","hide",1,6,HM_FARTHEST_FROM_TARGET);
	AI.PushGoal("grenade_run_hide","devalue",1);

	AI.CreateGoalPipe("grenade_run_away");
	AI.PushGoal("grenade_run_away","firecmd",0,0);
	AI.PushGoal("grenade_run_away","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("grenade_run_away","run",0,1);
	AI.PushGoal("grenade_run_away","backoff",1,6);
	AI.PushGoal("grenade_run_away","devalue",1);

	AI.CreateGoalPipe("closesthide");
	AI.PushGoal("closesthide","firecmd",0,0);
	--AI.PushGoal("randomhide","devalue",0);
--	AI.PushGoal("randomhide","acqtarget",0,"");
--	AI.PushGoal("randomhide","approach",1,2);
	AI.PushGoal("closesthide","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("closesthide","run",0,1);
	AI.PushGoal("closesthide","hide",1,15,HM_NEAREST_TO_TARGET);-- HM_FARTHEST_TO_TARGET
	AI.PushGoal("closesthide","branch",0,"CROUCH",IF_CAN_HIDE);
	AI.PushGoal("closesthide","branch",0,"END",BRANCH_ALWAYS);
	AI.PushLabel("closesthide","CROUCH");
	AI.PushGoal("closesthide","bodypos",0,BODYPOS_CROUCH);
	AI.PushLabel("closesthide","END");

	AI.CreateGoalPipe("fire_and_hide");
	AI.PushGoal("fire_and_hide", "firecmd", 0, 1);
	AI.PushGoal("fire_and_hide", "+timeout", 1, 0.5, 0.7);
	AI.PushGoal("fire_and_hide", "signal", 0, 10, "END_UNHIDE", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("unhide");
	AI.PushGoal("unhide", "firecmd", 0, 0);
	AI.PushGoal("unhide", "+bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhide", "+timeout", 1, 0.6,1.3);
	AI.PushGoal("unhide", "+bodypos", 1, BODYPOS_STAND);
	AI.PushGoal("unhide", "+timeout", 1, 0.4, 0.6);
	AI.PushGoal("unhide", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
	AI.PushGoal("unhide", "+run", 0, 1);
		AI.PushGoal("unhide", "+approach", 0, 1);
		AI.PushGoal("unhide", "+timeout", 1, 0.2, 0.3);
		AI.PushGoal("unhide", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
			AI.PushGoal("unhide", "+timeout", 1, 0.2, 0.3);
			AI.PushGoal("unhide", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
				AI.PushGoal("unhide", "+timeout", 1, 0.2, 0.3);
				AI.PushGoal("unhide", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
					AI.PushGoal("unhide", "+timeout", 1, 0.2, 0.3);
	AI.PushLabel("unhide", "STOP_HERE");
	AI.PushGoal("unhide", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("unhide", "+timeout", 1, 0.8, 1.2);
	AI.PushGoal("unhide", "signal", 0, 10, "END_UNHIDE", SIGNALFILTER_SENDER);


	AI.CreateGoalPipe("unhide_and_fire");
	AI.PushGoal("unhide_and_fire", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhide_and_fire","timeout",1,1,1.6);
	--AI.PushGoal("unhide_peek_right","run",0,1);
	AI.PushGoal("unhide_and_fire","firecmd",0,0);
	-- get out of the cover
	AI.PushGoal("unhide_and_fire","strafe",0,10,0);
	AI.PushGoal("unhide_and_fire","locate",0,"last_hideobject");
	AI.PushGoal("unhide_and_fire","backoff",0,4,0,AI_MOVE_FORWARD+AILASTOPRES_USE);
	AI.PushGoal("unhide_and_fire","timeout",1,1.8,2.1);
	AI.PushLabel("unhide_and_fire","DONE");
		AI.PushGoal("unhide_and_fire","branch", 1, "SEE_TARGET", IF_CAN_SHOOT_TARGET, 25);
		AI.PushGoal("unhide_and_fire","branch", 1, "DONE", IF_ACTIVE_GOALS);
	AI.PushLabel("unhide_and_fire","SEE_TARGET");
	AI.PushGoal("unhide_and_fire","clear",0,0);
	AI.PushGoal("unhide_and_fire", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhide_and_fire","firecmd",0,1);
	AI.PushGoal("unhide_and_fire","timeout",1,1.1,1.6);
	AI.PushGoal("unhide_and_fire", "signal", 0, 1, "END_UNHIDE", SIGNALFILTER_SENDER);
		
	AI.CreateGoalPipe("randomhide");
	AI.PushGoal("randomhide","firecmd",0,0);
	--AI.PushGoal("randomhide","devalue",0);
--	AI.PushGoal("randomhide","acqtarget",0,"");
--	AI.PushGoal("randomhide","approach",1,2);
	AI.PushGoal("randomhide","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("randomhide","run",0,1);
	AI.PushGoal("randomhide","hide",1,15,HM_RANDOM);-- HM_FARTHEST_TO_TARGET
	AI.PushGoal("randomhide","branch",0,"CROUCH",IF_CAN_HIDE);
	AI.PushGoal("randomhide","branch",0,"END",BRANCH_ALWAYS);
	AI.PushLabel("randomhide","CROUCH");
	AI.PushGoal("randomhide","bodypos",0,BODYPOS_CROUCH);
	AI.PushLabel("randomhide","END");
	--AI.PushGoal("randomhide","devalue",0);
	--AI.PushGoal("randomhide","signal",1,1,"TRY_TO_LOCATE_SOURCE",0);

	AI.CreateGoalPipe("randomhide_wider");
	AI.PushGoal("randomhide_wider","firecmd",0,0);
	AI.PushGoal("randomhide_wider","run",0,1);
	AI.PushGoal("randomhide_wider","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("randomhide_wider","hide",1,25,HM_NEAREST,1);-- HM_FARTHEST_TO_TARGET
	AI.PushGoal("randomhide_wider","branch",0,"CROUCH",IF_CAN_HIDE);
	AI.PushGoal("randomhide_wider","signal",0,1,"NO_HIDESPOT_IN_WIDER_RANGE",SIGNALFILTER_SENDER);
	AI.PushGoal("randomhide_wider","branch",0,"END",BRANCH_ALWAYS);
	AI.PushLabel("randomhide_wider","CROUCH");
	AI.PushGoal("randomhide_wider","bodypos",0,BODYPOS_CROUCH);
	AI.PushLabel("randomhide_wider","END");

	
	AI.CreateGoalPipe("randomhide_trace");
	AI.PushGoal("randomhide_trace","firecmd",0,0);
	AI.PushGoal("randomhide_trace","locate",0,"hidepoint");
	AI.PushGoal("randomhide_trace","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("randomhide_trace","run",0,1);
	AI.PushGoal("randomhide_trace","pathfind",1,"");
	AI.PushGoal("randomhide_trace","trace",1,1);
	AI.PushGoal("randomhide_trace","bodypos",0,BODYPOS_CROUCH);
	--AI.PushGoal("randomhide_trace","signal",0,1,"TRY_TO_LOCATE_SOURCE",0);
	


--	AI.CreateGoalPipe("hide_from_beacon");
----	AI.PushGoal("hide_from_beacon","firecmd",0,0);	
--	AI.PushGoal("hide_from_beacon","locate",0,"beacon");
----	AI.PushGoal("hide_from_beacon","acqtarget",0,"");
--	AI.PushGoal("hide_from_beacon","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("hide_from_beacon","run",0,1);
--	AI.PushGoal("hide_from_beacon","ignoreall",0,1);--don't lose/reaquire the target
--	AI.PushGoal("hide_from_beacon","hide",1,40,HM_NEAREST,1);
--	AI.PushGoal("hide_from_beacon","ignoreall",0,0);
----	AI.PushGoal("hide_from_beacon","branch",0,"CROUCH",IF_CAN_HIDE);
----	AI.PushGoal("hide_from_beacon","branch",0,"END",BRANCH_ALWAYS);
----	AI.PushLabel("hide_from_beacon","CROUCH");
----	AI.PushGoal("hide_from_beacon","bodypos",0,BODYPOS_CROUCH);
----	AI.PushGoal("hide_from_beacon","run",0,0);
----	AI.PushGoal("hide_from_beacon","timeout",1,3,5);
----	AI.PushLabel("hide_from_beacon","END");
--	AI.PushGoal("hide_from_beacon","signal",1,1,"END_HIDE",0);
	
	

	
	AI.CreateGoalPipe("not_so_random_hide_from");
--	AI.PushGoal("not_so_random_hide_from","devalue",0);
--	AI.PushGoal("not_so_random_hide_from","form",0,"beacon");
--	AI.PushGoal("not_so_random_hide_from","locate",0,"beacon");
--	AI.PushGoal("not_so_random_hide_from","acqtarget",1,"");
	AI.PushGoal("not_so_random_hide_from","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("not_so_random_hide_from","run",0,1);
	--AI.PushGoal("not_so_random_hide_from","firecmd",0,1);
	AI.PushGoal("not_so_random_hide_from","ignoreall",0,1);--don't lose/reaquire the target
	AI.PushGoal("not_so_random_hide_from","hide",1,40,HM_NEAREST,1);
	AI.PushGoal("not_so_random_hide_from","ignoreall",0,0);
	--AI.PushGoal("not_so_random_hide_from","firecmd",0,0);
	AI.PushGoal("not_so_random_hide_from","branch",0,"CROUCH",IF_CAN_HIDE);
	AI.PushGoal("not_so_random_hide_from","branch",0,"END",BRANCH_ALWAYS);
	AI.PushLabel("not_so_random_hide_from","CROUCH");
	AI.PushGoal("not_so_random_hide_from","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("not_so_random_hide_from","run",0,0);
	AI.PushGoal("not_so_random_hide_from","timeout",1,3,5);
	AI.PushLabel("not_so_random_hide_from","END");
	AI.PushGoal("not_so_random_hide_from","signal",1,1,"END_HIDE",0);

	AI.CreateGoalPipe("hide_around_from_target");
	--AI.PushGoal("hide_around_from_target","devalue",0);
	AI.PushGoal("hide_around_from_target","form",0,"beacon");
	AI.PushGoal("hide_around_from_target","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("hide_around_from_target","run",0,1);
	AI.PushGoal("hide_around_from_target","firecmd",0,1);
	AI.PushGoal("hide_around_from_target","hide",1,20,HM_RANDOM_AROUND_LASTOPRESULT);
	AI.PushGoal("hide_around_from_target","branch",0,"CROUCH",IF_CAN_HIDE);
	AI.PushGoal("hide_around_from_target","branch",0,"END",BRANCH_ALWAYS);
	AI.PushLabel("hide_around_from_target","CROUCH");
	AI.PushGoal("hide_around_from_target","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("hide_around_from_target","run",0,0);
	AI.PushGoal("hide_around_from_target","firecmd",0,0);
	AI.PushGoal("hide_around_from_target","timeout",1,3,5);
	AI.PushGoal("hide_around_from_target","devalue",0);
	AI.PushLabel("hide_around_from_target","END");
	AI.PushGoal("hide_around_from_target","signal",1,1,"END_HIDE",0);
	

	AI.CreateGoalPipe("basic_lookingaround");
	AI.PushGoal("basic_lookingaround","force_reevaluate");
	AI.PushGoal("basic_lookingaround","lookat",1,-90,90);
	AI.PushGoal("basic_lookingaround","timeout",1,1,3);

	AI.CreateGoalPipe("advanced_lookingaround");
	AI.PushGoal("advanced_lookingaround","basic_lookingaround");
	AI.PushGoal("advanced_lookingaround","locate",0,"hidepoint");
	AI.PushGoal("advanced_lookingaround","approach",1,0.5);
	
	AI.CreateGoalPipe("lookaround_protect");
	AI.PushGoal("lookaround_protect","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("lookaround_protect","lookat",1,-90,90);
	AI.PushGoal("lookaround_protect","timeout",1,1,3);
	AI.PushGoal("lookaround_protect","hide",1,20,HM_RANDOM_AROUND_LASTOPRESULT);
	
	AI.CreateGoalPipe("lookaround_30seconds");
	AI.PushGoal("lookaround_30seconds","clear",1,1)
	AI.PushGoal("lookaround_30seconds","timeout",0,30)
	AI.PushGoal("lookaround_30seconds","lookat",1,-90,90);
	AI.PushGoal("lookaround_30seconds","timeout",1,1,3);
	AI.PushGoal("lookaround_30seconds","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("lookaround_30seconds","timeout",1,1,3);
	AI.PushGoal("lookaround_30seconds","strafe",1,-2);
	AI.PushGoal("lookaround_30seconds","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("lookaround_30seconds","lookat",1,-90,90);
	AI.PushGoal("lookaround_30seconds","timeout",1,1,3);
	AI.PushGoal("lookaround_30seconds","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("lookaround_30seconds","timeout",1,1,3);
	AI.PushGoal("lookaround_30seconds","strafe",1,2);
	AI.PushGoal("lookaround_30seconds","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("lookaround_30seconds","branch",0,-6);




--	AI.CreateGoalPipe("throw_grenade");
--	AI.PushGoal("throw_grenade","timeout",1,0.2);
--	AI.PushGoal("throw_grenade","signal",0,1,"SHARED_GRENADE_THROW_OR_NOT",0);

	AI.CreateGoalPipe("unconditional_grenade");
	AI.PushGoal("unconditional_grenade","signal",1,1,"FIRE_IN_THE_HOLE",SIGNALID_READIBILITY);
	AI.PushGoal("unconditional_grenade","signal",1,1,"SHARED_GRANATE_THROW_ANIM",0);
	AI.PushGoal("unconditional_grenade","timeout",1,1);
	AI.PushGoal("unconditional_grenade","signal",1,-10,"grenate",0);


	AI.CreateGoalPipe("look_in_direction_of");
	AI.PushGoal("look_in_direction_of","acqtarget",0,"");
	AI.PushGoal("look_in_direction_of","timeout",1,1,3);
	AI.PushGoal("look_in_direction_of","lookat",1,-180,180);


	AI.CreateGoalPipe("minimize_exposure");
	AI.PushGoal("minimize_exposure","run",0,1);
	AI.PushGoal("minimize_exposure","run",0,1);
	AI.PushGoal("minimize_exposure","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("minimize_exposure","firecmd",0,0);
	AI.PushGoal("minimize_exposure","hide",1,20,HM_NEAREST,1);
	AI.PushGoal("minimize_exposure","run",0,0);

	AI.CreateGoalPipe("notify_team");
	AI.PushGoal("notify_team","lookaround",1,-1);
	AI.PushGoal("notify_team","lookaround",1,-1);
	AI.PushGoal("notify_team","advise_caution_to_team");
	AI.PushGoal("notify_team","signal",0,1,"KEEP_ALERTED",0);


	-------------------
	----
	---- COVER
	----
	--------------------

	AI.CreateGoalPipe("dont_shoot");
	AI.PushGoal("dont_shoot","firecmd",0,0);
	AI.PushGoal("dont_shoot","timeout",1,0,0.5);
	AI.PushGoal("dont_shoot","firecmd",0,1);

	
	AI.CreateGoalPipe("cover_look_closer");				-- USED
	AI.PushGoal("cover_look_closer","timeout",1,0.5,1.5);
	AI.PushGoal("cover_look_closer","run",0,0);
	AI.PushGoal("cover_look_closer","approach",1,15);
	AI.PushGoal("cover_look_closer","lookat",1,0,-90);
	AI.PushGoal("cover_look_closer","timeout",1,0.5);
	AI.PushGoal("cover_look_closer","lookat",1,0,90);
	


	AI.CreateGoalPipe("cover_wait_a_sec");
	AI.PushGoal("cover_wait_a_sec","timeout",1,0.5,1.5);
	AI.PushGoal("cover_wait_a_sec","signal",0,1,"OnNoHidingPlace",0); -- fake make him attack close
	
	AI.CreateGoalPipe("cover_grenade_run_away");
	AI.PushGoal("cover_grenade_run_away","firecmd",0,0);
	AI.PushGoal("cover_grenade_run_away","signal",0,1,"IM_RUNNING_AWAY",0);
	AI.PushGoal("cover_grenade_run_away","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("cover_grenade_run_away","run",0,1);
	AI.PushGoal("cover_grenade_run_away","backoff",1,8);
	AI.PushGoal("cover_grenade_run_away","devalue",1);
	AI.PushGoal("cover_grenade_run_away","clear",0,1);

	AI.CreateGoalPipe("cover_scramble_beacon");
	AI.PushGoal("cover_scramble_beacon","DropBeaconAt",0);
	AI.PushGoal("cover_scramble_beacon","cover_scramble",0);
	
	AI.CreateGoalPipe("cover_scramble");
	AI.PushGoal("cover_scramble","setup_combat");
	--AI.PushGoal("cover_scramble","timeout",1,1,1.3);
	AI.PushGoal("cover_scramble","firecmd",0,1);
	AI.PushGoal("cover_scramble","ignoreall",0,1);
	AI.PushGoal("cover_scramble","hide",1,20,HM_NEAREST,1,10);
	AI.PushGoal("cover_scramble","ignoreall",0,0);
	AI.PushGoal("cover_scramble","timeout",1,0,1);
	AI.PushGoal("cover_scramble","signal",0,1,"COVER_NORMALATTACK",0);

	AI.CreateGoalPipe("cover_pindown");
	AI.PushGoal("cover_pindown","run",0,1);
	AI.PushGoal("cover_pindown","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("cover_pindown","firecmd",0,1);
	AI.PushGoal("cover_pindown","ignoreall",0,1);
	AI.PushGoal("cover_pindown","hide",1,20,HM_NEAREST_TO_TARGET,1,10);
	AI.PushGoal("cover_pindown", "branch", 1, "HIDDEN", IF_IS_HIDDEN, 1);	
		AI.PushGoal("cover_pindown","hide",1,20,HM_NEAREST_TO_TARGET,1,4);
	AI.PushLabel("cover_pindown", "HIDDEN");	
	AI.PushGoal("cover_pindown","ignoreall",0,0);
	AI.PushGoal("cover_pindown","signal",0,1,"END_PINDOWN",0);
	AI.PushGoal("cover_pindown","branch",0,-1,1);

	AI.CreateGoalPipe("short_crouch_cover_fire");
	AI.PushGoal("short_crouch_cover_fire","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("short_crouch_cover_fire","firecmd",0,1);
	AI.PushGoal("short_crouch_cover_fire","timeout",1,2,3);
	AI.PushGoal("short_crouch_cover_fire","firecmd",0,0);
	AI.PushGoal("short_crouch_cover_fire","bodypos",0,BODYPOS_STAND);

	AI.CreateGoalPipe("short_cover_fire");
	AI.PushGoal("short_cover_fire","firecmd",0,1);
	AI.PushGoal("short_cover_fire","timeout",1,4,5);
--	AI.PushGoal("short_cover_fire","firecmd",0,0);
--	AI.PushGoal("short_cover_fire","bodypos",0,BODYPOS_STAND);
	
	AI.CreateGoalPipe("cover_close_wrapper");
	AI.PushGoal("cover_close_wrapper","signal",0,1,"COVER_NORMALATTACK");

	AI.CreateGoalPipe("cover_crouchleft");
	AI.PushGoal("cover_crouchleft","firecmd",0,1);
	AI.PushGoal("cover_crouchleft","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("cover_crouchleft","strafe",0,-1);
	AI.PushGoal("cover_crouchleft","timeout",1,0.5,1);
	AI.PushGoal("cover_crouchleft","strafe",0,0);

	AI.CreateGoalPipe("cover_crouchright");
	AI.PushGoal("cover_crouchright","firecmd",0,1);
	AI.PushGoal("cover_crouchright","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("cover_crouchright","strafe",0,1);
	AI.PushGoal("cover_crouchright","timeout",1,0.5,1);
	AI.PushGoal("cover_crouchright","strafe",0,0);


	AI.CreateGoalPipe("cover_step_pindown");
	AI.PushGoal("cover_step_pindown","firecmd",0,0);
	AI.PushGoal("cover_step_pindown","run",0,1);
	AI.PushGoal("cover_step_pindown","hide",1,10,HM_NEAREST_TO_TARGET,1);

	AI.CreateGoalPipe("cover_rollLeft");
	AI.PushGoal("cover_rollLeft","firecmd",0,0);
	AI.PushGoal("cover_rollLeft","strafe",0,1);
	AI.PushGoal("cover_rollLeft","signal",0,1,"SHARED_PLAYLEFTROLL");
	AI.PushGoal("cover_rollLeft","timeout",1,1);
	AI.PushGoal("cover_rollLeft","strafe",0,0);
	AI.PushGoal("cover_rollLeft","firecmd",0,1);
	AI.PushGoal("cover_rollLeft","timeout",1,60);

	AI.CreateGoalPipe("cover_rollRight");
	AI.PushGoal("cover_rollRight","firecmd",0,0);
	AI.PushGoal("cover_rollRight","strafe",0,-1);
	AI.PushGoal("cover_rollRight","signal",0,1,"SHARED_PLAYRIGHTROLL");
	AI.PushGoal("cover_rollRight","timeout",1,1);
	AI.PushGoal("cover_rollRight","strafe",0,0);
	AI.PushGoal("cover_rollRight","firecmd",0,1);
	AI.PushGoal("cover_rollRight","timeout",1,60);


	AI.CreateGoalPipe("cover_beacon_investigate");
	AI.PushGoal("cover_beacon_investigate","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("cover_beacon_investigate","locate",0,"beacon");
	AI.PushGoal("cover_beacon_investigate","acqtarget",0,"");
	AI.PushGoal("cover_beacon_investigate","run",0,1);
--	AI.PushGoal("cover_beacon_investigate","approach",1,15);
	AI.PushGoal("cover_beacon_investigate","hide",1,15,HM_NEAREST_TO_TARGET,1);		
	AI.PushGoal("cover_beacon_investigate","bodypos",0,BODYPOS_STEALTH);
	AI.PushGoal("cover_beacon_investigate","firecmd",0,0);
	AI.PushGoal("cover_beacon_investigate","run",0,1);
	AI.PushGoal("cover_beacon_investigate","approach",1,3);	
	AI.PushGoal("cover_beacon_investigate","lookat",0,-180,180);
	AI.PushGoal("cover_beacon_investigate","timeout",1,.7,1.1);
	AI.PushGoal("cover_beacon_investigate","lookat",0,-180,180);
	AI.PushGoal("cover_beacon_investigate","timeout",1,.7,1.1);
	AI.PushGoal("cover_beacon_investigate","lookat",0,-180,180);
	AI.PushGoal("cover_beacon_investigate","timeout",1,.7,1.1);
	AI.PushGoal("cover_beacon_investigate","signal",1,1,"LOOK_FOR_TARGET",0);



	AI.CreateGoalPipe("cover_refpoint_investigate");
	AI.PushGoal("cover_refpoint_investigate","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("cover_refpoint_investigate","locate",0,"refpoint");
	AI.PushGoal("cover_refpoint_investigate","acqtarget",0,"");
	AI.PushGoal("cover_refpoint_investigate","run",0,1);
	AI.PushGoal("cover_refpoint_investigate","firecmd",0,3);	
--	AI.PushGoal("cover_refpoint_investigate","approach",1,15);
	AI.PushGoal("cover_refpoint_investigate","pathfind",1,"");
	AI.PushGoal("cover_refpoint_investigate","trace",0,0);
	AI.PushGoal("cover_refpoint_investigate","+firecmd",0,3);	
	AI.PushGoal("cover_refpoint_investigate","+branch", 0, -1, IF_PATH_LONGER, 25);	
		AI.PushGoal("cover_refpoint_investigate","firecmd",0,0);	
	AI.PushGoal("cover_refpoint_investigate","+lookat",0,-90,90,0,1);
	AI.PushGoal("cover_refpoint_investigate","+timeout",1,.61,.73);
	AI.PushGoal("cover_refpoint_investigate","+lookat",1,-790);	
	AI.PushGoal("cover_refpoint_investigate","+branch", 0, -3, IF_PATH_LONGER, 20);	
--	AI.PushGoal("cover_refpoint_investigate","hide",1,20,HM_NEAREST_TO_TARGET,1);		
	AI.PushGoal("cover_refpoint_investigate","bodypos",0,BODYPOS_STEALTH);
	AI.PushGoal("cover_refpoint_investigate","firecmd",0,0);
	AI.PushGoal("cover_refpoint_investigate","run",0,0);
--	AI.PushGoal("cover_refpoint_investigate","+approach",0,3);	
--	AI.PushGoal("cover_refpoint_investigate","pathfind",1,"");
--	AI.PushGoal("cover_refpoint_investigate","+trace",0,0);
	AI.PushGoal("cover_refpoint_investigate","+lookat",0,-90,90,0,1);
	AI.PushGoal("cover_refpoint_investigate","+timeout",1,.61,.73);
	AI.PushGoal("cover_refpoint_investigate","+lookat",1,-790);	
	AI.PushGoal("cover_refpoint_investigate","+branch", 0, -3, IF_PATH_LONGER, 3);	
	AI.PushGoal("cover_refpoint_investigate","clear",0,1);	-- 
	AI.PushGoal("cover_refpoint_investigate","lookat",0,-180,180);
	AI.PushGoal("cover_refpoint_investigate","timeout",1,.7,1.1);
	AI.PushGoal("cover_refpoint_investigate","lookat",0,-180,180);
	AI.PushGoal("cover_refpoint_investigate","timeout",1,.7,1.1);
	AI.PushGoal("cover_refpoint_investigate","lookat",0,-180,180,0);
	AI.PushGoal("cover_refpoint_investigate","timeout",1,.7,1.1);
	AI.PushGoal("cover_refpoint_investigate","clear",0,1);	-- 
	AI.PushGoal("cover_refpoint_investigate","signal",1,1,"LOOK_FOR_TARGET",0);


	AI.CreateGoalPipe("cover_beacon_pindown");
	AI.PushGoal("cover_beacon_pindown","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("cover_beacon_pindown","locate",0,"beacon");
--	AI.PushGoal("cover_beacon_pindown","pathfind",1,"");
	AI.PushGoal("cover_beacon_pindown","run",0,1);
--	AI.PushGoal("cover_beacon_pindown","trace",1,8);
	AI.PushGoal("cover_beacon_pindown","approach",1,8);
	AI.PushGoal("cover_beacon_pindown","hide",1,10,HM_NEAREST,1);
	AI.PushGoal("cover_beacon_pindown","timeout",1,0,1);
	AI.PushGoal("cover_beacon_pindown","signal",1,1,"FINISH_RUN_TO_FRIEND",0);


	AI.CreateGoalPipe("left_cover_step_pindown");
	AI.PushGoal("left_cover_step_pindown","locate",0,"beacon");
	AI.PushGoal("left_cover_step_pindown","acqtarget",0,"");
	AI.PushGoal("left_cover_step_pindown","firecmd",0,0);
	AI.PushGoal("left_cover_step_pindown","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("left_cover_step_pindown","run",0,1);
	AI.PushGoal("left_cover_step_pindown","hide",1,15,HM_FRONTLEFTMOST_FROM_TARGET,1);

	AI.CreateGoalPipe("right_cover_step_pindown");
	AI.PushGoal("right_cover_step_pindown","locate",0,"beacon");
	AI.PushGoal("right_cover_step_pindown","acqtarget",0,"");
	AI.PushGoal("right_cover_step_pindown","firecmd",0,0);
	AI.PushGoal("right_cover_step_pindown","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("right_cover_step_pindown","run",0,1);
	AI.PushGoal("right_cover_step_pindown","hide",1,15,HM_FRONTRIGHTMOST_FROM_TARGET,1);


	AI.CreateGoalPipe("forward_cover_step_pindown");
	AI.PushGoal("forward_cover_step_pindown","locate",0,"beacon");
	AI.PushGoal("forward_cover_step_pindown","acqtarget",0,"");
	AI.PushGoal("forward_cover_step_pindown","firecmd",0,0);
	AI.PushGoal("forward_cover_step_pindown","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("forward_cover_step_pindown","run",0,1);
	AI.PushGoal("forward_cover_step_pindown","hide",1,15,HM_NEAREST_TO_TARGET,1);
	


	AI.CreateGoalPipe("cover_strafeattack");
	AI.PushGoal("cover_strafeattack","firecmd",0,1);
	AI.PushGoal("cover_strafeattack","approach",1,0.5);
	AI.PushGoal("cover_strafeattack","approach",1,0.5);
	AI.PushGoal("cover_strafeattack","timeout",1,1);

	AI.CreateGoalPipe("cover_closeleft");
	AI.PushGoal("cover_closeleft","strafe",0,-1);
	AI.PushGoal("cover_closeleft","cover_strafeout");

	AI.CreateGoalPipe("cover_closeright");
	AI.PushGoal("cover_closeright","strafe",0,1);
	AI.PushGoal("cover_closeright","cover_strafeout");

	AI.CreateGoalPipe("cover_strafeout");
	AI.PushGoal("cover_strafeout","run",0,1);
	AI.PushGoal("cover_strafeout","timeout",1,0.2);
	AI.PushGoal("cover_strafeout","strafe",0,0);
	AI.PushGoal("cover_strafeout","firecmd",0,0);
	AI.PushGoal("cover_strafeout","timeout",1,1);
	AI.PushGoal("cover_strafeout","signal",0,1,"COVER_NORMALATTACK",0);


	AI.CreateGoalPipe("cover_coverfire");
	AI.PushGoal("cover_coverfire","timeout",1,0,0.3);
	AI.PushGoal("cover_coverfire","strafe",0,0);
	AI.PushGoal("cover_coverfire","firecmd",0,1);
	AI.PushGoal("cover_coverfire","timeout",1,2);

	AI.CreateGoalPipe("cover_coverleft");
	AI.PushGoal("cover_coverleft","strafe",0,1);
	AI.PushGoal("cover_coverleft","cover_coverfire");

	AI.CreateGoalPipe("cover_coverright");
	AI.PushGoal("cover_coverright","strafe",0,-1);
	AI.PushGoal("cover_coverright","cover_coverfire");

	AI.CreateGoalPipe("cover_provide_cover");
	AI.PushGoal("cover_provide_cover","firecmd",0,1);
	AI.PushGoal("cover_provide_cover","locate",0,"beacon");
	AI.PushGoal("cover_provide_cover","acqtarget",0,"");
	AI.PushGoal("cover_provide_cover","pathfind",1,"");
	AI.PushGoal("cover_provide_cover","trace",1,0,1);
	AI.PushGoal("cover_provide_cover","firecmd",0,2);
	AI.PushGoal("cover_provide_cover","timeout",1,10);
	
	
	AI.CreateGoalPipe("cover_searchlr");
	AI.PushGoal("cover_searchlr","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("cover_searchlr","firecmd",0,1);
	AI.PushGoal("cover_searchlr","strafe",0,1);
	AI.PushGoal("cover_searchlr","timeout",1,0.5);
	AI.PushGoal("cover_searchlr","strafe",0,0);
	AI.PushGoal("cover_searchlr","signal",0,1,"WaitForTarget",0);

	AI.CreateGoalPipe("acquire_beacon");
	AI.PushGoal("acquire_beacon","locate",0,"beacon");
	AI.PushGoal("acquire_beacon","acqtarget",0,"");

	AI.CreateGoalPipe("cover_hideform");
	AI.PushGoal("cover_hideform","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("cover_hideform","firecmd",0,1);
	AI.PushGoal("cover_hideform","locate",0,"formation");
	AI.PushGoal("cover_hideform","run",0,1);
	AI.PushGoal("cover_hideform","hide",1,10,HM_NEAREST_TO_LASTOPRESULT,1);
	AI.PushGoal("cover_hideform","reload");
	AI.PushGoal("cover_hideform","signal",0,1,"HOLD_POSITION");

	AI.CreateGoalPipe("cover_form_comeout");
	AI.PushGoal("cover_form_comeout","timeout",1,0,1);
	AI.PushGoal("cover_form_comeout","comeout");
	AI.PushGoal("cover_form_comeout","timeout",1,0,1);
	AI.PushGoal("cover_form_comeout","signal",0,1,"FORM_STOP_COVERING",0);



	AI.CreateGoalPipe("cover_form");
	AI.PushGoal("cover_form","locate",0,"beacon");
	AI.PushGoal("cover_form","acqtarget",0,"");
	AI.PushGoal("cover_form","lookat",1,-90,90);
	AI.PushGoal("cover_form","shoot_cover");

	AI.CreateGoalPipe("cover_form_wait");
	AI.PushGoal("cover_form_wait","hide",1,20,HM_FARTHEST_FROM_TARGET,1);
	AI.PushGoal("cover_form_wait","timeout",1,0,0.5);


	AI.CreateGoalPipe("cover_crouchfire");
	AI.PushGoal("cover_crouchfire","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("cover_crouchfire","firecmd",0,1);
	AI.PushGoal("cover_crouchfire","timeout",1,1);
	AI.PushGoal("cover_crouchfire","cover_hideform");
	
---------------------------------------------------------------------------------------
--
	AI.CreateGoalPipe("camper_pindown");
	AI.PushGoal("camper_pindown","run",0,1);
	AI.PushGoal("camper_pindown","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("camper_pindown","firecmd",0,1);
	AI.PushGoal("camper_pindown","ignoreall",0,1);
	AI.PushGoal("camper_pindown","hide",1,20,HM_NEAREST,1,10);
	AI.PushGoal("camper_pindown","ignoreall",0,0);
	AI.PushGoal("camper_pindown","signal",0,1,"END_PINDOWN",0);
	AI.PushGoal("camper_pindown","branch",0,-1,1);

	AI.CreateGoalPipe("backoff_hide");
	AI.PushGoal("backoff_hide","firecmd",0,1);
	AI.PushGoal("backoff_hide","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("backoff_hide","run",0,1);
	AI.PushGoal("backoff_hide","hide",1,30,HM_NEAREST_BACKWARDS,1,7);
	AI.PushGoal("backoff_hide","branch", 1, "HIDDEN", IF_CAN_HIDE);	
	AI.PushGoal("backoff_hide","branch", 1, "PIPE_END", BRANCH_ALWAYS);
	AI.PushLabel("backoff_hide","HIDDEN");		
	AI.PushGoal("backoff_hide","bodypos",0,BODYPOS_CROUCH);	
	AI.PushGoal("backoff_hide","timeout", 1, 1.1,2);	
	AI.PushGoal("backoff_hide","signal",0,1,"BACKOFF_DONE",0);
	AI.PushLabel("backoff_hide","PIPE_END");	

	AI.CreateGoalPipe("backoff_anchor");
	AI.PushGoal("backoff_anchor","firecmd",0,1);
	AI.PushGoal("backoff_anchor","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("backoff_anchor","run",0,1);
	AI.PushGoal("backoff_anchor","approach",1,1.1,AILASTOPRES_USE);
--	AI.PushGoal("backoff_anchor","devalue",0);
	AI.PushGoal("backoff_anchor","bodypos",0,BODYPOS_CROUCH);	
	AI.PushGoal("backoff_anchor", "timeout", 1, .5,1);	
	AI.PushGoal("backoff_anchor","signal",0,1,"BACKOFF_DONE",0);
	

	AI.CreateGoalPipe("backoff_firing");
	AI.PushGoal("backoff_firing","firecmd",0,1);
	AI.PushGoal("backoff_firing","locate",0,"atttarget");
	AI.PushGoal("backoff_firing","lookat",1,0,0,1);	
	AI.PushGoal("backoff_firing","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("backoff_firing","run",0,1);
	AI.PushGoal("backoff_firing","backoff",1,6);
	AI.PushGoal("backoff_firing","lookat",1,-500);	
	AI.PushGoal("backoff_firing","timeout",1,1);
	AI.PushGoal("backoff_firing","signal",0,1,"END_BACKOFF",0);

	AI.CreateGoalPipe("look_at_refpoint");
	AI.PushGoal("look_at_refpoint","locate",0,"refpoint");
--	AI.PushGoal("look_at_refpoint","acqtarget",0,"");
	AI.PushGoal("look_at_refpoint","lookat",1,0,0,1);	
	
	AI.CreateGoalPipe("look_at_beacon");
	AI.PushGoal("look_at_beacon","locate",0,"beacon");
--	AI.PushGoal("look_at_beacon","acqtarget",0,"");
	AI.PushGoal("look_at_beacon","lookat",1,0,0,1);	

	AI.CreateGoalPipe("look_at_beacon_signal");
	AI.PushGoal("look_at_beacon_signal","locate",0,"beacon");
--	AI.PushGoal("look_at_beacon","acqtarget",0,"");
	AI.PushGoal("look_at_beacon_signal","lookat",1,0,0,1);
	AI.PushGoal("look_at_beacon_signal","signal",0,1,"LOOKING_BEACON",0);	


	AI.CreateGoalPipe("update_beacon");
	AI.PushGoal("update_beacon","form",0,"beacon");



	AI.CreateGoalPipe("check_hide");
	AI.PushGoal("check_hide", "clear",			0, 0);	-- remove active goals so hide will be the only one
	AI.PushGoal("check_hide", "hide",				1, 20, HM_NEAREST, true);
	AI.PushGoal("check_hide", "branch",			0, 2, IF_CAN_HIDE);
		AI.PushGoal("check_hide","signal",1,1,"HIDE_UNAVAILABLE",0);	
		AI.PushGoal("check_hide", "branch", 0, 1, BRANCH_ALWAYS);	-- end this goal pipe
	AI.PushGoal("check_hide","signal",1,1,"HIDE_AVAILABLE",0);		
	AI.PushGoal("check_hide", "clear",			0, 0);	-- remove active goals so test-hide is not executed	
	
	
	AI.CreateGoalPipe("low_hide_shoot");
	AI.PushGoal("low_hide_shoot","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("low_hide_shoot","timeout",1,1,4);
	AI.PushGoal("low_hide_shoot","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("low_hide_shoot","timeout",1,0.5);
	AI.PushGoal("low_hide_shoot","+firecmd",0,1);
	AI.PushGoal("low_hide_shoot","+timeout",1,1.0,2.0);
	AI.PushGoal("low_hide_shoot","+firecmd",0,0);
	AI.PushGoal("low_hide_shoot", "clear",				0, 0);	-- remove active goals so hide will be the only one
	AI.PushGoal("low_hide_shoot", "hide",				0, 20, HM_NEAREST, true);	-- check hide
	AI.PushGoal("low_hide_shoot", "branch",			0, 3, IF_IS_HIDDEN, .6 );
		AI.PushGoal("low_hide_shoot","ignoreall",0,1);
		AI.PushGoal("low_hide_shoot","hide",1,20,HM_NEAREST,1,10);
		AI.PushGoal("low_hide_shoot","ignoreall",0,0);
	AI.PushGoal("low_hide_shoot", "clear",				0, 0);	-- remove active goals - to get read of first "test" hide
--		AI.PushGoal("validate_hide","signal",1,1,"HIDE_INVALID",0);	
--		AI.PushGoal("validate_hide", "branch", 0, 4, BRANCH_ALWAYS);	-- end this goal pipe
--	AI.PushGoal("validate_hide","signal",1,1,"HIDE_AVAILABE",0);		
	

	AI.CreateGoalPipe("backoff_underfire");
	AI.PushGoal("backoff_underfire","firecmd",0,0);
--	AI.PushGoal("backoff_underfire","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("backoff_underfire","run",0,1);
	AI.PushGoal("backoff_underfire","backoff",1,6,0,AI_BACKOFF_FROM_TARGET);
	AI.PushGoal("backoff_underfire","devalue",1);

	-- approaching dead body (heard falling sound)
	---------------------------------------------
	AI.BeginGoalPipe("approach_dead");
		AI.PushGoal("timeout",1,0.2,0.4);
		AI.PushGoal("lookat",1,0,0,1);
		AI.PushGoal("timeout",1,0.2,0.4);
		AI.PushGoal("bodypos",0,BODYPOS_STAND);	
		AI.PushGoal("run",0,0);		
		--AI.PushGoal("locate",0,"refpoint");	
		--AI.PushGoal("approach",0,2,AILASTOPRES_USE);
		
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("approach",1,2,AILASTOPRES_USE,2.0);
		
--		AI.BeginGroup();
--			AI.PushGoal("locate",0,"refpoint");					
--			AI.PushGoal("approach",0,2,AILASTOPRES_USE,2.0);
--			AI.PushGoal("timeout",0,2,3);
--		AI.EndGroup();
--		AI.PushGoal("wait", 1, WAIT_ANY_2);
		AI.PushGoal("clear",0,0);
		AI.PushGoal("signal",1,1,"INVESTIGATE_DONE",0);
	AI.EndGoalPipe();	

	---------------------------------------------

	AI.CreateGoalPipe("check_dead");
--	AI.PushGoal("check_dead","acqtarget",0,"");
--	AI.PushGoal("check_dead","timeout",1,0.2,0.4);
--	AI.PushGoal("check_dead","lookat",1,0,0,1);
--	AI.PushGoal("check_dead","timeout",1,0.2,0.4);
	AI.PushGoal("check_dead","bodypos",0,BODYPOS_STAND);	
	AI.PushGoal("check_dead","run",0,2);		
	AI.PushGoal("check_dead","locate",0,"refpoint");	
	AI.PushGoal("check_dead","approach",0,2,AILASTOPRES_USE);
	-- loop until the target is visible
	AI.PushLabel("check_dead", "VISIBLE_LOOP");
		AI.PushGoal("check_dead","locate",0,"refpoint");	
		AI.PushGoal("check_dead","branch", 1, "TARGET_VISIBLE", IF_SEES_LASTOP, 50.0);
		AI.PushGoal("check_dead","branch", 1, "VISIBLE_LOOP", IF_ACTIVE_GOALS);	
	-- If the following gets executed the approach finished already while approaching fast.	
	AI.PushGoal("check_dead","branch", 1, "APPROACH_DONE", BRANCH_ALWAYS);
	-- approach more cautiously	
	AI.PushLabel("check_dead", "TARGET_VISIBLE");
	AI.PushGoal("check_dead","bodypos",0,BODYPOS_STEALTH);	
	AI.PushGoal("check_dead","run",0,1);
--	AI.PushGoal("check_dead","lookat",0,0,0,1);
--	AI.PushGoal("check_dead","timeout",1,0.3,0.8);
	AI.PushLabel("check_dead", "SEEK_LOOP");
		AI.PushGoal("check_dead","lookat",0,-90,90,0,1);
		AI.PushGoal("check_dead","timeout",1,.61,.73);
		AI.PushGoal("check_dead","lookat",1,-790);	
	AI.PushGoal("check_dead","branch", 0, "SEEK_LOOP", IF_ACTIVE_GOALS);	
	AI.PushLabel("check_dead", "APPROACH_DONE");
	-- At the target, check it.	
	AI.PushGoal("check_dead","bodypos",0,BODYPOS_CROUCH);	
	AI.PushGoal("check_dead","signal",1,1,"CHECKING_DEAD",0);
	AI.PushGoal("check_dead","locate",0,"beacon");	
	AI.PushGoal("check_dead","lookat",1,0,0,1);
	AI.PushGoal("check_dead","timeout",1,1,2);	
	AI.PushGoal("check_dead","lookat",0,-90,90);
	AI.PushGoal("check_dead","timeout",1,0.6,0.8);	
	AI.PushGoal("check_dead","lookat",0,-90,90);
	AI.PushGoal("check_dead","timeout",1,0.6,0.8);
	AI.PushGoal("check_dead","signal",1,1,"BE_ALERTED",0);

	---------------------------------------------
	AI.BeginGoalPipe("check_sleeping");
		AI.PushGoal("bodypos",0,BODYPOS_STAND);	
		AI.PushGoal("run",0,2);		
		AI.PushGoal("locate",0,"refpoint");	
		AI.PushGoal("approach",0,2,AILASTOPRES_USE);
		-- loop until the target is visible
		AI.PushLabel("VISIBLE_LOOP");
			AI.PushGoal("locate",0,"refpoint");	
			AI.PushGoal("branch", 1, "TARGET_VISIBLE", IF_SEES_LASTOP, 50.0);
			AI.PushGoal("branch", 1, "VISIBLE_LOOP", IF_ACTIVE_GOALS);	
		-- If the following gets executed the approach finished already while approaching fast.	
		AI.PushGoal("branch", 1, "APPROACH_DONE", BRANCH_ALWAYS);
		-- approach more cautiously	
		AI.PushLabel("TARGET_VISIBLE");
		AI.PushGoal("bodypos",0,BODYPOS_STEALTH);	
		AI.PushGoal("run",0,1);
		AI.PushLabel( "SEEK_LOOP");
			AI.PushGoal("lookat",0,-90,90,0,1);
			AI.PushGoal("timeout",1,.61,.73);
			AI.PushGoal("lookat",1,-790);	
		AI.PushGoal("branch", 0, "SEEK_LOOP", IF_ACTIVE_GOALS);	
		AI.PushLabel("APPROACH_DONE");
		-- At the target, check it.	
		AI.PushGoal("bodypos",0,BODYPOS_CROUCH);	
		AI.PushGoal("signal",1,1,"CHECKING_DEAD",0);
		AI.PushGoal("locate",0,"beacon");	
		AI.PushGoal("lookat",1,0,0,1);
		AI.PushGoal("timeout",1,1,2);	
		AI.PushGoal("lookat",0,-90,90);
		AI.PushGoal("timeout",1,0.6,0.8);	
		AI.PushGoal("lookat",0,-90,90);
		AI.PushGoal("timeout",1,0.6,0.8);
		AI.PushGoal("signal",1,1,"CHECK_DONE",0);
	AI.EndGoalPipe();

	-- go to tag 

	AI.CreateGoalPipe("cover_comeout");
	AI.PushGoal("cover_comeout","firecmd",0,1);
	AI.PushGoal("cover_comeout","approach",1,0.9);
	AI.PushGoal("cover_comeout","signal",1,1,"COVER_NORMALATTACK",0);

	---------------------------------------
	---
	--- orders goalpipes
	---
	--------------------------------------

	AI.CreateGoalPipe("commander_start_convoy");
	AI.PushGoal("commander_start_convoy", "timeout", 1, 1);
	AI.PushGoal("commander_start_convoy", "signal", 0, 10, "NC_StartConvoy", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("reload_combat");
	AI.PushGoal("reload_combat", "branch",			0, 2, IF_STANCE_IS, BODYPOS_PRONE); -- don't hide when prone
	AI.PushGoal("reload_combat", "clear",				0, 0);	-- remove active goals so hide will be the only one
	AI.PushGoal("reload_combat", "hide",				0, 3, HM_NEAREST, true);
	AI.PushGoal("reload_combat", "branch",			0, 3, IF_CAN_HIDE);
		AI.PushGoal("reload_combat", "bodypos",		0, BODYPOS_CROUCH);
		AI.PushGoal("reload_combat", "timeout",		1, 0.8);	-- wait to reload weapon
--		AI.PushGoal("reload_combat", "bodypos",		0, BODYPOS_STAND);
		AI.PushGoal("reload_combat", "branch",		0, 4, BRANCH_ALWAYS);	-- end this goal pipe
	AI.PushGoal("reload_combat", "bodypos",			0, BODYPOS_STAND);
	AI.PushGoal("reload_combat", "timeout",			1, 0.1);
	AI.PushGoal("reload_combat", "branch",			0, -1, IF_ACTIVE_GOALS); -- wait for "hide" to finish
	AI.PushGoal("reload_combat", "bodypos",			0, BODYPOS_CROUCH);
	AI.PushGoal("reload_combat", "timeout",			1, 0.5);
--	AI.PushGoal("reload_combat", "bodypos",			0, BODYPOS_STAND);

	AI.CreateGoalPipe("random_reacting_timeout");
	AI.PushGoal("random_reacting_timeout", "timeout", 1, 0.1, 0.4);

	AI.CreateGoalPipe("stay_hidden");
	AI.PushGoal("stay_hidden", "bodypos", 0, BODYPOS_CROUCH);
--	AI.PushGoal("stay_hidden", "clear", 0, 0);
	AI.PushGoal("stay_hidden", "+firecmd", 0, 1);
	AI.PushGoal("stay_hidden", "+timeout", 1, 0.4, 0.8);
--	AI.PushGoal("stay_hidden", "firecmd", 0, 0);
	AI.PushGoal("stay_hidden", "+hide", 1, 5, HM_ASKLEADER, true);
	AI.PushGoal("stay_hidden", "timeout", 1, 1);

	AI.CreateGoalPipe("hide_fast_fire");
	AI.PushGoal("hide_fast_fire", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("hide_fast_fire", "run", 1, 1.5);
	--AI.PushGoal("hide_fast_fire", "hide", 1, 8, HM_ASKLEADER, false);
	--AI.PushGoal("hide_fast_fire", "+hide", 1, 8, HM_USEREFPOINT, false);
	AI.PushGoal("hide_fast_fire", "+locate", 1, "refpoint");
	AI.PushGoal("hide_fast_fire", "+approach", 1, 1, AILASTOPRES_USE);
	AI.PushGoal("hide_fast_fire", "firecmd", 0, 0);
--	AI.PushGoal("hide_fast_fire", "signal", 1, 1, "SMART_THROW_GRENADE", 0);
	AI.PushGoal("hide_fast_fire", "signal", 0, 1, "END_HIDE_FIRE", SIGNALFILTER_SENDER);

	
	AI.CreateGoalPipe("hide_fast");
	AI.PushGoal("hide_fast", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("hide_fast", "run", 1, 1.5);
--	AI.PushGoal("hide_fast", "hide", 1, 8, HM_ASKLEADER, false);
	AI.PushGoal("hide_fast", "+hide", 1, 8, HM_USEREFPOINT, false);
	AI.PushGoal("hide_fast", "firecmd", 0, 0);
--	AI.PushGoal("hide_fast", "signal", 1, 1, "SMART_THROW_GRENADE", 0);
	AI.PushGoal("hide_fast", "signal", 0, 1, "END_HIDE", SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("hide_fast_nosame");
	AI.PushGoal("hide_fast_nosame", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("hide_fast_nosame", "run", 1, 1.5);
	AI.PushGoal("hide_fast_nosame", "hide", 1, 8, HM_ASKLEADER, true);
	AI.PushGoal("hide_fast_nosame", "firecmd", 0, 0);
	AI.PushGoal("hide_fast_nosame", "signal", 0, 1, "END_HIDE", SIGNALFILTER_SENDER);



	AI.CreateGoalPipe("stay_hidden_dont_fire");
	AI.PushGoal("stay_hidden_dont_fire", "bodypos", 0, BODYPOS_CROUCH);
--	AI.PushGoal("stay_hidden_dont_fire", "clear", 0, 0);
	AI.PushGoal("stay_hidden_dont_fire", "+timeout", 1, 0.4, 0.8);
	AI.PushGoal("stay_hidden_dont_fire", "firecmd", 0, 0);
	AI.PushGoal("stay_hidden_dont_fire", "+hide", 1, 5, HM_ASKLEADER, true);
	AI.PushGoal("stay_hidden_dont_fire", "timeout", 1, 1);

	AI.CreateGoalPipe("hide_follow");
	AI.PushGoal("hide_follow", "hide", 1, 0, HM_USEREFPOINT, true);
	--AI.PushGoal("hide_follow", "bodypos", 1, BODYPOS_CROUCH);
	AI.PushGoal("hide_follow", "branch",			0, "HIDE_OK", IF_CAN_HIDE);
	AI.PushGoal("hide_follow", "signal", 0, 1, "HIDE_POINT_NOT_REACHED", SIGNALFILTER_SENDER);
	AI.PushGoal("hide_follow", "branch",			0, "END",BRANCH_ALWAYS);
	AI.PushLabel("hide_follow","HIDE_OK");
	AI.PushGoal("hide_follow", "signal", 0, 1, "HIDE_POINT_REACHED", SIGNALFILTER_SENDER);
	AI.PushLabel("hide_follow","END");

	AI.CreateGoalPipe("random_look_around");
	AI.PushGoal("random_look_around", "timeout", 1, 0.2, 0.5);
	AI.PushGoal("random_look_around", "lookaround", 1, 60);
	AI.PushGoal("random_look_around", "random", 1, -2, 80);
	AI.PushGoal("random_look_around", "timeout", 1, 0.2, 0.5);
	AI.PushGoal("random_look_around", "branch", 1, 2, IF_STANCE_IS, BODYPOS_CROUCH);
		AI.PushGoal("random_look_around", "bodypos", 1, BODYPOS_CROUCH);
		AI.PushGoal("random_look_around", "branch", 1, 1, BRANCH_ALWAYS);
	AI.PushGoal("random_look_around", "bodypos", 1, BODYPOS_STAND);

	AI.CreateGoalPipe("notify_threatened");
--	AI.PushGoal("notify_threatened", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("notify_threatened", "DropBeaconAt");
--	AI.PushGoal("notify_threatened", "timeout", 1, 0.3, 0.6);
--	AI.PushGoal("notify_threatened", "signal", 0, 10, "NC_PlayerSeen", SIGNALFILTER_SUPERSPECIES);
	AI.PushGoal("notify_threatened", "signal", 0, 1, "NotifyThreatened", SIGNALFILTER_SUPERGROUP);
	AI.PushGoal("notify_threatened", "signal", 0, 1, "FIRST_HOSTILE_CONTACT", SIGNALID_READIBILITY);
	AI.PushGoal("notify_threatened", "timeout", 1, 0.2);

	AI.CreateGoalPipe("notify_player_seen");
--	AI.PushGoal("notify_player_seen", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("notify_player_seen", "DropBeaconAt");
--	AI.PushGoal("notify_player_seen", "timeout", 1, 0.3, 0.6);
--	AI.PushGoal("notify_player_seen", "signal", 0, 10, "NC_PlayerSeen", SIGNALFILTER_SUPERSPECIES);
	AI.PushGoal("notify_player_seen", "signal", 0, 1, "NotifyPlayerSeen", SIGNALFILTER_LEADERENTITY);
	AI.PushGoal("notify_player_seen", "signal", 0, 1, "FIRST_HOSTILE_CONTACT_GROUP", SIGNALID_READIBILITY);
	AI.PushGoal("notify_player_seen", "timeout", 1, 0.5);

	AI.CreateGoalPipe("notify_enemy_seen");
	AI.PushGoal("notify_enemy_seen", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("notify_enemy_seen", "DropBeaconAt");
	AI.PushGoal("notify_enemy_seen", "signal", 0, 1, "ORD_ATTACK", SIGNALFILTER_LEADER);
	AI.PushGoal("notify_enemy_seen", "timeout", 1, 0.5);

	AI.CreateGoalPipe("notify_enemy_seen_player");
	AI.PushGoal("notify_enemy_seen_player", "DropBeaconAt");
	AI.PushGoal("notify_enemy_seen_player", "signal", 0, 1, "START_ATTACK", SIGNALFILTER_LEADERENTITY);
	--AI.PushGoal("notify_enemy_seen_player", "timeout", 1, 0.5);


	AI.CreateGoalPipe("notified_player_seen");
	AI.PushGoal("notified_player_seen", "random_reacting_timeout");
	AI.PushGoal("notified_player_seen", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("notified_player_seen", "timeout", 1, 0.2);
	AI.PushGoal("notified_player_seen", "timeout", 1, 0.2);
	AI.PushGoal("notified_player_seen", "timeout", 1, 0.2);
	AI.PushGoal("notified_player_seen", "timeout", 1, 0.2);
	AI.PushGoal("notified_player_seen", "timeout", 1, 0.2);
	AI.PushGoal("notified_player_seen", "signal", 0, 1, "NotifyNoOrders", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("order_timeout");
	AI.PushGoal("order_timeout", "signal", 0, 10, "order_timeout_begin", SIGNALFILTER_SENDER);
	AI.PushGoal("order_timeout", "timeout", 1, 0.3, 1.0);
	AI.PushGoal("order_timeout", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);
	AI.PushGoal("order_timeout", "signal", 0, 10, "order_timeout_end", SIGNALFILTER_SENDER);



	AI.CreateGoalPipe("order_hide_dont_fire");
	AI.PushGoal("order_hide_dont_fire", "signal", 0, 10, "order_hide_begin", SIGNALFILTER_SENDER);
	AI.PushGoal("order_hide_dont_fire", "clear", 0, 0);
	AI.PushGoal("order_hide_dont_fire", "timeout", 1, 0.2, 0.8);
	AI.PushGoal("order_hide_dont_fire", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("order_hide_dont_fire", "+firecmd", 0, 0);
	AI.PushGoal("order_hide_dont_fire", "+run", 0, 1);
	AI.PushGoal("order_hide_dont_fire", "+hide", 1, 0, HM_USEREFPOINT, true); -- distance: 0, method: HM_USEREFPOINT, lookAt: true
	AI.PushGoal("order_hide_dont_fire", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("order_hide_dont_fire", "signal", 0, 10, "order_hide_end", SIGNALFILTER_SENDER);
	AI.PushGoal("order_hide_dont_fire", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);

	AI.CreateGoalPipe("order_hide");
	AI.PushGoal("order_hide", "signal", 0, 10, "order_hide_begin", SIGNALFILTER_SENDER);
	AI.PushGoal("order_hide", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("order_hide", "clear", 0, 0);
	AI.PushGoal("order_hide", "firecmd", 0, 1);
--	AI.PushGoal("order_hide", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("order_hide", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("order_hide", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("order_hide", "+firecmd", 0, 0);
	AI.PushGoal("order_hide", "+run", 0, 1.5); -- enable sprinting
	AI.PushGoal("order_hide", "+hide", 1, 0, HM_USEREFPOINT, true); -- distance: 0, method: HM_USEREFPOINT, lookAt: true
	AI.PushGoal("order_hide", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("order_hide", "firecmd", 0, 1);
	AI.PushGoal("order_hide", "signal", 0, 10, "order_hide_end", SIGNALFILTER_SENDER);
	AI.PushGoal("order_hide", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("order_hide", "signal", 1, 1, "SignalToNearest_InPosition", SIGNALFILTER_SENDER);
	AI.PushGoal("order_hide", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);



	AI.CreateGoalPipe("order_hide2");
	AI.PushGoal("order_hide2", "signal", 0, 10, "order_hide_begin", SIGNALFILTER_SENDER);
----
	AI.PushGoal("order_hide2", "clear", 0, 0);
	AI.PushGoal("order_hide2", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("order_hide2", "firecmd", 0, 1);
	AI.PushGoal("order_hide2", "timeout", 1, 0.75, 1.5);
	AI.PushGoal("order_hide2", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("order_hide2", "firecmd", 0, 0);
----
	AI.PushGoal("order_hide2", "run", 0, 1);
	AI.PushGoal("order_hide2", "hide", 0, 0, HM_USEREFPOINT, true); -- distance: 0, method: HM_USEREFPOINT, lookAt: true
----
--	AI.PushGoal("order_hide2", "timeout", 1, 0.1);
--	AI.PushGoal("order_hide2", "branch", 0, 3);
----
--	AI.PushGoal("order_hide2", "timeout", 0, 0.1);
--	AI.PushGoal("order_hide2", "branch", 0, 3);
----
	AI.PushGoal("order_hide2", "timeout", 1, 0.75, 1.5);
	AI.PushGoal("order_hide2", "branch", 0, -9);
----
	AI.PushGoal("order_hide2", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("order_hide2", "firecmd", 0, 1);
--	AI.PushGoal("order_hide2", "locate", 0, "refpoint");
--	AI.PushGoal("order_hide2", "approach", 1, 0.001, AILASTOPRES_USE);		-- distance should be zero but there is some bug - goal never ends!!!
	--AI.PushGoal("order_hide2", "clear", 0, 0);
	--AI.PushGoal("order_hide2", "locate", 0, "player");
	--AI.PushGoal("order_hide2", "acqtarget", 0, "");
	AI.PushGoal("order_hide2", "signal", 0, 10, "order_hide_end", SIGNALFILTER_SENDER);
	AI.PushGoal("order_hide2", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);

	AI.CreateGoalPipe("order_fire");
	AI.PushGoal("order_fire", "signal", 0, 10, "order_fire_begin", SIGNALFILTER_SENDER);
	AI.PushGoal("order_fire", "clear", 0, 0);
	AI.PushGoal("order_fire", "+firecmd", 0, 1);
	AI.PushGoal("order_fire", "+run", 0, 0);
	AI.PushGoal("order_fire", "+bodypos", 1, BODYPOS_STAND);
	AI.PushGoal("order_fire", "+timeout", 1, 0.1, 0.3);
	AI.PushGoal("order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
		AI.PushGoal("order_fire", "+approach", 0, 1);
		AI.PushGoal("order_fire", "+timeout", 1, 0.2, 0.3);
		AI.PushGoal("order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
			AI.PushGoal("order_fire", "+timeout", 1, 0.2, 0.3);
			AI.PushGoal("order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
				AI.PushGoal("order_fire", "+timeout", 1, 0.2, 0.3);
				AI.PushGoal("order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
					AI.PushGoal("order_fire", "+timeout", 1, 0.2, 0.3);
	AI.PushLabel("order_fire", "STOP_HERE");
	AI.PushGoal("order_fire", "firecmd", 0, 2);
	AI.PushGoal("order_fire", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("order_fire", "signal", 0, 10, "order_fire_end", SIGNALFILTER_SENDER);
	AI.PushGoal("order_fire", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);


	AI.CreateGoalPipe("close_fire");
	AI.PushGoal("close_fire", "firecmd", 0, FIREMODE_CONTINUOUS);
	AI.PushGoal("close_fire", "+timeout", 1, 2.6, 3.9);
	AI.PushGoal("close_fire", "firecmd", 0, 1);
	AI.PushGoal("close_fire", "signal", 0, 1, "END_CLOSE_FIRE", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("bodypos_crouch");
	AI.PushGoal("bodypos_crouch", "bodypos", 0, BODYPOS_CROUCH);

	AI.CreateGoalPipe("bodypos_prone");
	AI.PushGoal("bodypos_prone", "bodypos", 0, BODYPOS_PRONE);

	AI.CreateGoalPipe("bodypos_crouch_or_prone");
	AI.PushGoal("bodypos_crouch_or_prone", "branch", 0, "PRONE", IF_STANCE_IS, BODYPOS_CROUCH);
		AI.PushGoal("bodypos_crouch_or_prone", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("bodypos_crouch_or_prone", "branch", 0, "EXIT", BRANCH_ALWAYS);
	AI.PushLabel("bodypos_crouch_or_prone", "PRONE");
		AI.PushGoal("bodypos_crouch_or_prone", "bodypos", 0, BODYPOS_PRONE);
	AI.PushLabel("bodypos_crouch_or_prone", "EXIT");

	AI.CreateGoalPipe("order_initial_fire");
	AI.PushGoal("order_initial_fire", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);
--	AI.PushGoal("order_initial_fire", "random", 0, 2, 50);
	AI.PushGoal("order_initial_fire", "bodypos", 0, BODYPOS_CROUCH);
--	AI.PushGoal("order_initial_fire", "random", 0, 1, 100);
--	AI.PushGoal("order_initial_fire", "bodypos", 0, BODYPOS_PRONE);
	AI.PushGoal("order_initial_fire", "locate", 0, "beacon");
	AI.PushGoal("order_initial_fire", "acqtarget", 0, "");
	AI.PushGoal("order_initial_fire", "firecmd", 0, 1);
	AI.PushGoal("order_initial_fire", "timeout", 1, 0.5, 1.0);
	AI.PushGoal("order_initial_fire", "firecmd", 0, 1);
	
	AI.CreateGoalPipe("bridge_destroyed_init");
	AI.PushGoal("bridge_destroyed_init", "clear", 1, 1);
	AI.PushGoal("bridge_destroyed_init", "locate", 0, "LeaderA_P21");
	AI.PushGoal("bridge_destroyed_init", "acqtarget", 0, "");
	AI.PushGoal("bridge_destroyed_init", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("bridge_destroyed_init", "timeout", 1, 0.1, 0.4);
	AI.PushGoal("bridge_destroyed_init", "devalue", 0);
	AI.PushGoal("bridge_destroyed_init", "lookaround", 1, 60);
	AI.PushGoal("bridge_destroyed_init", "timeout", 1, 0.1, 0.2);
	AI.PushGoal("bridge_destroyed_init", "random", 0, -2, 60);
	AI.PushGoal("bridge_destroyed_init", "run", 0, 1.5);

	AI.CreateGoalPipe("bridge_destroyed");
	AI.PushGoal("bridge_destroyed", "locate", 0, "LeaderA_P15");
	AI.PushGoal("bridge_destroyed", "acqtarget", 0, "");
	AI.PushGoal("bridge_destroyed", "approach", 0, 15);
	AI.PushGoal("bridge_destroyed", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("bridge_destroyed", "timeout", 1, 0.1, 0.2);
	AI.PushGoal("bridge_destroyed", "devalue", 0);
	AI.PushGoal("bridge_destroyed", "lookaround", 1, 90);
	AI.PushGoal("bridge_destroyed", "timeout", 1, 0.1, 0.2);
	AI.PushGoal("bridge_destroyed", "branch", 0, 1);
	AI.PushGoal("bridge_destroyed", "signal", 1, 1, "OnStopPanicking", SIGNALFILTER_SENDER);
	AI.PushGoal("bridge_destroyed", "random", 0, -4, 95);
	AI.PushGoal("bridge_destroyed", "run", 0, 0);
	AI.PushGoal("bridge_destroyed", "random", 0, -6, 100);
	AI.PushGoal("bridge_destroyed", "branch", 0, 1);
	AI.PushGoal("bridge_destroyed", "clear", 1, 1);
	AI.PushGoal("bridge_destroyed", "signal", 1, 1, "OnStopPanicking", SIGNALFILTER_SENDER);
	AI.PushGoal("bridge_destroyed", "clear", 0, 1);

	AI.CreateGoalPipe("bridge_destroyed_wait");
	AI.PushGoal("bridge_destroyed_wait", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("bridge_destroyed_wait", "timeout", 1, 0.1, 0.4);
	AI.PushGoal("bridge_destroyed_wait", "lookaround", 1, 60);
	AI.PushGoal("bridge_destroyed_wait", "timeout", 1, 0.5, 1);
	AI.PushGoal("bridge_destroyed_wait", "random", 0, -2, 90);
	AI.PushGoal("bridge_destroyed_wait", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("bridge_destroyed_wait", "timeout", 1, 0.1, 0.4);

	AI.CreateGoalPipe("order_move_path");
	AI.PushGoal("order_move_path", "acqtarget", 0, "");
	AI.PushGoal("order_move_path", "continuous", 0, 1);
	AI.PushGoal("order_move_path", "run", 0, 1);
	AI.PushGoal("order_move_path", "pathfind", 1, "", 1);
	AI.PushGoal("order_move_path", "trace", 1, 1);
	AI.PushGoal("order_move_path", "signal", 0, 1, "PatrolPath", SIGNALFILTER_SENDER);	-- get next point in path
	AI.PushGoal("order_move_path", "timeout", 1, 0.1);

	AI.CreateGoalPipe("hide_from_new_target");
	AI.PushGoal("hide_from_new_target", "devalue", 0, 1);
	AI.PushGoal("hide_from_new_target", "acqtarget", 0, "");
	AI.PushGoal("hide_from_new_target", "firecmd", 0, 0);
	AI.PushGoal("hide_from_new_target", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("hide_from_new_target", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("hide_from_new_target", "bodypos", 0, BODYPOS_STAND);
--	AI.PushGoal("hide_from_new_target","jump",1,30,HM_NEAREST,0);
	AI.PushGoal("hide_from_new_target", "hide", 1, 10, HM_ASKLEADER, true);
	AI.PushGoal("hide_from_new_target", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("hide_from_new_target", "firecmd", 0, 1);

	AI.CreateGoalPipe("hide_on_bullet_rain");
	AI.PushGoal("hide_on_bullet_rain", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("hide_on_bullet_rain", "firecmd", 0, 0);
	AI.PushGoal("hide_on_bullet_rain", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("hide_on_bullet_rain", "hide", 0, 10, HM_ASKLEADER, true);
	AI.PushGoal("hide_on_bullet_rain", "timeout", 1, 0.5, 1.0);
	AI.PushGoal("hide_on_bullet_rain", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("hide_on_bullet_rain", "timeout", 1, 0.3);
	AI.PushGoal("hide_on_bullet_rain", "branch", 0, -1); -- wait until hide is finished
	AI.PushGoal("hide_on_bullet_rain", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("hide_on_bullet_rain", "firecmd", 0, 1);


	AI.CreateGoalPipe("order_move");
	AI.PushGoal("order_move","locate",0,"refpoint");
	--AI.PushGoal("order_move","acqtarget",0,"");
	AI.PushGoal("order_move","+approach",1,1.2,AILASTOPRES_USE);
	AI.PushGoal("order_move","signal",0,1,"ORD_DONE",SIGNALFILTER_SENDER);	
	AI.PushGoal("order_move","signal",0,10,"ORD_DONE",SIGNALFILTER_LEADER);		

-- will be dynamically created in ACT_GOTO
--	AI.CreateGoalPipe("action_goto");
--	AI.PushGoal("action_goto","locate",0,"refpoint");
--	AI.PushGoal("action_goto","+approach",1,1.2,AILASTOPRES_USE);

	AI.CreateGoalPipe("action_lookatpoint");
	AI.PushGoal("action_lookatpoint","locate",0,"refpoint");
	AI.PushGoal("action_lookatpoint","+lookat",1,0,0,true);
	AI.PushGoal("action_lookatpoint","timeout",1,0.2);
--	AI.PushGoal("action_lookatpoint","signal",0,10,"ACTION_DONE",SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("action_resetlookat");
	AI.PushGoal("action_resetlookat","lookat",1,0,0);
--	AI.PushGoal("action_resetlookat","signal",0,10,"ACTION_DONE",SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("action_weaponholster");
	AI.PushGoal("action_weaponholster", "signal", 1, 10, "HOLSTERITEM_TRUE", SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("action_weapondraw");
	AI.PushGoal("action_weapondraw", "signal", 1, 10, "HOLSTERITEM_FALSE", SIGNALFILTER_SENDER);

	-- use this goal pipe to insert it as a dummy pipe in actions which are executed inside their signal handler
	AI.CreateGoalPipe("action_dummy");
	AI.PushGoal("action_dummy","timeout",1,0.1);

	AI.CreateGoalPipe("action_enter");
	AI.PushGoal("action_enter", "waitsignal", 0, "ENTERING_END");
	AI.PushGoal("action_enter", "signal", 1, 10, "SETUP_ENTERING", SIGNALFILTER_SENDER);
	AI.PushGoal("action_enter", "locate", 0, "animtarget");	-- the anim target is set by the vehicle code
	AI.PushGoal("action_enter", "run", 0, 1);
	AI.PushGoal("action_enter", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("action_enter", "+approach", 1, 0, AILASTOPRES_USE + AI_STOP_ON_ANIMATION_START, 2);
	AI.PushGoal("action_enter", "branch", 1, "PATH_FOUND", NOT + IF_LASTOP_FAILED );
		AI.PushGoal("action_enter", "signal", 1, 1, "CANCEL_CURRENT", 0);
	AI.PushLabel("action_enter", "PATH_FOUND" );
	AI.PushGoal("action_enter", "timeout", 1, 0.1);
	AI.PushGoal("action_enter", "branch", 1, -1, IF_ACTIVE_GOALS);
	--AI.PushGoal("action_enter", "signal", 1, 10, "CHECK_INVEHICLE", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("action_enter_fast");
	AI.PushGoal("action_enter_fast", "waitsignal", 0, "ENTERING_END" );
	AI.PushGoal("action_enter_fast", "signal", 1, 10, "SETUP_ENTERING_FAST", SIGNALFILTER_SENDER);
	AI.PushGoal("action_enter_fast", "timeout", 1, 0.1);
	AI.PushGoal("action_enter_fast", "branch", 1, -1, IF_ACTIVE_GOALS);

	AI.CreateGoalPipe("action_exit");
	AI.PushGoal("action_exit", "waitsignal", 1, "EXITING_END", nil, 10.0 );

	AI.CreateGoalPipe("check_driver");
	AI.PushGoal("check_driver", "signal", 1, 1, "CHECK_DRIVER", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("action_unload");
	AI.PushGoal("action_unload", "waitsignal", 0, "UNLOAD_DONE", nil, 10.0);
	AI.PushGoal("action_unload", "signal", 1, 10, "DO_UNLOAD", SIGNALFILTER_SENDER);
	AI.PushGoal("action_unload", "timeout", 1, 0.1);
	AI.PushGoal("action_unload", "branch", 1, -1, IF_ACTIVE_GOALS);


	AI.CreateGoalPipe("order_move_MT");
--	AI.PushGoal("order_move_MT","locate",0,"refpoint");
	AI.PushGoal("order_move_MT","acqtarget",0,"");
	AI.PushGoal("order_move_MT","stick",1,1.2,0,1);
	AI.PushGoal("order_move_MT","signal",0,10,"ORD_DONE",SIGNALFILTER_LEADER);		


	AI.CreateGoalPipe("order_search");
	AI.PushGoal("order_search", "signal", 0, 10, "order_search_begin", SIGNALFILTER_SENDER);
	AI.PushGoal("order_search", "clear", 0, 0);
	AI.PushGoal("order_search", "timeout", 1, 0.1, 0.8);
	AI.PushGoal("order_search", "locate", 0, "refpoint");
	AI.PushGoal("order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
		AI.PushGoal("order_search", "clear", 0, 0);
		AI.PushGoal("order_search", "+run", 0, 1);
		AI.PushGoal("order_search", "+bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("order_search", "+timeout", 1, 0.25);
		AI.PushGoal("order_search", "+locate", 0, "refpoint");
		AI.PushGoal("order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
			AI.PushGoal("order_search", "+pathfind", 1, "");
			AI.PushGoal("order_search", "+branch", 1, "DONE", IF_NO_PATH); -- if no path just ignore this hide point
			AI.PushGoal("order_search", "+branch", 1, "DONE", IF_PATH_LONGER, 35.0); -- if no found path is longer than 35m just ignore this hide point
			AI.PushGoal("order_search", "+trace", 0, 1, 0, 8);
			AI.PushLabel("order_search", "LOOP1");
				AI.PushGoal("order_search", "+timeout", 1, 0.2, 0.4);
				AI.PushGoal("order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
			AI.PushGoal("order_search", "+branch", 1, "LOOP1", IF_ACTIVE_GOALS);
			AI.PushGoal("order_search", "+run", 0, 0);
			AI.PushGoal("order_search", "+trace", 0, 1, 0, 1);
			AI.PushLabel("order_search", "LOOP2");
				AI.PushGoal("order_search", "+timeout", 1, 0.1, 0.2);
				AI.PushGoal("order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
			AI.PushGoal("order_search", "+branch", 1, "LOOP2", IF_ACTIVE_GOALS);
	AI.PushLabel("order_search", "DONE");
	AI.PushGoal("order_search", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("order_search", "+bodypos", 1, BODYPOS_CROUCH);
	AI.PushGoal("order_search", "+firecmd", 0, 1);
	AI.PushGoal("order_search", "+timeout", 1, 0.2, 0.5);
	AI.PushGoal("order_search", "signal", 1, 1, "FOLLOW_ME", SIGNALID_READIBILITY);
	AI.PushGoal("order_search", "signal", 0, 10, "order_search_end", SIGNALFILTER_SENDER);
	AI.PushGoal("order_search", "signal", 1, 10, "ORD_DONE", SIGNALFILTER_LEADER);


	AI.CreateGoalPipe("approach_refpoint");
	AI.PushGoal("approach_refpoint","locate",0,"refpoint");
	AI.PushGoal("approach_refpoint","+approach",1,1,AILASTOPRES_USE);
	AI.PushGoal("approach_refpoint","signal",0,1,"REFPOINT_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("approach_lookat_refpoint");
	AI.PushGoal("approach_lookat_refpoint","acqtarget",0,"");
	AI.PushGoal("approach_lookat_refpoint","locate",0,"refpoint");
	AI.PushGoal("approach_lookat_refpoint","approach",1,1,AILASTOPRES_LOOKAT);
	AI.PushGoal("approach_lookat_refpoint","signal",0,1,"TARGET_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("strafe_obstacle");
	AI.PushGoal("strafe_obstacle","locate",0,"refpoint");
	AI.PushGoal("strafe_obstacle","approach",0,1,AILASTOPRES_USE);
	AI.PushGoal("strafe_obstacle","timeout",1,6,8);
	AI.PushGoal("strafe_obstacle","branch",1,"STRAFE_POINT_NOT_REACHED",IF_ACTIVE_GOALS);
		AI.PushGoal("strafe_obstacle","signal",0,1,"STRAFE_POINT_REACHED",SIGNALFILTER_SENDER);		
		AI.PushGoal("strafe_obstacle","branch",1,"END",BRANCH_ALWAYS);
	AI.PushLabel("strafe_obstacle","STRAFE_POINT_NOT_REACHED");
		AI.PushGoal("strafe_obstacle","signal",0,1,"STRAFE_POINT_NOT_REACHED",SIGNALFILTER_SENDER);		
	AI.PushLabel("strafe_obstacle","END");
	AI.PushGoal("strafe_obstacle","clear",1,0);

	AI.BeginGoalPipe("vehicle_danger");
		AI.PushGoal("run",0,1);
		AI.PushGoal("bodypos",0,BODYPOS_STAND,1);
		AI.PushGoal("strafe",0,4,4);
		AI.PushGoal("firecmd",0,1);
		AI.PushGoal("locate",0,"vehicle_avoid");
		AI.PushGoal("+stick",0,0,AILASTOPRES_USE+AI_CONSTANT_SPEED,STICK_SHORTCUTNAV,10.0);--refpoint can be moved by another vehicle danger
		AI.PushGoal("waitsignal",1,"OnEndVehicleDanger",nil,6);		
		AI.PushGoal("clear",1,0);		
		AI.PushGoal("signal",0,1,"END_VEHICLE_DANGER",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	

	AI.CreateGoalPipe("approach_at_distance");
	AI.PushGoal("approach_at_distance","approach",1,3,AILASTOPRES_USE);
	AI.PushGoal("approach_at_distance","signal",0,1,"TARGET_REACHED",SIGNALFILTER_SENDER);		


	AI.CreateGoalPipe("approach_refpoint_ignoring");
	AI.PushGoal("approach_refpoint_ignoring","ignoreall",0,1);
	AI.PushGoal("approach_refpoint_ignoring","clear",0,1);
	AI.PushGoal("approach_refpoint_ignoring","locate",0,"refpoint");
	AI.PushGoal("approach_refpoint_ignoring","approach",1,1,AILASTOPRES_USE);
	AI.PushGoal("approach_refpoint_ignoring","signal",0,-1,"REFPOINT_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("approach_target_at_distance");
	AI.PushGoal("approach_target_at_distance","timeout",1,1,2);
	AI.PushGoal("approach_target_at_distance","locate",0,"refpoint");
	AI.PushGoal("approach_target_at_distance","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("approach_target_at_distance","run",1,1);
	AI.PushGoal("approach_target_at_distance","approach",1,1,AILASTOPRES_USE);
	AI.PushGoal("approach_target_at_distance","signal",0,1,"TARGET_DISTANCE_REACHED",SIGNALFILTER_SENDER);		


	AI.CreateGoalPipe("approach_lastop_ignoring");
	AI.PushGoal("approach_lastop_ignoring","approach",1,1.1,AILASTOPRES_USE);
	AI.PushGoal("approach_lastop_ignoring","signal",0,-1,"TARGET_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("approach_lastop");
	AI.PushGoal("approach_lastop","approach",1,1.1,AILASTOPRES_USE);
	AI.PushGoal("approach_lastop","signal",0,1,"TARGET_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("approach_lastop_distance");
	AI.PushGoal("approach_lastop_distance","approach",1,1.8,AILASTOPRES_USE);
	AI.PushGoal("approach_lastop_distance","signal",0,1,"TARGET_REACHED",SIGNALFILTER_SENDER);		



	AI.CreateGoalPipe("approach_lastop_lookaround");
	AI.PushGoal("approach_lastop_lookaround","approach",0,1.1,AILASTOPRES_USE);
	AI.PushGoal("approach_lastop_lookaround","timeout",1,1,2);
	AI.PushGoal("approach_lastop_lookaround","lookat",1,-10,-20);
	AI.PushGoal("approach_lastop_lookaround","timeout",1,1,2);
	AI.PushGoal("approach_lastop_lookaround","lookat",1,20,30);
	AI.PushGoal("approach_lastop_lookaround","timeout",1,1,2);
	AI.PushGoal("approach_lastop_lookaround","lookat",1,0);
	AI.PushGoal("approach_lastop_lookaround","branch",1,-1);
	AI.PushGoal("approach_lastop_lookaround","signal",0,1,"TARGET_REACHED",SIGNALFILTER_SENDER);		


	AI.CreateGoalPipe("gather_conversation_partecipants");
	AI.PushGoal("gather_conversation_partecipants", "timeout", 1, 1);
	AI.PushGoal("gather_conversation_partecipants", "signal",0,1,"START_CONVERSATION",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("start_vehicle_delay");
	AI.PushGoal("start_vehicle_delay", "timeout", 1, 2.5,3);
	AI.PushGoal("start_vehicle_delay", "signal",0,1,"START_VEHICLE",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("reset_lookat");
	AI.PushGoal("reset_lookat","lookat",1,-500); --reset look at 

	AI.CreateGoalPipe("vehicle_gunner_cover_fire");
	AI.PushGoal("vehicle_gunner_cover_fire","firecmd",1,FIREMODE_BURST);
	AI.PushGoal("vehicle_gunner_cover_fire","timeout",1,2,3);
	AI.PushGoal("vehicle_gunner_cover_fire","firecmd",1,0);
	AI.PushGoal("vehicle_gunner_cover_fire", "signal",0,1,"EXIT_VEHICLE_DONE",SIGNALFILTER_SENDER);

	AI.BeginGoalPipe("vehicle_gunner_shoot");
		AI.PushGoal("firecmd",1,FIREMODE_BURST_DRAWFIRE);
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",1,1,"INVEHICLEGUNNER_CHECKGETOFF",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",1,1,"INVEHICLEGUNNER_CHECKGETOFF",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",1,1,"INVEHICLEGUNNER_CHECKGETOFF",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",1,1,"INVEHICLEGUNNER_CHECKGETOFF",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",1,1,"INVEHICLEGUNNER_CHECKGETOFF",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",1,1,"INVEHICLEGUNNER_CHECKGETOFF",SIGNALFILTER_SENDER);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("timeout",1,0.3,0.5);
	AI.EndGoalPipe();

	for direction=-110,110,10 do
		self:CreateLookAroundPipe("LookAround",direction,0.6,1.2);
		self:CreateLookAroundPipe("LookAroundFast",direction,0.3,0.6);
	end	

	AI.LogEvent("REUSABLE PIPES LOADED");
	
end


function PipeManager:CreateLookAroundPipe(pipename,direction,tmin,tmax)
	
	g_StringTemp1 = pipename..direction;
	
	AI.CreateGoalPipe(g_StringTemp1);			
	AI.PushGoal(g_StringTemp1,"lookat",1,direction);
	AI.PushGoal(g_StringTemp1,"timeout",1,tmin,tmax);
	AI.PushGoal(g_StringTemp1,"lookat",1,-20);
	AI.PushGoal(g_StringTemp1,"timeout",1,tmin,tmax);
	AI.PushGoal(g_StringTemp1,"lookat",1,40);
	AI.PushGoal(g_StringTemp1,"timeout",1,tmin,tmax);
	AI.PushGoal(g_StringTemp1,"signal",0,1,"LOOKING_DONE",SIGNALFILTER_SENDER);		
end

