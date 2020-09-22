----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements user interface events, sent by C++.
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 17:8:2004   11:25 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------

local function IsLoadingScreenEnabled()
	return System.GetCVar("g_enableloadingscreen")~=0
end

----------------------------------------------------------------------------------------------------
function UI:OnInit()
	self.uis = {};
	self.sorted_uis = {};
	self.classes = {};
	self.images = {};
	
	self.backgroundMusic = 0;

	-- load system scripts
	UI:LoadScript("uiui.lua");
	UI:LoadScript("uiscreen.lua");
	UI:LoadScript("uiwidget.lua");
	-- load system widgets
	UI:LoadScript("widgets/uistatic.lua");
	UI:LoadScript("widgets/uibutton.lua");
	UI:LoadScript("widgets/uiprogressbar.lua");
	
	-- load ui's
	UI:LoadScript("main/main.lua");
	UI:LoadScript("loading/loading.lua");
	UI:LoadScript("hud/hud.lua");
end


----------------------------------------------------------------------------------------------------
function UI:OnPreUpdate(frameTime, frameId)
	self:Sort();

	if (System.GetCVar("g_enableitems")==0) then return end
	
	for i,ui in pairs(self.sorted_uis) do
		if (ui.active and (self.preUpdate)) then		
			ui:Message(UIM_UPDATE, frameTime, frameId);
		end
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnPostUpdate(frameTime, frameId)
	
	if (not System.IsEditor()) then
		if ((g_gameRules and g_gameRules.fadeAlpha and (g_gameRules.fadeAlpha > 0.05)) or
			(g_gameRules and g_gameRules.fadeFrames and (g_gameRules.fadeFrames > 0))) then
			HUD:Hide(true);
			HUD:Slide(true, 1000);
			self.unhideOnce = true;
		elseif (self.unhideOnce) then
			self.unhideOnce = nil;
			HUD:Hide(true);
			HUD:Slide(false, 5);
		end
	end
	
	if (System.GetCVar("g_enableitems")==0) then return end

	for i,ui in pairs(self.sorted_uis) do
		if (ui.active and (not self.preUpdate)) then		
			ui:Message(UIM_UPDATE, frameTime, frameId);
		end
	end
	
	-- CXP HACK
	if ((g_gameRules and g_gameRules.fadeAlpha and (g_gameRules.fadeAlpha > 0.05)) or
		(g_gameRules and g_gameRules.fadeFrames and (g_gameRules.fadeFrames > 0))) then
		UI.Begin2D(UI.GetScreenWidth(), UI.GetScreenHeight());
		UI.DrawQuad(0,0,UI.GetScreenWidth(),UI.GetScreenHeight(), nil, {0, 0, 0, g_gameRules.fadeAlpha});	
		UI.End2D();
	end
	-- CXP HACK
end


----------------------------------------------------------------------------------------------------
function UI:OnRelease()
	for name,ui in pairs(self.uis) do
		UI:DestroyUI(name);
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnIdle(idleTime)
end


----------------------------------------------------------------------------------------------------
function UI:OnKeyDown(keyCode, keyName, keyChar)
	for name,ui in pairs(self.uis) do
		if (ui.focused) then
			ui:Message(UIM_KEYDOWN, keyCode, keyName, keyChar);
		end
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnKeyUp(keyCode, keyName, keyChar)
	for name,ui in pairs(self.uis) do
		if (ui.focused) then
			ui:Message(UIM_KEYUP, keyCode, keyName, keyChar);
		end
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnMouseDown(btn)
	for name,ui in pairs(self.uis) do
		if (ui.focused) then
			ui:Message(UIM_MOUSEDOWN, btn);
		end
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnMouseUp(btn)
	for name,ui in pairs(self.uis) do
		if (ui.focused) then
			ui:Message(UIM_MOUSEUP, btn);
		end
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnMouseMove(dx, dy, dz)
	for name,ui in pairs(self.uis) do
		if (ui.focused) then
			ui:Message(UIM_MOUSEMOVE, dx, dy, dz);
		end
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnLevelNotFound(levelName)
	--print to console that the level wasn't found
end


----------------------------------------------------------------------------------------------------
function UI:OnLoadingStart(levelName, levelFolder, totalProgress)
	if (IsLoadingScreenEnabled() and (not System.IsEditor())) then
		System.ShowConsole(0);
	
		local main = UI:GetUI("main");
		main:Focus(false);
		main:Activate(false); -- in here music will be stopped again

		local loading = UI:GetUI("loading");
		loading:StartLoading(levelName, levelFolder, totalProgress);
		loading:SetMaxProgress(totalProgress);
		loading:SetProgress(0);
		--UI:ActivateBackgroundMusic(true); -- its already playing
	end

	UI.PauseGame(true);
end


----------------------------------------------------------------------------------------------------
function UI:OnLoadingComplete(levelName, levelFolder, totalProgress)
	local main = UI:GetUI("main");
	main:Focus(true);

	UI.PauseGame(false);

	if (IsLoadingScreenEnabled() and (not System.IsEditor())) then
		local loading = UI:GetUI("loading");
		loading:EndLoading(levelName, levelFolder, totalProgress);
		System.Log("------- UI:Events LoadingComplete: Music off");
		UI:ActivateBackgroundMusic(false);
	else
		main:Activate(false);
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnLoadingError(levelName, levelFolder)
	System.ShowConsole(1);
	UI.PauseGame(false);
	
	local main = UI:GetUI("main");
	main:Focus(true);
	main:Activate(true);

	if IsLoadingScreenEnabled() then
		local loading = UI:GetUI("loading");
		loading:EndLoading(levelName, levelFolder, 0);
	end
end


----------------------------------------------------------------------------------------------------
function UI:OnLoadingProgress(levelName, levelFolder, progressAmount)
	UI.PauseGame(false);

	if IsLoadingScreenEnabled() then
		local loading = UI:GetUI("loading");
		loading:SetProgress(progressAmount);
	end
end

function UI:ActivateBackgroundMusic(activate)
	--System.Log("------- MaInUI Onactivate: Music ");
	
	--if (not System.IsEditor() and self.backgroundMusic) then	
	if (not System.IsEditor()) then
		if (activate) then

			if (self.backgroundMusic ~= 1) then
			  Sound.SetMenuMusic(true, "menu", "menu_music");
			  self.backgroundMusic = 1;
			end;

		else
			if (self.backgroundMusic == 1) then
				Sound.SetMenuMusic(false, "menu", "menu_silence");
				self.backgroundMusic = 0;
			end;
		end;
		end
	
end

----------------------------------------------------------------------------------------------------
function UI:IsLoading()
	return UI:GetUI("loading").active;
end
