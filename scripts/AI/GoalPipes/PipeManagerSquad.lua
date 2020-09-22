function PipeManager:InitSquad()

	AI.CreateGoalPipe("squad_form_init");
--	AI.PushGoal("squad_form_init", "ignoreall", 0, 1);
	AI.PushGoal("squad_form_init", "run", 0, 0);
	AI.PushGoal("squad_form_init", "+bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("squad_form_init", "+branch", 0, 3, IF_FIRE_IS, 0);
		AI.PushGoal("squad_form_init", "+locate", 0, "formation");
		AI.PushGoal("squad_form_init", "+approach", 0, 1, AILASTOPRES_USE+AI_REQUEST_PARTIAL_PATH);
		AI.PushGoal("squad_form_init", "+timeout", 1, 3); -- move towards formation point 
	AI.PushGoal("squad_form_init", "clear", 0, 1);
	AI.PushGoal("squad_form_init", "firecmd", 0, 0);
	--AI.PushGoal("squad_form_init", "run", 0, 1);

	AI.CreateGoalPipe("squad_form");
	--AI.PushGoal("squad_form","ignoreall",0,1);
	AI.PushGoal("squad_form","firecmd",0,0);
	AI.PushGoal("squad_form", "+bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("squad_form","+locate",0,"formation");
	--AI.PushGoal("squad_form","+acqtarget",0,"");
	AI.PushGoal("squad_form","+stick",1,0,AI_REQUEST_PARTIAL_PATH+AILASTOPRES_USE,1);
	AI.PushGoal("squad_form","+ignoreall",0,0);
	AI.PushGoal("squad_form","+signal",1,1,"FORMATION_REACHED",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("squad_form_combat");

	--AI.PushGoal("squad_form_combat","ignoreall",0,1);
	AI.PushGoal("squad_form_combat","+locate",0,"formation");
	AI.PushGoal("squad_form_combat","+bodypos",0,BODYPOS_STAND);
	AI.PushGoal("squad_form_combat","+run",0,1.5);
	--AI.PushGoal("squad_form_combat","+firecmd",0,1);
	AI.PushGoal("squad_form_combat","+branch",0,"NOTARGET",IF_NO_ENEMY_TARGET);
	AI.PushGoal("squad_form_combat","+strafe",1,0,5);
	AI.PushGoal("squad_form_combat","+stick",1,0.0,AILASTOPRES_USE+AI_REQUEST_PARTIAL_PATH,1);
	AI.PushGoal("squad_form_combat","+branch",0,"END",BRANCH_ALWAYS);
	AI.PushLabel("squad_form_combat","NOTARGET");
	AI.PushGoal("squad_form_combat","+strafe",1,0,2);
	AI.PushGoal("squad_form_combat","+acqtarget",0,"");
	AI.PushGoal("squad_form_combat","+locate",0,"formationsight");
	AI.PushGoal("squad_form_combat","+stick",1,0.0,AILASTOPRES_LOOKAT+AI_REQUEST_PARTIAL_PATH,1);
	AI.PushLabel("squad_form_combat","END");
	AI.PushGoal("squad_form_combat","+ignoreall",0,0);
	AI.PushGoal("squad_form_combat","+signal",1,1,"FORMATION_REACHED",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("stay_in_formation");
	AI.PushGoal("stay_in_formation","locate",0,"formation");
	AI.PushGoal("stay_in_formation","+acqtarget",0,"");
	AI.PushGoal("stay_in_formation","+locate",0,"formationsight");
	AI.PushGoal("stay_in_formation","+stick",1,0.0,AILASTOPRES_LOOKAT+AI_REQUEST_PARTIAL_PATH,0);

	AI.CreateGoalPipe("stay_in_formation_look_at_player");
	AI.PushGoal("stay_in_formation_look_at_player","locate",0,"formation");
	AI.PushGoal("stay_in_formation_look_at_player","+acqtarget",0,"");
	AI.PushGoal("stay_in_formation_look_at_player","+locate",0,"player");
	AI.PushGoal("stay_in_formation_look_at_player","+stick",1,0.0,AILASTOPRES_LOOKAT+AI_REQUEST_PARTIAL_PATH,0);

	AI.CreateGoalPipe("follow_and_lookat_player_5sec");
	AI.PushGoal("follow_and_lookat_player_5sec","locate",0,"formation");
	AI.PushGoal("follow_and_lookat_player_5sec","+acqtarget",0,"");
	AI.PushGoal("follow_and_lookat_player_5sec","+locate",0,"player");
	AI.PushGoal("follow_and_lookat_player_5sec","+stick",0,0.0,AILASTOPRES_LOOKAT+AI_REQUEST_PARTIAL_PATH,0);
	AI.PushGoal("follow_and_lookat_player_5sec","timeout",1,5,6);
	AI.PushGoal("follow_and_lookat_player_5sec","clear",1);
	AI.PushGoal("follow_and_lookat_player_5sec","locate",0,"formation");

	AI.CreateGoalPipe("squad_lookaround");
	AI.PushGoal("squad_lookaround","lookaround",0,60,3,100,100,AI_BREAK_ON_LIVE_TARGET);
	
	AI.CreateGoalPipe("squad_lookat_player_5sec");
	AI.PushGoal("squad_lookat_player_5sec","locate",0,"player");
	AI.PushGoal("squad_lookat_player_5sec","+lookat",0,0,0,1);
	AI.PushGoal("squad_lookat_player_5sec","timeout",1,5,6);
	AI.PushGoal("squad_lookat_player_5sec","clear",1);

	AI.CreateGoalPipe("squad_try_follow");
	AI.PushGoal("squad_try_follow","branch",1,"FORM",BRANCH_ALWAYS);
	AI.PushGoal("squad_try_follow","timeout",1,1);
	AI.PushLabel("squad_try_follow", "FORM" );
	AI.PushGoal("squad_try_follow","locate",1,"formation");
	AI.PushGoal("squad_try_follow","pathfind",1,"");
	AI.PushGoal("squad_try_follow","branch",1,"TIMEOUT",IF_NO_PATH);
	AI.PushGoal("squad_try_follow", "signal", 1, 1, "CAN_FOLLOW",0);
	AI.PushLabel("squad_try_follow", "TIMEOUT" );
	
	AI.CreateGoalPipe("stay_in_formation_with_target");
	AI.PushGoal("stay_in_formation_with_target","locate",0,"formation");
	AI.PushGoal("stay_in_formation_with_target","+stick",1,0.0,AILASTOPRES_USE+AI_REQUEST_PARTIAL_PATH,0);


	AI.CreateGoalPipe("stay_in_formation_prone");
	AI.PushGoal("stay_in_formation_prone","bodypos",0,BODYPOS_PRONE);
	AI.PushGoal("stay_in_formation_prone","locate",0,"formation");
	AI.PushGoal("stay_in_formation_prone","+acqtarget",0,"");
	AI.PushGoal("stay_in_formation_prone","+run",0,1.5);
	AI.PushGoal("stay_in_formation_prone","+locate",0,"formationsight");
	AI.PushGoal("stay_in_formation_prone","+stick",1,0,AILASTOPRES_LOOKAT+AI_REQUEST_PARTIAL_PATH,0);
	
	AI.CreateGoalPipe("action_form");
	AI.PushGoal("action_form","locate",0,"formation",1000);
	AI.PushGoal("action_form","+acqtarget",0,"");
	AI.PushGoal("action_form","+locate",0,"formationsight",1000);
	AI.PushGoal("action_form","+run",1,1);	
	AI.PushGoal("action_form","+stick",1,0.0,AILASTOPRES_LOOKAT+AI_REQUEST_PARTIAL_PATH,1);	
	AI.PushGoal("action_form", "branch", 0, "NO_PATH", IF_NO_PATH );
	AI.PushGoal("action_form", "signal", 1, 1, "END_ACT_FORM",0);
	AI.PushGoal("action_form", "branch", 0, "END", BRANCH_ALWAYS );
	AI.PushLabel("action_form", "NO_PATH" );
	AI.PushGoal("action_form", "signal", 1, 1, "CANCEL_CURRENT",0);
	AI.PushLabel("action_form", "END" );

	AI.CreateGoalPipe("action_end_form");

	AI.CreateGoalPipe("stay_in_formation_moving");
	AI.PushGoal("stay_in_formation_moving","locate",0,"formation",1000);
	AI.PushGoal("stay_in_formation_moving","+acqtarget",0,"");
	AI.PushGoal("stay_in_formation_moving","+locate",0,"formationsight",1000);
	AI.PushGoal("stay_in_formation_moving","+stick",1,0.0,AILASTOPRES_LOOKAT+AI_REQUEST_PARTIAL_PATH,STICK_SHORTCUTNAV);	

	AI.CreateGoalPipe("squad_form_special");
	AI.PushGoal("squad_form_special","locate",0,"formation_special");
	AI.PushGoal("squad_form_special","+acqtarget",0,"");
	AI.PushGoal("squad_form_special","+locate",0,"formationsight");
	AI.PushGoal("squad_form_special","+stick",1,0,AI_REQUEST_PARTIAL_PATH,1);
	AI.PushGoal("squad_form_special","signal",1,1,"FORMATION_REACHED",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("squad_revolt");
	AI.PushGoal("squad_revolt","acqtarget",1,"player");
	AI.PushGoal("squad_revolt", "+ignoreall", 1, 1);
	AI.PushGoal("squad_revolt", "+timeout", 1, 0.5, 0.7);
	AI.PushGoal("squad_revolt", "+ignoreall", 1, 0);
	--AI.PushGoal("squad_revolt", "+signal", 1, 1, "CHANGE_CHARACTER_COVER", SIGNALFILTER_SENDER);
	--AI.PushGoal("squad_revolt", "+signal", 1, 1, "OnUnitBusy", SIGNALFILTER_LEADER);
	AI.PushGoal("squad_revolt", "+signal", 1, 1, "GO_TO_ATTACK", SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("squad_hide_outdoor");
	AI.PushGoal("squad_hide_outdoor", "ignoreall", 0, 0);
	AI.PushGoal("squad_hide_outdoor", "firecmd", 0, 1);
	AI.PushGoal("squad_hide_outdoor", "timeout", 1, 1.5,2.3);
	AI.PushGoal("squad_hide_outdoor", "firecmd", 0, 0);
	AI.PushGoal("squad_hide_outdoor", "strafe", 0, 0,2);
	AI.PushGoal("squad_hide_outdoor", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("squad_hide_outdoor", "run", 1, 1.5);
	AI.PushGoal("squad_hide_outdoor", "branch", 1, "NOTARGET", IF_NO_ENEMY_TARGET);
	AI.PushGoal("squad_hide_outdoor", "branch", 1, "HIDE", BRANCH_ALWAYS);
	AI.PushLabel("squad_hide_outdoor","NOTARGET");
	AI.PushGoal("squad_hide_outdoor", "acqtarget", 0, "beacon");
	AI.PushLabel("squad_hide_outdoor","HIDE");
	AI.PushGoal("squad_hide_outdoor", "+locate", 0,"refpoint");
	AI.PushGoal("squad_hide_outdoor", "+hide", 1, 6, HM_NEAREST_TO_LASTOPRESULT);
	AI.PushGoal("squad_hide_outdoor", "branch", 1, "HIDDEN",IF_CAN_HIDE);
	AI.PushGoal("squad_hide_outdoor", "+hide", 1, 6, HM_NEAREST);
	AI.PushGoal("squad_hide_outdoor", "branch", 1, "HIDDEN",IF_CAN_HIDE);
	AI.PushGoal("squad_hide_outdoor", "signal", 1, 1, "CANNOT_HIDE", SIGNALFILTER_SENDER);
	AI.PushGoal("squad_hide_outdoor", "branch", 1, "END",BRANCH_ALWAYS);
	AI.PushLabel("squad_hide_outdoor","HIDDEN");
	AI.PushGoal("squad_hide_outdoor", "signal", 1, 1, "END_HIDE", SIGNALFILTER_SENDER);
	AI.PushLabel("squad_hide_outdoor","END");

	AI.BeginGoalPipe("squad_hide_follow_outdoor");
		AI.PushGoal("ignoreall", 0, 0);
		AI.PushGoal( "firecmd", 0, 0);
		AI.PushGoal("strafe", 0, 0,2);
		AI.PushGoal("bodypos", 0, BODYPOS_CROUCH);
		AI.PushGoal("run", 1, 1);
		AI.PushGoal("branch", 1, "NOTARGET", IF_NO_ENEMY_TARGET);
		AI.PushGoal("branch", 1, "HIDE", BRANCH_ALWAYS);
		AI.PushLabel("NOTARGET");
		AI.PushGoal("acqtarget", 0, "beacon");
		AI.PushLabel("HIDE");
		AI.PushGoal("+locate", 0,"formation");
		AI.PushGoal( "+hide", 1, 6, HM_NEAREST_TO_LASTOPRESULT+HM_INCLUDE_SOFTCOVERS);
		AI.PushGoal( "branch", 1, "HIDDEN",IF_CAN_HIDE);
		AI.PushGoal("+hide", 1, 6, HM_NEAREST+HM_INCLUDE_SOFTCOVERS);
		AI.PushGoal( "branch", 1, "HIDDEN",IF_CAN_HIDE);
		AI.PushGoal( "signal", 1, 1, "CANNOT_HIDE", SIGNALFILTER_SENDER);
		AI.PushGoal("branch", 1, "END",BRANCH_ALWAYS);
		AI.PushLabel("HIDDEN");
		AI.PushGoal( "signal", 1, 1, "END_HIDE", SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();

	AI.BeginGoalPipe("squad_stay_hidden_follow");
		AI.PushGoal("usecover",1,COVER_HIDE,1.5,2);
	AI.EndGoalPipe();
	
	AI.CreateGoalPipe("squad_reload");
	AI.PushGoal("squad_reload", "firecmd", 0, 0);
	AI.PushGoal("squad_reload", "+hide", 1, 8, HM_NEAREST+HM_BACK);
	AI.PushGoal("squad_reload","+bodypos",1,BODYPOS_CROUCH);
	AI.PushGoal("squad_reload", "+signal", 1, 1,"RELOAD", SIGNALFILTER_SENDER);
	AI.PushGoal("squad_reload", "+waitsignal", 1, "OnReloadDone",nil,4);
	AI.PushGoal("squad_reload","+bodypos",1,BODYPOS_STAND);
	AI.PushGoal("squad_reload", "+signal", 1, 1,"END_RELOAD", SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("squad_reload_indoor");
	AI.PushGoal("squad_reload_indoor", "firecmd", 0, 0);
	AI.PushGoal("squad_reload_indoor", "+hide", 1, 5, HM_NEAREST+HM_BACK);
	AI.PushGoal("squad_reload_indoor", "+signal", 1, 1,"RELOAD", SIGNALFILTER_SENDER);
	AI.PushGoal("squad_reload_indoor", "+waitsignal", 1, "OnReloadDone",nil,4);
	AI.PushGoal("squad_reload_indoor", "+signal", 1, 1,"END_RELOAD", SIGNALFILTER_SENDER);
	

	AI.BeginGoalPipe("squad_hide_indoor");
		AI.PushGoal("ignoreall", 0, 0);
		AI.PushGoal("strafe", 0, 0,2);
		AI.PushGoal("bodypos", 0, BODYPOS_STAND);
		AI.PushGoal("run", 1, 1.5);
--	AI.PushGoal( "+locate", 1, "refpoint");
--	AI.PushGoal( "+hide", 1, 3, HM_NEAREST_TO_LASTOPRESULT);
		AI.PushGoal( "branch", 1, "NOTARGET", IF_NO_ENEMY_TARGET);
		AI.PushGoal( "branch", 1, "HIDE", BRANCH_ALWAYS);
		AI.PushLabel("NOTARGET");
		AI.PushGoal( "acqtarget", 0, "beacon");
		AI.PushLabel("HIDE");
		AI.PushGoal( "+locate", 1, "formation");
		AI.PushGoal( "+hide", 1, 6, HM_NEAREST_TO_LASTOPRESULT);
		AI.PushGoal( "branch", 1, "HIDDEN",IF_CAN_HIDE);
		AI.PushGoal("+hide", 1, 6, HM_NEAREST);
		AI.PushGoal( "branch", 1, "END",IF_CANNOT_HIDE);
		AI.PushGoal( "firecmd", 0, 0);
		AI.PushLabel("HIDDEN");
		AI.PushGoal( "signal", 1, 1, "END_HIDE", SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();
	
	AI.BeginGoalPipe("squad_hide_follow_indoor");
		AI.PushGoal("ignoreall", 0, 0);
		AI.PushGoal( "strafe", 0, 0,2);
		AI.PushGoal("bodypos", 0, BODYPOS_STAND);
		AI.PushGoal( "run", 1, 1);
--	AI.PushGoal("squad_hide_indoor", "+locate", 1, "refpoint");
--	AI.PushGoal("squad_hide_indoor", "+hide", 1, 3, HM_NEAREST_TO_LASTOPRESULT);
		AI.PushGoal("branch", 1, "NOTARGET", IF_NO_ENEMY_TARGET);
		AI.PushGoal("branch", 1, "HIDE", BRANCH_ALWAYS);
		AI.PushLabel("NOTARGET");
		AI.PushGoal( "acqtarget", 0, "beacon");
		AI.PushLabel("HIDE");
		AI.PushGoal( "locate", 1, "formation");
		AI.PushGoal( "+hide", 1, 5, HM_NEAREST_TO_LASTOPRESULT+HM_BACK+HM_INCLUDE_SOFTCOVERS);
		AI.PushGoal( "branch", 1, "HIDDEN",IF_CAN_HIDE);
		AI.PushGoal("hide", 1, 6, HM_NEAREST+HM_BACK+HM_INCLUDE_SOFTCOVERS);
		AI.PushGoal( "branch", 1, "END",IF_CANNOT_HIDE);
		AI.PushLabel("HIDDEN");
		AI.PushGoal( "signal", 1, 1, "END_HIDE", SIGNALFILTER_SENDER);
		AI.PushLabel("END");
	AI.EndGoalPipe();

	AI.CreateGoalPipe("squad_hide_back_indoor");
	AI.PushGoal("squad_hide_back_indoor", "ignoreall", 0, 0);
	AI.PushGoal("squad_hide_back_indoor", "strafe", 0, 0,2);
	AI.PushGoal("squad_hide_back_indoor", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("squad_hide_back_indoor", "run", 1, 1.5);
	AI.PushGoal("squad_hide_back_indoor", "branch", 1, "NOTARGET", IF_NO_ENEMY_TARGET);
	AI.PushGoal("squad_hide_back_indoor", "branch", 1, "HIDE", BRANCH_ALWAYS);
	AI.PushLabel("squad_hide_back_indoor","NOTARGET");
	AI.PushGoal("squad_hide_back_indoor", "acqtarget", 0, "beacon");
	AI.PushLabel("squad_hide_back_indoor","HIDE");
	AI.PushGoal("squad_hide_back_indoor", "+locate", 1, "formation");
	AI.PushGoal("squad_hide_back_indoor", "+hide", 1, 5, HM_NEAREST);
	AI.PushGoal("squad_hide_back_indoor", "branch", 1, "END",IF_CANNOT_HIDE);
	AI.PushGoal("squad_hide_back_indoor", "firecmd", 0, 0);
	AI.PushGoal("squad_hide_back_indoor", "signal", 1, 1, "END_HIDE", SIGNALFILTER_SENDER);
	AI.PushLabel("squad_hide_back_indoor","END");


	AI.CreateGoalPipe("squad_fire_covered");
	AI.PushLabel("squad_fire_covered","LOOP");
	AI.PushGoal("squad_fire_covered","locate",0,"beacon");
	AI.PushGoal("squad_fire_covered","strafe",0,2,2);
	AI.PushGoal("squad_fire_covered", "firecmd", 0, 1);
	AI.PushGoal("squad_fire_covered", "branch", 1, "SKIP_HIDE", IF_COVER_NOT_COMPROMISED);
		AI.PushGoal("squad_fire_covered","hide",1,4,HM_NEAREST);
	AI.PushLabel("squad_fire_covered","SKIP_HIDE");
	AI.PushGoal("squad_fire_covered","usecover",1,COVER_HIDE,3.5,4,1);
	AI.PushGoal("squad_fire_covered","usecover",1,COVER_UNHIDE,3.5,4.5,1);
	AI.PushGoal("squad_fire_covered", "signal", 1, 1, "THROW_GRENADE_IF_NO_LIVE_TARGET", SIGNALFILTER_SENDER);
	AI.PushGoal("squad_fire_covered", "timeout", 1, 1.3,1.7);
	AI.PushGoal("squad_fire_covered","usecover",1,COVER_HIDE,3.5,4.5,1);
	AI.PushGoal("squad_fire_covered","usecover",1,COVER_UNHIDE,3.5,4.5,1);
	AI.PushGoal("squad_fire_covered", "signal", 1, 1, "END_FIRE_COVERED", SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("squad_hide_near");
	AI.PushGoal("squad_hide_near", "hide", 1, 4, HM_NEAREST);
	AI.PushGoal("squad_hide_near", "branch", 1, "END",IF_CANNOT_HIDE);
	AI.PushGoal("squad_hide_near", "signal", 1, 1, "END_HIDE", SIGNALFILTER_SENDER);
	AI.PushLabel("squad_hide_near","END");
	
	AI.CreateGoalPipe("squad_hide_evade");
	AI.PushGoal("squad_hide_evade","firecmd",0,0);
	AI.PushGoal("squad_hide_evade","locate",0,"formation");
	AI.PushGoal("squad_hide_evade","run",0,1.5);
	AI.PushGoal("squad_hide_evade", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("squad_hide_evade","hide",1,10,HM_NEAREST+HM_BACK);
	AI.PushGoal("squad_hide_evade", "branch", 1, "END",IF_CANNOT_HIDE);
	AI.PushGoal("squad_hide_evade","usecover",1,COVER_HIDE,2,4);
	AI.PushLabel("squad_hide_evade","END");
	AI.PushGoal("squad_hide_evade","firecmd",0,1); -- give time to change another goalpipe
	AI.PushGoal("squad_hide_evade","signal",1,1,"END_HIDE",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("squad_hide_evade_indoor");
	AI.PushGoal("squad_hide_evade_indoor","firecmd",0,0);
	AI.PushGoal("squad_hide_evade_indoor","locate",0,"formation");
	AI.PushGoal("squad_hide_evade_indoor","run",0,1.5);
	AI.PushGoal("squad_hide_evade_indoor", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("squad_hide_evade_indoor","hide",1,4,HM_NEAREST_TO_LASTOPRESULT+HM_BACK);
	AI.PushGoal("squad_hide_evade_indoor", "branch", 1, "END",IF_CANNOT_HIDE);
	AI.PushGoal("squad_hide_evade_indoor","timeout",1,2,4);
	AI.PushLabel("squad_hide_evade_indoor","END");
	AI.PushGoal("squad_hide_evade_indoor","firecmd",0,1); -- give time to change another goalpipe
	AI.PushGoal("squad_hide_evade_indoor","signal",1,1,"END_HIDE",SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("squad_hide_with_player");
	AI.PushGoal("squad_hide_with_player", "locate", 1, "formation");
	AI.PushGoal("squad_hide_with_player", "run", 1, 1);
	AI.PushGoal("squad_hide_with_player", "hide", 1, 6, HM_NEAREST_TO_ME+HM_AROUND_LASTOP);
	AI.PushGoal("squad_hide_with_player", "branch", 1, "USE_REFPOINT",IF_CANNOT_HIDE);
	AI.PushGoal("squad_hide_with_player","usecover",1,COVER_HIDE,30000,30000,1);
	AI.PushGoal("squad_hide_with_player", "branch", 1, "END",BRANCH_ALWAYS);
	AI.PushLabel("squad_hide_with_player","USE_REFPOINT");
	AI.PushGoal("squad_hide_with_player","locate",0,"refpoint");
	AI.PushGoal("squad_hide_with_player","+approach",1,0.3,AILASTOPRES_USE);
	AI.PushLabel("squad_hide_with_player","END");
	AI.PushGoal("squad_hide_with_player","signal",0,1,"REFPOINT_REACHED",SIGNALFILTER_SENDER);		


	AI.CreateGoalPipe("squad_short_cover_fire");
	AI.PushGoal("squad_short_cover_fire", "branch", 1, "NOTARGET", IF_NO_ENEMY_TARGET);
	AI.PushGoal("squad_short_cover_fire", "branch", 1, "FIRE", BRANCH_ALWAYS);
	AI.PushLabel("squad_short_cover_fire","NOTARGET");
	AI.PushGoal("squad_short_cover_fire", "devalue", 1, 0);
	AI.PushGoal("squad_short_cover_fire", "acqtarget", 1, "beacon");
	AI.PushGoal("squad_short_cover_fire", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushLabel("squad_short_cover_fire","FIRE");
	AI.PushGoal("squad_short_cover_fire","firecmd",0,1);
	AI.PushGoal("squad_short_cover_fire", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("squad_short_cover_fire","timeout",1,3,4);
	AI.PushGoal("squad_short_cover_fire", "signal", 1, 1, "END_SHORT_COVER_FIRE", SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("squad_close_fire");
	AI.PushGoal("squad_close_fire","firecmd",0,FIREMODE_CONTINUOUS);
	AI.PushGoal("squad_close_fire","timeout",1,2,3);
	AI.PushGoal("squad_close_fire","firecmd",0,0);
	AI.PushGoal("squad_close_fire","timeout",1,0.2,0.4);
	AI.PushGoal("squad_close_fire", "signal", 0, 1, "END_CLOSE_FIRE", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("squad_follow_fire");
	AI.PushGoal("squad_follow_fire", "run", 1, 1.5);
	AI.PushGoal("squad_follow_fire", "branch", 1, "NOTARGET", IF_NO_ENEMY_TARGET);
	AI.PushGoal("squad_follow_fire", "branch", 1, "FORM", BRANCH_ALWAYS);
	AI.PushLabel("squad_follow_fire","NOTARGET");
	AI.PushGoal("squad_follow_fire", "acqtarget", 1, "beacon");
	AI.PushLabel("squad_follow_fire","FORM");
	AI.PushGoal("squad_follow_fire", "locate", 1, "formation");
	--AI.PushGoal("squad_follow_fire", "firecmd",0,1);
	AI.PushGoal("squad_follow_fire", "stick", 1, 1,AILASTOPRES_USE);--,1);


	AI.CreateGoalPipe("squad_short_blind_fire");
	AI.PushGoal("squad_short_blind_fire", "ignoreall", 1, 0);
	AI.PushGoal("squad_short_blind_fire", "acqtarget", 0, "refpoint");
	AI.PushGoal("squad_short_blind_fire", "bodypos", 0, BODYPOS_CROUCH);
--	AI.PushGoal("squad_short_blind_fire","firecmd",0,FIREMODE_FORCED);
	AI.PushGoal("squad_short_blind_fire","firecmd",0,FIREMODE_BURST);
	AI.PushGoal("squad_short_blind_fire","timeout",1,1.7,2.4);
	AI.PushGoal("squad_short_blind_fire","firecmd",0,0);
	AI.PushGoal("squad_short_blind_fire", "signal", 0, 1, "END_SHORT_BLIND_FIRE", SIGNALFILTER_SENDER);

	
	AI.CreateGoalPipe("squad_reposition");
	AI.PushGoal("squad_reposition", "ignoreall", 1, 0);
	AI.PushGoal("squad_reposition","strafe",1,10);
--	AI.PushGoal("squad_reposition", "run", 0, 0);
--	AI.PushGoal("squad_reposition", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("squad_reposition","branch",0,"NOTARGET",IF_NO_ENEMY_TARGET);
	AI.PushGoal("squad_reposition","branch",0,"MOVE",BRANCH_ALWAYS);
	AI.PushLabel("squad_reposition","NOTARGET");
	AI.PushGoal("squad_reposition","acqtarget",0,"beacon");
	AI.PushLabel("squad_reposition","MOVE");
	AI.PushGoal("squad_reposition","locate",0,"refpoint");
	AI.PushGoal("squad_reposition","approach",0,1,AILASTOPRES_USE);
	AI.PushLabel("squad_reposition","ADVANCE");
	AI.PushGoal("squad_reposition","timeout",1,0.8,1.2);
	AI.PushGoal("squad_reposition","lookat",1,10,30);
	AI.PushGoal("squad_reposition", "signal", 1, 1, "SMART_THROW_GRENADE", SIGNALFILTER_SENDER);
	AI.PushGoal("squad_reposition","timeout",1,0.8,1.2);
	AI.PushGoal("squad_reposition","lookat",1,-30,10);
	AI.PushGoal("squad_reposition", "branch", 1, "ADVANCE", IF_ACTIVE_GOALS);
	AI.PushGoal("squad_reposition","lookat",1,-500);
	AI.PushGoal("squad_reposition", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("squad_reposition","firecmd",0,0);
	AI.PushGoal("squad_reposition","acqtarget",0,"beacon");
	AI.PushGoal("squad_reposition","timeout",1,0.3,0.6);
	AI.PushGoal("squad_reposition","lookat",1,30,45);
	AI.PushGoal("squad_reposition","timeout",1,0.5,0.8);
	AI.PushGoal("squad_reposition","lookat",1,-45,-30);
	AI.PushGoal("squad_reposition","timeout",1,0.5,0.8);
	AI.PushGoal("squad_reposition","lookat",1,-500);
	AI.PushGoal("squad_reposition", "signal", 0, 1, "END_REPOSITION", SIGNALFILTER_SENDER);

	AI.CreateGoalPipe("unhide_peek_left");
	AI.PushGoal("unhide_peek_left", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhide_peek_left","timeout",1,1,1.6);
	AI.PushGoal("unhide_peek_left","strafe",0,10,0);
	--AI.PushGoal("unhide_peek_left","run",0,1);
	AI.PushGoal("unhide_peek_left","firecmd",0,0);
	-- get out of the cover
	AI.PushGoal("unhide_peek_left","locate",0,"last_hideobject");
	AI.PushGoal("unhide_peek_left","backoff",0,2,0,AI_MOVE_LEFT+AILASTOPRES_USE);
	AI.PushGoal("unhide_peek_left","timeout",1,1.8,2.1);
	AI.PushLabel("unhide_peek_left","DONE");
		AI.PushGoal("unhide_peek_left","branch", 1, "SEE_TARGET", IF_CAN_SHOOT_TARGET, 25);
		AI.PushGoal("unhide_peek_left","branch", 1, "DONE", IF_ACTIVE_GOALS);
		-- can't shoot target
		--AI.PushGoal("unhide_peek_left","clear",0,0);
		AI.PushGoal("unhide_peek_left","branch", 1, "PEEK", BRANCH_ALWAYS);
	AI.PushLabel("unhide_peek_left","SEE_TARGET");
	AI.PushGoal("unhide_peek_left","animation",1,AIANIM_ACTION,"idle");
	AI.PushGoal("unhide_peek_left","clear",0,0);
	AI.PushGoal("unhide_peek_left", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhide_peek_left","firecmd",0,1);
	AI.PushGoal("unhide_peek_left","timeout",1,1.1,1.6);
	AI.PushGoal("unhide_peek_left", "signal", 0, 1, "END_UNHIDE", SIGNALFILTER_SENDER);
	AI.PushGoal("unhide_peek_left", "branch", 1, "END", BRANCH_ALWAYS);
	-- peek if the head is not exposed
	AI.PushLabel("unhide_peek_left","PEEK");
	AI.PushGoal("unhide_peek_left","firecmd",0,1);
	AI.PushGoal("unhide_peek_left", "branch", 1, "IS_EXPOSED", IF_EXPOSED_TO_TARGET, 3, 0.5);
		AI.PushGoal("unhide_peek_left","timeout",0,3);
		AI.PushLabel("unhide_peek_left","PEEK2");
			AI.PushGoal("unhide_peek_left","branch", 1, "SEE_TARGET", IF_CAN_SHOOT_TARGET, 25);
			AI.PushGoal("unhide_peek_left","branch", 1, "PEEK2", IF_ACTIVE_GOALS);
		AI.PushGoal("unhide_peek_left","animation",1,AIANIM_ACTION,"idle");
	AI.PushLabel("unhide_peek_left","IS_EXPOSED");
	AI.PushGoal("unhide_peek_left","clear",0,0);
--	AI.PushGoal("unhide_peek_left","timeout",1,1,1.5);
	AI.PushGoal("unhide_peek_left", "signal", 0, 1, "END_UNHIDE", SIGNALFILTER_SENDER);
--	AI.PushGoal("unhide_peek_left","unhide_and_fire");
	AI.PushLabel("unhide_peek_left","END");
	AI.PushGoal("unhide_peek_left","firecmd",0,0);

	AI.CreateGoalPipe("unhide_peek_right");
	AI.PushGoal("unhide_peek_right", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhide_peek_right","timeout",1,1,1.6);
	AI.PushGoal("unhide_peek_right","strafe",0,10,0);
	--AI.PushGoal("unhide_peek_right","run",0,1);
	AI.PushGoal("unhide_peek_right","firecmd",0,0);
	-- get out of the cover
	AI.PushGoal("unhide_peek_right","locate",0,"last_hideobject");
	AI.PushGoal("unhide_peek_right","backoff",0,2,0,AI_MOVE_RIGHT+AILASTOPRES_USE);
	AI.PushGoal("unhide_peek_right","timeout",1,1.8,2.1);
	AI.PushLabel("unhide_peek_right","DONE");
		AI.PushGoal("unhide_peek_right","branch", 1, "SEE_TARGET", IF_CAN_SHOOT_TARGET, 25);
		AI.PushGoal("unhide_peek_right","branch", 1, "DONE", IF_ACTIVE_GOALS);
		-- can't shoot target
		--AI.PushGoal("unhide_peek_right","clear",0,0);
		AI.PushGoal("unhide_peek_right","branch", 1, "PEEK", BRANCH_ALWAYS);
	AI.PushLabel("unhide_peek_right","SEE_TARGET");
	AI.PushGoal("unhide_peek_right","animation",1,AIANIM_ACTION,"idle");
	AI.PushGoal("unhide_peek_right","clear",0,0);
	AI.PushGoal("unhide_peek_right", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhide_peek_right","firecmd",0,1);
	AI.PushGoal("unhide_peek_right","timeout",1,1.1,1.6);
	AI.PushGoal("unhide_peek_right", "signal", 0, 1, "END_UNHIDE", SIGNALFILTER_SENDER);
	AI.PushGoal("unhide_peek_right", "branch", 1, "END", BRANCH_ALWAYS);
	-- peek if the head is not exposed
	AI.PushLabel("unhide_peek_right","PEEK");
	AI.PushGoal("unhide_peek_right","firecmd",0,1);
	AI.PushGoal("unhide_peek_right", "branch", 1, "IS_EXPOSED", IF_EXPOSED_TO_TARGET, 3, 0.5);
		AI.PushGoal("unhide_peek_right","animation",1,AIANIM_ACTION,"peekRight");
		AI.PushGoal("unhide_peek_right","timeout",0,3);
		AI.PushLabel("unhide_peek_right","PEEK2");
			AI.PushGoal("unhide_peek_right","branch", 1, "SEE_TARGET", IF_CAN_SHOOT_TARGET, 25);
			AI.PushGoal("unhide_peek_right","branch", 1, "PEEK2", IF_ACTIVE_GOALS);
			AI.PushGoal("unhide_peek_right","animation",1,AIANIM_ACTION,"idle");
	AI.PushLabel("unhide_peek_right","IS_EXPOSED");
	AI.PushGoal("unhide_peek_right","clear",0,0);
--	AI.PushGoal("unhide_peek_right","timeout",1,1,1.5);
	AI.PushGoal("unhide_peek_right","firecmd",0,0);
	--AI.PushGoal("unhide_peek_right","unhide_and_fire");
	AI.PushGoal("unhide_peek_right", "signal", 0, 1, "END_UNHIDE", SIGNALFILTER_SENDER);
	AI.PushLabel("unhide_peek_right","END");

	AI.CreateGoalPipe("squad_wait_hidden");
	AI.PushGoal("squad_wait_hidden","timeout",1,2.5,3);
	AI.PushGoal("squad_wait_hidden", "signal", 0, 1, "END_UNHIDE", SIGNALFILTER_SENDER);


	AI.CreateGoalPipe("unhidden_fire");
	AI.PushGoal("unhidden_fire", "firecmd", 0, 1);
	AI.PushGoal("unhidden_fire", "+bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("unhidden_fire", "+timeout", 1, 1.1,1.7);
	AI.PushGoal("unhidden_fire", "firecmd", 0, 0);
	AI.PushGoal("unhidden_fire", "signal", 0, 10, "END_UNHIDE", SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("hostage_hide");
	AI.PushGoal("hostage_hide","signal",1,1,"START_HIDE",SIGNALFILTER_SENDER);
	AI.PushGoal("hostage_hide","acqtarget",0,"beacon");
	AI.PushGoal("hostage_hide","+run",0,1.5);
	AI.PushGoal("hostage_hide", "+bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("hostage_hide","+locate",0,"player");
	AI.PushGoal("hostage_hide","+hide",1,7,HM_NEAREST+HM_AROUND_LASTOP+HM_BACK);
	AI.PushGoal("hostage_hide", "branch", 1, "NOHIDE2",IF_CANNOT_HIDE);
	AI.PushGoal("hostage_hide","signal",1,1,"END_HIDE",SIGNALFILTER_SENDER);
	AI.PushGoal("hostage_hide", "branch", 1, "END",BRANCH_ALWAYS);
	AI.PushLabel("hostage_hide","NOHIDE2");
	AI.PushGoal("hostage_hide","locate",0,"formation");
	AI.PushGoal("hostage_hide","+stick", 1, 0.0, AILASTOPRES_USE,1);
	AI.PushGoal("hostage_hide","signal",1,1,"HIDE_FAILED",SIGNALFILTER_SENDER);
	AI.PushGoal("hostage_hide","locate",0,"formation");
	AI.PushGoal("hostage_hide","+stick", 1, 0.0, AILASTOPRES_USE);
	AI.PushLabel("hostage_hide","END");


	AI.CreateGoalPipe("hostage_stay_hidden");
	--AI.PushGoal("hostage_stay_hidden", "bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("hostage_stay_hidden","animation", 1, AIANIM_ACTION, "cower");
	AI.PushGoal("hostage_stay_hidden", "branch", 1, "HIDE", IF_COVER_COMPROMISED);
	AI.PushGoal("hostage_stay_hidden", "timeout", 1, 4,4.7);
	AI.PushLabel("hostage_stay_hidden","HIDE");
	AI.PushGoal("hostage_stay_hidden","hide",1,4,HM_NEAREST);

	AI.CreateGoalPipe("hostage_hide_short");
	AI.PushGoal("hostage_hide_short","run",0,1);
--	AI.PushGoal("hostage_hide", "+bodypos", 0, BODYPOS_STEALTH);
	AI.PushGoal("hostage_hide_short", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("hostage_hide_short","hide",1,4,HM_NEAREST);
	AI.PushGoal("hostage_hide_short", "branch", 1, "NOHIDE",IF_CANNOT_HIDE);
	AI.PushGoal("hostage_hide_short", "+bodypos", 0, BODYPOS_CROUCH);
	AI.PushGoal("hostage_hide_short", "timeout", 1, 4,4.7);
	AI.PushGoal("hostage_hide_short", "branch", 1, "END",BRANCH_ALWAYS);
	AI.PushLabel("hostage_hide_short","NOHIDE");
--	AI.PushGoal("hostage_hide_short", "+bodypos", 0, BODYPOS_PRONE);
	AI.PushGoal("hostage_hide_short","animation", 0,AIANIM_ACTION, "cower");
	AI.PushGoal("hostage_hide_short", "timeout", 1, 4);
	AI.PushGoal("hostage_hide_short","clear", 1,0);
	AI.PushGoal("hostage_hide_short","animation", 1,AIANIM_ACTION, "idle");
	AI.PushLabel("hostage_hide_short","END");

--	AI.CreateGoalPipe("hostage_join_player");
--	AI.PushGoal("hostage_join_player","signal",1,10,"OnUnitResumed",SIGNALFILTER_LEADER);
--	AI.PushGoal("hostage_join_player", "timeout", 1, 0.5); --wait for leader to process the signal


	AI.CreateGoalPipe("hostage_retrieve_object");
	AI.PushGoal("hostage_retrieve_object","run",1,1);
	AI.PushGoal("hostage_retrieve_object","approach",1,0.5,AILASTOPRES_USE);
	
	AI.CreateGoalPipe("hostage_cower");
--	AI.PushGoal("hostage_cower", "bodypos", 0, BODYPOS_STAND);
	AI.PushGoal("hostage_cower","animation", 0, AIANIM_ACTION, "cower");
	AI.PushGoal("hostage_cower","waitsignal", 1, "END_COWER" );
	AI.PushGoal("hostage_cower","clear", 1,0);
	AI.PushGoal("hostage_cower","animation", 1, AIANIM_ACTION, "idle" );
	--AI.PushGoal("hostage_cower","signal", 1,1, "END_COWER",SIGNALFILTER_SENDER);
	
	AI.CreateGoalPipe("hostage_wait_for_player");
	AI.PushGoal("hostage_wait_for_player","acqtarget", 1, "player" );
	AI.PushGoal("hostage_wait_for_player","waitsignal", 1, "CONTINUE" );
	
	AI.CreateGoalPipe("form_and_hold");
	AI.PushGoal("form_and_hold","clear",0);
	AI.PushGoal("form_and_hold","ignoreall",0,1);
--	AI.PushGoal("form_and_hold","locate",0,"refpoint");
	AI.PushGoal("form_and_hold","signal",0,1,"SET_TIMEOUT",SIGNALFILTER_SENDER);		
	AI.PushGoal("form_and_hold","bodypos",0,BODYPOS_STAND);
	AI.PushGoal("form_and_hold","run",0,1);
	AI.PushGoal("form_and_hold","pathfind",1,"refpoint");
	AI.PushGoal("form_and_hold","branch",1,-2);
	AI.PushGoal("form_and_hold","trace",0,1);
	--AI.PushGoal("form_and_hold","approach",0,1,AILASTOPRES_USE);
	AI.PushGoal("form_and_hold","timeout",1,0.5);
	AI.PushGoal("form_and_hold","branch",1,-1);
	AI.PushGoal("form_and_hold","signal",0,1,"FORMATION_REACHED",SIGNALFILTER_SENDER);		
	AI.PushGoal("form_and_hold","ignoreall",0,0);

	AI.CreateGoalPipe("squad_follow_lookaround_start");
	AI.PushGoal("squad_follow_lookaround_start","clear",1,1);
	AI.PushGoal("squad_follow_lookaround_start","bodypos",1,BODYPOS_CROUCH);
	AI.PushGoal("squad_follow_lookaround_start","locate",1,"refpoint");
	AI.PushGoal("squad_follow_lookaround_start","lookat",0,0,0,1);--lookat lastop
	AI.PushGoal("squad_follow_lookaround_start","timeout",1,0.8,0.9);
	
	AI.CreateGoalPipe("squad_follow_lookaround");
	AI.PushGoal("squad_follow_lookaround","lookaround",1,90,3,2,4);
	
	AI.CreateGoalPipe("squad_follow_lookaround_indoor_start");
	AI.PushGoal("squad_follow_lookaround_indoor_start","clear",1,1);

	AI.CreateGoalPipe("squad_follow_lookaround_indoor");
	--AI.PushGoal("squad_follow_lookaround_indoor","bodypos",1,BODYPOS_CROUCH);
	AI.PushGoal("squad_follow_lookaround_indoor","lookaround",1,120,3,2,4);
	
end
