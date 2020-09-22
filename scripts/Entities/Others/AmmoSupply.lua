--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: 
--  
--------------------------------------------------------------------------
--  History:
--  - 11/07/2011   : Created by Tom Houghton
--
--------------------------------------------------------------------------

AmmoSupply = {
	Client = {},
	Server = {},

	Editor={
		Model="Editor/Objects/spawnpointhelper.cgf",  -- TODO!
		Icon="SpawnPoint.bmp",  -- TODO!
		DisplayArrow=0,
	},
	
	Properties=
	{
		bEnabled=1,
	},
}

--------------------------------------------------------------------------
function AmmoSupply.Server:OnInit()
	--Log("[tlh] AmmoSupply.Server:OnInit()");
	self:Enable(tonumber(self.Properties.bEnabled)~=0);	
end

--------------------------------------------------------------------------
function AmmoSupply:Enable(enable)
	--Log("[tlh] AmmoSupply:Enable(enabled='%s'), name='%s'", tostring(enable), self:GetName());
	if (enable) then
		g_gameRules.game:AddAmmoSupply(self.id);
	else
		g_gameRules.game:RemoveAmmoSupply(self.id);
	end
	self.enabled=enable;
end

--------------------------------------------------------------------------
function AmmoSupply.Server:OnShutDown()
	--Log("[tlh] AmmoSupply.Server:OnShutDown()");
	if (g_gameRules) then
		g_gameRules.game:RemoveAmmoSupply(self.id);
	end
end

--------------------------------------------------------------------------
function AmmoSupply:IsEnabled()
	--Log("[tlh] AmmoSupply:IsEnabled()");
	return self.enabled;
end

--------------------------------------------------------------------------
-- EVENTS
--

---------
function AmmoSupply:Event_Enable()
	--Log("[tlh] AmmoSupply:Event_Enable()");
	self:Enable(true);
	BroadcastEvent(self, "Enabled");
end

---------
function AmmoSupply:Event_Disable()
	--Log("[tlh] AmmoSupply:Event_Disable()");
	self:Enable(false);
	BroadcastEvent(self, "Disabled");
end

--------------------------------------------------------------------------
-- FLOW
--

AmmoSupply.FlowEvents =
{
	Inputs =
	{
		Enable = { AmmoSupply.Event_Enable, "bool" },
		Disable = { AmmoSupply.Event_Disable, "bool" },
	},
	Outputs =
	{
		Enabled = "bool",
		Disabled = "bool",
	},
}

