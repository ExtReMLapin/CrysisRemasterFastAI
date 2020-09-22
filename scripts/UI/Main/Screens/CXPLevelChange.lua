----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the next level screen!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 16:2:2005   13:01 : Created by Craig Tiller from MainMenu.lua
--
----------------------------------------------------------------------------------------------------

if (_clicked_menu) then
	System.Quit();
	
	return;
end


local GetBackgroundName = function()
	if CXP_NextLevel == "cxp_part_2" then
		return "textures/gui/CXP1_complete.dds"
	else
		return "textures/gui/CXP2_complete.dds"
	end
end

local CXPLevelChange = UI:BeginUI("levelchange")
UI:MakeScreen({
	cxp1 =
	{
		class = "static",
		left 	= 0,
		top 	= 0,
		width = 800,
		height= 600,
		zorder= -1,
		color	= {0,0,0,0},

		skin =
		{
			normal = GetBackgroundName(),
		}
	},
	
	OnUpdate = function(self, frameTime, frameId)
		if (self.ftb) then
			if (not self.ftb_start) then
				self.ftb_start = _time;
			end
			local dt = _time-self.ftb_start;
			self.cxp1.color[4] = math.min(255, 255*dt/2);
			
			Sound.SetMasterVolumeScale(math.max(0, (1-dt/2)));

			if (dt >= 2) then
				dt = 2;
				self.ftb = false;
				self.fpic = true;
			end
		elseif (self.fpic) then
			if (not self.fpic_start) then
				self.fpic_start = _time;
			end

			local dt = _time-self.fpic_start;
			self.cxp1.color[1] = math.min(255, 255*dt/0.5);
			self.cxp1.color[2] = math.min(255, 255*dt/0.5);
			self.cxp1.color[3] = math.min(255, 255*dt/0.5);
		end
		
		
		if not self.timer then
			self.timer = 0
		else
			self.timer = self.timer + frameTime;
			
			if (self.timer > 17) then
				if (not self.fmus_start) then
					self.fmus_start = _time;
					UI.PauseGame(false);
				end
				
				local dt = _time-self.fmus_start;
			end

			if self.timer > 20 then
				System.Quit()
			end
		end
	end,
	
}, "levelchange");
UI:EndUI()

local mm = UI:GetUI("mainmenu")
if mm then mm:Activate(false) end


HUD:Hide(true);
CXPLevelChange:Focus(true)
CXPLevelChange:GetScreen("levelchange").ftb = true;
CXPLevelChange:GetScreen("levelchange"):Activate(true)
CXPLevelChange:Activate(true)
UI.EnableInput(true)

local weapon = GetLocalWeapon();
if (weapon) then
	weapon:FadeCrosshair(weapon:GetCrosshairAlpha(), 0, 0.25);
end

Script.SetTimer(250, function() UI.PauseGame(true); if (GetLocalWeapon()) then GetLocalWeapon():EnableCrosshair(false); end; end);