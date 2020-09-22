Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Plover = {
	Properties = {
	},
	Sounds = 
	{
                          "Sounds/physics:animals:piper_idle",   -- idle
                          "Sounds/physics:animals:piper_scared",  -- scared
                          "Sounds/physics:animals:piper_die",    -- die
                          "Sounds/physics:animals:piper_pickup",  -- pickup
                          "Sounds/physics:animals:piper_throw",  -- throw
	},
	Animations = 
	{
		"walk_loop",   -- walking
		"idle01",      -- idle1
		"idle01",      -- idle2
		"idle01",      -- idle3
		"idle01",      -- pickup
		"idle01",      -- throw
	},
	Editor = {
		Icon = "Bird.bmp"
	},
}

MakeDerivedEntity( Plover,Chickens )


function Plover:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end
