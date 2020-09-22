Script.ReloadScript("scripts/Utils/EntityUtils.lua")

-- Basic entity
BasicEntity = {
	Properties = {
		soclasses_SmartObjectClass = "",
		bAutoGenAIHidePts = 0,
		
		object_Model = "Objects/box.cgf",
		object_ModelFrozen = "",
		Physics = {
			bPhysicalize = 1, -- True if object should be physicalized at all.
			bRigidBody = 1, -- True if rigid body, False if static.
			bPushableByPlayers = 1,
		
			Density = -1,
			Mass = -1,
		},
		
		bFreezable=1,
		bCanShatter=1,
	},

	Client = {},
	Server = {},
	
	-- Temp.
	_Flags = {},
	
		Editor={
		Icon = "physicsobject.bmp",
		IconOnTop=1,
	  },
			
}

local Physics_DX9MP_Simple = {
	bPhysicalize = 1, -- True if object should be physicalized at all.
	bPushableByPlayers = 0,
		
	Density = 0,
	Mass = 0,
		
}

MakeUsable(BasicEntity);
MakePickable(BasicEntity);

------------------------------------------------------------------------------------------------------
function BasicEntity:OnSpawn()
	self.bRigidBodyActive = 1;

	self:SetFromProperties();	
end


----------------------------------------------------------------------------------------------------
function BasicEntity:OnPreFreeze(freeze, vapor)
	if (freeze) then
		return self.freezable;
	end
end

----------------------------------------------------------------------------------------------------
function BasicEntity:CanShatter()
	return self.Properties.bCanShatter;
end

------------------------------------------------------------------------------------------------------
function BasicEntity:SetFromProperties()
	local Properties = self.Properties;

	if (Properties.object_Model == "") then
		do return end;
	end
	
	self.freezable=tonumber(Properties.bFreezable)~=0;
	
	self:LoadObject(0,Properties.object_Model);
	--self:CharacterUpdateOnRender(0,1); -- If it is a character force it to update on render.
	
	if (Properties.object_ModelFrozen ~= "") then
 		self.frozenModelSlot = self:LoadObject(-1, Properties.object_ModelFrozen);
 		self:DrawSlot(self.frozenModelSlot, 0);
 	else
  	self.frozenModelSlot = nil;
  end
	
	if (Properties.Physics.bPhysicalize == 1) then
		self:PhysicalizeThis();
	end

	-- Mark AI hideable flag.
	if (Properties.bAutoGenAIHidePts == 1) then
		self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 0); -- set
	else
		self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 2); -- remove
	end
	
end

------------------------------------------------------------------------------------------------------
function BasicEntity:IsRigidBody()

	local Properties = self.Properties;
	local Mass = Properties.Mass; 
  local Density = Properties.Density;
  if (Mass == 0 or Density == 0 or Properties.bPhysicalize ~= 1) then 
  	return false;
  end
  return true;
end

------------------------------------------------------------------------------------------------------
function BasicEntity:PhysicalizeThis()
	-- Init physics.
	local Physics = self.Properties.Physics;
	if (CryAction.IsImmersivenessEnabled() == 0) then
		Physics = Physics_DX9MP_Simple;
	end
	EntityCommon.PhysicalizeRigid( self,0,Physics,self.bRigidBodyActive );
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function BasicEntity:OnPropertyChange()
	self:SetFromProperties();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function BasicEntity:OnReset()
	self:ResetOnUsed()
	
	local PhysProps = self.Properties.Physics;
	if (PhysProps.bPhysicalize == 1) then
		self:PhysicalizeThis();
		self:AwakePhysics(0);
	end
end

------------------------------------------------------------------------------------------------------
function BasicEntity:GetFrozenSlot()
	if (self.frozenModelSlot) then
		return self.frozenModelSlot;
	end
	return -1;
end

------------------------------------------------------------------------------------------------------
function BasicEntity:Event_Remove()
--	self:Hide(1);
	self:DrawSlot(0,0);
	self:DestroyPhysics();
	self:ActivateOutput( "Remove", true );
end


------------------------------------------------------------------------------------------------------
function BasicEntity:Event_Hide()
	self:Hide(1);
	self:ActivateOutput( "Hide", true );
	if CurrentCinematicName then
		Log("%.3f %s %s : Event_Hide", _time, CurrentCinematicName, self:GetName() );
	end
	--self:DrawObject(0,0);
	--self:DestroyPhysics();
end

------------------------------------------------------------------------------------------------------
function BasicEntity:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHide", true );
	if CurrentCinematicName then
		Log("%.3f %s %s : Event_UnHide", _time, CurrentCinematicName, self:GetName() );
	end
	--self:DrawObject(0,1);
	--self:SetPhysicsProperties( 1,self.bRigidBodyActive );
end

------------------------------------------------------------------------------------------------------
function BasicEntity:Event_RagDollize()  
	self:RagDollize(0);
	self:ActivateOutput( "RagDollized", true );
end

------------------------------------------------------------------------------------------------------
function BasicEntity.Client:OnPhysicsBreak( vPos,nPartId,nOtherPartId )
	self:ActivateOutput("Break",nPartId+1 );
end

------------------------------------------------------------------------------------------------------
--function BasicEntity:OnDamage( hit )
--	if( hit.ipart and hit.ipart>=0 ) then
--		self:AddImpulse( hit.ipart, hit.pos, hit.dir, hit.impact_force_mul );
--	end
--end

function BasicEntity:IsUsable(user)
	local ret = nil
	-- From EntityUtils.lua
	if not self.__usable then self.__usable = self.Properties.bUsable end
	
	local mp = System.IsMultiplayer();
	if(mp and mp~=0) then
		return 0;
	end

	if (self.__usable == 1) then
		ret = 2
	else
		local PhysProps = self.Properties.Physics;
		if (self:IsRigidBody() == true and user and user.CanGrabObject) then
			ret = user:CanGrabObject(self)
		end
	end
		
	return ret or 0
end

BasicEntity.FlowEvents =
{
	Inputs =
	{
		Used = { BasicEntity.Event_Used, "bool" },
		EnableUsable = { BasicEntity.Event_EnableUsable, "bool" },
		DisableUsable = { BasicEntity.Event_DisableUsable, "bool" },

		Hide = { BasicEntity.Event_Hide, "bool" },
		UnHide = { BasicEntity.Event_UnHide, "bool" },
		Remove = { BasicEntity.Event_Remove, "bool" },
		RagDollize = { BasicEntity.Event_RagDollize, "bool" },
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
