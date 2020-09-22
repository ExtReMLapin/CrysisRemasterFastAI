Script.ReloadScript( "SCRIPTS/Entities/AI/Shared/BasicAI.lua");
Script.ReloadScript( "SCRIPTS/Entities/AI/Aliens/Alien_x.lua");

CreateAlien(Alien_x);
Alien=CreateAI(Alien_x);
Alien:Expose();
