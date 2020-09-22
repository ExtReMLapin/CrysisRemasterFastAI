Fish = {
  type = "Fish",
  MapVisMask = 0,
	ENTITY_DETAIL_ID=1,

	Properties = {
		Flocking =
		{
			bEnableFlocking = 0,
			FieldOfViewAngle = 250,
			FactorAlign = 0,
			FactorCohesion = 1,
			FactorSeparation = 10,
			AttractDistMin = 5,
			AttractDistMax = 20,
		},
		Movement =
		{
			HeightMin = 1,
			HeightMax = 20,
			SpeedMin = 2,
			SpeedMax = 8,
			FactorOrigin = 0.1,
			FactorHeight = 0.4,
			FactorAvoidLand = 10,
			FactorRandomAcceleration = 2,
			MaxAnimSpeed = 1.7,
		},
		Boid = 
		{
			nCount = 10,
			object_Model = "objects/characters/animals/birds/tern/tern.chr",
			Size = 1,
			SizeRandom = 0,
			--Radius = 0.5,
			gravity_at_death = -9.81,
			Mass = 10,
		},
		Options = 
		{
			bFollowPlayer = 0,
			bNoLanding = 0,
			bObstacleAvoidance = 0,
			VisibilityDist = 30,
			bActivate = 0,
			Radius = 20,
		},
	},
	
	BubblesEffect = "water.bubbles.fish", --underwater bubbles for fish breathing
	SplashEffect = "water.body_splash.enter_water", --Splash when fish touches water surface


	Editor = {
		Icon = "Fish.bmp"
	},
	params={x=0,y=0,z=0},
	bubble_pos={x=0,y=0,z=0},
	bubble_dir={x=0,y=0,z=1},
}

-------------------------------------------------------
--function Birds:OnLoad(table)
--end

-------------------------------------------------------
--function Birds:OnSave(table)
--end

function Fish:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

-------------------------------------------------------
function Fish:OnInit()

	self:NetPresent(0);
	--self:EnableSave(1);		

	self.flock = 0;
	self:CreateFlock();
	if (self.Properties.Options.bActivate ~= 1 and self.flock ~= 0) then
		Boids.EnableFlock( self,0 );
	end

	self:SendProceedFadeAreaEventAlways(false);
end

-------------------------------------------------------
function Fish:OnShutDown()
end

-------------------------------------------------------
function Fish:CreateFlock()
	local Flocking = self.Properties.Flocking;
	local Movement = self.Properties.Movement;
	local Boid = self.Properties.Boid;
	local Options = self.Properties.Options;

	local params = self.params;

	params.count = Boid.nCount;
	params.model = Boid.object_Model;

	params.boid_size = Boid.Size;
	params.boid_size_random = Boid.SizeRandom;
	params.min_height = Movement.HeightMin;
	params.max_height = Movement.HeightMax;
	params.min_attract_distance = Flocking.AttractDistMin;
	params.max_attract_distance = Flocking.AttractDistMax;
	params.min_speed = Movement.SpeedMin;
	params.max_speed = Movement.SpeedMax;
	
	if (Flocking.bEnableFlocking == 1) then
		params.factor_align = Flocking.FactorAlign;
	else
		params.factor_align = 0;
	end
	params.factor_cohesion = Flocking.FactorCohesion;
	params.factor_separation = Flocking.FactorSeparation;
	params.factor_origin = Movement.FactorOrigin;
	params.factor_keep_height = Movement.FactorHeight;
	params.factor_avoid_land = Movement.FactorAvoidLand;
	params.factor_random_accel = Movement.FactorRandomAcceleration;
	
	params.spawn_radius = Options.Radius;
	--params.boid_radius = Boid.boid_radius;
	params.gravity_at_death = Boid.gravity_at_death;
	params.boid_mass = Boid.Mass;

	params.fov_angle = Flocking.FieldOfViewAngle;

	params.max_anim_speed = Movement.MaxAnimSpeed;
	params.follow_player = Options.bFollowPlayer;
	params.no_landing = Options.bNoLanding;
	params.avoid_obstacles = Options.bObstacleAvoidance;
	params.max_view_distance = Options.VisibilityDist;
	
	if (self.flock == 0) then
		self.flock = 1;
		Boids.CreateFlock( self, Boids.FLOCK_FISH, params );
	end
	if (self.flock ~= 0) then
		Boids.SetFlockParams( self, params );
	end
end

-------------------------------------------------------
function Fish:OnPropertyChange()
	self:CreateFlock();
end

-------------------------------------------------------
function Fish:OnSpawnBubble( pos )
	Particle.SpawnEffect( self.BubblesEffect,pos,self.bubble_dir );
end
-------------------------------------------------------
function Fish:OnSpawnSplash( pos )
	Particle.SpawnEffect( self.SplashEffect,pos,self.bubble_dir );
end

-------------------------------------------------------
function Fish:Event_Activate()
	if (self.flock ~= 0) then
		Boids.EnableFlock( self,1 );
	end
end

-------------------------------------------------------
function Fish:Event_Deactivate()
	if (self.flock ~= 0) then
		Boids.EnableFlock( self,0 );
	end
end

function Fish:OnProceedFadeArea( player,areaId,fadeCoeff )
	if (self.flock ~= 0) then
		Boids.SetFlockPercentEnabled( self,fadeCoeff*100 );
	end
end

Fish.FlowEvents =
{
	Inputs =
	{
		Activate = { Fish.Event_Activate, "bool" },
		Deactivate = { Fish.Event_Deactivate, "bool" },
	},
	Outputs =
	{
		Activate = "bool",
		Deactivate = "bool",
	},
}
