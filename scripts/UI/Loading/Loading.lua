----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the loading screen!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 18:3:2005   21:02 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
local LoadingUI = UI:BeginUI("loading");
	UI:MakeScreen({
		bg = 
		{
			class = "static",
			left = 0,
			top = 0,
			width = 800,
			height = 600,
			zorder = -1,
			
			skin =
			{
				normal 	= "textures/gui/bg.dds",
			},
		},
		
		progressbar =
		{
			class = "progressbar",
			left = 82,
			top = 530,
			width = 636,
			height = 35,
			zorder = 1,
			
			skin =
			{
				normal = "textures/gui/bar.dds",
				background = "textures/gui/bar_empty.dds",
			},
		},
	}, "loading");
UI:EndUI();

LoadingUI.zorder = 1000;
LoadingUI:Focus(false);
LoadingUI:GetScreen("loading"):Activate(true);


----------------------------------------------------------------------------------------------------
function LoadingUI:OnUpdate(frameTime, frameId)
	if (frameId ~= 0) then -- was this a real frame ?

		if (self.loading) then
			if (self.keepframes and (self.keepframes > 0)) then
				self.keepframes = self.keepframes-1;
				if (self.keepframes == 0) then
					self:Activate(false);
					self.keepframes = nil;
					self.loading = nil;
				end
			end
		end

		if (self.keepframes) then
			Log("loading ui update: %d", self.keepframes);
		end
	end
end


----------------------------------------------------------------------------------------------------
function LoadingUI:StartLoading(levelName, levelFolder, totalProgress)
	self.loading = true;
	self:Activate(true);
end


----------------------------------------------------------------------------------------------------
function LoadingUI:SetMaxProgress(maxprogress)
	self.screens.loading.progressbar.max_progress = maxprogress;
end


----------------------------------------------------------------------------------------------------
function LoadingUI:SetProgress(progress)
	self.screens.loading.progressbar.progress = progress;
end


----------------------------------------------------------------------------------------------------
function LoadingUI:GetProgress()
	return self.screens.loading.progressbar.progress;
end

----------------------------------------------------------------------------------------------------
function LoadingUI:EndLoading(levelName, levelFolder, totalProgress)
	self.keepframes = 4;
end
