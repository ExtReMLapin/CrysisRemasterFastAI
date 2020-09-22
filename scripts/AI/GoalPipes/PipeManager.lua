PipeManager =	 {

}


function PipeManager:OnInit()


	AI.LogEvent("PipeManager initialized");
	
	-- need this to let the AISystem know - all the later created pipes are NOT dynamic, don't need to be saved
	AI.CreateGoalPipe("_first_");
	
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerShared.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManager2.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerJob.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerCombat.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PMReusable.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerAlien.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerVehicle.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerTrooper.lua",true,true);
	Script.LoadScript("Scripts/AI/GoalPipes/PMSingle.lua",true,true);	
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerCover2.lua",true,true);	
	Script.LoadScript("Scripts/AI/GoalPipes/PipeManagerSquad.lua",true,true);	
	
	
	PipeManager:OnInitShared();
	PipeManager:OnInit2();
	PipeManager:InitReusable();
	PipeManager:OnInitJob();
	PipeManager:OnInitCombat();
	PipeManager:OnInitAlien();	
	PipeManager:OnInitVehicle();	
	PipeManager:OnInitTrooper();	
	PipeManager:OnInitSingle();
	PipeManager:OnInitCover2();
	PipeManager:InitSquad();
	

	-- goal pipe used as inserted pipe while executing actions. used to temporary suspend previous pipe.
	-- it never ends, but will be forced to end by AI Action system after action execution
	AI.CreateGoalPipe("_action_");
	AI.PushGoal("_action_","timeout",1,0.1);
	AI.PushGoal("_action_","branch",1,-1,BRANCH_ALWAYS);

	-- need this to let the AISystem know - all the later created pipes are dynamic, need to be saved
	AI.CreateGoalPipe("_last_");
	
	
end
