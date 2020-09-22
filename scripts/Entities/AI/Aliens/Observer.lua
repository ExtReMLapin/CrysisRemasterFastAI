Script.ReloadScript( "SCRIPTS/Entities/AI/Aliens/Observer_x.lua");

CreateAlien(Observer_x);
Observer = CreateAI(Observer_x)
Observer:Expose();
