
TROOPER_CLOSE_DISTANCE_STICK =2.2;
TROOPER_VEHICLE_DISTANCE_STICK = 5.6;

function PipeManager:OnInitTrooper() 
	AI.LogEvent("TROOPERCALLED");

	-- Goalpipes for the Alien Trooper Drone.	

	AI.BeginGoalPipe("tr_check_prone_and_stick");
--		AI.PushLabel("FINDING_PATH");
--		AI.PushGoal("timeout",1,0.01);
--		AI.PushGoal("branch",1,"FINDING_PATH",IF_PATH_STILL_FINDING);
--		AI.PushGoal("branch",1,"APPROACH",IF_PATH_SHORTER,8);
--			AI.PushGoal("bodypos",0,BODYPOS_PRONE);
--		AI.PushLabel("APPROACH");
--		AI.PushGoal("timeout",1,0.01);
--		AI.PushGoal("branch",1,"APPROACH",IF_ACTIVE_GOALS);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_check_prone_and_stick_ml");
--		AI.PushLabel("FINDING_PATH");
--		AI.PushGoal("timeout",1,0.01);
--		AI.PushGoal("branch",1,"FINDING_PATH",IF_PATH_STILL_FINDING);
--		AI.PushGoal("branch",1,"APPROACH",IF_PATH_SHORTER,12);
--			AI.PushGoal("bodypos",0,BODYPOS_PRONE);
--		AI.PushLabel("APPROACH");
--		AI.PushGoal("timeout",1,0.01);
--		AI.PushGoal("branch",1,"APPROACH",IF_ACTIVE_GOALS);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_check_prone_and_stick_l");
--		AI.PushLabel("FINDING_PATH");
--		AI.PushGoal("timeout",1,0.01);
--		AI.PushGoal("branch",1,"FINDING_PATH",IF_PATH_STILL_FINDING);
--		AI.PushGoal("branch",1,"APPROACH",IF_PATH_SHORTER,20);
--			AI.PushGoal("bodypos",0,BODYPOS_PRONE);
--		AI.PushLabel("APPROACH");
--		AI.PushGoal("timeout",1,0.01);
--		AI.PushGoal("branch",1,"APPROACH",IF_ACTIVE_GOALS);
	AI.EndGoalPipe();

	
	AI.CreateGoalPipe("tr_squad_form");
	AI.PushGoal("tr_squad_form","lookat",1,-500); --reset look at 
	AI.PushGoal("tr_squad_form","firecmd",0,0);
	AI.PushGoal("tr_squad_form","ignoreall",0,1);
	--AI.PushGoal("tr_squad_form","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_squad_form","locate",0,"formation");
	AI.PushGoal("tr_squad_form","+acqtarget",0,"");
	AI.PushGoal("tr_squad_form","+stick",1,1,0,1);
	AI.PushGoal("tr_squad_form","+ignoreall",0,0);
	AI.PushGoal("tr_squad_form","+signal",1,10,"ORD_DONE",SIGNALFILTER_LEADER);
	AI.PushGoal("tr_squad_form","+locate",0,"formation");
	AI.PushGoal("tr_squad_form","+stick",1,0.5,AILASTOPRES_USE);
	
--	AI.CreateGoalPipe("tr_not_so_random_hide_from");
--	AI.PushGoal("tr_not_so_random_hide_from","form",0,"beacon");
--	AI.PushGoal("tr_not_so_random_hide_from","acqtarget",1,"");
--	--AI.PushGoal("tr_not_so_random_hide_from","bodypos",0,BODYPOS_PRONE);
--	AI.PushGoal("tr_not_so_random_hide_from","run",0,1);
--	AI.PushGoal("tr_not_so_random_hide_from","ignoreall",0,1);--don't lose/reaquire the target
--	AI.PushGoal("tr_not_so_random_hide_from","hide",1,20,HM_NEAREST,1);
--	AI.PushGoal("tr_not_so_random_hide_from","ignoreall",0,0);
--	AI.PushGoal("tr_not_so_random_hide_from","branch",0,"STAND",IF_CAN_HIDE);
--	AI.PushGoal("tr_not_so_random_hide_from","branch",0,"END",BRANCH_ALWAYS);
--	AI.PushLabel("tr_not_so_random_hide_from","STAND");
--	--AI.PushGoal("tr_not_so_random_hide_from","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("tr_not_so_random_hide_from","run",0,0);
--	AI.PushGoal("tr_not_so_random_hide_from","timeout",1,3,5);
--	AI.PushLabel("tr_not_so_random_hide_from","END");
--	AI.PushGoal("tr_not_so_random_hide_from","signal",1,1,"END_HIDE",0);
	
--	AI.CreateGoalPipe("tr_dig_in_attack");
--	--AI.PushGoal("tr_dig_in_attack","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("tr_dig_in_attack","firecmd",0,1);
--	AI.PushGoal("tr_dig_in_attack","timeout",1,0.5,1.5);
--	AI.PushGoal("tr_dig_in_attack","firecmd",0,0);
--	--AI.PushGoal("tr_dig_in_attack","bodypos",0,BODYPOS_PRONE);
--	AI.PushGoal("tr_dig_in_attack","hide",1,20,HM_NEAREST);
--	AI.PushGoal("tr_dig_in_attack","signal",1,1,"CHECK_FOR_TARGET",0)
--	AI.PushGoal("tr_dig_in_attack","firecmd",0,1);
--	AI.PushGoal("tr_dig_in_attack","timeout",1,1,3);
	
--	AI.CreateGoalPipe("tr_dig_in_shoot_on_spot");
----	AI.PushGoal("tr_dig_in_shoot_on_spot","bodypos",0,BODYPOS_PRONE);
----	AI.PushGoal("tr_dig_in_shoot_on_spot","timeout",1,1,4);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","timeout",1,0.5);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","+firecmd",0,1);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","+timeout",1,1.0,2.0);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","+firecmd",0,0);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","ignoreall",0,1);
--	--AI.PushGoal("tr_dig_in_shoot_on_spot","bodypos",0,BODYPOS_PRONE);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","hide",1,20,HM_NEAREST,1,10);
--	AI.PushGoal("tr_dig_in_shoot_on_spot","ignoreall",0,0);
	
--	AI.CreateGoalPipe("tr_pindown");
--	AI.PushGoal("tr_pindown","ignoreall",0,0);
--	AI.PushGoal("tr_pindown","run",0,1);
--	AI.PushGoal("tr_pindown","approach",1,30);
--	AI.PushGoal("tr_pindown","firecmd",0,1);
--	AI.PushGoal("tr_pindown","timeout",1,1,2.5);
--	AI.PushGoal("tr_pindown","firecmd",0,0);
--	AI.PushGoal("tr_pindown","run",0,1);
--	AI.PushGoal("tr_pindown","ignoreall",0,1);
--	AI.PushGoal("tr_pindown","+hide",1,20,HM_NEAREST_TO_TARGET,1,10);
--	AI.PushGoal("tr_pindown","+ignoreall",0,0);
--	AI.PushGoal("tr_pindown","signal",0,1,"END_PINDOWN",0);
--	AI.PushGoal("tr_pindown","branch",0,-1,1);

--	AI.CreateGoalPipe("tr_beacon_pindown");
--	--AI.PushGoal("tr_beacon_pindown","bodypos",0,BODYPOS_PRONE);
--	AI.PushGoal("tr_beacon_pindown","locate",0,"beacon");
--	AI.PushGoal("tr_beacon_pindown","pathfind",1,"");
--	AI.PushGoal("tr_beacon_pindown","run",0,1);
--	AI.PushGoal("tr_beacon_pindown","trace",1,1);
--	AI.PushGoal("tr_beacon_pindown","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("tr_beacon_pindown","timeout",1,0,1);
--	AI.PushGoal("tr_beacon_pindown","signal",1,1,"FINISH_RUN_TO_FRIEND",0);

	AI.CreateGoalPipe("tr_approach_target_at_distance");
	AI.PushGoal("tr_approach_target_at_distance","firecmd",0,0);
	AI.PushGoal("tr_approach_target_at_distance","timeout",1,1,2);
	AI.PushGoal("tr_approach_target_at_distance","locate",0,"refpoint");
	--AI.PushGoal("tr_approach_target_at_distance","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_approach_target_at_distance","run",0,1);
	AI.PushGoal("tr_approach_target_at_distance","approach",1,1,AILASTOPRES_USE);
	AI.PushGoal("tr_approach_target_at_distance","run",0,0);
	AI.PushGoal("tr_approach_target_at_distance","signal",0,1,"TARGET_DISTANCE_REACHED",SIGNALFILTER_SENDER);		

--	AI.CreateGoalPipe("tr_strafe_obstacle");
--	AI.PushGoal("tr_strafe_obstacle","locate",0,"refpoint");
--	--AI.PushGoal("tr_strafe_obstacle","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("tr_strafe_obstacle","firecmd",0,1);
--	AI.PushGoal("tr_strafe_obstacle","approach",0,1,AILASTOPRES_USE);
--	AI.PushGoal("tr_strafe_obstacle","timeout",1,6,8);
--	AI.PushGoal("tr_strafe_obstacle","branch",1,"STRAFE_POINT_NOT_REACHED",IF_ACTIVE_GOALS);
--		AI.PushGoal("tr_strafe_obstacle","signal",0,1,"STRAFE_POINT_REACHED",SIGNALFILTER_SENDER);		
--		AI.PushGoal("tr_strafe_obstacle","branch",1,"END",BRANCH_ALWAYS);
--	AI.PushLabel("tr_strafe_obstacle","STRAFE_POINT_NOT_REACHED");
--		AI.PushGoal("tr_strafe_obstacle","signal",0,1,"STRAFE_POINT_NOT_REACHED",SIGNALFILTER_SENDER);		
--	AI.PushLabel("tr_strafe_obstacle","END");
--	AI.PushGoal("tr_strafe_obstacle","clear",1,0);

	AI.CreateGoalPipe("tr_strafe_obstacle");
	AI.PushGoal("tr_strafe_obstacle","firecmd",0,0);
--	AI.PushGoal("cover_fire", "+bodypos", 1, BODYPOS_PRONE);
	AI.PushGoal("tr_strafe_obstacle", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
		AI.PushGoal("tr_strafe_obstacle", "+approach", 0, 5,AILASTOPRES_USE);
		AI.PushGoal("tr_strafe_obstacle", "+timeout", 1, 0.2, 0.3);
		AI.PushGoal("tr_strafe_obstacle", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
			AI.PushGoal("tr_strafe_obstacle", "+timeout", 1, 0.2, 0.3);
			AI.PushGoal("tr_strafe_obstacle", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
				AI.PushGoal("tr_strafe_obstacle", "+timeout", 1, 0.2, 0.3);
				AI.PushGoal("tr_strafe_obstacle", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
					AI.PushGoal("tr_strafe_obstacle", "+timeout", 1, 0.2, 0.3);
	AI.PushLabel("tr_strafe_obstacle", "STOP_HERE");
	AI.PushGoal("tr_strafe_obstacle", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("tr_strafe_obstacle","signal",0,1,"STRAFE_POINT_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("tr_strafe_obstacle_left");
	AI.PushGoal("tr_strafe_obstacle_left","firecmd",0,0);
	AI.PushGoal("tr_strafe_obstacle_left", "+backoff", 0, 4, 0, AI_MOVE_LEFT);
	AI.PushLabel("tr_strafe_obstacle_left", "LOOP");
	AI.PushGoal("tr_strafe_obstacle_left", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
	AI.PushGoal("tr_strafe_obstacle_left", "+branch", 1, "LOOP", BRANCH_ALWAYS);
	AI.PushLabel("tr_strafe_obstacle_left", "STOP_HERE");
	AI.PushGoal("tr_strafe_obstacle_left", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("tr_strafe_obstacle_left","signal",0,1,"STRAFE_POINT_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("tr_strafe_obstacle_right");
	AI.PushGoal("tr_strafe_obstacle_right","firecmd",0,0);
	AI.PushGoal("tr_strafe_obstacle_right", "+backoff", 0, 4, 0, AI_MOVE_RIGHT);
	AI.PushLabel("tr_strafe_obstacle_right", "LOOP");
	AI.PushGoal("tr_strafe_obstacle_right", "+branch", 1, "STOP_HERE", IF_CAN_SHOOT_TARGET);
	AI.PushGoal("tr_strafe_obstacle_right", "+branch", 1, "LOOP", BRANCH_ALWAYS);
	AI.PushLabel("tr_strafe_obstacle_right", "STOP_HERE");
	AI.PushGoal("tr_strafe_obstacle_right", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("tr_strafe_obstacle_right","signal",0,1,"STRAFE_POINT_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("tr_reach_target_visibility");
	AI.PushGoal("tr_reach_target_visibility","acqtarget",1,"");
	AI.PushGoal("tr_reach_target_visibility","ignoreall",1,1);
	AI.PushGoal("tr_reach_target_visibility","+firecmd",0,0);
	AI.PushGoal("tr_reach_target_visibility", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
		AI.PushGoal("tr_reach_target_visibility", "+approach", 0, 2);
		AI.PushGoal("tr_reach_target_visibility", "+timeout", 1, 0.2, 0.3);
		AI.PushGoal("tr_reach_target_visibility", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
			AI.PushGoal("tr_reach_target_visibility", "+timeout", 1, 0.2, 0.3);
			AI.PushGoal("tr_reach_target_visibility", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
				AI.PushGoal("tr_reach_target_visibility", "+timeout", 1, 0.2, 0.3);
				AI.PushGoal("tr_reach_target_visibility", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
					AI.PushGoal("tr_reach_target_visibility", "+timeout", 1, 0.2, 0.3);
	AI.PushLabel("tr_reach_target_visibility", "STOP_HERE");
	AI.PushGoal("tr_reach_target_visibility","ignoreall",1,0);
	AI.PushGoal("tr_reach_target_visibility", "clear", 0, 1); -- stops approaching - 0 means keep att. target
	AI.PushGoal("tr_reach_target_visibility","signal",0,1,"VISIBILITY_POINT_REACHED",SIGNALFILTER_SENDER);		


	AI.BeginGoalPipe("tr_seek_target");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("ignoreall",0,0);
		AI.PushGoal("run",0,1);
		AI.PushGoal("stick",1,0.4,AI_REQUEST_PARTIAL_PATH,STICK_BREAK);
		--AI.PushGoal("tr_check_prone_and_stick",1);
		AI.PushGoal("run",0,0);
--		AI.PushGoal("locate",1,"beacon");		
--		AI.PushGoal("approach",1,0.5,AILASTOPRES_USE+AI_REQUEST_PARTIAL_PATH);
		AI.PushGoal("signal",1,1,"GO_TO_SEARCH",SIGNALFILTER_SENDER);

		--AI.PushGoal("signal",0,1,"END_SEEK_TARGET",0);
	AI.EndGoalPipe();

	AI.CreateGoalPipe("tr_strafe_and_form");
--	AI.PushGoal("tr_strafe_and_form","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_strafe_and_form","firecmd",0,0);
	AI.PushGoal("tr_strafe_and_form","run",0,-0.3);
	AI.PushGoal("tr_strafe_and_form","locate",1,"refpoint");
	AI.PushGoal("tr_strafe_and_form","approach",1,1,1);
	AI.PushGoal("tr_strafe_and_form","timeout",1,0.5,1.5);
	AI.PushGoal("tr_strafe_and_form","locate",1,"formation");
	AI.PushGoal("tr_strafe_and_form","run",0,0);
	AI.PushGoal("tr_strafe_and_form","approach",1,1,1);
	AI.PushGoal("tr_strafe_and_form","timeout",1,0.5,1);
	AI.PushGoal("tr_strafe_and_form","signal",0,1,"StrafeShoot",0);



	AI.CreateGoalPipe("tr_stick_close");
	AI.PushGoal("tr_stick_close","firecmd",0,0);
	AI.PushGoal("tr_stick_close","run",0,1);
	AI.PushGoal("tr_stick_close","stick",1,5,0,1);

	AI.CreateGoalPipe("tr_stick_close_defend");
	AI.PushGoal("tr_stick_close_defend","tr_stick_close",1);
	AI.PushGoal("tr_stick_close_defend","signal",0,1,"CHECK_DEFEND_SPOT",SIGNALFILTER_SENDER);


	AI.CreateGoalPipe("tr_prepare_melee");
	AI.PushGoal("tr_prepare_melee","run",0,1);
	AI.PushGoal("tr_prepare_melee","stick",1,0.1,0,1);
--	AI.PushGoal("tr_prepare_melee","signal",0,1,"END_PREPARE_MELEE",SIGNALFILTER_SENDER);

	
	AI.BeginGoalPipe("tr_try_melee_inplace");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("run",0,1.5);
		AI.BeginGroup();
			AI.PushGoal("stick",0,2.2,0,STICK_BREAK);
--			AI.PushGoal("signal",1,1,"MELEE_ONGOING",SIGNALFILTER_SENDER);
			AI.PushGoal("timeout",0,0.7);
		AI.EndGroup();
		AI.PushGoal("wait", 1, WAIT_ANY);
		AI.PushGoal("branch",1,"OK",IF_TARGET_DIST_LESS,TROOPER_CLOSE_DISTANCE_STICK);
			AI.PushGoal("signal",1,1,"MELEE_FAILED",SIGNALFILTER_SENDER);
			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
		AI.PushLabel("OK");
			AI.PushGoal("signal",1,1,"MELEE_OK",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
		AI.PushGoal("clear",0,0);
	AI.EndGoalPipe();


	AI.BeginGoalPipe("tr_try_melee_special");
		--AI.PushGoal("firecmd",0,FIREMODE_AIM);
		AI.PushGoal("branch",0,"OK",IF_TARGET_DIST_LESS, TROOPER_CLOSE_DISTANCE_STICK);
		AI.PushGoal("run",0,1.5);
		AI.PushLabel("LOOP"); -- first get close enough
			AI.PushGoal("stick",0,1.5,0);--,STICK_SHORTCUTNAV);
			AI.PushGoal("branch",0,"OK",IF_TARGET_DIST_LESS, TROOPER_CLOSE_DISTANCE_STICK);
			AI.PushGoal("branch",0,"FAILED",IF_NO_PATH);
			AI.PushGoal("branch",0,"LOOP2_0",IF_TARGET_DIST_LESS,4);
			AI.PushGoal("signal",0,1,"SET_END_MELEE_TIMER",SIGNALFILTER_SENDER);
		AI.PushLabel("LOOP1"); -- first get close enough
			AI.PushGoal("timeout",1,0.2);
			AI.PushGoal("branch",0,"LOOP1",NOT+IF_TARGET_DIST_LESS,4);
		AI.PushLabel("LOOP2_0");
			AI.PushGoal("signal",0,1,"SET_END_MELEE_TIMER",SIGNALFILTER_SENDER);
		AI.PushLabel("LOOP2");
			AI.PushGoal("branch",0,"OK",IF_TARGET_DIST_LESS,TROOPER_CLOSE_DISTANCE_STICK);
			AI.PushGoal("branch",0,"FAILED",NOT+IF_TARGET_DIST_LESS,4.5);
			AI.PushGoal("timeout",1,0.2);
			AI.PushGoal("branch",0,"LOOP2",IF_ACTIVE_GOALS);-- stick
		AI.PushLabel("FAILED");
			AI.PushGoal("signal",1,1,"EndBehaviour",SIGNALFILTER_SENDER);
			AI.PushGoal("branch",0,"END",BRANCH_ALWAYS);
		AI.PushLabel("OK");
			AI.PushGoal("branch",0,"MELEE",NOT+IF_TARGET_DIST_LESS,TROOPER_CLOSE_DISTANCE_STICK*0.7);
				AI.PushGoal("run",0,1);
				AI.PushGoal("backoff",1,TROOPER_CLOSE_DISTANCE_STICK,1,AI_BACKOFF_FROM_TARGET+AI_MOVE_BACKWARD+AI_CHECK_SLOPE_DISTANCE);
		AI.PushLabel("MELEE");
			--AI.PushGoal("animation",0,AIANIM_SIGNAL,"meleeAttack");
			AI.PushGoal("signal",0,1,"MELEE_OK",SIGNALFILTER_SENDER);
			--AI.PushGoal("timeout",1,0.5);
			AI.PushGoal("clear",0,0); -- clear current stick
			AI.PushGoal("branch",0,"LOOP",BRANCH_ALWAYS);
			--AI.PushGoal("signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
		AI.PushGoal("clear",0,0);
	AI.EndGoalPipe();


--	AI.BeginGoalPipe("tr_try_melee_vehicle");
--		AI.PushGoal("firecmd",0,0);
--		AI.PushGoal("branch",1,"OK",IF_TARGET_DIST_LESS, TROOPER_VEHICLE_DISTANCE_STICK);
--		AI.PushGoal("run",0,1);
--		AI.PushGoal("strafe",0,10);
--		AI.PushLabel("LOOP"); -- first get close enough
--			AI.PushGoal("stick",0,4,AI_REQUEST_PARTIAL_PATH+AI_DONT_STEER_AROUND_TARGET,STICK_SHORTCUTNAV);
--			AI.PushGoal("branch",1,"OK",IF_TARGET_DIST_LESS, TROOPER_VEHICLE_DISTANCE_STICK);
--			AI.PushGoal("branch",1,"FAILED",IF_NO_PATH);
--			AI.PushGoal("branch",1,"LOOP2_0",IF_TARGET_DIST_LESS,5);
--			AI.PushGoal("signal",0,1,"SET_END_MELEE_TIMER",SIGNALFILTER_SENDER);
--		AI.PushLabel("LOOP1"); -- first get close enough
--			AI.PushGoal("timeout",1,0.2);
--			AI.PushGoal("branch",1,"LOOP1",NOT+IF_TARGET_DIST_LESS,5);
--		AI.PushLabel("LOOP2_0");
--			AI.PushGoal("signal",0,1,"SET_END_MELEE_TIMER",SIGNALFILTER_SENDER);
--		AI.PushLabel("LOOP2");
--			AI.PushGoal("branch",1,"OK",IF_TARGET_DIST_LESS,TROOPER_VEHICLE_DISTANCE_STICK);
--			AI.PushGoal("branch",1,"FAILED",NOT+IF_TARGET_DIST_LESS,5);
--			AI.PushGoal("timeout",1,0.2);
--			AI.PushGoal("branch",1,"LOOP2",IF_ACTIVE_GOALS);-- stick
--		AI.PushLabel("FAILED");
--			AI.PushGoal("signal",1,1,"MELEE_FAILED",SIGNALFILTER_SENDER);
--			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
--		AI.PushLabel("OK");
--			AI.PushGoal("animation",0,AIANIM_SIGNAL,"meleeAttack");
--			AI.PushGoal("signal",0,1,"MELEE_OK",SIGNALFILTER_SENDER);
--			AI.PushGoal("timeout",1,0.5);
--			AI.PushGoal("clear",0,0); -- clear current stick
--			AI.PushGoal("branch",1,"LOOP",BRANCH_ALWAYS);
--			--AI.PushGoal("signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);
--		AI.PushLabel("END");
--		AI.PushGoal("clear",0,0);
--	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_try_melee_vehicle");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("locate",0,"self");
		AI.PushGoal("proximity",0,TROOPER_VEHICLE_DISTANCE_STICK+0.3,"MELEE_TARGET_CLOSE", AIPROX_VISIBLE_TARGET_ONLY);
--		AI.PushGoal("branch",1,"OK",IF_TARGET_DIST_LESS, TROOPER_VEHICLE_DISTANCE_STICK);
		AI.PushGoal("run",0,1);
		AI.PushGoal("strafe",0,10);
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("stick",1,0.1,AILASTOPRES_USE+AI_REQUEST_PARTIAL_PATH+AI_DONT_STEER_AROUND_TARGET,STICK_SHORTCUTNAV);
		AI.PushGoal("branch",1,"OK",IF_TARGET_DIST_LESS, TROOPER_VEHICLE_DISTANCE_STICK);
		AI.PushLabel("FAILED");
			AI.PushGoal("signal",1,1,"EndBehaviour",SIGNALFILTER_SENDER);
		AI.PushLabel("OK");
			--AI.PushGoal("signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();


	AI.BeginGoalPipe("tr_try_melee_knocked");
		AI.PushGoal("clear",0,0); -- clear current messed up stick
		AI.PushGoal("run",0,1.5);
		AI.PushGoal("stick",0,1.7,0,STICK_SHORTCUTNAV);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_stick_close_shooting0");
		AI.PushGoal("bodypos",1,BODYPOS_STAND);
		AI.PushGoal("run",0,0);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("stick",0,5,0);
		AI.PushGoal("signal",0,1,"RANDOM_FIGHT_SOUND",SIGNALFILTER_SENDER);
		AI.PushLabel("LOOP");
	--	AI.PushGoal("stick",1,5,0,1);
			AI.PushGoal("firecmd",1,FIREMODE_BURST);
			AI.PushGoal("timeout",1,2.1,2.7);
			AI.PushGoal("firecmd",1,0);
			AI.PushGoal("timeout",1,0.4);
			AI.PushGoal("branch",1,"LOOP",BRANCH_ALWAYS);
		AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_stick_shooting0");
		AI.PushGoal("bodypos",1,BODYPOS_STAND);
		AI.PushGoal("run",0,1);
		--AI.PushGoal("firecmd",1,0);
		--AI.PushGoal("stick",1,10,0,1);
		AI.PushGoal("stick",0,10,0);
		AI.PushLabel("LOOP");
		
		AI.PushGoal("firecmd",1,FIREMODE_BURST);
		AI.PushGoal("signal",0,1,"RANDOM_FIGHT_SOUND",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,2.6);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("timeout",1,0.4);
		AI.PushGoal("branch",1,"LOOP",BRANCH_ALWAYS);
		
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_melee_jump");
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",0,1,"END_MELEE_JUMP",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_stick_close_shooting1");
		AI.PushGoal("run",0,1);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("stick",0,5,0);
		AI.PushLabel("LOOP");
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
		AI.PushGoal("timeout",1,2.5,3.3);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("timeout",1,1,1.5);
		AI.PushGoal("branch",1,"LOOP",BRANCH_ALWAYS);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_stick_shooting1");
		AI.PushGoal("run",1,1);
		AI.PushGoal("stick",0,10,0);
--		AI.PushGoal("signal",0,1,"RANDOM_FIGHT_SOUND",SIGNALFILTER_SENDER);
		--AI.PushGoal("signal",0,1,"FIREMODE1",SIGNALID_READIBILITY);
		AI.PushLabel("LOOP");
		AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
		AI.PushGoal("timeout",1,5,7);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("timeout",1,1,2);
		AI.PushGoal("branch",1,"LOOP",BRANCH_ALWAYS);
	AI.EndGoalPipe();
	
	AI.CreateGoalPipe("tr_stick_close_shooting0_defend");
	AI.PushGoal("tr_stick_close_shooting0_defend","tr_stick_close_shooting0",1);
	AI.PushGoal("tr_stick_close_shooting0_defend","signal",0,1,"CHECK_DEFEND_SPOT",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_stick_close_shooting1_defend");
	AI.PushGoal("tr_stick_close_shooting1_defend","tr_stick_close_shooting1",1);
	AI.PushGoal("tr_stick_close_shooting1_defend","signal",0,1,"CHECK_DEFEND_SPOT",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_stick_shooting0_defend");
	AI.PushGoal("tr_stick_shooting0_defend","tr_stick_shooting0",1);
	AI.PushGoal("tr_stick_shooting0_defend","signal",0,1,"CHECK_DEFEND_SPOT",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_stick_shooting1_defend");
	AI.PushGoal("tr_stick_shooting1_defend","tr_stick_shooting1",1);
	AI.PushGoal("tr_stick_shooting1_defend","signal",0,1,"CHECK_DEFEND_SPOT",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_goto_refpoint");
	AI.PushGoal("tr_goto_refpoint","locate",1,"refpoint");
	AI.PushGoal("tr_goto_refpoint","+approach",1,1,AILASTOPRES_USE);

	AI.CreateGoalPipe("tr_approach_beacon");
	AI.PushGoal("tr_approach_beacon","locate",1,"beacon");
	AI.PushGoal("tr_approach_beacon","approach",1,1,AILASTOPRES_USE);
	AI.PushGoal("tr_approach_beacon","signal",0,1,"BEACON_APPROACHED",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_end_dodge_grenade");
	AI.PushGoal("tr_end_dodge_grenade","locate",0,"beacon");
	AI.PushGoal("tr_end_dodge_grenade","acqtarget",0,"");
	AI.PushGoal("tr_end_dodge_grenade","approach",1,5);
	AI.PushGoal("tr_end_dodge_grenade","signal",0,1,"END_DODGE_GRENADE",SIGNALFILTER_SENDER);
	

	AI.CreateGoalPipe("tr_setup_combat");	
--	AI.PushGoal("tr_setup_combat","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_setup_combat","run",0,1);
	AI.PushGoal("tr_setup_combat","signal",0,1,"UNCLOAK",0);	

	AI.CreateGoalPipe("tr_setup_stealth");	
--	AI.PushGoal("tr_setup_stealth","bodypos",0,BODYPOS_STEALTH);	
	AI.PushGoal("tr_setup_stealth","run",0,0);	
	AI.PushGoal("tr_setup_stealth","signal",0,1,"CLOAK",0);	


	AI.CreateGoalPipe("tr_just_shoot");
	AI.PushGoal("tr_just_shoot","run",1,1);
	AI.PushGoal("tr_just_shoot","firecmd",0,FIREMODE_CONTINUOUS);
	AI.PushGoal("tr_just_shoot","timeout",1,2);
	AI.PushGoal("tr_just_shoot","firecmd",0,0);
	AI.PushGoal("tr_just_shoot","signal",1,1,"TR_NORMALATTACK",0);

	AI.CreateGoalPipe("tr_acquire_target_and_pursue");
	AI.PushGoal("tr_acquire_target_and_pursue","+ignoreall",1,1);
	AI.PushGoal("tr_acquire_target_and_pursue","+run",0,0.5);
	AI.PushGoal("tr_acquire_target_and_pursue","+firecmd",1,0);
	AI.PushGoal("tr_acquire_target_and_pursue","+stick",1,4,AILASTOPRES_USE+AILASTOPRES_LOOKAT,1);
	AI.PushGoal("tr_acquire_target_and_pursue","+acqtarget",1,"");
	AI.PushGoal("tr_acquire_target_and_pursue","+firecmd",1,FIREMODE_CONTINUOUS);
	AI.PushGoal("tr_acquire_target_and_pursue","+signal",0,1,"FIREMODE0",SIGNALID_READIBILITY);
	AI.PushGoal("tr_acquire_target_and_pursue","+signal",0,1,"RANDOM_FIGHT_SOUND",SIGNALFILTER_SENDER);
	AI.PushGoal("tr_acquire_target_and_pursue","+timeout",1,2,3);
	AI.PushGoal("tr_acquire_target_and_pursue","+ignoreall",1,0);
	AI.PushGoal("tr_acquire_target_and_pursue","signal",1,1,"TR_NORMALATTACK",0);
	
	AI.CreateGoalPipe("tr_attack_get_in_range");	
	AI.PushGoal("tr_attack_get_in_range","firecmd",0,0);	
--	AI.PushGoal("tr_attack_get_in_range","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_attack_get_in_range","run",0,1);
	AI.PushGoal("tr_attack_get_in_range","approach",1,15);
	AI.PushGoal("tr_attack_get_in_range","run",0,0);
	AI.PushGoal("tr_attack_get_in_range","signal",1,1,"TR_NORMALATTACK",0);

	AI.CreateGoalPipe("tr_backoff");	
	--AI.PushGoal("tr_backoff","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_backoff","firecmd",0,0);	
	AI.PushGoal("tr_backoff","backoff",1,6,4,AI_BACKOFF_FROM_TARGET);

	AI.BeginGoalPipe("tr_backoff_fire");	
		--AI.PushGoal("bodypos",0,BODYPOS_STAND);
		AI.PushGoal("firecmd",0,FIREMODE_BURST);	
		AI.PushGoal("backoff",1,6,4,AI_BACKOFF_FROM_TARGET);
		AI.PushGoal("firecmd",0,0);	
		AI.PushGoal("signal",1,1,"END_BACKOFF",0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_backoff_fire_lastop");	
		AI.PushGoal("acqtarget",0,"");
		--AI.PushGoal("bodypos",0,BODYPOS_STAND);
		AI.PushGoal("firecmd",0,FIREMODE_BURST);	
		AI.PushGoal("backoff",1,6,4,AI_BACKOFF_FROM_TARGET+AI_MOVE_LEFT+AI_MOVE_RIGHT+AI_MOVE_BACKWARD+AI_MOVE_BACKLEFT+AI_MOVE_BACKRIGHT+ AI_RANDOM_ORDER);
		AI.PushGoal("firecmd",0,0);	
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_hide_away_from_lastop");	
		AI.PushGoal("acqtarget",0,"");
		AI.PushGoal("firecmd",0,FIREMODE_BURST);	
		AI.PushGoal("hide",1,15,HM_FARTHEST_FROM_TARGET);
		AI.PushGoal("branch",1,"OK",NOT+IF_CANNOT_HIDE);
			AI.PushGoal("backoff",1,10,4,AI_BACKOFF_FROM_TARGET+AI_MOVE_LEFT+AI_MOVE_RIGHT+AI_MOVE_BACKWARD+AI_MOVE_BACKLEFT+AI_MOVE_BACKRIGHT+ AI_RANDOM_ORDER);
			AI.PushGoal("branch",1,"END",IF_EXPOSED_TO_TARGET);
		AI.PushLabel("OK");
			AI.PushGoal("firecmd",0,0);	
			AI.PushGoal("timeout",1,2.5,4.0);
		AI.PushLabel("END");
		AI.PushGoal("signal",1,1,"END_HIDE_FROM_LASTOP",0);
	AI.EndGoalPipe();


	AI.BeginGoalPipe("tr_look_closer");
		AI.PushGoal("firecmd",0,0);	
		AI.PushGoal("timeout",1,0.3,0.7);
--		AI.PushGoal("approach",1,10,AI_REQUEST_PARTIAL_PATH);
--		AI.PushGoal("branch",1,"CONTINUE",IF_NO_ENEMY_TARGET);
--		AI.PushGoal("signal",1,1,"GO_TO_ATTACK",0);
--		AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
--		AI.PushLabel("CONTINUE");
		AI.PushGoal("approach",1,0.4,AI_REQUEST_PARTIAL_PATH);
		AI.PushGoal("branch",1,"END",IF_NO_PATH);
		AI.PushGoal("bodypos", 1, BODYPOS_STEALTH);
		AI.PushGoal("lookaround",1,90,3,4,6);
		AI.PushLabel("END");
		AI.PushGoal("bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("signal",1,1,"END_LOOK_CLOSER",0);
--		AI.PushLabel("END");
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_look_closer_lastop");
		AI.PushGoal("firecmd",0,0);	
		AI.PushGoal("timeout",1,0.5,1.0);
		AI.PushGoal("approach",1,0.4,AILASTOPRES_USE + AI_REQUEST_PARTIAL_PATH);
--		AI.PushGoal("tr_check_prone_and_stick",1);
		AI.PushGoal("branch",1,"END",IF_NO_PATH);
		AI.PushGoal("lookaround",1,90,3,7,10);
		AI.PushLabel("END");
		AI.PushGoal("signal",1,1,"END_LOOK_CLOSER",0);
	AI.EndGoalPipe();

	AI.CreateGoalPipe("tr_threatened");
--	AI.PushGoal("tr_threatened","DRAW_GUN"); 
	AI.PushGoal("tr_threatened","tr_setup_combat");
	AI.PushGoal("tr_threatened","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_threatened","timeout",1,0.2,0.8); 
--	AI.PushGoal("tr_threatened","signal",1,1,"DO_THREATENED_ANIMATION",0);
--	AI.PushGoal("tr_threatened","take_cover");
	AI.PushGoal("tr_threatened","timeout",1,0.5,1); 

	AI.CreateGoalPipe("tr_investigate_threat");
--	AI.PushGoal("tr_investigate_threat","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_investigate_threat","firecmd",0,0);	
	AI.PushGoal("tr_investigate_threat","approach",1,0.7);
	AI.PushGoal("tr_investigate_threat","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_investigate_threat","firecmd",0,1);	
	AI.PushGoal("tr_investigate_threat","timeout",1,0.5,1.5);	

	AI.CreateGoalPipe("tr_getting_shot_at");
	AI.PushGoal("tr_getting_shot_at","clear",0,1);	-- get to cover, nothing else matters
	AI.PushGoal("tr_getting_shot_at","ignoreall",0,1);	-- get to cover, nothing else matters
	AI.PushGoal("tr_getting_shot_at","take_cover");
	AI.PushGoal("tr_getting_shot_at","ignoreall",0,0);
--	AI.PushGoal("tr_getting_shot_at","DRAW_GUN");
	AI.PushGoal("tr_getting_shot_at","tr_setup_combat");	-- now regroup
	AI.PushGoal("tr_getting_shot_at","signal",0,1,"INVESTIGATE_TARGET",0);

	AI.CreateGoalPipe("tr_group_member_died");
	AI.PushGoal("tr_group_member_died","timeout",1,0.2);
	AI.PushGoal("tr_group_member_died","locate",1,"beacon");
	AI.PushGoal("tr_group_member_died","acqtarget",1,"");
	--AI.PushGoal("tr_group_member_died","bodypos",1,BODYPOS_PRONE);
	AI.PushGoal("tr_group_member_died","run",1,1);
	AI.PushGoal("tr_group_member_died","timeout",1,1);
	AI.PushGoal("tr_group_member_died","hide",1,20,HM_NEAREST,1);
	AI.PushGoal("tr_group_member_died","bodypos",1,BODYPOS_STAND);
	AI.PushGoal("tr_group_member_died","run",1,0);

	AI.CreateGoalPipe("tr_group_member_died_beacon");
	AI.PushGoal("tr_group_member_died_beacon","DropBeaconAt");		
	AI.PushGoal("tr_group_member_died_beacon","tr_group_member_died");
	AI.PushGoal("tr_group_member_died_beacon","clear",0,1);
	AI.PushGoal("tr_group_member_died_beacon","signal",0,1,"DEATH_CONFIRMED",SIGNALFILTER_GROUPONLY);
	
	AI.CreateGoalPipe("tr_choose_manner");
	AI.PushGoal("tr_choose_manner","timeout",1,1,2);
	AI.PushGoal("tr_choose_manner","signal",0,1,"CHOOSE_MANNER",0);
		
	AI.CreateGoalPipe("tr_approach_threat");
--	AI.PushGoal("tr_approach_threat","bodypos",1,BODYPOS_PRONE);
	AI.PushGoal("tr_approach_threat","run",1,1);
	AI.PushGoal("tr_approach_threat","hide",1,20,HM_NEAREST);
	AI.PushGoal("tr_approach_threat","timeout",1,0.5,1);
	AI.PushGoal("tr_approach_threat","firecmd",0,0);
	AI.PushGoal("tr_approach_threat","run",0,0);
	AI.PushGoal("tr_approach_threat","approach",1,0.5);
	AI.PushGoal("tr_approach_threat","bodypos",1,BODYPOS_STAND);
	AI.PushGoal("tr_approach_threat","timeout",1,1);
	AI.PushGoal("tr_approach_threat","signal",0,1,"CEASE",0);
	
	AI.CreateGoalPipe("tr_cease_approach");
	AI.PushGoal("tr_cease_approach","devalue",0);
	AI.PushGoal("tr_cease_approach","timeout",0,8,10); -- start branch
	AI.PushGoal("tr_cease_approach","signal",0,1,"TARGET_LOST_ANIMATION",0); -- play animation
	AI.PushGoal("tr_cease_approach","timeout",1,2,3); 
	AI.PushGoal("tr_cease_approach","lookat",1,-60,60);
	AI.PushGoal("tr_cease_approach","timeout",1,2,2.5); 
	AI.PushGoal("tr_cease_approach","branch",1,-4);	-- end branch
	AI.PushGoal("tr_cease_approach","timeout",1,1);
	AI.PushGoal("tr_cease_approach","signal",0,1,"CONFUSED_ANIMATION",0); -- play animation
	AI.PushGoal("tr_cease_approach","timeout",1,2,3);
	AI.PushGoal("tr_cease_approach","signal",0,1,"RETURN_TO_FIRST",0); -- change behaviour back to idle
	AI.PushGoal("tr_cease_approach","signal",0,1,"GoOn",0);  -- start proper action there

	AI.CreateGoalPipe("tr_lookaround_30seconds");
	AI.PushGoal("tr_lookaround_30seconds","clear",1,1)
	AI.PushGoal("tr_lookaround_30seconds","timeout",0,30)
	AI.PushGoal("tr_lookaround_30seconds","lookat",1,-90,90);
	AI.PushGoal("tr_lookaround_30seconds","timeout",1,1,3);
	--AI.PushGoal("tr_lookaround_30seconds","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_lookaround_30seconds","timeout",1,1,3);
	AI.PushGoal("tr_lookaround_30seconds","strafe",1,-2);
	--AI.PushGoal("tr_lookaround_30seconds","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_lookaround_30seconds","lookat",1,-90,90);
	AI.PushGoal("tr_lookaround_30seconds","timeout",1,1,3);
	--AI.PushGoal("tr_lookaround_30seconds","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_lookaround_30seconds","timeout",1,1,3);
	AI.PushGoal("tr_lookaround_30seconds","strafe",1,2);
	--AI.PushGoal("tr_lookaround_30seconds","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_lookaround_30seconds","branch",0,-6);
	
	AI.CreateGoalPipe("tr_look_for_threat");	
	AI.PushGoal("tr_look_for_threat","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_look_for_threat","lookat",1,-150,-210);
	AI.PushGoal("tr_look_for_threat","timeout",1,1);
	AI.PushGoal("tr_look_for_threat","lookat",1,-90,-180);
	AI.PushGoal("tr_look_for_threat","timeout",1,1);
	AI.PushGoal("tr_look_for_threat","lookat",1,70,110);
	AI.PushGoal("tr_look_for_threat","lookat",1,-70,-110);

	AI.BeginGoalPipe("tr_random_search");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("locate",0,"hidepoint");
		AI.PushGoal("run",0,0);
		AI.PushGoal("acqtarget",1,"");
		AI.PushGoal("approach",1,3);
		AI.PushGoal("clear",0,1);
	AI.EndGoalPipe();
	
	AI.CreateGoalPipe("tr_approach_dead_beacon");
--	AI.PushGoal("tr_approach_dead_beacon","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_approach_dead_beacon","firecmd",0,0);
	AI.PushGoal("tr_approach_dead_beacon","run",0,0);
	AI.PushGoal("tr_approach_dead_beacon","locate",1,"beacon");
	AI.PushGoal("tr_approach_dead_beacon","acqtarget",1,"");
	AI.PushGoal("tr_approach_dead_beacon","approach",1,3);
	AI.PushGoal("tr_approach_dead_beacon","clear",0,1);
	AI.PushGoal("tr_approach_dead_beacon","tr_look_for_threat");
	AI.PushGoal("tr_approach_dead_beacon","tr_random_search");
--
--	AI.CreateGoalPipe("tr_shoot_cover");
--	AI.PushGoal("tr_shoot_cover","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("tr_shoot_cover","firecmd",0,2);
--	AI.PushGoal("tr_shoot_cover","+hide",1,10,HM_NEAREST);
--	AI.PushGoal("tr_shoot_cover","run",0,0);
--	AI.PushGoal("tr_shoot_cover","firecmd",0,0);

	AI.CreateGoalPipe("tr_confirm_targetloss");
	AI.PushGoal("tr_confirm_targetloss","tr_setup_stealth");
	AI.PushGoal("tr_confirm_targetloss","locate",0,"beacon");
	AI.PushGoal("tr_confirm_targetloss","acqtarget",0,"");
	--AI.PushGoal("tr_confirm_targetloss","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_confirm_targetloss","firecmd",0,0);
	AI.PushGoal("tr_confirm_targetloss","approach",1,1);
	AI.PushGoal("tr_confirm_targetloss","devalue",0);

--	AI.CreateGoalPipe("tr_disturbance_let_it_go");
--	AI.PushGoal("tr_disturbance_let_it_go","setup_idle");
--	AI.PushGoal("tr_disturbance_let_it_go","bodypos",1,BODYPOS_STAND);
--	AI.PushGoal("tr_disturbance_let_it_go","timeout",1,1,2);
--	AI.PushGoal("tr_disturbance_let_it_go","signal",0,1,"DO_LETGO_ANIMATION",0);
--	AI.PushGoal("tr_disturbance_let_it_go","timeout",1,0,1);
--	AI.PushGoal("tr_disturbance_let_it_go","signal",0,1,"RETURN_TO_FIRST",0);

--	AI.CreateGoalPipe("tr_notify_player_seen");
--	AI.PushGoal("tr_notify_player_seen", "DropBeaconAt");
--	AI.PushGoal("tr_notify_player_seen", "signal", 0, 1, "NotifyPlayerSeen", SIGNALFILTER_SUPERGROUP);
--	AI.PushGoal("tr_notify_player_seen", "signal", 0, 1, "FIRST_HOSTILE_CONTACT", SIGNALID_READIBILITY);
--	AI.PushGoal("tr_notify_player_seen", "timeout", 1, 0.5);

--	AI.CreateGoalPipe("tr_go_for_cover");
--	AI.PushGoal("tr_go_for_cover","locate",0,"beacon");
--	AI.PushGoal("tr_go_for_cover","acqtarget",0,"");
----	AI.PushGoal("tr_go_for_cover","bodypos",1,BODYPOS_PRONE);
--	AI.PushGoal("tr_go_for_cover","run",1,1);
--	AI.PushGoal("tr_go_for_cover","hide",1,20,HM_NEAREST);
--	AI.PushGoal("tr_go_for_cover","devalue",0);
--	--AI.PushGoal("tr_go_for_cover","bodypos",1,BODYPOS_STAND);
--	AI.PushGoal("tr_go_for_cover","timeout",1,0.25,0.5);
--	AI.PushGoal("tr_go_for_cover","lookat",1,180);
--	AI.PushGoal("tr_go_for_cover","timeout",1,1,1.5);
--	AI.PushGoal("tr_go_for_cover","locate",0,"beacon");
--	AI.PushGoal("tr_go_for_cover","acqtarget",0,"");
--	AI.PushGoal("tr_go_for_cover","tr_approach_threat");

--	AI.CreateGoalPipe("tr_recog_corpse");
--	AI.PushGoal("tr_recog_corpse","form",1,"beacon");
--	AI.PushGoal("tr_recog_corpse","locate",1,"beacon");
--	AI.PushGoal("tr_recog_corpse","acqtarget",1,"");
----	AI.PushGoal("tr_recog_corpse","bodypos",0,BODYPOS_PRONE);
--	AI.PushGoal("tr_recog_corpse","run",1,1);
--	AI.PushGoal("tr_recog_corpse","hide",1,20,HM_NEAREST);
--	--AI.PushGoal("tr_recog_corpse","bodypos",0,BODYPOS_PRONE);
--	AI.PushGoal("tr_recog_corpse","run",1,0);
--	AI.PushGoal("tr_recog_corpse","hide",1,20,HM_NEAREST_TO_LASTOPRESULT);
----	AI.PushGoal("tr_recog_corpse","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("tr_recog_corpse","timeout",1,0,1);
--	AI.PushGoal("tr_recog_corpse","branch",0,-2,1);	-- this will loop until there is no more hiding points
--	AI.PushGoal("tr_recog_corpse","acqtarget",1,"");
--	AI.PushGoal("tr_recog_corpse","approach",1,1);
--	AI.PushGoal("tr_recog_corpse","timeout",1,1);
--	AI.PushGoal("tr_recog_corpse","signal",1,1,"DEATH_RECOGNITION",0);
--	AI.PushGoal("tr_recog_corpse","timeout",1,2);
--	AI.PushGoal("tr_recog_corpse","signal",1,1,"DEATH_CONFIRMED",SIGNALFILTER_GROUPONLY);

	AI.CreateGoalPipe("tr_cease_investigation");
	AI.PushGoal("tr_cease_investigation","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_cease_investigation","devalue",0);
	AI.PushGoal("tr_cease_investigation","timeout",0,8,12); -- start branch
	AI.PushGoal("tr_cease_investigation","signal",0,1,"ANIM_SOUND",0); -- play animation
	AI.PushGoal("tr_cease_investigation","timeout",1,2,3); 
	AI.PushGoal("tr_cease_investigation","lookat",1,-60,60);
	AI.PushGoal("tr_cease_investigation","timeout",1,2,2.5); 
	AI.PushGoal("tr_cease_investigation","branch",1,-4);	-- end branch
	AI.PushGoal("tr_cease_investigation","signal",0,1,"ANIM_CONFUSED",0); -- play animation
	AI.PushGoal("tr_cease_investigation","timeout",1,3,4);
	AI.PushGoal("tr_cease_investigation","signal",0,1,"RETURN_TO_FIRST",0); -- change behaviour back to idle
	AI.PushGoal("tr_cease_investigation","signal",0,1,"GoOn",0);  -- start proper action there

	AI.CreateGoalPipe("tr_random_hide");
	AI.PushGoal("tr_random_hide","firecmd",0,0);
	--AI.PushGoal("tr_random_hide","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_random_hide","run",0,1);
	AI.PushGoal("tr_random_hide","hide",1,30,HM_RANDOM,1);
	AI.PushGoal("tr_random_hide","branch",0,"END",IF_CANNOT_HIDE);
--	AI.PushGoal("tr_random_hide","bodypos",0,BODYPOS_STAND);
	AI.PushLabel("tr_random_hide","END");
	AI.PushGoal("tr_random_hide","run",0,0);
	AI.PushGoal("tr_random_hide","signal",1,1,"END_HIDE",0);


	AI.CreateGoalPipe("tr_approach_lastop_lookaround");
	--AI.PushGoal("tr_approach_lastop_lookaround","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_approach_lastop_lookaround","firecmd",0,0);
	AI.PushGoal("tr_approach_lastop_lookaround","approach",0,1.1,AILASTOPRES_USE);
	--AI.PushGoal("tr_approach_lastop_lookaround","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_approach_lastop_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_approach_lastop_lookaround","lookat",1,-10,-20);
	AI.PushGoal("tr_approach_lastop_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_approach_lastop_lookaround","lookat",1,20,30);
	AI.PushGoal("tr_approach_lastop_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_approach_lastop_lookaround","lookat",1,0);
	AI.PushGoal("tr_approach_lastop_lookaround","branch",1,-1);
	AI.PushGoal("tr_approach_lastop_lookaround","signal",0,1,"TARGET_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("tr_stay_and_lookaround");
	AI.PushGoal("tr_stay_and_lookaround","firecmd",0,0);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,-50,-70);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,50,70);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,-50,-70);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,50,70);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,-70,-50);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,50,70);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,-50,-70);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","lookat",1,50,70);
	AI.PushGoal("tr_stay_and_lookaround","timeout",1,1,2);
	AI.PushGoal("tr_stay_and_lookaround","signal",1,1,"END_LOOKAROUND",SIGNALFILTER_SENDER);		


	AI.CreateGoalPipe("tr_search_hidespot_around");-- around the lastop
	AI.PushGoal("tr_search_hidespot_around","firecmd",0,0);
	AI.PushGoal("tr_search_hidespot_around","locate",1,"hidepoint_lastop",20);
	AI.PushGoal("tr_search_hidespot_around", "branch", 1, "NO_HIDESPOT", IF_NO_LASTOP);
	AI.PushGoal("tr_search_hidespot_around","approach",1,1.1,AILASTOPRES_USE);
	AI.PushGoal("tr_search_hidespot_around","signal",0,1,"HIDESPOT_SEARCHED",SIGNALFILTER_SENDER);		
	AI.PushGoal("tr_search_hidespot_around","branch",1,"END");		
	AI.PushLabel("tr_search_hidespot_around","NO_HIDESPOT");		
	AI.PushGoal("tr_search_hidespot_around","signal",0,1,"HIDESPOT_NOT_FOUND",SIGNALFILTER_SENDER);		
	AI.PushLabel("tr_search_hidespot_around","END");		

	AI.CreateGoalPipe("tr_search_for_target");
	--AI.PushGoal("tr_search_for_target","tr_setup_stealth");
	AI.PushGoal("tr_search_for_target","run",0,0);
	AI.PushGoal("tr_search_for_target","firecmd",0,0);
	--AI.PushGoal("tr_search_for_target","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_search_for_target","locate",0,"beacon");
	AI.PushGoal("tr_search_for_target","pathfind",1,"");
	AI.PushGoal("tr_search_for_target","trace",1,1);
	AI.PushGoal("tr_search_for_target","locate",0,"hidepoint");
	AI.PushGoal("tr_search_for_target","acqtarget",1,"");
	AI.PushGoal("tr_search_for_target","approach",1,3);
	--AI.PushGoal("tr_search_for_target","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_search_for_target","devalue",0);	
	AI.PushGoal("tr_search_for_target","timeout",1,1,3);
	AI.PushGoal("tr_search_for_target","lookat",1,-90,90);
	AI.PushGoal("tr_search_for_target","timeout",1,1,3);
	AI.PushGoal("tr_search_for_target","lookat",1,-90,90);

	AI.CreateGoalPipe("tr_scared_shoot");
	AI.PushGoal("tr_scared_shoot","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_scared_shoot","firecmd",1,2);
	AI.PushGoal("tr_scared_shoot","firecmd",1,2);
	AI.PushGoal("tr_scared_shoot","signal",1,1,"AI_AGGRESSIVE",SIGNALID_READIBILITY);
	AI.PushGoal("tr_scared_shoot","form",1,"beacon");
	AI.PushGoal("tr_scared_shoot","locate",1,"beacon");
	AI.PushGoal("tr_scared_shoot","timeout",1,0.5,2);
	AI.PushGoal("tr_scared_shoot","firecmd",1,1);

	AI.CreateGoalPipe("tr_grenade_run_away");
	AI.PushGoal("tr_grenade_run_away","firecmd",0,0);
	--AI.PushGoal("tr_grenade_run_away","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_grenade_run_away","run",0,1);
--	AI.PushGoal("tr_grenade_run_away","backoff",1,10,10);
	AI.PushGoal("tr_grenade_run_away","hide",1,20,HM_NEAREST);
	AI.PushGoal("tr_grenade_run_away","devalue",1);
		
	AI.CreateGoalPipe("tr_backoff_from");
	AI.PushGoal("tr_backoff_from","firecmd",0,0);
	AI.PushGoal("tr_backoff_from","run",0,1);
	--AI.PushGoal("tr_backoff_from","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_backoff_from","backoff",1,5,2);

	AI.CreateGoalPipe("tr_standing_there");
	AI.PushGoal("tr_standing_there","firecmd",0,0);
	--AI.PushGoal("tr_standing_there","bodypos",0,BODYPOS_STAND);

	AI.CreateGoalPipe("tr_random_short_timeout");
	AI.PushGoal("tr_random_short_timeout","firecmd",0,0);
	AI.PushGoal("tr_random_short_timeout","timeout",1,0.3,0.6);

	AI.CreateGoalPipe("tr_random_very_short_timeout");
	AI.PushGoal("tr_random_very_short_timeout","firecmd",0,0);
	AI.PushGoal("tr_random_very_short_timeout","timeout",1,0.1,0.3);

	AI.CreateGoalPipe("tr_short_cover_fire");
	AI.PushGoal("tr_short_cover_fire","acqtarget",1,"");
	AI.PushGoal("tr_short_cover_fire","firecmd",1,FIREMODE_CONTINUOUS);
	AI.PushGoal("tr_short_cover_fire","timeout",1,1.5);
	AI.PushGoal("tr_short_cover_fire","firecmd",1,0);
	AI.PushGoal("tr_short_cover_fire","timeout",1,0.4,0.5);
	AI.PushGoal("tr_short_cover_fire","firecmd",1,FIREMODE_CONTINUOUS);
	AI.PushGoal("tr_short_cover_fire","timeout",1,1.2);
	AI.PushGoal("tr_short_cover_fire","firecmd",1,0);
	AI.PushGoal("tr_short_cover_fire","signal",1,1,"END_COVER_FIRE",SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("tr_group_fire");
	AI.PushGoal("tr_group_fire","acqtarget",1,"");
	AI.PushGoal("tr_group_fire","firecmd",1,FIREMODE_CONTINUOUS);
	AI.PushGoal("tr_group_fire","timeout",1,1,1.2);
	AI.PushGoal("tr_group_fire","firecmd",1,0);
	AI.PushGoal("tr_group_fire","timeout",1,0.5,0.7);
	AI.PushGoal("tr_group_fire","firecmd",1,FIREMODE_CONTINUOUS);
	AI.PushGoal("tr_group_fire","timeout",1,1.0);
	AI.PushGoal("tr_group_fire","firecmd",1,0);
	
	AI.CreateGoalPipe("tr_hide_near");
	AI.PushGoal("tr_hide_near","firecmd",1,0);
	AI.PushGoal("tr_hide_near","run",0,1);
	AI.PushGoal("tr_hide_near","ignoreall",0,1);--don't lose/reaquire the target
	AI.PushGoal("tr_hide_near","+hide",1,5,HM_NEAREST_TO_LASTOPRESULT,1);
	AI.PushGoal("tr_hide_near","+ignoreall",0,0);
--	AI.PushGoal("tr_hide_near","branch",0,"STAND",IF_CAN_HIDE);
--	AI.PushGoal("tr_hide_near","branch",0,"END",BRANCH_ALWAYS);
--	AI.PushLabel("tr_hide_near","STAND");
--	AI.PushGoal("tr_hide_near","run",0,0);
--	AI.PushGoal("tr_hide_near","timeout",1,3,5);
	AI.PushGoal("tr_hide_near","signal",1,1,"END_HIDE_NEAR",0);
	AI.PushLabel("tr_hide_near","END");


	AI.CreateGoalPipe("tr_hide_flank");
	AI.PushGoal("tr_hide_flank","timeout",0,10,15);
	AI.PushLabel("tr_hide_flank","LOOP");
	AI.PushGoal("tr_hide_flank","run",0,1);
	AI.PushGoal("tr_hide_flank","ignoreall",0,1);--don't lose/reaquire the target
	AI.PushGoal("tr_hide_flank","+locate",0,"refpoint");
	AI.PushGoal("tr_hide_flank","firecmd",1,0);
	AI.PushGoal("tr_hide_flank","+hide",1,4,HM_NEAREST_TO_LASTOPRESULT,1);
	AI.PushGoal("tr_hide_flank","+ignoreall",0,0);
	AI.PushGoal("tr_hide_flank","timeout",0,1.5,3);
	AI.PushGoal("tr_hide_flank","approach",1,1,1);--refpoint
	AI.PushGoal("tr_hide_flank","timeout",0,2,3);
	AI.PushGoal("tr_hide_flank","branch",0,"LOOP",IF_ACTIVE_GOALS);
	AI.PushGoal("tr_hide_flank","signal",1,1,"END_FLANK",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_melee_timeout");
	AI.PushGoal("tr_melee_timeout","animation", 1, AIANIM_SIGNAL, "meleeAttack");
	AI.PushGoal("tr_melee_timeout","timeout",1,0.9,1.1);
	AI.PushGoal("tr_melee_timeout","signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);

	AI.BeginGoalPipe("tr_melee");
		AI.BeginGroup();
			AI.PushGoal("animation", 0, AIANIM_SIGNAL, "meleeAttack");
			AI.PushGoal("timeout",0,1.4);
		AI.EndGroup();
		AI.PushGoal("wait",1,WAIT_ANY);
		AI.PushGoal("signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();


	AI.CreateGoalPipe("tr_melee_moar");
	AI.PushGoal("tr_melee_moar","animation", 1, AIANIM_SIGNAL, "meleeAttack");
	AI.PushGoal("tr_melee_moar","timeout",1,1.5,1.8);
	AI.PushGoal("tr_melee_moar","signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);

--	AI.BeginGoalPipe("tr_do_melee");
--		AI.PushGoal("animation", 0, AIANIM_SIGNAL, "meleeAttack");
--		AI.PushGoal("stick", 0,1.5);
--		AI.PushGoal("waitsignal",1,"MELEE_DONE",nil,1.5);		
--	AI.EndGoalPipe();

	AI.CreateGoalPipe("tr_shoot_timeout");
	AI.PushGoal("tr_shoot_timeout","timeout",0,10,15);
	AI.PushLabel("tr_shoot_timeout","LOOP");
	AI.PushGoal("tr_shoot_timeout","firecmd",0,1);
	AI.PushGoal("tr_shoot_timeout","branch",0,"LOOP",IF_ACTIVE_GOALS);
	AI.PushGoal("tr_shoot_timeout","firecmd",0,0);
	AI.PushGoal("tr_shoot_timeout","signal",1,1,"END_FLANK",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_dig_in_shoot_on_spot_timeout");
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","timeout",0,10,15);
	AI.PushLabel("tr_dig_in_shoot_on_spot_timeout","LOOP");
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","timeout",1,0.5);
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","+firecmd",0,1);
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","+timeout",1,1.0,2.0);
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","+firecmd",0,0);
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","ignoreall",0,1);
--	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","branch",0,"LOOP",IF_ACTIVE_GOALS);
	AI.PushGoal("tr_dig_in_shoot_on_spot_timeout","signal",1,1,"END_FLANK",SIGNALFILTER_SENDER);

	-- Beware: Always Insert this goalpipe as a subpipe, never select it
	AI.CreateGoalPipe("tr_order_hide");
	AI.PushGoal("tr_order_hide", "signal", 0, 10, "order_hide_begin", SIGNALFILTER_SENDER);
	AI.PushGoal("tr_order_hide", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("tr_order_hide", "clear", 0, 0);
	AI.PushGoal("tr_order_hide", "firecmd", 0, 1);
	AI.PushGoal("tr_order_hide", "timeout", 1, 0.1, 0.3);
--	AI.PushGoal("tr_order_hide", "bodypos", 0, BODYPOS_PRONE);
	AI.PushGoal("tr_order_hide", "+firecmd", 0, 0);
	AI.PushGoal("tr_order_hide", "+run", 0, 1.5); -- enable sprinting
	AI.PushGoal("tr_order_hide", "+hide", 1, 0, HM_USEREFPOINT, true); -- distance: 0, method: HM_USEREFPOINT, lookAt: true
	AI.PushGoal("tr_order_hide", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("tr_order_hide", "firecmd", 0, 1);
	AI.PushGoal("tr_order_hide", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("tr_order_hide", "signal", 1, 1, "SignalToNearest_InPosition", SIGNALFILTER_SENDER);
	--AI.PushGoal("tr_order_hide", "signal", 0, 10, "END_ORDER_HIDE", SIGNALFILTER_SENDER);
	AI.PushGoal("tr_order_hide", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);

	-- Beware: Always Insert this goalpipe as a subpipe, never select it
	AI.CreateGoalPipe("tr_order_hide_around");
	--AI.PushGoal("tr_order_hide_around", "bodypos", 0, BODYPOS_PRONE);
	AI.PushGoal("tr_order_hide_around", "+firecmd", 0, 0);
	AI.PushGoal("tr_order_hide_around", "+run", 0, 1); 
	AI.PushGoal("tr_order_hide_around", "+hide", 1, 4, HM_NEAREST, true); -- distance: 0, method: HM_USEREFPOINT, lookAt: true
	AI.PushGoal("tr_order_hide_around", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("tr_order_hide_around", "firecmd", 0, 1);
	AI.PushGoal("tr_order_hide_around", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);
	AI.PushGoal("tr_order_hide_around", "timeout", 1, 0.1, 0.3);
	AI.PushGoal("tr_order_hide_around", "signal", 1, 1, "SignalToNearest_InPosition", SIGNALFILTER_SENDER);


--	AI.CreateGoalPipe("tr_stay_hidden");
----	AI.PushGoal("tr_stay_hidden", "bodypos", 0, BODYPOS_PRONE);
--	AI.PushGoal("tr_stay_hidden", "+firecmd", 0, 1);
--	AI.PushGoal("tr_stay_hidden", "+timeout", 1, 0.4, 0.8);
--	AI.PushGoal("tr_stay_hidden", "hide", 1, 5, HM_ASKLEADER, true);
--	AI.PushGoal("tr_stay_hidden", "timeout", 1, 1);

	-- Beware: Always Insert this goalpipe as a subpipe, never select it
	AI.CreateGoalPipe("tr_order_fire");
	--AI.PushGoal("tr_order_fire", "signal", 0, 10, "order_fire_begin", SIGNALFILTER_SENDER);
	AI.PushGoal("tr_order_fire", "clear", 0, 0);
	AI.PushGoal("tr_order_fire", "+firecmd", 0, 1);
	AI.PushGoal("tr_order_fire", "+run", 0, 0);
	--AI.PushGoal("tr_order_fire", "+bodypos", 1, BODYPOS_STAND);
	AI.PushGoal("tr_order_fire", "+timeout", 1, 0.1, 0.3);
	AI.PushGoal("tr_order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
		--AI.PushGoal("tr_order_fire", "+approach", 0, 0.5);
		AI.PushGoal("tr_order_fire", "+timeout", 1, 0.2, 0.3);
		AI.PushGoal("tr_order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
			AI.PushGoal("tr_order_fire", "+timeout", 1, 0.2, 0.3);
			AI.PushGoal("tr_order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
				AI.PushGoal("tr_order_fire", "+timeout", 1, 0.2, 0.3);
				AI.PushGoal("tr_order_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
					AI.PushGoal("tr_order_fire", "+timeout", 1, 0.2, 0.3);
	AI.PushLabel("tr_order_fire", "STOP_HERE");
	AI.PushGoal("tr_order_fire", "firecmd", 0, 2);
	AI.PushGoal("tr_order_fire", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	--AI.PushGoal("tr_order_fire", "signal", 0, 1, "END_ORDER_FIRE", SIGNALFILTER_SENDER);
	AI.PushGoal("tr_order_fire", "signal", 0, 10, "ORD_DONE", SIGNALFILTER_LEADER);


--	AI.CreateGoalPipe("tr_order_search");
--	AI.PushGoal("tr_order_search","lookat",1,-500); --reset look at 
--	--AI.PushGoal("tr_order_search", "signal", 0, 10, "order_search_begin", SIGNALFILTER_SENDER);
--	AI.PushGoal("tr_order_search", "clear", 0, 0);
--	AI.PushGoal("tr_order_search", "timeout", 1, 0.1, 0.8);
--	AI.PushGoal("tr_order_search", "locate", 0, "refpoint");
--	AI.PushGoal("tr_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
--		AI.PushGoal("tr_order_search", "clear", 0, 0);
--		AI.PushGoal("tr_order_search", "+run", 0, 1);
--	--	AI.PushGoal("tr_order_search", "+bodypos", 1, BODYPOS_PRONE);
--		AI.PushGoal("tr_order_search", "+timeout", 1, 0.25);
--		AI.PushGoal("tr_order_search", "+locate", 0, "refpoint");
--		AI.PushGoal("tr_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
--			AI.PushGoal("tr_order_search", "+pathfind", 1, "");
--			AI.PushGoal("tr_order_search", "+branch", 1, "DONE", IF_NO_PATH); -- if no path just ignore this hide point
--			AI.PushGoal("tr_order_search", "+branch", 1, "DONE", IF_PATH_LONGER, 95.0); -- if no found path is longer than 35m just ignore this hide point
--			AI.PushGoal("tr_order_search","firecmd",0,0);
--			AI.PushGoal("tr_order_search", "+trace", 0, 1, 0, 8);
--			AI.PushLabel("tr_order_search", "LOOP1");
--				AI.PushGoal("tr_order_search", "+timeout", 1, 0.2, 0.4);
--				AI.PushGoal("tr_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
--			AI.PushGoal("tr_order_search", "+branch", 1, "LOOP1", IF_ACTIVE_GOALS);
--			AI.PushGoal("tr_order_search", "+run", 0, 0);
--			AI.PushGoal("tr_order_search", "+trace", 0, 1, 0, 1);
--			AI.PushLabel("tr_order_search", "LOOP2");
--				AI.PushGoal("tr_order_search", "+timeout", 1, 0.1, 0.2);
--				AI.PushGoal("tr_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
--			AI.PushGoal("tr_order_search", "+branch", 1, "LOOP2", IF_ACTIVE_GOALS);
--	AI.PushLabel("tr_order_search", "DONE");
--	AI.PushGoal("tr_order_search", "clear", 0, 0); -- stops approaching - 0 means keep att. target
----	AI.PushGoal("tr_order_search", "+bodypos", 1, BODYPOS_STAND);
--	AI.PushGoal("tr_order_search", "signal", 1, 10, "ORD_DONE", SIGNALFILTER_LEADER)
	AI.BeginGoalPipe("tr_order_search");
		AI.PushGoal("bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("firecmd", 0,0);
--		AI.PushGoal("pathfind", 1, "refpoint");
--		AI.PushGoal("branch", 1, "PATH_FOUND", NOT+IF_NO_PATH);
--			AI.PushGoal("signal",0,1,"OnUnitStop",SIGNALFILTER_LEADER);		
--			AI.PushGoal("branch", 1, "DONE", BRANCH_ALWAYS);
--		AI.PushLabel("PATH_FOUND");
--		AI.PushGoal("signal",0,1,"OnUnitMoving",SIGNALFILTER_LEADER);		
		--AI.PushGoal("trace",1,1);
		AI.PushGoal("locate", 1, "refpoint");
		AI.PushGoal("stick", 1, 0, AILASTOPRES_USE, 1, STICK_BREAK);	-- noncontinuous stick
		AI.PushGoal("branch", 1, "PATH_FOUND", NOT+IF_NO_PATH);
			AI.PushGoal("signal",0,1,"OnUnitStop",SIGNALFILTER_LEADER);		
			AI.PushGoal("branch", 1, "DONE", BRANCH_ALWAYS);
		AI.PushLabel("PATH_FOUND");
		AI.PushGoal("signal",0,1,"OnUnitMoving",SIGNALFILTER_LEADER);		
		AI.PushGoal("signal",1,1,"HIDESPOT_REACHED",SIGNALFILTER_SENDER);		
		AI.PushGoal("bodypos", 1, BODYPOS_STEALTH);
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("+lookat",1,0,0,1,AI_LOOKAT_CONTINUOUS + AI_LOOKAT_USE_BODYDIR);
--		AI.PushGoal("timeout",1,0.9);--time to align to the initial lookat target
		AI.PushGoal("lookaround",1,90,3,3,5,AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("lookat",1,-500);
		AI.PushLabel("DONE");
	--	AI.PushGoal("signal",0,1,"ORD_DONE",SIGNALFILTER_LEADER);		
		AI.PushGoal("bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("signal",0,1,"END_SEARCH",SIGNALFILTER_SENDER);		
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_order_search_hidespot");
		AI.PushGoal("firecmd", 0,0);
		AI.PushGoal("acqtarget", 1, "refpoint");
		AI.PushGoal("approach", 0,6);
		AI.PushLabel("LOOP");
			AI.PushGoal("timeout",1,0.5);
			AI.PushGoal("branch", 1, "PATH_NOT_FOUND", IF_NO_PATH);
			AI.PushGoal("branch", 1, "PATH_FOUND", NOT+IF_NO_PATH);
			AI.PushGoal("branch", 1, "LOOP", BRANCH_ALWAYS);
		AI.PushLabel("PATH_NOT_FOUND");
			AI.PushGoal("signal",0,1,"OnUnitStop",SIGNALFILTER_LEADER);		
			AI.PushGoal("branch", 1, "DONE", BRANCH_ALWAYS);
		AI.PushLabel("PATH_FOUND");
		AI.PushGoal("signal",0,1,"OnUnitMoving",SIGNALFILTER_LEADER);		
		AI.PushLabel("LOOP2");
			AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("branch", 1, "LOOP2", IF_ACTIVE_GOALS);
		AI.PushGoal("branch", 1, "SEE", IF_SEES_TARGET);
		AI.PushGoal("signal",1,1,"HIDESPOT_REACHED",SIGNALFILTER_SENDER);		
		-- can't see the hidespot, go directly there
		AI.PushGoal("approach", 1,0.4,AI_REQUEST_PARTIAL_PATH);
		AI.PushGoal("bodypos", 1, BODYPOS_STEALTH);
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("+lookat",1,0,0,1);
		AI.PushGoal("lookaround",1,180,3,3,5,AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("lookat",1,-500);
		AI.PushGoal("branch", 1, "DONE", BRANCH_ALWAYS);
		AI.PushLabel("SEE");
		-- trooper is close to hidespot and sees it
		AI.PushGoal("timeout",1,0.9,1.5);
		AI.PushLabel("DONE");
	--	AI.PushGoal("signal",0,1,"ORD_DONE",SIGNALFILTER_LEADER);		
		AI.PushGoal("bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("signal",0,1,"END_SEARCH",SIGNALFILTER_SENDER);		
	AI.EndGoalPipe();

	AI.CreateGoalPipe("tr_search_cover_fire");
	AI.PushGoal("tr_search_cover_fire", "+locate", 0, "refpoint");
	AI.PushGoal("tr_search_cover_fire", "+acqtarget", 0, "");
	AI.PushGoal("tr_search_cover_fire", "+firecmd", 0, 3);
	AI.PushGoal("tr_search_cover_fire", "+timeout", 1, 4,6);
	AI.PushGoal("tr_search_cover_fire", "+firecmd", 0, 0);
	AI.PushGoal("tr_search_cover_fire","+signal",1,10,"ORD_DONE",SIGNALFILTER_LEADER);		
	
	AI.CreateGoalPipe("tr_approach_refpoint");
	AI.PushGoal("tr_approach_refpoint","firecmd",0,0);
	AI.PushGoal("tr_approach_refpoint","locate",0,"refpoint");
	AI.PushGoal("tr_approach_refpoint","approach",1,1.1,AILASTOPRES_USE);
	AI.PushGoal("tr_approach_refpoint","signal",0,1,"REFPOINT_REACHED",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("tr_approach_refpoint2");
	AI.PushGoal("tr_approach_refpoint2","firecmd",0,0);
	AI.PushGoal("tr_approach_refpoint2","locate",0,"refpoint");
	AI.PushGoal("tr_approach_refpoint2","approach",1,1.1,AILASTOPRES_USE);
	AI.PushGoal("tr_approach_refpoint2","signal",0,1,"REFPOINT_REACHED2",SIGNALFILTER_SENDER);		

	AI.CreateGoalPipe("tr_stick_refpoint");
	AI.PushGoal("tr_stick_refpoint","firecmd",0,0);
	AI.PushGoal("tr_stick_refpoint","locate",0,"refpoint");
	AI.PushGoal("tr_stick_refpoint","stick",1,2,AILASTOPRES_USE,1);
	AI.PushGoal("tr_stick_refpoint","signal",0,1,"REFPOINT_REACHED",SIGNALFILTER_SENDER);		


	AI.BeginGoalPipe("tr_look_around");
		AI.PushGoal("firecmd", 0,0);
		AI.PushGoal("bodypos", 1, BODYPOS_STEALTH);
		AI.PushGoal("lookaround",0,90,3,1000,1000);
		AI.PushLabel("LOOP");
			AI.PushGoal("timeout", 1,3);
			AI.PushGoal("signal",1,1,"CHECK_LOOK_AROUND",SIGNALFILTER_SENDER);		
		AI.PushGoal("branch",1,"LOOP",BRANCH_ALWAYS);
	AI.EndGoalPipe();	

	AI.BeginGoalPipe("tr_look_around_refpoint");
		AI.PushGoal("firecmd", 0,0);
		AI.PushGoal("acqtarget",0,"refpoint");
		AI.PushGoal("timeout", 1,1);
		AI.PushGoal("lookaround",1,90,3,1000,1000);
	AI.EndGoalPipe();	
	
	AI.CreateGoalPipe("tr_use_freeze_weapon");
	AI.PushGoal("tr_use_freeze_weapon","firecmd",0,0);		
	AI.PushGoal("tr_use_freeze_weapon","signal",0,1,"SELECT_FREEZE_WEAPON",SIGNALFILTER_SENDER);		
	AI.PushGoal("tr_use_freeze_weapon","+timeout", 1, 0.5, 0.7);
	AI.PushGoal("tr_use_freeze_weapon","+firecmd",0,1);		
	AI.PushGoal("tr_use_freeze_weapon","branch",0,"END",IF_NO_ENEMY_TARGET);
	AI.PushGoal("tr_use_freeze_weapon","+timeout", 1, 2, 2.4);
	AI.PushGoal("tr_use_freeze_weapon","branch",0,"END",IF_NO_ENEMY_TARGET);
	AI.PushGoal("tr_use_freeze_weapon","+timeout", 1, 2, 2.4);
	AI.PushGoal("tr_use_freeze_weapon","branch",0,"END",IF_NO_ENEMY_TARGET);
	AI.PushGoal("tr_use_freeze_weapon","+timeout", 1, 2, 2.4);
	AI.PushLabel("tr_use_freeze_weapon","END");
	AI.PushGoal("tr_use_freeze_weapon","+firecmd",0,0);		
	AI.PushGoal("tr_use_freeze_weapon","+signal",0,1,"SELECT_NORMAL_WEAPON",SIGNALFILTER_SENDER);		
	AI.PushGoal("tr_use_freeze_weapon","timeout", 1, 0.5, 0.7);
	AI.PushGoal("tr_use_freeze_weapon","firecmd",0,1);		
	
	AI.CreateGoalPipe("tr_grenade_seen");
	AI.PushGoal("tr_grenade_seen","firecmd",0,0);		
	AI.PushGoal("tr_grenade_seen", "backoff", 1, 7); 
	AI.PushGoal("tr_grenade_seen", "devalue",0); 

	AI.CreateGoalPipe("tr_short_fire");
	AI.PushGoal("tr_short_fire","firecmd",0,1);
	AI.PushGoal("tr_short_fire","timeout",1,0.5,1);
	AI.PushGoal("tr_short_fire","firecmd",0,0);
	
	AI.CreateGoalPipe("tr_goto");
	AI.PushGoal("tr_goto","firecmd",0,0);		
	AI.PushGoal("tr_goto","approach",1,0.2,AILASTOPRES_USE);
	AI.PushGoal("tr_goto","+signal",0,1,"END_GOTO",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_confused");
	AI.PushGoal("tr_confused","firecmd",0,0);
	AI.PushGoal("tr_confused","timeout",1,0.1,0.3);
	AI.PushGoal("tr_confused","signal",0,1,"START_CONFUSED",SIGNALFILTER_SENDER);
	AI.PushGoal("tr_confused","timeout",1,4,5);
	AI.PushGoal("tr_confused","signal",0,1,"END_CONFUSED",SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("tr_dumb");
	AI.PushGoal("tr_dumb", "+ignoreall", 0,1);
	AI.PushGoal("tr_dumb", "+clear", 1);
	AI.PushGoal("tr_dumb", "+firecmd", 1,0);
	AI.PushGoal("tr_dumb", "+timeout", 1,7);
	AI.PushGoal("tr_dumb", "+ignoreall", 0,0);
	AI.PushGoal("tr_dumb","signal",0,1,"END_DUMB",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_melee_backoff");
	AI.PushGoal("tr_melee_backoff", "backoff",1,4,5,AI_BACKOFF_FROM_TARGET);
	AI.PushGoal("tr_melee_backoff","firecmd",1,FIREMODE_CONTINUOUS);
	AI.PushGoal("tr_melee_backoff","timeout",1,1.5,2.2);
	AI.PushGoal("tr_melee_backoff", "signal",1,1,"END_MELEE_BACKOFF",0);
	
	
	AI.CreateGoalPipe("tr_threatened_2_attack");
	--AI.PushGoal("tr_threatened_2_attack","timeout",1,0.8,0.9);
	--AI.PushGoal("tr_threatened_2_attack","clear",0,1);
	--entity:CancelSubpipe( ); -- report as failed
	AI.PushGoal("tr_threatened_2_attack","signal",0,1,"GO_TO_ATTACK",SIGNALFILTER_SENDER);
	

	AI.CreateGoalPipe("tr_collective_fire1");
	AI.PushGoal("tr_collective_fire1","acqtarget",1,"");
	AI.PushGoal("tr_collective_fire1","ignoreall",1,1);
	AI.PushGoal("tr_collective_fire1","+firecmd",0,0);
	AI.PushGoal("tr_collective_fire1", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
		AI.PushGoal("tr_collective_fire1", "+approach", 0, 2);
		AI.PushGoal("tr_collective_fire1", "+timeout", 1, 0.2, 0.3);
		AI.PushGoal("tr_collective_fire1", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
			AI.PushGoal("tr_collective_fire1", "+timeout", 1, 0.2, 0.3);
			AI.PushGoal("tr_collective_fire1", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
				AI.PushGoal("tr_collective_fire1", "+timeout", 1, 0.2, 0.3);
				AI.PushGoal("tr_collective_fire1", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
					AI.PushGoal("tr_collective_fire1", "+timeout", 1, 0.2, 0.3);
	AI.PushLabel("tr_collective_fire1", "STOP_HERE");
	AI.PushGoal("tr_collective_fire1","signal",0,1,"VISIBILITY_POINT_REACHED",SIGNALFILTER_SENDER);
	AI.PushGoal("tr_collective_fire1", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("tr_collective_fire1","signal",0,10,"ORD_DONE",SIGNALFILTER_LEADER);		
	
	AI.CreateGoalPipe("tr_end_collective_fire1");
	AI.PushGoal("tr_end_collective_fire1","ignoreall",1,0);
--	AI.PushGoal("tr_end_collective_fire1","lookat",1,-500); --reset look at 

--	AI.CreateGoalPipe("tr_fire_moar");
--	AI.PushGoal("tr_fire_moar","acqtarget",1,"");
--	AI.PushGoal("tr_fire_moar","firecmd",1,FIREMODE_CONTINUOUS);
--	AI.PushGoal("tr_fire_moar", "timeout",1,4);
--	AI.PushGoal("tr_fire_moar", "signal",1,1,"BEAM_OFF",SIGNALFILTER_SUPERGROUP);
--	AI.PushGoal("tr_fire_moar", "timeout",1,3);
--	AI.PushGoal("tr_fire_moar","firecmd",1,0);
--	AI.PushGoal("tr_fire_moar", "signal",1,1,"END_COLLECT_FIRE",SIGNALFILTER_SUPERGROUP);

	AI.CreateGoalPipe("tr_wait_explosion");
	--AI.PushGoal("tr_wait_explosion","signal",0,1,"REBOOT",SIGNALID_READIBILITY);
	AI.PushGoal("tr_wait_explosion","timeout", 1, 5);
	AI.PushGoal("tr_wait_explosion", "devalue",0); 
	--AI.PushGoal("tr_wait_explosion","signal",0,1,"clear",SIGNALID_READIBILITY);
	AI.PushGoal("tr_wait_explosion","signal",1,1,"OnExplosion",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("tr_backoff_from_explosion");
	AI.PushGoal("tr_backoff_from_explosion","run",0,1.5);
	--AI.PushGoal("tr_backoff_from_explosion","+bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("tr_backoff_from_explosion","+backoff",1,12,6,AILASTOPRES_USE);
	AI.PushGoal("tr_backoff_from_explosion","+timeout",1,5);
	AI.PushGoal("tr_backoff_from_explosion","signal",1,1,"END_BACKOFF",SIGNALFILTER_SENDER);

	
	AI.BeginGoalPipe("tr_attack_switch_position");
		AI.PushGoal("signal",1,1,"CHECK_FIRE",SIGNALFILTER_SENDER);
		-- debug only
--		AI.PushGoal("signal",1,0,"CHECK_TROOPER_GROUP",SIGNALFILTER_SUPERGROUP);
		AI.PushGoal("strafe",0,10,10,1);
		AI.PushGoal("run",0,1);
		AI.PushGoal("firecmd",0,FIREMODE_AIM);
		AI.PushGoal("locate",0,"formation");
--		AI.PushGoal("branch",1,"APPROACH",IF_LASTOP_DIST_LESS,8);
--			AI.PushGoal("bodypos",0,BODYPOS_PRONE);
--		AI.PushLabel("APPROACH");
		AI.PushGoal("stick",1,1,AILASTOPRES_USE,STICK_BREAK);--+STICK_SHORTCUTNAV);
		--AI.PushGoal("tr_check_prone_and_stick",1);
		AI.PushGoal("branch",1,"END", IF_NO_PATH);
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
		
		AI.PushGoal("signal",1,10,"OnFormationPointReached",SIGNALFILTER_LEADER);
		AI.PushGoal("signal",1,1,"OnFormationPointReached",SIGNALFILTER_SENDER);
--		AI.PushGoal("locate",0,"formation");
--		AI.PushGoal("stick",0,0.2,AILASTOPRES_USE);
--		AI.PushGoal("timeout",1,0.8,1.5);
		AI.PushGoal("timeout",1,2.1,2.5);
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("signal",1,1,"CHECK_REPOSITION",SIGNALFILTER_SENDER);
--		AI.PushGoal("timeout",1,0.6,1.1);
--		AI.PushGoal("firecmd",0,FIREMODE_CONTINUOUS);
--		AI.PushGoal("timeout",1,1.2,1.7);
--		AI.PushGoal("firecmd",0,0);
--		AI.PushGoal("clear",1,0);
		AI.PushGoal("signal",1,1,"END_SWITCH_POSITION",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_attack_switch_position_refpoint");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("run",0,1);
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("approach",1,0.2,AILASTOPRES_USE);
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
		AI.PushGoal("signal",1,10,"OnFormationPointReached",SIGNALFILTER_LEADER);
		AI.PushGoal("signal",1,1,"OnFormationPointReached",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,2.8,3.5);
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("clear",1,0);
		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();


	AI.BeginGoalPipe("tr_attack_switch_position_moar");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("strafe",0,5);
		AI.PushGoal("run",0,1);
		AI.PushGoal("locate",0,"formation");
--		AI.PushGoal("branch",1,"APPROACH",IF_LASTOP_DIST_LESS,8);
--			AI.PushGoal("bodypos",0,BODYPOS_PRONE);
--		AI.PushLabel("APPROACH");
		AI.PushGoal("stick",1,0.2,AI_CONSTANT_SPEED+AILASTOPRES_USE,1);
		--AI.PushGoal("tr_check_prone_and_stick",1);
		AI.PushGoal("signal",1,10,"OnFormationPointReached",SIGNALFILTER_LEADER);
		--AI.PushGoal("firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("signal",1,1,"START_FIRE_MOAR",SIGNALFILTER_SENDER);
		--AI.PushGoal("timeout",1,4.8,5.5);
		--AI.PushGoal("firecmd",0,0);
		AI.PushGoal("signal",1,1,"END_MOAR",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_start_fire_moar");
		AI.PushGoal("firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("+timeout",1,4.8,5.5);
		AI.PushGoal("+firecmd",0,0);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_avoid_danger");
		AI.PushGoal("run",0,1.5);
		AI.PushGoal("strafe",0,5);
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("backoff",1,14,8,AILASTOPRES_USE+ AI_MOVE_BACKWARD+AI_MOVE_BACKLEFT+AI_MOVE_BACKRIGHT);
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
		AI.PushGoal("timeout",1,4,5);
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("signal",1,1,"BackToSwitchPosition",SIGNALFILTER_SENDER);
		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_approach_target_timeout");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("run",0,1);
		AI.PushGoal("approach",0,1);
		AI.PushGoal("timeout",1,6);
		AI.PushGoal("clear",0,0);
		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();

--	AI.BeginGoalPipe("tr_dodge_left");
----		AI.PushGoal("pathfind",1,"refpoint");
----		AI.PushGoal("branch",1,"NO_PATH_LEFT",IF_NO_PATH);
--			AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
--			AI.PushGoal("animation", 1, AIANIM_SIGNAL, "dodgeLeft");
----			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
----		AI.PushLabel("NO_PATH_LEFT");
----		AI.PushGoal("signal",1,1,"SET_DODGE_RIGHT",SIGNALFILTER_SENDER);
----		AI.PushGoal("pathfind",1,"refpoint");
----		AI.PushGoal("branch",1,"NO_PATH_RIGHT",IF_NO_PATH);
----			AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
----			AI.PushGoal("animation", 1, AIANIM_SIGNAL, "dodgeRight");
----			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
----		AI.PushLabel("NO_PATH_RIGHT");
----		AI.PushLabel("END");
--		AI.PushGoal("signal",0,1,"DODGE_FINISHED",SIGNALFILTER_SENDER);
--		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
--	AI.EndGoalPipe();

--	AI.BeginGoalPipe("tr_dodge_right");
--		AI.PushGoal("run",1,2);
--		AI.PushGoal("strafe",0,6,6);
--		AI.PushGoal("pathfind",1,"refpoint");
--		AI.PushGoal("branch",1,"PATH_OK",NOT+IF_NO_PATH);
--		AI.PushGoal("signal",0,1,"DODGE_FAILED",SIGNALFILTER_SENDER);
--		AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
--		AI.PushLabel("PATH_OK");
--		AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
--		AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeRight");
----		AI.PushGoal("trace",1);
--		AI.PushGoal("signal",0,1,"DODGE_FINISHED",SIGNALFILTER_SENDER);
--		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
--		AI.PushLabel("END")
--	AI.EndGoalPipe();
--	
--	AI.BeginGoalPipe("tr_dodge_left");
--		AI.PushGoal("run",1,2);
--		AI.PushGoal("strafe",0,6,6);
--		AI.PushGoal("pathfind",1,"refpoint");
--		AI.PushGoal("branch",1,"PATH_OK",NOT+IF_NO_PATH);
--		AI.PushGoal("signal",0,1,"DODGE_FAILED",SIGNALFILTER_SENDER);
--		AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
--		AI.PushLabel("PATH_OK");
--		AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
--		AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeLeft");
--		
--		--AI.PushGoal("trace",1);
--		AI.PushGoal("signal",0,1,"DODGE_FINISHED",SIGNALFILTER_SENDER);
--		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
--		AI.PushLabel("END")
--	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_dodge_left");
			AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
		AI.BeginGroup();
			AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeLeft");
			AI.PushGoal("timeout", 0, 2);
		AI.EndGroup();
		AI.PushGoal("wait", 1, WAIT_ANY);
		AI.PushGoal("signal",0,1,"DODGE_FINISHED",SIGNALFILTER_SENDER);
--		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_dodge_right");
			AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
		AI.BeginGroup();
			AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeRight");
			AI.PushGoal("timeout", 0, 2);--fallback, but it should never fail
		AI.EndGroup();
		AI.PushGoal("wait", 1, WAIT_ANY);
		AI.PushGoal("signal",0,1,"DODGE_FINISHED",SIGNALFILTER_SENDER);
	--	AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_dodge_right_short");
			AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
		AI.BeginGroup();
			AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeShortRight");
			AI.PushGoal("timeout", 0, 2);--fallback, but it should never fail
		AI.EndGroup();
		AI.PushGoal("wait", 1, WAIT_ANY);
		AI.PushGoal("signal",0,1,"DODGE_FINISHED",SIGNALFILTER_SENDER);
	--	AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_dodge_left_short");
			AI.PushGoal("signal",0,1,"DODGE_OK",SIGNALFILTER_SENDER);
		AI.BeginGroup();
			AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeShortLeft");
			AI.PushGoal("timeout", 0, 2);--fallback, but it should never fail
		AI.EndGroup();
		AI.PushGoal("wait", 1, WAIT_ANY);
		AI.PushGoal("signal",0,1,"DODGE_FINISHED",SIGNALFILTER_SENDER);
	--	AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();


	AI.BeginGoalPipe("tr_dodge_left_short_moving");
			AI.PushGoal("clear", 0, 0);
			AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeShortLeft");
			AI.PushGoal("stick", 0, TROOPER_CLOSE_DISTANCE_STICK,0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_dodge_right_short_moving");
			AI.PushGoal("clear", 0, 0);
			AI.PushGoal("animation", 0, AIANIM_SIGNAL, "dodgeShortRight");
			AI.PushGoal("stick", 0, TROOPER_CLOSE_DISTANCE_STICK,0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_dodge_left_forward");
			AI.PushGoal("clear", 0, 0);
			AI.PushGoal("stick", 0, TROOPER_CLOSE_DISTANCE_STICK,0);
			AI.PushGoal("animation", 1, AIANIM_SIGNAL, "dodgeLeftFwd");
			AI.PushGoal("signal",1,1,"END_DODGE_FORWARD",SIGNALFILTER_SENDER);
			
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_dodge_right_forward");
			AI.PushGoal("clear", 0, 0);
			AI.PushGoal("stick", 0, TROOPER_CLOSE_DISTANCE_STICK,0);
			AI.PushGoal("animation", 1, AIANIM_SIGNAL, "dodgeRightFwd");
			AI.PushGoal("signal",1,1,"END_DODGE_FORWARD",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	
	AI.BeginGoalPipe("tr_jump_melee");
--		AI.BeginGroup();
			AI.PushGoal("animation", 1, AIANIM_SIGNAL, "meleeJumpAttack");
--			AI.PushGoal("timeout", 0, 4);--fallback, but it should never fail
--		AI.EndGroup();
--		AI.PushGoal("wait", 1, WAIT_ANY);
		AI.PushGoal("signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_end_melee");
		AI.PushGoal("timeout", 1, 0.3);
		AI.PushGoal("signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_jump_melee_ground");
--		AI.BeginGroup();
			AI.PushGoal("animation", 1, AIANIM_SIGNAL, "jumpMeleeGround");
--			AI.PushGoal("timeout", 0, 4);--fallback, but it should never fail
--		AI.EndGroup();
--		AI.PushGoal("wait", 1, WAIT_ANY);
		AI.PushGoal("signal",1,1,"END_MELEE",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_check_lower_target");
		AI.PushGoal("branch",1,"CHECK_TARGET",IF_CAN_SHOOT_TARGET);
			AI.PushGoal("timeout", 1, 2); -- give time to reorient towards the target
		AI.PushLabel("CHECK_TARGET");
		AI.PushGoal("branch",1,"END",IF_NO_ENEMY_TARGET);
			AI.PushGoal("signal",1,1,"CHECK_LOWER_TARGET",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_keep_position");
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
		AI.PushGoal("signal",1,10,"OnFormationPointReached",SIGNALFILTER_LEADER);
		AI.PushGoal("timeout",1,1.8,2.5);
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("signal",1,10,"CHECK_LOWER_TARGET",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5,0.8);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_keep_position_moar");
		AI.PushGoal("signal",1,10,"OnFormationPointReached",SIGNALFILTER_LEADER);
		AI.PushGoal("signal",1,1,"START_FIRE_MOAR",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,3.5,4.5);
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("signal",0,1,"UPDATE_FIRE_MOAR_STATS",SIGNALFILTER_SENDER);
		AI.PushGoal("signal",1,1,"CHECK_LOWER_TARGET",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5,0.8);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_goto_shoot_spot");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("approach",0,0.5,AILASTOPRES_USE);
		AI.PushLabel("LOOP");
			AI.PushGoal("timeout",1,0.2);
			AI.PushGoal("branch",1,"LOOP",IF_PATH_STILL_FINDING);
		AI.PushGoal("branch",1,"PATH_NOT_FOUND",IF_PATH_LONGER,25);
		AI.PushGoal("branch",1,"PATH_NOT_FOUND",IF_NO_PATH);
		-- path found and good
		AI.PushLabel("TRACE_LOOP");
			AI.PushGoal("timeout",1,0.1);
			AI.PushGoal("branch",1,"TRACE_LOOP_END",NOT+IF_CAN_SHOOT_TARGET);
				AI.PushGoal("firecmd",0,FIREMODE_BURST);
		AI.PushLabel("TRACE_LOOP_END");
		AI.PushGoal("branch",1,"TRACE_LOOP",IF_ACTIVE_GOALS);
		
		AI.PushGoal("signal",0,1,"OnClearSpotList",SIGNALFILTER_LEADER);
		AI.PushGoal("signal",0,1,"SPOT_REACHED",SIGNALFILTER_SENDER);
		
		AI.PushGoal("branch",1,"CHECK_TARGET",IF_CAN_SHOOT_TARGET);
			AI.PushGoal("timeout",1,2);-- give time to orient towards the target
--			AI.PushGoal("signal",0,1,"GO_TO_SHOOT_ON_SPOT",SIGNALFILTER_SENDER);
		AI.PushGoal("branch",1,"END_SUCCESS",IF_NO_ENEMY_TARGET);
		AI.PushLabel("CHECK_TARGET");
		AI.PushGoal("signal",1,1,"CHECK_LOWER_TARGET",SIGNALFILTER_SENDER); -- should select another goalpipe
		AI.PushGoal("branch",1,"END_SUCCESS",BRANCH_ALWAYS);
		AI.PushLabel("PATH_NOT_FOUND");
			AI.PushGoal("clear",0,0);
			AI.PushGoal("signal",1,1,"REQUEST_NEW_POINT",SIGNALFILTER_SENDER);
			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
		AI.PushLabel("END_SUCCESS");
			AI.PushGoal("signal",0,1,"END_JUMP_ON_SPOT",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_check_other_shoot_spots")		
		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
		AI.PushGoal("timeout",1,1,1.5);
--		AI.PushGoal("timeout",1,1.8,2);
--		AI.PushGoal("signal",0,1,"END_JUMP_ON_SPOT",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_strafe");
		AI.PushGoal("strafe",1,10,10);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_aim");
		AI.PushGoal("firecmd",1,FIREMODE_AIM);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_jump_timeout");
		AI.PushGoal("strafe",1,10,10);
		AI.PushGoal("timeout",1,3);
		AI.PushGoal("signal",0,1,"OnLand",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_jump_timeout_3sec");
		AI.PushGoal("timeout",1,3);
	AI.EndGoalPipe();
	
	
	AI.BeginGoalPipe("tr_jump_timeout_1sec");
		AI.PushGoal("timeout",1,1);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_try_jump_fire");
		AI.PushGoal("pathfind",1,"refpoint");
		AI.PushGoal("branch",1,"PATH_FOUND",NOT+IF_NO_PATH);
			AI.PushGoal("signal",1,1,"OnRequestUpdate",SIGNALFILTER_LEADER);
			AI.PushGoal("signal",1,1,"END_JUMP",SIGNALFILTER_SENDER);
			AI.PushGoal("timeout",1,1);
			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
		AI.PushLabel("PATH_FOUND");
		AI.PushGoal("signal",1,1,"JUMP_FIRE",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_jump_fire_left");
		AI.PushGoal("strafe",0,8);
		AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
		--AI.PushGoal("animation", 1, AIANIM_SIGNAL, "jumpFireLeft");
		AI.PushGoal("waitsignal",1,"OnLand",nil,4);--wait for the execution of OnLand signal
		AI.PushGoal("firecmd",1,0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_jump_fire_right");
		AI.PushGoal("strafe",0,8);
		AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
		--AI.PushGoal("animation", 1, AIANIM_SIGNAL, "jumpFireRight");
		AI.PushGoal("waitsignal",1,"OnLand",nil,4);--wait for the execution of OnLand signal
		AI.PushGoal("firecmd",1,0);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_chase_fire");
		AI.PushGoal("strafe",0,500);
		AI.PushGoal("bodypos",1,BODYPOS_PRONE);
		AI.PushGoal("run",1,3);
--		AI.PushGoal("locate",1,"formation");
--		AI.PushGoal("stick",0,3,AILASTOPRES_USE,1);
--		AI.PushLabel("LOOP1");
--			AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
--			AI.PushGoal("timeout",1,3,3.7);
--			AI.PushGoal("firecmd",1,0);
--			AI.PushGoal("timeout",1,1.5,2.2);
--		--AI.PushGoal("branch",1,"STICK",NOT+IF_ACTIVE_GOALS);
--			AI.PushGoal("signal",1,1,"TRY_JUMP_CHASE",SIGNALFILTER_SENDER);
--		AI.PushLabel("STICK");
--		AI.PushGoal("clear",0,0);
--		AI.PushGoal("branch",1,"LOOP1",IF_ACTIVE_GOALS);

		--AI.PushGoal("signal",1,10,"OnFormationPointReached",SIGNALFILTER_LEADER);
		--AI.PushGoal("signal",1,1,"TRY_MELEE",SIGNALFILTER_SENDER);
		AI.PushGoal("run",1,3);
		AI.PushGoal("locate",1,"formation");
		AI.PushGoal("stick",0,1,AILASTOPRES_USE);
		AI.PushLabel("LOOP2");
			AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
			AI.PushGoal("timeout",1,3,3.7);
			AI.PushGoal("firecmd",1,0);
			AI.PushGoal("timeout",1,0.9,1.5);
		AI.PushGoal("branch",1,"LOOP2",BRANCH_ALWAYS);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_start_fire_continuous");
		AI.PushGoal("firecmd",0,FIREMODE_CONTINUOUS);
	AI.EndGoalPipe();
	

	AI.BeginGoalPipe("tr_shoot_moving_target");
		AI.PushGoal("strafe",0,500);
		AI.PushGoal("bodypos",1,BODYPOS_PRONE);
		AI.PushGoal("run",1,2);
		AI.PushGoal("locate",1,"formation");
		AI.PushGoal("stick",0,5,AILASTOPRES_USE);
		AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
		AI.PushGoal("timeout",1,1.5);
		AI.PushGoal("branch",1,"END",IF_NO_ENEMY_TARGET);
			AI.PushGoal("timeout",1,2,2.3);
		AI.PushLabel("END");
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("strafe",0,0);
		AI.PushGoal("signal",1,1,"ON_END_SHOOT_MOVING_TARGET",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

--	AI.BeginGoalPipe("tr_shoot_on_small_rock");
--		AI.PushGoal("locate",0,"refpoint");
--		AI.PushGoal("approach",1,0,AILASTOPRES_USE);
--		--AI.PushGoal("animation", 1, AIANIM_ACTION, "onRock1_5");
--		AI.PushGoal("branch",1,"END2",IF_NO_PATH);
--		AI.PushGoal("firecmd",1,1);
--		AI.PushGoal("timeout",1,1.3,1.6);
--		AI.PushGoal("branch",1,"END",IF_NO_ENEMY_TARGET);
--		AI.PushGoal("timeout",1,1.9,2.5);
--		AI.PushLabel("END");
--		AI.PushGoal("firecmd",1,0);
--		AI.PushGoal("locate",0,"formation");
--		--AI.PushGoal("animation", 1, AIANIM_ACTION, "idle");
--		AI.PushLabel("END2");
--		AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
--		AI.PushGoal("locate",0,"formation");
--		AI.PushGoal("approach",1,0.5,AILASTOPRES_USE);
--	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_shoot_on_rock");
		AI.PushGoal("bodypos",1,BODYPOS_CROUCH);
		AI.PushGoal("firecmd",1,FIREMODE_BURST);
		AI.PushGoal("timeout",1,2.9,3.9);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("signal",0,1,"END_SHOOT_ON_ROCK",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1.0,1.3);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_shoot_on_rock_moar");
		AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
		AI.PushGoal("timeout",1,3.7,4.5);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("signal",0,1,"END_SHOOT_ON_ROCK_MOAR",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1.0,1.3);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_shoot_on_wall");
		AI.PushGoal("timeout",1,0.3);
		AI.PushGoal("signal",1,1,"ON_WALL",SIGNALFILTER_SENDER);
		AI.PushGoal("firecmd",1,FIREMODE_BURST);
		AI.PushGoal("timeout",1,2.9,3.9);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("signal",0,1,"END_SHOOT_ON_WALL",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1.0,1.3);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_shoot_on_wall_moar");
		AI.PushGoal("signal",1,1,"ON_WALL",SIGNALFILTER_SENDER);
		AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
		AI.PushGoal("timeout",1,3.7,4.5);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("signal",0,1,"END_SHOOT_ON_WALL_MOAR",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,1.0,1.3);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_end_stay_on_rock_timeout");
		AI.PushGoal("firecmd",1,FIREMODE_CONTINUOUS);
		AI.PushGoal("timeout",1,2.5,3.1);
		AI.PushGoal("bodypos",1,BODYPOS_STAND);
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("signal",1,1,"END_SHOOT_ON_ROCK",SIGNALFILTER_SENDER);
	--	AI.PushGoal("signal",1,10,"OnRequestUpdate",SIGNALFILTER_LEADER);
	AI.EndGoalPipe();
	
--	AI.BeginGoalPipe("tr_on_rock_animation");
--		AI.PushGoal("animation", 1, AIANIM_ACTION, "stayOnRock");
--	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_end_animation");
		AI.PushGoal("animation", 1, AIANIM_ACTION, "idle");
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_prepare_switch_position");
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("animation", 0, AIANIM_ACTION, "idle");
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",1,1,"GO_TO_SWITCH_POSITION",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_prepare_shoot_spot");
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("animation", 0, AIANIM_ACTION, "idle");
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",1,1,"GO_TO_SHOOT_SPOT",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_prepare_special_action");
		AI.PushGoal("firecmd",1,0);
		AI.PushGoal("animation", 0, AIANIM_ACTION, "idle");
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",1,1,"GO_TO_SPECIAL_ACTION",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();


	AI.BeginGoalPipe("tr_dodge_vehicle");
		AI.PushGoal("locate",0,"refpoint");
		AI.PushGoal("approach",1,1,AILASTOPRES_USE);
		AI.PushGoal("locate",0,"formation");
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_retreat");
		AI.PushGoal("firecmd",0,FIREMODE_BURST);	
--		AI.PushGoal("locate",0,"refpoint");
--		AI.PushGoal("locate",0,"hidepoint_lastop");
--		AI.PushGoal("approach",1,0.1,AILASTOPRES_USE);
--		AI.PushGoal("branch",1,"PATH_OK",NOT+IF_NO_PATH);
			AI.PushGoal("hide",1,20,HM_FARTHEST_FROM_TARGET+HM_BACK);
			AI.PushGoal("branch",1,"PATH_OK",IF_CAN_HIDE);
			AI.PushGoal("branch",1,"HAS_TARGET",NOT+IF_NO_ENEMY_TARGET);
			AI.PushGoal("acqtarget",1,"beacon");
		AI.PushLabel("HAS_TARGET");
			AI.PushGoal("branch",1,"PATH_OK",IF_TARGET_DIST_GREATER,18);
			AI.PushGoal("backoff",1,20,10,AI_BACKOFF_FROM_TARGET+AI_MOVE_BACKWARD+AI_MOVE_BACKRIGHT+AI_MOVE_BACKLEFT+AI_MOVE_LEFT+AI_MOVE_RIGHT,7);
			AI.PushGoal("branch",1,"BACKOFF_OK",NOT+IF_NO_PATH);
			AI.PushGoal("branch",1,"PATH_OK",IF_TARGET_DIST_GREATER,18);
			AI.PushGoal("signal",1,1,"RETREAT_FAILED",SIGNALFILTER_SENDER);
			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
		AI.PushLabel("PATH_OK");
			AI.PushGoal("signal",1,1,"RETREAT_OK",SIGNALFILTER_SENDER);
			AI.PushGoal("timeout",1,2.5,3.1);
			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
		AI.PushLabel("BACKOFF_OK");
			AI.PushGoal("hide",1,8,HM_NEAREST);
			AI.PushGoal("branch",1,"PATH_OK",IF_CAN_HIDE);
			AI.PushGoal("signal",1,1,"RETREAT_FAILED",SIGNALFILTER_SENDER);
			
		AI.PushLabel("END");
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_hide_nearby");
			AI.PushGoal("firecmd",0,FIREMODE_BURST);	
			AI.PushGoal("hide",1,8,HM_NEAREST);
			AI.PushGoal("branch",1,"PATH_OK",IF_CAN_HIDE);
			AI.PushGoal("signal",1,1,"RETREAT_FAILED",SIGNALFILTER_SENDER);
			AI.PushGoal("branch",1,"END",BRANCH_ALWAYS);
		AI.PushLabel("PATH_OK");
			AI.PushGoal("signal",1,1,"RETREAT_OK",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_stay_retreated");
		AI.PushGoal("timeout",1,2.4,3.5);
		AI.PushGoal("usecover",1,COVER_UNHIDE,5,7,1);
		AI.PushGoal("timeout",1,3.4,4.5);
		AI.PushGoal("usecover",1,COVER_HIDE,5,7,1);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_wait_response_from_other_groups");	
		--AI.PushGoal("signal",1,10,"IS_PLAYER_ENGAGED",SIGNALFILTER_SUPERSPECIES);
		--AI.PushGoal("timeout",1,0.8);
		AI.PushGoal("signal",1,1,"PLAYER_NOT_ENGAGED",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_retaliate_target");	
		AI.PushGoal("acqtarget",1,"");
		AI.PushGoal("timeout",1,0.5,0.8);
	AI.EndGoalPipe();

	AI.CreateGoalPipe("tr_random_timeout");
	AI.PushGoal("tr_random_timeout","timeout",1,3,3.5);


	AI.BeginGoalPipe("tr_set_dropped");
		AI.PushGoal("timeout",1,1.7,1.9);
		AI.PushGoal("signal",1,1,"SET_DROPPED",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,4);
		AI.PushGoal("signal",1,1,"OnLandForced",SIGNALFILTER_SENDER);--fallback
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_stick");
		AI.PushGoal("acqtarget",0,"P1");
		AI.PushGoal("run",1,1.5);
		AI.PushGoal("locate",0,"P");
		AI.PushGoal("firecmd",0,FIREMODE_AIM);
		AI.PushGoal("strafe",0,8,8);
		AI.PushGoal("stick",1,0,AILASTOPRES_USE);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tr_grabbed");
		AI.PushGoal("clear",1,1);
		AI.PushGoal("ignoreall",0,1);
		AI.PushLabel("SLEEPYSLEEPER");
		AI.PushGoal("signal",1,1,"choke",SIGNALID_READIBILITY);
		AI.PushGoal("timeout",1,5.1,5.7);
		AI.PushGoal("branch", 1, "SLEEPYSLEEPER", BRANCH_ALWAYS);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_hit_back");
		AI.PushGoal("locate",1,"refpoint");
		AI.PushGoal("move",1,1,2,AILASTOPRES_USE,1);
		AI.PushGoal("signal",1,1,"END_HIT_BACK",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_short_jump_timeout");
		AI.PushGoal("timeout",1,0.6);
		AI.PushGoal("signal",1,1,"OnLand",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_wait_land");
		AI.PushGoal("waitsignal", 1, "OnLand", nil, 6);
	AI.EndGoalPipe();
	
	
	AI.BeginGoalPipe("tr_melee_special_timeout");
		AI.PushGoal("branch", 1, "OK", IF_TARGET_DIST_GREATER,6);
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
		AI.PushGoal("timeout",0,3);
		AI.PushLabel("LOOP");
			AI.PushGoal("branch", 1, "OK", IF_TARGET_DIST_GREATER,6);
			AI.PushGoal("timeout",1,0.2);
			AI.PushGoal("branch", 1, "FAIL",NOT+IF_TARGET_MOVED,0.5);
		AI.PushGoal("branch", 1, "LOOP", IF_ACTIVE_GOALS);
		AI.PushLabel("OK");
			AI.PushGoal("signal",1,1,"MELEE_SPECIAL_TIMEOUT",SIGNALFILTER_SENDER);
				AI.PushGoal("branch", 1, "END", BRANCH_ALWAYS);
			AI.PushLabel("FAIL");
				AI.PushGoal("signal",1,1,"MELEE_SPECIAL_TIMEOUT_FAIL",SIGNALFILTER_SENDER);
		AI.PushLabel("END");
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("clear",0,0);
				
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_check_dead_target");
		AI.PushGoal("timeout",1,0.1);
		AI.PushGoal("signal",1,1,"CHECK_DEAD_TARGET",SIGNALFILTER_GROUPONLY);
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("tr_check_dead_body_moving");
		AI.PushGoal("timeout",1,1);
		AI.PushGoal("signal",1,1,"CHECK_DEAD_BODY_MOVING",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("tr_check_dead_body");
		AI.PushGoal("acqtarget",0,"refpoint");
		AI.PushGoal("stick",1,2,0,STICK_BREAK);
		AI.PushGoal("signal",1,1,"DEAD_BODY_APPROACHED",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,4);
		AI.PushGoal("signal",1,1,"END_CHECK_DEAD_BODY",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	
--	AI.BeginGoalPipe("tr_wait_timeout2");
--		AI.PushGoal("signal", 1, 1,"MELEE_SPECIAL_TIMEOUT2", SIGNALFILTER_SENDER );
--	AI.EndGoalPipe();
	

end
