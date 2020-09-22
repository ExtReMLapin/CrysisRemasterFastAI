----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the main user interface!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 16:2:2005   13:01 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
local MainUI = UI:BeginUI("main");
	UI:LoadScript("main/screens/mainmenu.lua");
	UI:LoadScript("main/screens/lanmenu.lua");
UI:EndUI();

MainUI:Activate(not System.IsEditor());
MainUI:Focus(true);
MainUI:GetScreen("mainmenu"):Activate(true);	
MainUI:GetScreen("lanmenu"):Activate(false);	

MainUI.zorder 					= 1000;
MainUI.mouseCursor 			= "textures/gui/mouse.dds";
MainUI.mouseSize				=	24;
MainUI.backgroundColor	= UIBlack;


MainUI.OnKeyDown = function(self, keyCode, keyName, keyChar)
	if (not System.IsEditor()) then
		if (keyName == "esc") then
			if (g_gameRules or (not self.active)) then
				self:Activate(not self.active);
				UI:ActivateBackgroundMusic(self.active);
			end
		elseif ((keyName == "pause") and (not self.active)) then
			UI.PauseGame(not UI.IsGamePaused());
		end
	end
end


function MainUI:OnActivate(activate)
	System.ClearKeyState();
	UI.PauseGame(activate);
	UI:GetUI("hud"):Activate(not activate);
end


local XInputUI = UI:BeginUI("xinput");
	UI:LoadScript("main/screens/xinputdisconnect.lua");
UI:EndUI();

XInputUI:Activate(false);
XInputUI:Focus(true);
XInputUI:GetScreen("xinputdisconnect"):Activate(true);	

XInputUI.zorder 					= 1100;

XInputUI.OnKeyDown = function(self, keyCode, keyName, keyChar)
	if (keyName == "disconnect") then
		if (g_gameRules and (not self.active)) then
			UI.PauseGame(true);
			self:Activate(true);
		end
	elseif (keyName == "connect" or keyName == "enter") then
		if (g_gameRules and self.active) then
			UI.PauseGame(false);
			self:Activate(false);
		end
	elseif (keyName == "space") then
		if (g_gameRules and self.active) then
			UI.PauseGame(false);
			self:Activate(false);
		end
	end
end

