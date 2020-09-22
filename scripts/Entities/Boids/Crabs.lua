Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Crabs = {
	Properties = {
	},
	Sounds = 
	{
                          "Sounds/physics:animals:crab_idle",   -- idle
                          "Sounds/physics:animals:crab_idle",  -- scared
                          "Sounds/physics:animals:crab_idle",    -- die
                          "Sounds/physics:animals:crab_pickup",  -- pickup
                          "Sounds/physics:animals:crab_idle",  -- throw
	},
	Animations = 
	{
		"walk_loop",   -- walking
		"idle01",      -- idle1
		"idle01",      -- scared anim
		"idle01",      -- idle3
		"idle01",      -- pickup
		"idle01",      -- throw
	},
	Editor = {
		Icon = "Bug.bmp"
	},
}


MakeDerivedEntity( Crabs,Chickens )


function Crabs:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

