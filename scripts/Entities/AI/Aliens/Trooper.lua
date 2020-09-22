Script.ReloadScript( "SCRIPTS/Entities/AI/Aliens/Trooper_x.lua");

CreateAlien(Trooper_x);
Trooper = CreateAI(Trooper_x)
Trooper:Expose();
