-----------------------------------------------------------------------------------------------
--
--	SoundMood entity - to be attached to area 
--	will set specified SoundMood settings when entering area
--  registers/updates/unregisters Presets and supports blending

SoundMoodVolume = {
	type = "SoundMoodVolume",
	
	Editor={
		Model="Editor/Objects/Sound.cgf",
		Icon="SoundMoodVolume.bmp",
	},
	
	Properties = {
		--reverbpresetReverbPreset="",
		sSoundMoodName = "",
		OuterRadius=2,
		--bFullEffectWhenInside=1, --used for Reverb-Morphing
		bEnabled=1,
	},
	bstarted=0,
}

function SoundMoodVolume:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

----------------------------------------------------------------------------------------
function SoundMoodVolume:OnLoad(table)
  self.bstarted = table.bstarted;
  self.bEnabled = table.bEnabled;
end

----------------------------------------------------------------------------------------
function SoundMoodVolume:OnSave(table)
  table.bstarted = self.bstarted;
  table.bEnabled = self.bEnabled;
  
end

----------------------------------------------------------------------------------------
function SoundMoodVolume:OnPropertyChange()

  self:SetSoundEffectRadius(self.Properties.OuterRadius);
	self.bEnabled = self.Properties.bEnabled;
	self.sSoundMoodName = self.Properties.sSoundMoodName;
	
--	System.Log("Property change SoundMood "..self.sSoundMoodName);
	
	--if (self.bEnabled ~= 0) then
	  --if (self.bEnabled ~= 0) then
		  --self:OnEnterNearArea();
		--end
	--else
	  --self:OnLeaveNearArea();
	--end
	
end

----------------------------------------------------------------------------------------
function SoundMoodVolume:CliSrv_OnInit()
	
	self.bstarted = 0;
	self.sSoundMoodName = "";
	self:NetPresent(0);
	self.inside = 0;
	self.fFadeValue = 0;
	self:SetFlags(ENTITY_FLAG_VOLUME_SOUND,0);
	if (self.Initialized) then
		return
	end	
	
	self:SetSoundEffectRadius(self.Properties.OuterRadius);
	self:SendProceedFadeAreaEventAlways(false);
	self.Initialized=1;
end

----------------------------------------------------------------------------------------
function SoundMoodVolume:OnShutDown()
end

----------------------------------------------------------------------------------------
function SoundMoodVolume:RegisterSoundMood( player )
  --local Preset=ReverbPresetDB[self.Properties.reverbpresetReverbPreset];
 
  -- local test=nil + 1;  -- for testing unless lua debugger works
	--if (self.Properties.sSoundMood) then
	  --System.Log("Register SoundMood "..self.Properties.sSoundMoodName);
	  --System.Log("Preset "..Preset.nEnvironment);
	  if (self.bstarted == 0) then
	    Sound.RegisterSoundMood(self.Properties.sSoundMoodName);
    	--Sound.RegisterWeightedEaxEnvironment(self.Properties.reverbpresetReverbPreset, Preset, self.Properties.bFullEffectWhenInside, 0);
    	self.bstarted=1;
    end;
  --end;
	
end

----------------------------------------------------------------------------------------
function SoundMoodVolume:UnregisterSoundMood( player )
	
	-- disable eax, choosing OFF preset	

	--System.Log("Unregister SoundMood "..self.Properties.sSoundMood);
	if (self.bstarted ~= 0) then
	  --System.Log("Unregister SoundMood "..self.Properties.sSoundMood);
		Sound.UnregisterSoundMood(self.Properties.sSoundMoodName);
		--Sound.UnregisterWeightedEaxEnvironment(self.Properties.reverbpresetReverbPreset);
		self.bstarted=0;
		
	end;

end

----------------------------------------------------------------------------------------
function SoundMoodVolume:UpdateSoundMood( player, fDistSq )
  
  if (self.Properties.OuterRadius ~= 0) then
  
    --if (self.bstarted == 0) then
      --OnEnterNearArea(player, areaId);
    --end;
    
    --System.Log("Update SoundMood "..self.Properties.sSoundMoodName);
    
    if (self.inside == 1) then
    	if (self.fFadeValue ~= 1) then
    	  Sound.UpdateSoundMood(self.Properties.sSoundMoodName, 1, 0);
    		--Sound.UpdateWeightedEaxEnvironment(self.Properties.reverbpresetReverbPreset, 1);
    		self.fFadeValue = 1;
    		--System.Log("FADE proceed self fade"..self.fFadeValue);
    	end;
    else
  		local fFade = 1 - (math.sqrt(fDistSq) / self.Properties.OuterRadius);
  	 	--System.Log("FADE proceed "..fFade);
  	 	if ( fFade > 0) then
  	 	  Sound.UpdateSoundMood(self.Properties.sSoundMoodName, fFade, 0);
    		--Sound.UpdateWeightedEaxEnvironment(self.Properties.reverbpresetReverbPreset, fFade);
    		self.fFadeValue = fFade;
     	end    
    end;

  end

end

----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
SoundMoodVolume.Server={
	OnInit=function(self)
		self:CliSrv_OnInit()
	end,
	OnShutDown=function(self)
	end,
}

----------------------------------------------------------------------------------------
SoundMoodVolume.Client={
	OnInit=function(self)
		self:CliSrv_OnInit()
	end,
	OnShutDown=function(self)
	end,
	
	OnBeginState=function(self)
--System.Log("Entering INACTIVE");		
	end,
	

	
	-- OnEnterNearArea = ReverbVolume.OnEnterNearArea,
	--OnEnterArea=ReverbVolume.Client_Inactive_OnEnterArea,
	--OnMove=ReverbVolume.OnMove,
--		OnMove=EAXPresetArea.Client.OnMove,		
	
	OnBeginState=function(self)
--System.Log("Entering ACTIVE");		
		--	System.Log("SetTimer");
--			self:SetTimer(200);
	end,
		--OnMove = function(self)
		--end,
	OnEnterNearArea = function(self,player, nAreaID,fFade )
		if (g_localActorId ~= player.id and player.class~="CameraSource") then	return end;	    

	  SoundMoodVolume.RegisterSoundMood(self,player);
	end,
	
	OnMoveNearArea = function(self,player, nAreaID,fFade,fDistsq )
		if (g_localActorId ~= player.id and player.class~="CameraSource") then	return end;    

	   SoundMoodVolume.UpdateSoundMood(self,player,fDistsq);
	end,	
	
	OnEnterArea = function(self,player, nAreaID,fFade )
		--System.LogToConsole("OnEnterArea-Client");
		if (g_localActorId ~= player.id and player.class~="CameraSource") then	return end;	    
	  self.inside = 1;
	  self.fFadeValue = 0;
	  SoundMoodVolume.RegisterSoundMood(self,player);
	  SoundMoodVolume.UpdateSoundMood(self,player,fDistsq);
	end,
	
	OnSoundEnterArea = function(self,player,areaId,fFade )
		--System.LogToConsole("OnEnterArea-Client");
		if (g_localActorId ~= player.id and player.class~="CameraSource") then	return end; 
	  --self.inside = 1;
	  --self.fFadeValue = 0;
--	  if (self.bEnabled ~= 0) then
--	    System.LogToConsole("OnSoundEnterArea-Client");
--	  end;
	end,
	
	
	OnProceedFadeArea = function(self, player, nAreaID, fFade)
	  --System.LogToConsole("OnMoveInsideArea-Client");
		if (g_localActorId ~= player.id and player.class~="CameraSource") then	return end;	    

	  self.inside = 1;
	  SoundMoodVolume.RegisterSoundMood(self,player);
	  SoundMoodVolume.UpdateSoundMood(self,player,fFade);
	end,
	
	OnLeaveArea = function(self)
		if (g_localActorId ~= player.id and player.class~="CameraSource") then	return end;

		--System.LogToConsole("OnLeaveNearArea-Client");
		self.inside = 0;
	end,	
	
	OnLeaveNearArea = function(self,player,areaId,fFade )
		if (g_localActorId ~= player.id and player.class~="CameraSource") then	return end;    

	  SoundMoodVolume.UnregisterSoundMood(self,player);
	  self.inside = 0;
	end,
	
		--OnMoveNearArea = function(self)
		--end,
		--OnLeaveNearArea = function(self)
		--end,
		OnEndState=function(self)
--			System.Log("KillTimer");
--			self:KillTimer();
		end,
}

----------------------------------------------------------------------------------------------------
function SoundMoodVolume:Event_Deactivate(sender)
  --System.Log( "Ambient Volume :Enable active");
  self.bEnabled = 0;
  SoundMoodVolume.UnregisterSoundMood(self);
  --self:OnReset();
end
----------------------------------------------------------------------------------------------------
function SoundMoodVolume:Event_Activate(sender)
  --System.Log( "SoundMoodVolume :Event_Activate");
  self.bEnabled = 1;
  SoundMoodVolume.RegisterSoundMood(self);
  --self:OnReset();
end
----------------------------------------------------------------------------------------------------
function SoundMoodVolume:Event_Fade(sender, fFade)
  --System.Log( "ASoundMoodVolume :Event_Fade"..tostring(fFade));
  self.fFadeValue = fFade;
  Sound.UpdateSoundMood(self.Properties.sSoundMoodName, self.fFadeValue, 0);
  --self:OnReset();
end


SoundMoodVolume.FlowEvents =
{
	Inputs =
	{
	  --SoundName = { SoundMoodVolume.Event_SoundName, "string" },
		--Enable = { SoundMoodVolume.Event_Enable, "bool" },
		Deactivate 	= { SoundMoodVolume.Event_Deactivate, "bool" },
		Activate   	= { SoundMoodVolume.Event_Activate, "bool" },
		Fade 				= { SoundMoodVolume.Event_Fade, "float" },
		--Volume = { SoundMoodVolume.Event_Volume, "float" },
	},
	Outputs =
	{
	},
}

