--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2008.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Network-ready Area Trigger
--  
--------------------------------------------------------------------------
--  History:
--  - 22/08/2008   15:43 : Modified by Marcio Martins
--
--------------------------------------------------------------------------
AreaTrigger =
{
	Properties =
	{
		bEnabled				= 1,
		bTriggerOnce		= 0,
		bOnlyPlayers		= 0,   
		bOnlyLocalPlayer= 0, 
		esFactionFilter	= "",
		ScriptCommand		= "",
		PlaySequence		= "",
		esFaction 			= "",
		bInVehicleOnly 	= 0,
		
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
		Icon="AreaTrigger.bmp",
		ShowBounds = 1,
	},
}



function AreaTrigger:OnPropertyChange()
	self:OnReset();
end


function AreaTrigger:OnReset()
	self.enabled = nil;
	self.triggerOnce = tonumber(self.Properties.bTriggerOnce)~=0;
	self.localOnly = tonumber(self.Properties.MultiplayerOptions.bLocalOnly)~=0;
	self.perPlayer = tonumber(self.Properties.MultiplayerOptions.bPerPlayer)~=0;
	
	self.isServer=CryAction.IsServer();
	self.isClient=CryAction.IsClient();

	self.inside={};
	self.insideCount=0;

	if (not self.localOnly) then
		self.triggeredPP={};
		self.triggeredOncePP={};
	end
	
	self.triggeredOnce=nil;
	self.triggered=nil;
	
	self:Enable(tonumber(self.Properties.bEnabled)~=0);
	self:ActivateOutput("IsInside", 0);	
end


function AreaTrigger:Enable(enable)
	self.enabled=enable;
end


function AreaTrigger:OnSpawn()
	self:OnReset();
end


function AreaTrigger:OnSave(props)
    props.enabled = self.enabled;
		props.triggered =	self.triggered;
		props.triggeredOnce =	self.triggeredOnce;
end


function AreaTrigger:OnLoad(props)
  	self:OnReset();
		self.enabled = props.enabled;
		self.triggered =	props.triggered;
		self.triggeredOnce =	props.triggeredOnce;
end


function AreaTrigger:CanTrigger(entityId)
	local entity=System.GetEntity(entityId);
	
	if (not entity) then return; end;
	
	local Properties = self.Properties;

	if (Properties.bOnlyPlayer ~= 0 and (not entity.actor or not entity.actor:IsPlayer())) then
		return false;
	end

	if (Properties.bOnlyLocalPlayer ~= 0 and entity ~= g_localActor) then
		return false;
	end

	if (Properties.bInVehicleOnly ~= 0 and not entity.vehicleId) then
		return false;
	end

	return true;
end


function AreaTrigger:Trigger(entityId, enter)
	self:ActivateOutput("IsInside", self.insideCount);
	self:ActivateOutput("Sender", entityId or NULL_ENTITY);
	self:ActivateOutput("Faction", AI.GetFactionOf(entityId or NULL_ENTITY) or "");

	if (enter) then
		local entity=System.GetEntity(entityId or NULL_ENTITY);
		if(entity) then
			if(self.Properties.esFaction ~= "" ) then 
				local faction;
				local isLeader;
				if (entity and entity.actor) then
					if(entity.actor:IsPlayer()) then
						faction = "Players";
						isLeader = true;
					elseif(entity.Properties and entity.Properties.esFaction) then
						faction = entity.Properties.esFaction;
						if(entity.AI) then 
							isLeader = sender.AI.bIsLeader;
						end
					end
					
					-- only the leader triggers this
					if(isLeader) then 
						g_SignalData.string1 = faction;
						if(faction ~= self.Properties.esFaction) then
							AI.Signal(SIGNALFILTER_LEADER, 1, "OnEnterEnemyArea", entity.id, g_SignalData);
						else
							AI.Signal(SIGNALFILTER_LEADER, 1, "OnEnterFriendlyArea", entity.id, g_SignalData);
						end
					end
				end	
			end
		end
		
		if(self.Properties.ScriptCommand and self.Properties.ScriptCommand~="")then
			local f = loadstring(self.Properties.ScriptCommand);
			if (f~=nil) then
				f();
			end
		end
	
		if(self.Properties.PlaySequence~="")then
			Movie.PlaySequence(self.Properties.PlaySequence);
		end
	else
		if(self.Properties.esFaction ~= "") then 
			local faction;
			local isLeader;
			if (entity and entity.actor) then
				if(entity.actor:IsPlayer()) then
					faction = "Players";
					isLeader = true;
				elseif(entity.Properties and entity.Properties.esFaction) then
					faction = entity.Properties.esFaction;
					if(entity.AI) then 
						isLeader = sender.AI.bIsLeader;
					end
				end
				
				-- only the leader triggers this
				if(isLeader) then
					g_SignalData.string1 = faction;
					if(senderSpecies ~= self.Properties.esFaction) then
						AI.Signal(SIGNALFILTER_LEADER,1, "OnLeaveEnemyArea", sender.id, g_SignalData);
					else
						AI.Signal(SIGNALFILTER_LEADER,1, "OnLeaveFriendlyArea", sender.id, g_SignalData);
					end
				end
			end	
		end		
	end
end


function AreaTrigger:EnteredArea(entityId, areaId)
	if (not self:CanTrigger(entityId, areaId)) then
		return;
	end	
	
	self.insideCount=self.insideCount+1;	

	self:Event_Enter(entityId);
end


function AreaTrigger:LeftArea(entityId, areaId)
	if (not self:CanTrigger(entityId, areaId)) then
		return;
	end
	
		self.insideCount=self.insideCount-1;
	
	self:Event_Leave(entityId);
end


function AreaTrigger.Server:OnEnterArea(entity, areaId)
	if (self:CanTrigger(entity.id)) then
		self:EnteredArea(entity.id, areaId);
	end
end


function AreaTrigger.Server:OnLeaveArea(entity, areaId)
	self:LeftArea(entity.id, areaId);
end


function AreaTrigger.Client:OnEnterArea(entity, areaId)
	if (not self:CanTrigger(entity.id)) then return; end;

	if (not self.localOnly or self.isServer) then return; end;
	
	self:EnteredArea(entity.id, areaId);
end


function AreaTrigger.Client:OnLeaveArea(entity, areaId)
	if (not self.localOnly or self.isServer) then return; end;
		
	self:LeftArea(entity.id, areaId);
end


function AreaTrigger:Event_Enter(entityId)
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

	self:Trigger(entityId, true);
	
	BroadcastEvent(self, "Enter");
	
end


function AreaTrigger:Event_Leave(entityId)
	if (not self.enabled) then return; end;
	if (self.localOnly and not self.triggered) then return; end;
	
	if (self.perPlayer) then
		if (not self.localOnly and entityId) then
			if (not self.triggeredPP[entityId]) then return; end;
		end
	else
		if (not self.triggered) then return; end;
	end
	
	--only disable triggered when all players are gone
	if(self.insideCount == 0) then
		self.triggered=nil;
	end
	
	if (not self.localOnly and entityId and self.insideCount == 0) then
		self.triggeredPP[entityId]=nil;
	end
	
	self:Trigger(entityId, false);

	BroadcastEvent(self, "Leave");
	
	self:ActivateOutput("Sender", entityId or NULL_ENTITY);
	self:ActivateOutput("IsInside", self.insideCount);
	
end


function AreaTrigger.Client:ClEnter(entityId, insideCount)
  self.insideCount = insideCount;
	self:Trigger(entityId, true);
	
	BroadcastEvent(self, "Enter");
end



function AreaTrigger.Client:ClLeave(entityId, inside)
  self.insideCount = inside;
	self:Trigger(entityId, false);
	
	self:ActivateOutput("Sender", entityId);
	self:ActivateOutput("IsInside", inside);	
	
	BroadcastEvent(self, "Leave");
end



function AreaTrigger:Event_Enable()
	self:Enable(true);
	
	BroadcastEvent(self, "Enable");
end

function AreaTrigger:Event_Disable()
	self:Enable(false);
	
	BroadcastEvent(self, "Disable");
end


AreaTrigger.FlowEvents =
{
	Inputs =
	{
		Disable = { AreaTrigger.Event_Disable, "bool" },
		Enable = { AreaTrigger.Event_Enable, "bool" },
		Enter = { AreaTrigger.Event_Enter, "bool" },
		Leave = { AreaTrigger.Event_Leave, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		Enter = "bool",
		Leave = "bool",
		IsInside = "int",
		Sender = "entity",		
		Faction = "string",
	},
}
