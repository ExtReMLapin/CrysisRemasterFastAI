ParticleEffect = {
	Properties = {
		soclasses_SmartObjectClass = "",
		ParticleEffect="",
		
		bActive=1,							-- Activate on startup
		bPrime=1,								-- Starts in equilibrium state, as if activated in past
		Scale=1,								-- Scale entire effect size.
		SpeedScale=1,						-- Scale particle emission speed
		CountScale=1,						-- Scale particle counts.
		bCountPerUnit=0,				-- Multiply count by attachment extent
		AttachType="",					-- BoundingBox, Physics, Render
		AttachForm="Surface",		-- Vertices, Edges, Surface, Volume
		PulsePeriod=0,					-- Restart continually at this period.

	},
	Editor = {
		Model="Editor/Objects/Particles.cgf",
		Icon="Particles.bmp",
	},
	
	States = { "Active","Idle" },

	Client = {},
	Server = {},
};

-------------------------------------------------------
function ParticleEffect:OnLoad(table)
	if (not table.nParticleSlot) then
		if (self.nParticleSlot) then
			-- need to clear the effect immediately, otherwise it persists for the remainder of it's lifetime between quick reloads
			self:DeleteParticleEmitter(self.nParticleSlot);
			self:FreeSlot(self.nParticleSlot);
			self.nParticleSlot = nil;
		end
		--self:GotoState("Idle");
	elseif (not self.nParticleSlot or self.nParticleSlot ~= table.nParticleSlot) then
		self:GotoState("Idle");
		self.nParticleSlot = self:LoadParticleEffect( table.nParticleSlot, self.Properties.ParticleEffect, self.Properties );
		self:GotoState("Active");
	end
end

-------------------------------------------------------
function ParticleEffect:OnSave(table)
  table.nParticleSlot = self.nParticleSlot;
end

-------------------------------------------------------
function ParticleEffect:OnPropertyChange()
	self:GotoState("");
	self:OnReset();
end

-------------------------------------------------------
function ParticleEffect:OnReset()
	self:GotoState( "Idle" );
	if (self.Properties.bActive ~= 0) then
		self:GotoState( "Active" );
	end
end

------------------------------------------------------------------------------------------------------
function ParticleEffect:Event_Enable()
	self:GotoState( "Active" );
	self:ActivateOutput( "Enable", true );

	self.Client.ClEvent_Enable(self);

end

function ParticleEffect:Event_Disable()
	self:GotoState( "Idle" );
	self:ActivateOutput( "Disable", true );

	self.Client.ClEvent_Disable(self);

end

function ParticleEffect:Event_Restart()
	self:GotoState( "Idle" );
	self:GotoState( "Active" );
	self:ActivateOutput( "Restart", true );

	self.Client.ClEvent_Restart(self);

end

function ParticleEffect:Event_Spawn()
	self:GetDirectionVector(1, g_Vectors.temp_v2); -- 1=forward vector
	Particle.SpawnEffect( self.Properties.ParticleEffect, self:GetPos(g_Vectors.temp_v1), g_Vectors.temp_v2, self.Properties.Scale );
	self:ActivateOutput( "Spawn", true );

	self.Client.ClEvent_Spawn(self);

end

function ParticleEffect:Enable()
	self:GotoState("Active");
	self.Client.ClEvent_Enable(self);
end

function ParticleEffect:Disable()
	self:GotoState("Idle");
	self.Client.ClEvent_Disable(self);
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Active State
-------------------------------------------------------------------------------
ParticleEffect.Active =
{
	OnBeginState = function( self )
	  if (not self.nParticleSlot) then
		  self.nParticleSlot = self:LoadParticleEffect( -1, self.Properties.ParticleEffect, self.Properties );
		end
	end,
	
	OnLeaveArea = function( self,entity,areaId )
		self:GotoState( "Idle" );
	end,
}

-------------------------------------------------------------------------------
-- Idle State
-------------------------------------------------------------------------------
ParticleEffect.Idle =
{
	OnBeginState = function( self )
	  if (self.nParticleSlot) then
		  self:FreeSlot(self.nParticleSlot);
		  self.nParticleSlot = nil;
	  end
	end,

	OnEnterArea = function( self,entity,areaId )
		self:GotoState( "Active" );
	end,
}

-- !!! net and states stuff
function ParticleEffect:DefaultState(cs, state)
	local default=self[state];
	self[cs][state]={
		OnBeginState = default.OnBeginState,
		OnEndState = default.OnEndState,
		OnLeaveArea = default.OnLeaveArea,
		OnEnterArea = default.OnEnterArea,
	}
end
-------------------------------------------------------
ParticleEffect:DefaultState("Server", "Idle");
ParticleEffect:DefaultState("Server", "Active");
ParticleEffect:DefaultState("Client", "Idle");
ParticleEffect:DefaultState("Client", "Active");

-------------------------------------------------------

ParticleEffect.FlowEvents =
{
	Inputs =
	{
		Disable = { ParticleEffect.Event_Disable, "bool" },
		Enable = { ParticleEffect.Event_Enable, "bool" },
		Restart = { ParticleEffect.Event_Restart, "bool" },
		Spawn = { ParticleEffect.Event_Spawn, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		Restart = "bool",
		Spawn = "bool",
	},
}

-------------------------------------------------------
-- client functions
-------------------------------------------------------

-------------------------------------------------------
function ParticleEffect.Client:OnInit()
	self:SetRegisterInSectors(1);
	self:PreLoadParticleEffect( self.Properties.ParticleEffect );
	
	self:SetUpdatePolicy(ENTITY_UPDATE_POT_VISIBLE);
	--self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);

	if (self.Properties.bActive ~= 0) then
		self:GotoState( "Active" );
	else
		self:GotoState( "Idle" );
	end
	--self:NetPresent(nil);
end

-------------------------------------------------------
function ParticleEffect.Client:ClEvent_Spawn()
	if( not CryAction.IsServer() ) then
		self:Event_Spawn();
	end
end
-------------------------------------------------------
function ParticleEffect.Client:ClEvent_Enable()
	if( not CryAction.IsServer() ) then
		self:Event_Enable();
	end
end
-------------------------------------------------------
function ParticleEffect.Client:ClEvent_Disable()
	if( not CryAction.IsServer() ) then
		self:Event_Disable();
	end
end
-------------------------------------------------------
function ParticleEffect.Client:ClEvent_Restart()
	if( not CryAction.IsServer() ) then
		self:Event_Restart();
	end
end
