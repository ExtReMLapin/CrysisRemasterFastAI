
function PipeManager:OnInitCombat()


---------------leans waiting on animation not currently called from combat manager	
	AI.CreateGoalPipe("LeanRight");
	AI.PushGoal("LeanRight","Trace_Anchor");
	AI.PushGoal("LeanRight","firecmd",0,0);
	AI.PushGoal("LeanRight","signal",0,1,"SHARED_LEAN_RIGHT",0);
	AI.PushGoal("LeanRight","firecmd",0,1);
	AI.PushGoal("LeanRight","timeout",1,0.5);
		
	AI.CreateGoalPipe("LeanLeft");
	AI.PushGoal("LeanRight","Trace_Anchor");
	AI.PushGoal("LeanLeft","firecmd",0,0);
	AI.PushGoal("LeanLeft","signal",0,1,"SHARED_LEAN_LEFT",0);
	AI.PushGoal("LeanLeft","firecmd",0,1);
	AI.PushGoal("LeanLeft","timeout",1,0.5);
	
	AI.CreateGoalPipe("ComeOut_Right");
	AI.PushGoal("ComeOut_Right","Trace_Anchor");
	AI.PushGoal("ComeOut_Right","firecmd",0,0);
	AI.PushGoal("ComeOut_Right","strafe",0,1);
	AI.PushGoal("ComeOut_Right","firecmd",0,1);
	AI.PushGoal("ComeOut_Right","timeout",1,0.5);
	AI.PushGoal("ComeOut_Right","strafe",0,0);
			
	AI.CreateGoalPipe("ComeOut_Left");
	AI.PushGoal("ComeOut_Left","Trace_Anchor");
	AI.PushGoal("ComeOut_Left","firecmd",0,0);
	AI.PushGoal("ComeOut_Left","strafe",0,-1);
	AI.PushGoal("ComeOut_Left","firecmd",0,1);
	AI.PushGoal("ComeOut_Left","timeout",1,0.5);
	AI.PushGoal("ComeOut_Left","strafe",0,0);
	
	AI.CreateGoalPipe("Shootspot");
	AI.PushGoal("Shootspot","Trace_Anchor");
	AI.PushGoal("Shootspot","bodypos",0,0);
	AI.PushGoal("Shootspot","firecmd",0,1);
	AI.PushGoal("Shootspot","timeout",1,0.5,1);
	AI.PushGoal("Shootspot","bodypos",0,1);
	AI.PushGoal("Shootspot","firecmd",0,1);
	AI.PushGoal("Shootspot","timeout",1,0.5,3);
		
	AI.CreateGoalPipe("Trace_Anchor");
	AI.PushGoal("Trace_Anchor","pathfind",1,"");
	AI.PushGoal("Trace_Anchor","trace",1,1);
	AI.PushGoal("Trace_Anchor","lookat",0,0,0);
	

	AI.CreateGoalPipe("RunToTrigger");
	AI.PushGoal("RunToTrigger","ignoreall",1,1);
	AI.PushGoal("RunToTrigger","bodypos",0,0);
	AI.PushGoal("RunToTrigger","run",0,1);
	AI.PushGoal("RunToTrigger","pathfind",1,"");
	AI.PushGoal("RunToTrigger","trace",1,1);
	AI.PushGoal("RunToTrigger","lookat",0,0,0);
 	AI.PushGoal("RunToTrigger","approach",0,.5);	
	AI.PushGoal("RunToTrigger","signal",0,1,"REACHED_TRIGGER",SIGNALFILTER_GROUPONLY);
	AI.PushGoal("RunToTrigger","timeout",1,2);
	AI.PushGoal("RunToTrigger","ignoreall",1,0);
	AI.PushGoal("RunToTrigger","signal",0,1,"PathDone",0);
	
	------Crouch--------------------------------------
	AI.CreateGoalPipe("Crouch_ComeOut_Left");
	AI.PushGoal("Crouch_ComeOut_Left","bodypos",0,1);
	AI.PushGoal("Crouch_ComeOut_Left","ComeOut_Left");

	AI.CreateGoalPipe("Crouch_ComeOut_Right");
	AI.PushGoal("Crouch_ComeOut_Right","bodypos",0,1);
	AI.PushGoal("Crouch_ComeOut_Right","ComeOut_Right");
	

	AI.CreateGoalPipe("Crouch_ThrowGrenade");
	AI.PushGoal("Crouch_ThrowGrenade","bodypos",0,1);
	AI.PushGoal("Crouch_ThrowGrenade","Trace_Anchor");
	AI.PushGoal("Crouch_ThrowGrenade","throw_grenade");	
			
	AI.CreateGoalPipe("approach_rpg_spot");
	AI.PushGoal("approach_rpg_spot","ignoreall",0,1);
	AI.PushGoal("approach_rpg_spot","approach",0,1.1,AILASTOPRES_USE);
	AI.PushGoal("approach_rpg_spot","locate",0,"refpoint");
	AI.PushGoal("approach_rpg_spot","acqtarget",0,"");
	AI.PushGoal("approach_rpg_spot","branch",1,-2);
	AI.PushGoal("approach_rpg_spot","signal",0,1,"RPG_SPOT_REACHED",SIGNALFILTER_SENDER);		


							
	AI.LogEvent("COMBAT PIPES LOADED");
end


