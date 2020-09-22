--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: all vehicles' goalpipes should go here
--  
--------------------------------------------------------------------------
--  History:
--  - 07/02/2005   : Created by Kirill Bulatsev
--
--------------------------------------------------------------------------


function PipeManager:OnInitVehicle()

--------------------------------------------------------------------------
-- HELICOPTER

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("h_attack_approach");
		AI.PushGoal("h_attack_approach","acqtarget",0,"");
		AI.PushGoal("h_attack_approach","firecmd",0,0);	
		AI.PushGoal("h_attack_approach","run",0,1);	
		AI.PushGoal("h_attack_approach","firecmd",0,0);			
		AI.PushGoal("h_attack_approach","locate",0,"refpoint");		
		AI.PushGoal("h_attack_approach","approach",1,10,AILASTOPRES_USE);
		AI.PushGoal("h_attack_approach","run",0,-21);
		--AI.PushGoal("h_attack","stick",1,25,0,1);
		AI.PushGoal("h_attack_approach","timeout",1,10);	
		AI.PushGoal("h_attack_approach","signal",0,1,"H_CHOOSE_ATTACK_ACTION",SIGNALFILTER_SENDER);


		--------------------------------------------------------------------------
		AI.CreateGoalPipe("h_move");
--		AI.PushGoal("h_move","run",0,1);			
		AI.PushGoal("h_move","locate",0,"refpoint");
		AI.PushGoal("h_move","acqtarget",1,"");
		AI.PushGoal("h_move","approach",1,15);
		AI.PushGoal("h_move","signal",0,10,"ACTION_DONE",SIGNALFILTER_SENDER);


		--------------------------------------------------------------------------
		AI.CreateGoalPipe("h_goto");
		AI.PushGoal("h_goto","acqtarget",1,"");
		AI.PushGoal("h_goto","approach",1,15);
		AI.PushGoal("h_goto","signal",0,1,"PatrolPath",SIGNALFILTER_SENDER);


--------------------------------------------------------------------------
-- TANK
		AI.CreateGoalPipe( "t_stand_shoot" );
		AI.PushGoal( "t_stand_shoot", "firecmd", 0, 1 );
--		AI.PushGoal( "t_stand_shoot", "timeout", 1, 1 );		


		AI.CreateGoalPipe("t_moveto");
		AI.PushGoal("t_moveto","acqtarget",0,"");
		AI.PushGoal("t_moveto","run",0,1);
		AI.PushGoal("t_moveto","approach",1,2);
		AI.PushGoal("t_moveto","signal",1,1,"on_spot",0);

	-----------------------------------------------------
	AI.CreateGoalPipe("vehicle_path_approach");
--	AI.PushGoal("vehicle_path_approach","run", 0, 1);
	--AI.PushGoal("vehicle_path_approach","pathfind",1,"",1);
	--AI.PushGoal("vehicle_path_approach","trace",1,1);
	AI.PushGoal("vehicle_path_approach","approach", 1, 3, AILASTOPRES_USE);
	
	AI.PushGoal("vehicle_path_approach","signal",0,1,"OnNextPathPoint",0);	-- get next point in path

	AI.CreateGoalPipe("t_approach_refpoint");
	AI.PushGoal("t_approach_refpoint","locate",0,"refpoint");
	AI.PushGoal("t_approach_refpoint","approach",1,5,AILASTOPRES_USE);--TO DO: this "5" is a temporary fix for the crazy tank behavior when it approaches point
	AI.PushGoal("t_approach_refpoint","signal",0,1,"REFPOINT_REACHED",SIGNALFILTER_SENDER);		

	--------------------------------------------------------------------------
	AI.CreateGoalPipe("t_approach_target_at_distance");
	AI.PushGoal("t_approach_target_at_distance","timeout",1,1,2);
	AI.PushGoal("t_approach_target_at_distance","locate",0,"refpoint");
	AI.PushGoal("t_approach_target_at_distance","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("t_approach_target_at_distance","run",1,1);
	AI.PushGoal("t_approach_target_at_distance","approach",1,5,AILASTOPRES_USE);
	AI.PushGoal("t_approach_target_at_distance","signal",0,1,"TARGET_DISTANCE_REACHED",SIGNALFILTER_SENDER);		


	AI.CreateGoalPipe("wait_and_start_path");
	AI.PushGoal("wait_and_start_path","timeout",1,4);
	AI.PushGoal("wait_and_start_path","signal",0,1,"OnNextPathPoint",0);	-- get next point in path

	AI.CreateGoalPipe("vehicle_path");
	AI.PushGoal("vehicle_path","continuous",0,1);
	AI.PushGoal("vehicle_path","acqtarget",1,"");
	AI.PushGoal("vehicle_path","run",0,0);
	AI.PushGoal("vehicle_path","approach",1,2);
	AI.PushGoal("vehicle_path","signal",0,1,"next_point",0);	-- get next point in path

	AI.CreateGoalPipe("vehicle_goto");
	AI.PushGoal("vehicle_goto","clear",0,1);
	AI.PushGoal("vehicle_goto","continuous",0,1);
	AI.PushGoal("vehicle_goto","locate",1,"refpoint");
	AI.PushGoal("vehicle_goto","acqtarget",1,"");
--	AI.PushGoal("vehicle_goto","run",0,0);
	AI.PushGoal("vehicle_goto","approach",1,4);
	AI.PushGoal("vehicle_goto","continuous",0,0);	
--	AI.PushGoal("vehicle_goto","signal",0,1,"REFPOINT_REACHED");
	AI.PushGoal("vehicle_goto","signal",0,1,"ORD_DONE",SIGNALFILTER_SENDER);
	AI.PushGoal("vehicle_goto","signal",0,1,"ACTION_DONE",SIGNALFILTER_SENDER);
	

--	AI.CreateGoalPipe("vehicle_goto");
--	AI.PushGoal("vehicle_goto","continuous",0,1);
--	AI.PushGoal("vehicle_goto","run",0,0);	
--	AI.PushGoal("vehicle_goto","locate",1,"base");
--	AI.PushGoal("vehicle_goto","acqtarget",1,"");
--	AI.PushGoal("vehicle_goto","stick",1,1,1,1);
--	AI.PushGoal("vehicle_goto","continuous",0,0);	
--	AI.PushGoal("vehicle_goto","signal",0,1,"CHASE_DONE",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("vehicle_chase");
	AI.PushGoal("vehicle_chase","continuous",0,1);
	AI.PushGoal("vehicle_chase","run",0,0);	
	AI.PushGoal("vehicle_chase","stick",1,15,AILASTOPRES_LOOKAT,1);
	AI.PushGoal("vehicle_chase","continuous",0,0);	
	AI.PushGoal("vehicle_chase","signal",0,1,"CHASE_DONE",SIGNALFILTER_SENDER);


	---------------------------------------------
	AI.BeginGoalPipe("tankclose_wait");
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_wait3");
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",0,1,"TANKCLOSE_ATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_wait4");
		AI.PushGoal("signal",1,1,"TANKCLOSE_CHECK_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("timeout",1,0.5);
		AI.PushGoal("signal",1,1,"TANKCLOSE_ATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();
	
	---------------------------------------------
	AI.BeginGoalPipe("tankclose_attack_start");
		AI.PushGoal("signal",0,1,"TANKCLOSE_INIT",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_____________error");
		AI.PushGoal("timeout",1,3.0);
		AI.PushGoal("signal",0,1,"TANKCLOSE_INIT", SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_speedzero");
			AI.PushGoal("timeout",1,0.5);
			AI.PushGoal("signal",1,1,"TANKCLOSE_ATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_memoryattack");
		AI.PushGoal("timeout",1,1.0);
		AI.PushGoal("firecmd",0,1);
		AI.PushGoal("timeout",1,4.0);
		AI.PushGoal("firecmd",0,0);
		AI.PushGoal("signal",0,1,"TANKCLOSE_MEMORYATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tankclose_alert_action");
		AI.PushGoal("timeout",1,1.0);
		AI.PushGoal("signal",1,1,"TANKCLOSE_MEMORYATTACK_START",SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_fire");
		AI.PushGoal("firecmd",0,FIREMODE_FORCED);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_nofire");
		AI.PushGoal("firecmd",0,0);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_fire_sec");
		AI.PushGoal("firecmd",0,FIREMODE_SECONDARY);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("tank_fire_burst");
		AI.PushGoal("firecmd",0,FIREMODE_BURST);
	AI.EndGoalPipe();

	---------------------------------------------

	AI.LogEvent("VEHICLE PIPES LOADED");

end





