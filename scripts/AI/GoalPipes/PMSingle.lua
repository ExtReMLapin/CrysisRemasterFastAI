--------------------------------------------------------------------------------------------------
--	: by Kirill
--	: single unit human combat pipes
--	
--------------------------------------------------------------------------------------------------

function PipeManager:OnInitSingle()


	AI.CreateGoalPipe("cover_fire");
--	AI.PushGoal("cover_fire", "clear", 0, 0);
	AI.PushGoal("cover_fire", "+firecmd", 0, 1);
	AI.PushGoal("cover_fire", "+run", 0, 0);
--	AI.PushGoal("cover_fire", "+bodypos", 1, BODYPOS_PRONE);
	AI.PushGoal("cover_fire", "+timeout", 1, 0.1, 0.3);
	AI.PushGoal("cover_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
		AI.PushGoal("cover_fire", "+approach", 0, 1);
		AI.PushGoal("cover_fire", "+timeout", 1, 0.2, 0.3);
		AI.PushGoal("cover_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
			AI.PushGoal("cover_fire", "+timeout", 1, 0.2, 0.3);
			AI.PushGoal("cover_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
				AI.PushGoal("cover_fire", "+timeout", 1, 0.2, 0.3);
				AI.PushGoal("cover_fire", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
					AI.PushGoal("cover_fire", "+timeout", 1, 0.2, 0.3);
	AI.PushLabel("cover_fire", "STOP_HERE");
--	AI.PushGoal("cover_fire", "firecmd", 0, 2);
	AI.PushGoal("cover_fire", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("cover_fire", "timeout", 1, 1, 1.3);	
	

	
	AI.CreateGoalPipe("camper_fire");
	AI.PushGoal("camper_fire", "+firecmd", 0, 1);
	AI.PushGoal("camper_fire", "+run", 0, 0);
	AI.PushGoal("camper_fire", "+timeout", 1, 0.1, 0.3);
	AI.PushGoal("camper_fire", "signal", 1, 1, "UNHIDE", 0);
	AI.PushGoal("camper_fire","ignoreall",0,1);	
	AI.PushGoal("camper_fire","timeout", 1, 1.5, 2.3);	
	AI.PushGoal("camper_fire","run", 0, 1);	
	AI.PushGoal("camper_fire","bodypos", 0, BODYPOS_STAND);	
	AI.PushGoal("camper_fire","hide",1,10,HM_NEAREST,1);
	AI.PushGoal("camper_fire","ignoreall",0,0);	


--	AI.CreateGoalPipe("shared_unhide");
--	AI.PushGoal("shared_unhide", "branch", 1, "STOP_HERE", IF_SEES_TARGET);
--		AI.PushGoal("shared_unhide", "+approach", 0, 1);
--		AI.PushGoal("shared_unhide", "+timeout", 1, 0.2, 0.3);
--		AI.PushGoal("shared_unhide", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
--			AI.PushGoal("shared_unhide", "+timeout", 1, 0.2, 0.3);
--			AI.PushGoal("shared_unhide", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
--				AI.PushGoal("shared_unhide", "+timeout", 1, 0.2, 0.3);
--				AI.PushGoal("shared_unhide", "+branch", 1, "STOP_HERE", IF_SEES_TARGET);
--					AI.PushGoal("shared_unhide", "+timeout", 1, 0.2, 0.3);
--	AI.PushLabel("shared_unhide", "STOP_HERE");
--	AI.PushGoal("shared_unhide", "clear", 0, 0); -- stops approaching - 0 means keep att. target


	AI.CreateGoalPipe("shared_unhide");
	AI.PushGoal("shared_unhide", "branch", 1, "STOP_HERE", IF_SEES_TARGET);
		AI.PushGoal("shared_unhide", "approach", 0, 1);
		AI.PushGoal("shared_unhide", "timeout", 1, 3.0,5.0);
	AI.PushLabel("shared_unhide", "STOP_HERE");
	AI.PushGoal("shared_unhide", "clear", 0, 0); -- stops approaching - 0 means keep att. target

	AI.CreateGoalPipe( "rpg_shoot_tank" );
	AI.PushGoal( "rpg_shoot_tank", "firecmd", 0, FIREMODE_OFF );
	AI.PushGoal( "rpg_shoot_tank", "run", 0, 0 );
	AI.PushGoal( "rpg_shoot_tank", "bodypos", 1, BODYPOS_STAND );
	AI.PushGoal( "rpg_shoot_tank", "timeout", 1, 0.25 );
	AI.PushGoal( "rpg_shoot_tank", "branch", 1, "STOP_HERE", IF_SEES_TARGET );
		AI.PushGoal( "rpg_shoot_tank", "approach", 0, 1 );
		AI.PushGoal( "rpg_shoot_tank", "waitsignal", 1, "OnTankSeen", nil, 2.0 );
		AI.PushGoal( "rpg_shoot_tank", "timeout", 1, 0.3, 0.8 );
	AI.PushLabel( "rpg_shoot_tank", "STOP_HERE" );
	AI.PushGoal( "rpg_shoot_tank", "clear", 0, 0 ); -- stops approaching - 0 means keep att. target
	AI.PushGoal( "rpg_shoot_tank", "bodypos", 1, BODYPOS_CROUCH );
	AI.PushGoal( "rpg_shoot_tank", "firecmd", 0, FIREMODE_AIM );
	AI.PushGoal( "rpg_shoot_tank", "+timeout", 1, 1.0, 1.5 );
	AI.PushGoal( "rpg_shoot_tank", "branch", 1, "CAN_SEE_CROUCHING", IF_SEES_TARGET );
		AI.PushGoal( "rpg_shoot_tank", "bodypos", 1, BODYPOS_STAND );
		AI.PushGoal( "rpg_shoot_tank", "timeout", 1, 0.3 );
	AI.PushLabel( "rpg_shoot_tank", "CAN_SEE_CROUCHING" );
	AI.PushGoal( "rpg_shoot_tank", "firecmd", 0, FIREMODE_CONTINUOUS );
	AI.PushGoal( "rpg_shoot_tank", "timeout", 1, 1 );
	AI.PushGoal( "rpg_shoot_tank", "firecmd", 0, FIREMODE_OFF );
	AI.PushGoal( "rpg_shoot_tank", "+bodypos", 1, BODYPOS_STAND );
	AI.PushGoal( "rpg_shoot_tank", "+run", 0, 1 );
	AI.PushGoal( "rpg_shoot_tank", "+hide", 1, 20, HM_NEAREST );
	--AI.PushGoal( "rpg_shoot_tank", "bodypos", 1, BODYPOS_CROUCH );
	AI.PushGoal( "rpg_shoot_tank", "timeout", 1, 1.5, 2.5 );
	

	AI.CreateGoalPipe("lowhide_fire");
	AI.PushGoal("lowhide_fire","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("lowhide_fire", "signal",0,1,"THREATEN",SIGNALID_READIBILITY);	
	AI.PushGoal("lowhide_fire", "timeout", 1, .6, .73);
	AI.PushGoal("lowhide_fire", "firecmd", 0, 1);
	AI.PushGoal("lowhide_fire", "timeout", 1, 2.1, 5.3);
	AI.PushGoal("lowhide_fire", "firecmd", 0, 0);	
	AI.PushGoal("lowhide_fire", "branch", 1, "CONTINUE", IF_SEES_TARGET,15);	-- if no obstacle near
		AI.PushGoal("lowhide_fire", "signal",1,1,"DONT_SEE_TARGET",0);
		AI.PushGoal("lowhide_fire", "branch", 1, "HIDDEN", BRANCH_ALWAYS);
	AI.PushLabel("lowhide_fire", "CONTINUE");	
	AI.PushGoal("lowhide_fire", "bodypos",0,BODYPOS_CROUCH);	
	AI.PushGoal("lowhide_fire","ignoreall",0,1);
	AI.PushGoal("lowhide_fire", "timeout", 1, 3.1, 6.3);
	AI.PushGoal("lowhide_fire","ignoreall",0,0);
--	VS2 fix - check for 2 meters now
--	AI.PushGoal("lowhide_fire", "branch", 1, "HIDDEN", IF_IS_HIDDEN, .5);	
	AI.PushGoal("lowhide_fire", "branch", 1, "HIDDEN", IF_IS_HIDDEN, 2);
	AI.PushGoal("lowhide_fire", "signal",1,1,"SpotCompromized",0);	
	AI.PushLabel("lowhide_fire", "HIDDEN");
	
	
--	AI.PushGoal("lowhide_fire","ignoreall",0,1);	
--	AI.PushGoal("lowhide_fire","run", 0, 1);	
--	AI.PushGoal("lowhide_fire","hide",1,10,HM_NEAREST,1);
--	AI.PushGoal("lowhide_fire","ignoreall",0,0);	


	AI.CreateGoalPipe("hide_now");
--	AI.PushGoal("not_so_random_hide_from","devalue",0);
--	AI.PushGoal("not_so_random_hide_from","form",0,"beacon");
--	AI.PushGoal("not_so_random_hide_from","locate",0,"beacon");
--	AI.PushGoal("not_so_random_hide_from","acqtarget",1,"");
--	AI.PushGoal("not_so_random_hide_from","bodypos",0,BODYPOS_STAND);
--	AI.PushGoal("not_so_random_hide_from","run",0,1);
	AI.PushGoal("hide_now","run",0,2);		-- do it as fast as possible
	AI.PushGoal("hide_now","firecmd",0,0);
	AI.PushGoal("hide_now","ignoreall",0,1);--don't lose/reaquire the target
	AI.PushGoal("hide_now","hide",1,10,HM_NEAREST,1);
	AI.PushGoal("hide_now","ignoreall",0,0);
--	--AI.PushGoal("not_so_random_hide_from","firecmd",0,0);
--	AI.PushGoal("not_so_random_hide_from","branch",0,"CROUCH",IF_CAN_HIDE);
--	AI.PushGoal("not_so_random_hide_from","branch",0,"END",BRANCH_ALWAYS);
--	AI.PushLabel("not_so_random_hide_from","CROUCH");
--	AI.PushGoal("not_so_random_hide_from","bodypos",0,BODYPOS_CROUCH);
--	AI.PushGoal("not_so_random_hide_from","run",0,0);
--	AI.PushGoal("not_so_random_hide_from","timeout",1,3,5);
--	AI.PushLabel("not_so_random_hide_from","END");
--	AI.PushGoal("not_so_random_hide_from","signal",1,1,"END_HIDE",0);


	AI.CreateGoalPipe("hide_now_anywhere");
	AI.PushGoal("hide_now_anywhere","run",0,2);		-- do it as fast as possible
	AI.PushGoal("hide_now_anywhere","firecmd",0,0);
	AI.PushGoal("hide_now_anywhere","ignoreall",0,1);--don't lose/reaquire the target
--	AI.PushGoal("hide_now_anywhere","bodypos",0,BODYPOS_STAND);	
	AI.PushGoal("hide_now_anywhere","hide",1,10,HM_RANDOM,1);
	AI.PushGoal("hide_now_anywhere","ignoreall",0,0);

	AI.CreateGoalPipe("see_refpoint");
	AI.PushGoal("see_refpoint", "run", 0, 0);	
	AI.PushGoal("see_refpoint", "+locate", 0, "refpoint");
	AI.PushGoal("see_refpoint", "+approach", 0, 1);
	AI.PushGoal("see_refpoint", "+timeout", 1, 0.2, 0.3);
	AI.PushGoal("see_refpoint", "+branch", 1, "STOP_HERE", IF_SEES_LASTOP,25);	-- if no obstacle near
	AI.PushGoal("see_refpoint", "+branch", 1, -2, BRANCH_ALWAYS);	-- loop the approach
	AI.PushLabel("see_refpoint", "STOP_HERE");
--	AI.PushGoal("get_out_of_cover", "firecmd", 0, 2);
	AI.PushGoal("see_refpoint", "clear", 0, 0); -- stops approaching - 0 means keep att. target
	AI.PushGoal("see_refpoint", "timeout", 1, .2, .3);	
	AI.PushGoal("see_refpoint","signal",0,1,"LOOK_FOR_TARGET",0);

	AI.CreateGoalPipe("dive_prone");
	AI.PushGoal("dive_prone","bodypos",0,BODYPOS_PRONE);	
	AI.PushGoal("dive_prone","timeout",1,.3,.7);		

	AI.CreateGoalPipe("dig_in_hold");
	AI.PushGoal("dig_in_hold","bodypos",0,BODYPOS_CROUCH);
	AI.PushGoal("dig_in_hold","firecmd",0,1);
	AI.PushGoal("dig_in_hold","timeout",1,1,4);
	AI.PushGoal("dig_in_hold","firecmd",0,0);	
	AI.PushGoal("dig_in_hold","timeout",1,0.5,2);
	AI.PushGoal("dig_in_hold","firecmd",0,1);
	AI.PushGoal("dig_in_hold","timeout",1,1,2);
	AI.PushGoal("dig_in_hold","firecmd",0,0);	
	AI.PushGoal("dig_in_hold","timeout",1,0.5,1);
	AI.PushGoal("dig_in_hold","hide",1,20,HM_NEAREST,1,10);	

	AI.CreateGoalPipe("sneak_left");
	AI.PushGoal("sneak_left","run",0,2);
	AI.PushGoal("sneak_left","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("sneak_left","hide",1,20,HM_LEFTMOST_FROM_TARGET);
--	AI.PushGoal("sneak_left","signal",0,1,"SNEAK_POINT_REACHED",0);

	AI.CreateGoalPipe("sneak_right");
	AI.PushGoal("sneak_right","run",0,2);
	AI.PushGoal("sneak_right","bodypos",0,BODYPOS_STAND);	
	AI.PushGoal("sneak_right","hide",1,20,HM_RIGHTMOST_FROM_TARGET);

	AI.CreateGoalPipe("sniper_backoff");
	AI.PushGoal("sniper_backoff", "bodypos", 0, BODYPOS_CROUCH);		
	AI.PushGoal("sniper_backoff", "run", 0, 0);
	AI.PushGoal("sniper_backoff", "strafe", 0, 100, 100);
	AI.PushGoal("sniper_backoff","backoff", 1, 222, 8, AI_BACKOFF_FROM_TARGET);	
	AI.PushGoal("sniper_backoff","signal",1,1,"sniper_move_start",0);

--	AI.CreateGoalPipe("sniper_move_idle");
--	AI.PushGoal("sniper_move_idle", "run", 0, 1);		
--	AI.PushGoal("sniper_move_idle", "bodypos", 0, BODYPOS_PRONE, 1);			
--	AI.PushGoal("sniper_move_idle","locate", 0, "refpoint");	
--	AI.PushGoal("sniper_move_idle","approach", 1, 0);
--	AI.PushGoal("sniper_move_idle","signal", 1, 1, "on_spot", 0);

	AI.BeginGoalPipe("sniper_move_idle");
		AI.PushGoal("bodypos", 0, BODYPOS_RELAX);
		AI.PushGoal("run", 0, 0);		
		AI.PushGoal("locate", 0, "refpoint");	
		AI.PushGoal("approach", 1, 0);
		AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
		AI.PushGoal("devalue",0);		
		AI.PushGoal("signal", 1, 1, "on_spot", 0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("sniper_move");
		AI.PushGoal("locate", 0, "refpoint");	
		AI.PushGoal("pathfind",1);
		AI.PushGoal("bodypos",		0, BODYPOS_CROUCH);	
		AI.PushGoal("run",	0, 0);
		AI.PushGoal("signal",1,1,"sniper_move_moving",0);	
	--	AI.PushGoal("strafe",0,100,100);
		AI.PushGoal("trace",1,1,0,0);
		AI.PushGoal("bodypos", 1, BODYPOS_PRONE);	
		AI.PushGoal("timeout",1,1.3,1.5);	
		AI.PushGoal("devalue",0);		
		AI.PushGoal("signal",1,1,"on_spot",0);
--		AI.PushGoal("signal",1,1,"move_done",0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("sniper_pre_snipe");
	--	AI.PushGoal("firecmd", 0, 1);
	--	AI.PushGoal("devalue",0);
		AI.PushGoal("locate", 0, "refpoint");	
		AI.PushGoal("lookat",1,0,0,1);	
		AI.PushGoal("timeout",1,.3,.5);
		AI.PushGoal("signal",1,1,"on_spot",0);
	AI.EndGoalPipe();

	AI.CreateGoalPipe("sniper_move_back");
	AI.PushGoal("sniper_move_back","locate", 0, "refpoint");	
	AI.PushGoal("sniper_move_back","pathfind",1);
	AI.PushGoal("sniper_move_back", "bodypos",		0, BODYPOS_CROUCH);	
	AI.PushGoal("sniper_move_back", "run",	0, 1);
--	AI.PushGoal("sniper_move","strafe",0,100,100);
	AI.PushGoal("sniper_move_back","trace",1,0,0,1);
	AI.PushGoal("sniper_move_back","signal",1,1,"on_spot_back",0);


	AI.CreateGoalPipe("sniper_shoot");
--	AI.PushLabel("sniper_shoot", "FIRE_LOOP");
	AI.PushGoal("sniper_shoot","+firecmd", 0, FIREMODE_CONTINUOUS);
	AI.PushGoal("sniper_shoot", "+waitsignal", 1, "WPN_SHOOT", nil, 16.0 );
--	AI.PushGoal("sniper_shoot","+timeout",1,.1,.2);
--	AI.PushGoal("sniper_shoot", "+branch", 1, "SHOT_DONE", IF_HAS_FIRED);
--	AI.PushGoal("sniper_shoot", "+branch", 1, "FIRE_LOOP", BRANCH_ALWAYS);
--	AI.PushLabel("sniper_shoot", "SHOT_DONE");
	AI.PushGoal("sniper_shoot","firecmd", 0, 0);
	AI.PushGoal("sniper_shoot","timeout",1,.7,1.1);
	AI.PushGoal("sniper_shoot","signal",1,1,"relocate",0);

	AI.BeginGoalPipe("sniper_snipe");
	--	AI.PushGoal("sniper_snipe","firecmd", 0, 1);
	--	AI.PushGoal("sniper_snipe","devalue",0);
		AI.PushGoal("locate", 0, "refpoint");	
		AI.PushLabel("KEEP_LOOKING");
			AI.PushGoal("lookat",1,0,0,1);	
			AI.PushGoal("timeout",1,.3,.5);
			AI.PushGoal("lookat",0,-15,15);	
			AI.PushGoal("timeout",1,.4,.6);
		AI.PushGoal( "branch", 1, "KEEP_LOOKING", IF_NO_ENEMY_TARGET);
		
		AI.PushGoal("+firecmd", 0, FIREMODE_CONTINUOUS);
		AI.PushGoal("+waitsignal", 1, "WPN_SHOOT", nil, 16.0 );
		AI.PushGoal("firecmd", 0, 0);
		AI.PushGoal("timeout",1,.7,1.1);
		AI.PushGoal("signal",1,1,"relocate",0);
		
	--	AI.PushGoal("sniper_snipe","lookat",0,-500,15);		-- reset lookat - since there are some problems with actor rotation currently	
	AI.EndGoalPipe();

	AI.CreateGoalPipe("sniper_singlespot");
	AI.PushGoal("sniper_singlespot","timeout",1,1.3,1.5);
	AI.PushGoal("sniper_singlespot","devalue",0);
	AI.PushGoal("sniper_singlespot","signal",1,1,"on_spot",0);

	--run to target and do melee. abort if trget moves for more than 2.5m
	AI.BeginGoalPipe("melee_far_during_reload");
		AI.PushGoal("firecmd", 0, 0);
		AI.PushGoal("run", 0, 2);
		AI.PushGoal("bodypos", 0, BODYPOS_STAND);
		AI.PushGoal("stick",0,1.3,0,STICK_BREAK, -1);
		AI.PushLabel("STICK_LOOP");
			AI.PushGoal("branch", 1, "END", IF_TARGET_MOVED_SINCE_START, 2.5);	-- this will check if current weapon has/allows melee
		AI.PushGoal("branch", 1, "STICK_LOOP", IF_ACTIVE_GOALS);
		AI.PushGoal("clear", 0, 0);	 -- stops approaching - 0 means keep att. target
		AI.PushGoal("firecmd", 1, FIREMODE_MELEE);
		AI.PushGoal("timeout", 1, 0.7);
		AI.PushLabel("END");
		AI.PushGoal("hide",1,10,HM_NEAREST+HM_INCLUDE_SOFTCOVERS);
		AI.PushGoal("signal",0,1,"HANDLE_RELOAD",0);
	AI.EndGoalPipe();

	--run to target and do melee. abort if trget moves for more than 2.5m
	AI.BeginGoalPipe("melee_far");
		AI.PushGoal("firecmd", 0, 0);
		AI.PushGoal("run", 0, 2);
		AI.PushGoal("bodypos", 0, BODYPOS_STAND);
		AI.PushGoal("stick",0,1.3,0,STICK_BREAK, -1);
		AI.PushLabel("STICK_LOOP");
			AI.PushGoal("branch", 1, "END", IF_TARGET_MOVED_SINCE_START, 2.5);	-- this will check if current weapon has/allows melee
		AI.PushGoal("branch", 1, "STICK_LOOP", IF_ACTIVE_GOALS);
		AI.PushGoal("clear", 0, 0);	 -- stops approaching - 0 means keep att. target
		AI.PushGoal("firecmd", 1, FIREMODE_MELEE);
		AI.PushGoal("timeout", 1, 0.7);
		AI.PushLabel("END");		
		AI.PushGoal("signal",0,1,"COVER_NORMALATTACK",0);
	AI.EndGoalPipe();

	--close to target - just do melee
	AI.BeginGoalPipe("melee_close");
		AI.PushGoal("bodypos", 0, BODYPOS_STAND);
		AI.PushGoal("firecmd", 1, FIREMODE_MELEE);
		AI.PushGoal("timeout", 1, 0.7);
		AI.PushGoal("signal",0,1,"COVER_NORMALATTACK",0);
	AI.EndGoalPipe();

	--close to target - just do melee using nano-suit power
	AI.BeginGoalPipe("melee_close_suit");
		AI.PushGoal("bodypos", 0, BODYPOS_STAND);
		AI.PushGoal("firecmd", 1, FIREMODE_MELEE);
		AI.PushGoal("timeout", 1, 0.7);
		AI.PushGoal("signal",0,1,"COVER_NORMALATTACK",0);
	AI.EndGoalPipe();


	---------------------------------------------
	AI.BeginGoalPipe("goto_point");
		AI.PushGoal("acqtarget",0,"");
		AI.PushGoal("bodypos", 0, BODYPOS_CROUCH);
		AI.PushGoal("run", 0, 1);
		AI.PushGoal("approach", 1, 1);
--		AI.PushGoal("firecmd",1,FIREMODE_BURST);
		AI.PushGoal("firecmd",1,FIREMODE_OFF);
		AI.PushGoal("lookaround",1,45,3,2,5,AI_BREAK_ON_LIVE_TARGET);
--		AI.PushGoal("timeout",1,0.5,0.8);
	AI.EndGoalPipe();


end

