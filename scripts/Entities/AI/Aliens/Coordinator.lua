Script.ReloadScript( "SCRIPTS/Entities/AI/Aliens/Coordinator_x.lua");

CreateAlien(Coordinator_x);
Coordinator = CreateAI(Coordinator_x)
Coordinator:Expose();