--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2008.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Network-ready Proximity Trigger
--  
--------------------------------------------------------------------------
--  History:
--  - 13/08/2008   15:43 : Modified by Marcio Martins
--
--------------------------------------------------------------------------
ProximityTrigger =
{
	Properties =
	{
		DimX = 5,
		DimY = 5,
		DimZ = 5,
		
		bEnabled		= 1,
		EnterDelay	= 0,
		ExitDelay		= 0,
		
		bOnlyPlayer		= 1,
		bOnlyMyPlayer	= 0,
		bOnlyAI 			= 0,
		bOnlySpecialAI= 0,
		esFactionFilter	= "",
		
		OnlySelectedEntity = "None",
		
		bKillOnTrigger	= 0,
		bTriggerOnce		= 0,
		ScriptCommand		= "",
		PlaySequence		= "",
		bInVehicleOnly	= 0,
		bOnlyOneEntity	= 0,
		
		UsableMessage		= "",
		bActivateWithUseButton=0,
	
		MultiplayerOptions=
		{
			bLocalOnly		= 0,
			bPerPlayer		= 0,
		},
	},

	Client={},
	Server={},

	Editor={
		Model="Editor/Objects/T.cgf",
		Icon="Trigger.bmp",
		ShowBounds = 1,
	},
}



function ProximityTrigger:OnPropertyChange()
	self:OnReset();
end


function ProximityTrigger:OnReset()
	if (self.timers) then
		for i,v in pairs(self.timers) do
			self:KillTimer(i);
		end
	end
	self.timerId = 0;

	self.enabled = nil;
	self.usable = tonumber(self.Properties.bActivateWithUseButton)~=0;
	self.triggerOnce = tonumber(self.Properties.bTriggerOnce)~=0;
	self.localOnly = tonumber(self.Properties.MultiplayerOptions.bLocalOnly)~=0;
	self.perPlayer = tonumber(self.Properties.MultiplayerOptions.bPerPlayer)~=0;
	
	self.isServer=CryAction.IsServer();
	self.isClient=CryAction.IsClient();

	self.inside={};
	self.timers={};

	if (not self.localOnly) then
		self.triggeredPP={};
		self.triggeredOncePP={};
	end
	
	self.triggeredOnce=nil;
	self.triggered=nil;
	
	self.insideCount=0;
	
	local min = { x=-self.Properties.DimX/2, y=-self.Properties.DimY/2, z=-self.Properties.DimZ/2 };
	local max = { x=self.Properties.DimX/2, y=self.Properties.DimY/2, z=self.Properties.DimZ/2 };
	
	self:SetUpdatePolicy( ENTITY_UPDATE_PHYSICS );
	
	self:SetTriggerBBox( min, max );
	
	self:Enable(tonumber(self.Properties.bEnabled)~=0);
	
	self:InvalidateTrigger();
	
	self:ActivateOutput("IsInside", 0);
end


function ProximityTrigger:Enable(enable)
	self.enabled=enable;
end


function ProximityTrigger:OnSpawn()
	self:OnReset();
end


function ProximityTrigger:OnDestroy()
end


function ProximityTrigger:OnSave(tbl)
    tbl.enabled = self.enabled;
		tbl.triggered =	self.triggered;
		tbl.triggeredOnce =	self.triggeredOnce;
end


function ProximityTrigger:OnLoad(tbl)
  	self:OnReset();
		self.enabled = tbl.enabled;
		self.triggered =	tbl.triggered;
		self.triggeredOnce =	tbl.triggeredOnce;
end


function ProximityTrigger:Event_Enter(entityId)
	if (not self.enabled) then return; end; -- TODO: might need a self.active here
	if (self.triggerOnce) then
		if (self.localOnly) then
			if (self.triggeredOnce) then
				return;
			end
		elseif (self.perPlayer and self.triggeredOncePP[entityId]) then	-- TODO: will need to skip this for non-player entities
			return;
		elseif (not self.perPlayer and self.triggeredOnce) then
			return;
		end
	end
	
	self.triggered=true;
	self.triggeredOnce=true;
	
	if (not self.localOnly and entityId) then
		self.triggeredPP[entityId]=true;
		self.triggeredOncePP[entityId]=true;
	end
	
--	Log(" ProximityTrigger: %s:Event_Enter(%s) inside: %d", self:GetName(), EntityName(entityId), self.insideCount);

	self:Trigger(entityId, self.insideCount);
	
	BroadcastEvent(self, "Enter");
end


function ProximityTrigger.Client:ClEnter(entityId, insideCount)
--	Log("ProximityTrigger: %s.Client:ClEnter(%s) count: %d", self:GetName(), EntityName(entityId), insideCount);
	
	self:Trigger(entityId, insideCount);
	BroadcastEvent(self, "Enter");
end

function ProximityTrigger:Event_Leave(entityId)
	if (not self.enabled) then return; end;
	if (self.localOnly and not self.triggered) then return; end;
	
	if (self.perPlayer) then
		if (not self.localOnly and entityId) then
			if (not self.triggeredPP[entityId]) then
				return;
			end;
		end
	else
		if (not self.triggered) then
			return;
		end;
	end
	
	--only disable triggered when all players are gone
	if(self.insideCount == 0) then
		self.triggered=nil;
	end
	
	if (not self.localOnly and entityId and self.insideCount == 0) then
		self.triggeredPP[entityId]=nil;
	end
	
	--Log("%s:Event_Leave(%s)", self:GetName(), EntityName(entityId));
	
	self:ActivateOutput("Sender", entityId or NULL_ENTITY);
	self:ActivateOutput("IsInside", self.insideCount);

	BroadcastEvent(self, "Leave");
end


function ProximityTrigger.Client:ClLeave(entityId, inside)
--	Log("%s.Client:ClLeave(%s, %s)", self:GetName(), EntityName(entityId), tostring(inside));
	
	self:ActivateOutput("Sender", entityId);
	self:ActivateOutput("IsInside", inside);

	BroadcastEvent(self, "Leave");	
end


function ProximityTrigger:Event_Enable()
	self:Enable(true);

	BroadcastEvent(self, "Enable");
end


function ProximityTrigger:Event_Disable()
	self:Enable(false);

	BroadcastEvent(self, "Disable");
end


function ProximityTrigger:CreateTimer(entityId, time, leave)
	local timerId=self.timerId;
	if (timerId>1023) then
		timerId=0;
	end
	timerId=timerId+1;
	self.timerId=timerId;
	
	if (leave) then
		timerId=timerId+1024;
	end
	self.timers[timerId]=entityId;
	self:SetTimer(timerId, time);
end


function ProximityTrigger.Client:OnTimer(timerId, msec)
	if (self.localOnly and not self.isServer) then
		self:OnTimer(timerId, msec);
	end
end


function ProximityTrigger.Server:OnTimer(timerId, msec)
	self:OnTimer(timerId, msec);
end


function ProximityTrigger:OnTimer(timerId, msec)
	local entityId=self.timers[timerId];
	if (not entityId) then return; end;

	if (timerId>1023) then
		self:Event_Leave(entityId);
	else
		self:Event_Enter(entityId);
	end
end


function ProximityTrigger.Server:SvRequestUse(userId)
	local entity=System.GetEntity(userId);
	if (entity) then
		self:OnUsed(entity);
	end
end


function ProximityTrigger:OnUsed(user)
	if (not self:CanTrigger(user)) then return; end;
	
	Log("%s:OnUsed(%s)", self:GetName(), EntityName(user));

	self:LockUsability(false);

	self:CreateTimer(user.id, self.Properties.EnterDelay*1000);
end


function ProximityTrigger:Trigger(entityId, inside)
	self:ActivateOutput("IsInside", inside);
	
	if(self.Properties.ScriptCommand and self.Properties.ScriptCommand~="")then
		local f = loadstring(self.Properties.ScriptCommand);
		if (f~=nil) then
			f();
		end
	end
	
	if(self.Properties.PlaySequence~="")then
		Movie.PlaySequence(self.Properties.PlaySequence);
	end

	 self:ActivateOutput("Sender", entityId or NULL_ENTITY);
	 self:ActivateOutput("Faction", AI.GetFactionOf(entityId or NULL_ENTITY) or "");
end


function ProximityTrigger:EnteredArea(entity, areaId)
	if (not self:CanTrigger(entity, areaId)) then
		return;
	end
	
	if (tonumber(self.Properties.bOnlyOneEntity)~=0 and self.insideCount>0) then
		return;
	end
	
	self.inside[entity.id]=true;
	self.insideCount=self.insideCount+1;

	if (not entity.ai) then
		if (self.Properties.bActivateWithUseButton~=0) then			
			return;
		end
	end
	
	self:CreateTimer(entity.id, self.Properties.EnterDelay*1000);
end


function ProximityTrigger:LeftArea(entity, areaId)
	if (not self:CanTrigger(entity, areaId)) then
		return;
	end
	
	self.inside[entity.id]=nil;
	self.insideCount=self.insideCount-1;
	
	if(self.Properties.ExitDelay==0) then
		self.Properties.ExitDelay=0.01;
	end
	
	self:CreateTimer(entity.id, self.Properties.ExitDelay*1000, true);
end


function ProximityTrigger.Server:OnEnterArea(entity, areaId)
	if (self:CanTrigger(entity)) then
		self:EnteredArea(entity, areaId);
	end
end


function ProximityTrigger.Server:OnLeaveArea(entity, areaId)
	self:LeftArea(entity, areaId);
end


function ProximityTrigger.Client:OnEnterArea(entity, areaId)
	if (not self:CanTrigger(entity)) then return; end;
	
	if (entity.actor) then
		if (self.usable and self.enabled) then
			self:LockUsability(true);
		end
	end
	
	if (not self.localOnly or self.isServer) then return; end;
	
	self:EnteredArea(entity, areaId);
end


function ProximityTrigger.Client:OnLeaveArea(entity, areaId)
	if (entity.actor) then
		if (self.usable and self.enabled) then
			self:LockUsability(false);
		end
	end
	
	if (not self.localOnly or self.isServer) then return; end;
		
	self:LeftArea(entity, areaId);
end


function ProximityTrigger:CanTrigger(entity)
	local Properties = self.Properties;

	if (Properties.bOnlyPlayer ~= 0 and (not entity.actor or not entity.actor:IsPlayer())) then
		return false;
	end

	if (Properties.bOnlySpecialAI ~= 0 and entity.ai and entity.Properties.special==0) then 
		return false;
	end

	if (Properties.bOnlyAI ~=0 and not entity.ai) then
		return false;
	end

	if (Properties.bOnlyMyPlayer ~= 0 and entity ~= g_localActor) then
		return false;
	end

	if (Properties.bInVehicleOnly ~= 0 and not entity.vehicleId) then
		return false;
	end

	if(Properties.OnlySelectedEntity~="None" and Properties.OnlySelectedEntity~="" and entity:GetName()~=Properties.OnlySelectedEntity) then
		return false;
	end
	
	return true;
end


function ProximityTrigger:IsUsable(user)
	return self.usable and self.enabled;
end


function ProximityTrigger:LockUsability(lock)
	local player=g_localActor;
	if (player) then
		if (lock) then
			player.actor:SetExtensionParams("Interactor", {locker = self.id, lockId = self.id, lockIdx = 1});
		else
			player.actor:SetExtensionParams("Interactor", {locker = self.id, lockId = NULL_ENTITY, lockIdx = 0});
		end
	end
end


function ProximityTrigger:GetUsableMessage()
	return self.Properties.UsableMessage or "";
end



ProximityTrigger.FlowEvents =
{
	Inputs =
	{
		Disable = { ProximityTrigger.Event_Disable, "bool" },
		Enable = { ProximityTrigger.Event_Enable, "bool" },
		Enter = { ProximityTrigger.Event_Enter, "bool" },
		Leave = { ProximityTrigger.Event_Leave, "bool" },
	},
	
	Outputs =
	{
		IsInside      = "int",
		Disable       = "bool",
		Enable        = "bool",
		Enter         = "bool",
		Leave         = "bool",
		Sender        = "entity",
		Faction       = "string",
	},
}
