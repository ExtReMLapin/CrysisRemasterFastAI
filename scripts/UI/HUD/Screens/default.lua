----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Default HUD!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 16:2:2005   13:09 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
local default =
{
	--[[
	background =
	{
		class = "static",
		left 	= 0,
		top		= 0,
		width	= 800,
		height= 600,
		
		skin =
		{
			normal = "textures/gui/hud/hud_43.dds",
		},
		
		zorder = -1,
	},
	
	radar =
	{
		class = "radar",
		
		left = 175,
		top = 90,
		width = 50,
		height = 50,

		color = {192, 255, 255, 128},
		
		radius 				= 50,
		radius_zoomed	= 210,
		range					= 45,
		range_zoomed	= 75,
		
		tracker_interval=0.25;
		
		schedule_delay=0.75,

		scanner_color1= {192, 255, 255, 64},
		scanner_color2= {192, 255, 255, 64},
		
--		scanner_color1= {200, 0, 0, 128},
--		scanner_color2= {200, 0, 0, 128},

		
		scanner_blend_speed	=12,
		scanner_bar_width		=1,
		scanner_speed				=180,

		scanner_blinks				= 4;
		scanner_blink_duration= 0.35,
		scanner_stay_duration	= 0.25,

		scanner_sound					= "sounds/gui/hud/target_lock.wav",

		scanner_view_target_delay	= 0.5,
	},

	stealthometer =
	{
		class = "stealthometer",
		
		left = 359,
		top = 580,
		width = 90,
		height = 12,
		
		color = { 64, 64, 64, 128},
		
		speed						= 2,
		stealth_green 	= { 0, 140, 0, 200},
		stealth_yellow 	= { 120, 120, 0, 200},
		stealth_red 		= { 140, 0, 0, 200},		
	},
	
	ecg =
	{
		class = "ecg",

		left 	= 10,
		top 	= 10,
		width = 180,
		height= 80,
		
		scroll	= true,
		visible = false,

		skin =
		{
			normal = "textures/gui/hud/ecg_bg.dds",
			rect	 = { 8, 2, 110, 60 },
		},
	},

	compass =
	{
		class = "compass",
		
		left 	= 330,
		top 	= 26,
		width = 140,
		height= 26,

		north_span		= { 112, 367, }, -- N coordinates
		color					= UIWhite,
		
		border_color	= { 108, 144, 132, 255 },

		needle_width	= 5,
		needle_height	= 8,
		needle_offset	= -12,

		needle =
		{
			normal 	= "textures/gui/hud/compass.dds",
			rect		= { 504, 40+8, 7, -8 },
		},

		skin =
		{
			normal	= "textures/gui/hud/compass.dds",
			rect		= { 0, 4, 140, 52 },
		},
	},
	
	hit_left =
	{
		class = "static",
		
		left 	= 115,
		top 	= 130,
		width = 20,
		height= 300,
		
		color	= { 128, 255, 255, 64 },

		skin 	=
		{
			normal	= "textures/gui/hud/hud_elements.dds",
			rect		= { 7+38, 3, -38, 211 },
		},
	},

	hit_right =
	{
		class = "static",
		
		left 	= 665,
		top 	= 130,
		width = 20,
		height= 280,
		
		color	= { 128, 255, 255, 64 },

		skin 	=
		{
			normal	= "textures/gui/hud/hud_elements.dds",
			rect		= { 7, 3, 38, 211 },
		},
	},

	hit_front =
	{
		class = "static",
		
		left 	= 245,
		top 	= 38,
		width = 300,
		height= 30,
		
		color	= { 128, 255, 255, 0 },

		skin 	=
		{
			normal	= "textures/gui/hud/hud_elements.dds",
			rect		= { 15, 216, 231, 38 },
		},
	},
	
	hit_back =
	{
		class = "static",
		
		left 	= 245,
		top 	= 460,
		width = 300,
		height= 36,
		
		color	= { 128, 255, 255, 0 },

		skin 	=
		{
			normal	= "textures/gui/hud/hud_elements.dds",
			rect		= { 15, 216+38, 231, -38 },
		},
	},
	--]]--
}


UI:MakeScreen(default, "default");


----------------------------------------------------------------------------------------------------
function default:UpdateHitAlerts(hit, headdir, hitdir)	

	local alpha = 0.65;
	local front_treshold = 0.15*alpha;
	local side_treshold = 0.05*alpha;

	local left, right, front, back = 0,0,0,0;
	
	if (hit and hitdir) then
		headdir.z = 0;
		
		local rcplen = 1/vecLen(headdir);
		headdir.x = headdir.x*rcplen;
		headdir.y = headdir.y*rcplen;
		headdir.z = headdir.z*rcplen;
		
		local rightdir = vecNormalize(vecCross(headdir, g_Vectors.up));
		front = -vecDot(headdir, hitdir)*alpha;
		right = -vecDot(rightdir, hitdir)*alpha;

		if (front < 0) then
			back = -front;
			front = 0;
		end

		if (right < 0) then
			left = -right;
			right = 0;
		end
		
		if (left > alpha-front_treshold) then
			left = 0;
		end
		if (right > alpha-side_treshold) then
			right = 0;
		end
		if (front > alpha-side_treshold) then
			front = 0;
		end
	elseif (hit) then
		left = alpha;
		right = alpha;
		front = alpha;
		back = alpha;
	end
		
	self:UpdateHitAlert("left", left);
	self:UpdateHitAlert("right", right);
	self:UpdateHitAlert("front", front);
	self:UpdateHitAlert("back", back);
end


----------------------------------------------------------------------------------------------------
function default:UpdateHitAlert(alert, amount)
	local alert = self["hit_"..alert];
	
	if (amount > 0.001) then
		alert.last_time = _time;
		alert.start_time = _time;
		alert.amount = amount;
	elseif (alert.last_time) then
		if (_time-alert.start_time >= 0.45) then
			local dt = _time-alert.last_time;
			alert.amount = alert.amount-dt*0.75;
		end
		alert.last_time = _time;
	end

	if ((not alert.amount) or (alert.amount < 0.001)) then
		alert.visible = false;
	else
		alert.visible = true;
		alert.color[4] = alert.amount*255;
	end
end


function default:OnDraw(frameTime, frameId, pass)
	if (UI:IsLoading()) then
		return;
	end

	UI.SetFont("hud", "default");
		
	local hr, hg, hb, ha = 0.42, 0.55, 0.52, 1;
	--[[
	
	if (g_localActor and g_localActorId) then
		self.ecg:SetTarget(g_localActorId);
		self.compass:SetTarget(g_localActorId);
		self.radar:SetTarget(g_localActorId);
	else
		self.ecg:SetTarget(nil);
		self.compass:SetTarget(nil);
		self.radar:SetTarget(nil);
	end
	
	if (g_localActor) then
		local weapon;

		local weapon = g_localActor.inventory:GetCurrentItem();
	
		self.viewDir = g_localActor.actor:GetHeadDir(self.viewDir);
		self:UpdateHitAlerts(g_localActor.hit, self.viewDir, g_localActor.hit_dir);
		g_localActor.hit = nil;

		local color = UIWhite;

		if (g_localActor.actor:GetHealth() <= 20) then
			color = UIRed;
		end
		
		HUD:DrawNumber(124, 568, string.format("%d", g_localActor.actor:GetHealth()), 26, color, -1.5);

		if (weapon and weapon.weapon) then
			local ammo = weapon.weapon:GetAmmoCount();
			local clips = weapon.weapon:GetClipCount();
			local clipsize = weapon.weapon:GetClipSize();
			
			if (ammo) then
				HUD:DrawNumberRA(669, 571, string.format("%.1d/%.1d", ammo, clips*clipsize), 23, UIWhite, -1);
			else
				HUD:DrawNumberRA(669, 571, string.format("%.1d/%.1d", 0, 0), 23, UIWhite, -1);
			end
		else
			HUD:DrawNumberRA(669, 571, string.format("%.1d/%.1d", 0, 0), 23, UIWhite, -1);
		end

		--System.DrawText(20, 20, "hud", "default", 0.001, 0, 0, 0, 0);
		
		if(g_localActor.squadmateUseMessage) then
		  HUD:DrawTextCentered(400, 590, g_localActor.squadmateUseMessage, 16, UI:GetColorF(hr, hg, hb, ha)); 
		end
		
		if (g_localActor.godMode and g_localActor.godMode>0) then	
			local deaths = g_localActor.deaths;
			if (not deaths) then
				deaths = 0;
			end
			
			if (g_localActor.godMode>1) then	
				--260, 47		
				HUD:DrawTextCentered(260, 47, "TeamGOD("..deaths..")", 20, UI:GetColorF(0.1, 1, 0.1, 1)); 
			elseif (g_localActor.godMode>0) then
				HUD:DrawTextCentered(260, 47, "GOD("..deaths..")", 20, UI:GetColorF(0.1, 1, 0.1, 1)); 
			end
		end
	end
	
	if (g_RemoteControl) then	  
	  local r = g_RemoteControl;
	  HUD:DrawTextCentered(r.x-10, r.y-12, r.message, r.fontSize+4, UI:GetColorF(hr, hg, hb, ha)); 
	end

	if (g_inVehicle) then -- used for debugging atm
  	local yStart = 300;
    for key,val in pairs(g_inVehicle) do
      HUD:DrawText(100, yStart, key..": "..tostring(val), 14, UI:GetColorF(1, 1, 1, ha));
      yStart = yStart + 18;
    end
  end
	
	if (g_aimode and g_localActor:IsSquadAlive()) then
		if (g_aimode == 1) then
			HUD:DrawImage(370, 550, 60, 26, UIWhite, "textures/gui/hud/hud_artset.dds", {245, 65, 127, 50});
		elseif (g_aimode == 0) then
			HUD:DrawImage(370, 550, 60, 26, UIWhite, "textures/gui/hud/hud_artset.dds", {122, 65, 127, 50});
		end
	end
	--]]
	HUD:UpdateInfoMessages(frameTime);
	HUD:UpdateInstructionMessages(frameTime);
end
