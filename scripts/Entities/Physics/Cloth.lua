Cloth = 
{
	Server = {},
	Client = {},

	Properties=
	{
		mass = 5,
		density = 200,

		fileModel="objects/library/architecture/aircraftcarrier/props/misc/medbay_curtain.cgf",
		gravity={x=0,y=0,z=-9.8},
		damping = 0.3,
		max_time_step = 0.02,
		sleep_speed = 0.01,
		thickness = 0.06,
		friction = 0,
		hardness = 20,
		air_resistance = 0,
		wind = {x=0,y=0,z=0},
		wind_event = {x=0,y=10,z=0},
		wind_variance = 0.2,
		max_iters = 20,
		accuracy = 0.05,
		water_resistance = 600,	
		impulse_scale = 0.02,
		explosion_scale = 0.003,
		collision_impulse_scale = 1.0,
		max_collision_impulse = 160,
		mass_decay = 0,
		stiffness_norm = 0,
		stiffness_tang = 0,
		attach_radius = 0,
		bCollideWithTerrain = 0,
		bCollideWithStatics = 1,
		bCollideWithPhysical = 1,
		bCollideWithPlayers = 1,
		max_safe_step = 0.2,
	},
	id_attach_to = -1,
	id_part_attach_to = -1,

	Editor=
	{
		--Model="Objects/Editor/LightSphear.cgf",
		Icon="physicsobject.bmp",
	},
}

function Cloth:OnReset()
	local PhysParams = {};
	PhysParams.density = self.Properties.density;
	PhysParams.mass = self.Properties.mass;

	self:LoadSubObject(0, self.Properties.fileModel, "cloth");

	if (self.Properties.attach_radius>0) then
	  local ents = Physics.SamplePhysEnvironment(self:GetPos(), self.Properties.attach_radius, 
																							 ent_static+ent_rigid+ent_sleeping_rigid+ent_independent);
		if (ents[3]) then
			PhysParams.AttachmentId = ents[3];
			PhysParams.AttachmentPartId = ents[2];
		end
	end
	self:Physicalize(0, PE_SOFT, PhysParams);
  self:SetPhysicParams(PHYSICPARAM_SIMULATION, self.Properties );
	self:SetPhysicParams(PHYSICPARAM_BUOYANCY, self.Properties );
	self:SetPhysicParams(PHYSICPARAM_SOFTBODY, self.Properties );

	local CollParams = { collision_mask = 0 };
	if self.Properties.bCollideWithTerrain==1 then CollParams.collision_mask = CollParams.collision_mask+ent_terrain; end
	if self.Properties.bCollideWithStatics==1 then CollParams.collision_mask = CollParams.collision_mask+ent_static; end
	if self.Properties.bCollideWithPhysical==1 then CollParams.collision_mask = CollParams.collision_mask+ent_rigid+ent_sleeping_rigid; end
	if self.Properties.bCollideWithPlayers==1 then CollParams.collision_mask = CollParams.collision_mask+ent_living; end
	self:SetPhysicParams(PHYSICPARAM_SOFTBODY, CollParams );
	if LengthSqVector(self.Properties.wind)*self.Properties.air_resistance>0 then
		self:AwakePhysics(1);
	else
		self:AwakePhysics(0);
	end
end

function Cloth:OnSpawn()
	self:OnReset();
end

function Cloth.Server:OnStartGame()
	self:OnReset();
end

function Cloth:OnPropertyChange()
	self:OnReset();
end

function Cloth:OnDamage( hit )

--	System:LogToConsole("dir="..hit.dir.x..","..hit.dir.y..","..hit.dir.z);
--	System:LogToConsole("pos="..hit.pos.x..","..hit.pos.y..","..hit.pos.z);
--	System:LogToConsole("impact_force="..hit.impact_force_mul);

	if( hit.ipart ) then
		self:AddImpulse( hit.ipart, hit.pos, hit.dir, hit.impact_force_mul );
	else	
		self:AddImpulse( -1, hit.pos, hit.dir, hit.impact_force_mul );
	end	
end

function Cloth:OnInit()
	self:OnReset();
end


function Cloth:OnShutDown()
end


function Cloth:Event_WindOn(sender)
	local windparam = { wind = {x=0,y=0,z=0} };
	CopyVector(windparam.wind, self.Properties.wind_event);
	self:SetPhysicParams(PHYSICPARAM_SOFTBODY, windparam );
end

function Cloth:Event_WindOff(sender)
	local windparam = { wind = {x=0,y=0,z=0} };
	CopyVector(windparam.wind, self.Properties.wind);
	self:SetPhysicParams(PHYSICPARAM_SOFTBODY, windparam );
end

Cloth.FlowEvents =
{
	Inputs =
	{
		WindOn = { Cloth.Event_WindOn, "bool" },
		WindOff = { Cloth.Event_WindOff, "bool" },
	},
	Outputs =
	{
		WindOn = "bool",
		WindOff = "bool",
	},
}
