Script.ReloadScript( "Scripts/Entities/Physics/BasicEntity.lua" );

-- Basic entity
RigidBodyEx = {
	Properties = {
		Physics = {
			bRigidBodyActive = 1,
			bActivateOnDamage = 0,
			bResting = 1, -- If rigid body is originally in resting state.
			bCanBreakOthers = 0,
			Simulation =
			{
				max_time_step = 0.02,
				sleep_speed = 0.04,
				damping = 0,
				bFixedDamping = 0,
				bUseSimpleSolver = 0,
			},
			Buoyancy=
			{
				water_density = 1000,
				water_damping = 0,
				water_resistance = 1000,	
			},
		},
	},
	
			Editor={
		Icon = "physicsobject.bmp",
		IconOnTop=1,
	},
}

local Physics_DX9MP_Simple = {
	bRigidBodyActive = 0,
	bActivateOnDamage = 0,
	bResting = 1, -- If rigid body is originally in resting state.
	Simulation =
	{
		max_time_step = 0.02,
		sleep_speed = 0.04,
		damping = 0,
		bFixedDamping = 0,
		bUseSimpleSolver = 0,
	},
	Buoyancy=
	{
		water_density = 1000,
		water_damping = 0,
		water_resistance = 1000,	
	},
	
}

MakeDerivedEntity( RigidBodyEx,BasicEntity )

-------------------------------------------------------
function RigidBodyEx:OnLoad(table)  
  self.bRigidBodyActive = table.bRigidBodyActive;
end

-------------------------------------------------------
function RigidBodyEx:OnSave(table)  
	table.bRigidBodyActive = self.bRigidBodyActive
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:OnSpawn()
	if (self.Properties.Physics.bRigidBodyActive == 1) then
		self.bRigidBodyActive = 1;
	end
	self:SetFromProperties();	
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:SetFromProperties()
	local Properties = self.Properties;

	if (Properties.object_Model == "") then
		do return end;
	end
	
	self:LoadObject(0,Properties.object_Model);
	self:CharacterUpdateOnRender(0,1); -- If it is a character force it to update on render.
	
	if (Properties.object_ModelFrozen ~= "") then
 		self.frozenModelSlot = self:LoadObject(-1, Properties.object_ModelFrozen);
 		self:DrawSlot(self.frozenModelSlot, 0);
 	else
  	self.frozenModelSlot = nil;
  end
	
	-- Enabling drawing of the slot.
	self:DrawSlot(0,1);
	
	if (Properties.Physics.bPhysicalize == 1) then
		self:PhysicalizeThis();
	end
	
	-- Mark AI hideable flag.
	if (self.Properties.bAutoGenAIHidePts == 1) then
		self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 0); -- set
	else
		self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 2); -- remove
	end
	
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:PhysicalizeThis()
	-- Init physics.
	local physics = self.Properties.Physics;
	if (CryAction.IsImmersivenessEnabled() == 0) then
		physics = Physics_DX9MP_Simple;
	end
	EntityCommon.PhysicalizeRigid( self,0,physics,self.bRigidBodyActive );
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function RigidBodyEx:OnPropertyChange()
	self:SetFromProperties();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function RigidBodyEx:OnReset()
	self:ResetOnUsed()
	
	local PhysProps = self.Properties.Physics;
	if (PhysProps.bPhysicalize == 1) then
		if (self.bRigidBodyActive ~= PhysProps.bRigidBodyActive) then
			self.bRigidBodyActive = PhysProps.bRigidBodyActive;
			self:PhysicalizeThis();
		end
		if (PhysProps.bRigidBody == 1) then
			self:AwakePhysics(1-PhysProps.bResting);
			self.bRigidBodyActive = PhysProps.bRigidBodyActive;
		end		
	end
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:GetFrozenSlot()
	if (self.frozenModelSlot) then
		return self.frozenModelSlot;
	end
	return -1;
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_Remove()
--	self:Hide(1);
	self:DrawSlot(0,0);
	self:DestroyPhysics();
	self:ActivateOutput( "Remove", true );
end


------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_Hide()
	self:Hide(1);
	self:ActivateOutput( "Hide", true );
	--self:DrawObject(0,0);
	--self:DestroyPhysics();
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHide", true );
	--self:DrawObject(0,1);
	--self:SetPhysicsProperties( 1,self.bRigidBodyActive );
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_RagDollize()  
	self:RagDollize(0);
	self:ActivateOutput( "RagDollized", true );
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx.Client:OnPhysicsBreak( vPos,nPartId,nOtherPartId )
	self:ActivateOutput("Break",nPartId+1 );
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx.Client:OnCollision(hit)
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:OnDamage( hit )

	if (self:IsARigidBody() == 1) then
				
		if (self.Properties.Physics.bActivateOnDamage == 1) then
      if (hit.explosion and self:GetState()~="Activated") then
        BroadcastEvent(self, "Activate");
        self:GotoState("AcTivated");
      end
		end
	end

	if( hit.ipart and hit.ipart>=0 ) then
		self:AddImpulse( hit.ipart, hit.pos, hit.dir, hit.impact_force_mul );
	end
end



------------------------------------------------------------------------------------------------------
-- Input events
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_Activate(sender)	
  self:GotoState("Activated");
end

------------------------------------------------------------------------------------------------------
-- Events to switch material Applied to object.
------------------------------------------------------------------------------------------------------
function RigidBodyEx:CommonSwitchToMaterial( numStr )
	if (not self.sOriginalMaterial) then
		self.sOriginalMaterial = self:GetMaterial();
	end
	
	if (self.sOriginalMaterial) then
		--System.Log( "Material: "..self.sOriginalMaterial..numStr );
		self:SetMaterial( self.sOriginalMaterial..numStr );
	end
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_SwitchToMaterialOriginal(sender)
	self:CommonSwitchToMaterial( "" );
end

------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_SwitchToMaterial1(sender)
	self:CommonSwitchToMaterial( "1" );
end
------------------------------------------------------------------------------------------------------
function RigidBodyEx:Event_SwitchToMaterial2(sender)
	self:CommonSwitchToMaterial( "2" );
end

------------------------------------------------------------------------------------------------------
-- Defaul state.
------------------------------------------------------------------------------------------------------
RigidBodyEx.Default = 
{
  OnBeginState = function(self)
    if (self:IsARigidBody()==1) then
      if (self.bRigidBodyActive~=self.Properties.Physics.bRigidBodyActive) then
        self:SetPhysicsProperties( 0,self.Properties.Physics.bRigidBodyActive );
      else
			  self:AwakePhysics(1-self.Properties.Physics.bResting);
		  end  
		end
	end,
	OnDamage = RigidBodyEx.OnDamage,
	OnCollision = RigidBodyEx.OnCollision,
	OnPhysicsBreak = RigidBodyEx.OnPhysicsBreak,
}

------------------------------------------------------------------------------------------------------
-- Activated state.
------------------------------------------------------------------------------------------------------
RigidBodyEx.Activated =
{
	OnBeginState = function(self)
	  if (self:IsARigidBody()==1 and self.bRigidBodyActive==0) then
      self:SetPhysicsProperties( 0,1 );
		  self:AwakePhysics(1);
	  end
	end,
	OnDamage = RigidBodyEx.OnDamage,
	OnCollision = RigidBodyEx.OnCollision,
	OnPhysicsBreak = RigidBodyEx.OnPhysicsBreak,
}

RigidBodyEx.FlowEvents =
{
	Inputs =
	{
		Used = { RigidBodyEx.Event_Used, "bool" },
		EnableUsable = { RigidBodyEx.Event_EnableUsable, "bool" },
		DisableUsable = { RigidBodyEx.Event_DisableUsable, "bool" },
		Activate = { RigidBodyEx.Event_Activate, "bool" },
		Hide = { RigidBodyEx.Event_Hide, "bool" },
		UnHide = { RigidBodyEx.Event_UnHide, "bool" },
		Remove = { RigidBodyEx.Event_Remove, "bool" },
		RagDollize = { RigidBodyEx.Event_RagDollize, "bool" },		
		SwitchToMaterial1 = { RigidBodyEx.Event_SwitchToMaterial1, "bool" },
		SwitchToMaterial2 = { RigidBodyEx.Event_SwitchToMaterial2, "bool" },
		SwitchToMaterialOriginal = { RigidBodyEx.Event_SwitchToMaterialOriginal, "bool" },
	},
	Outputs =
	{
		Used = "bool",
		EnableUsable = "bool",
		DisableUsable = "bool",
		Activate = "bool",
		Hide = "bool",
		UnHide = "bool",
		Remove = "bool",
		RagDollized = "bool",		
		Break = "int",
	},
}

