----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Weapon Crosshairs
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 16:12:2004   11:38 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
CrosshairDefault =
{
	Draw = function(self, cx, cy, weapon, inradius, outradius, alpha, frameTime)

		-- CXP HACK	
		local theend = UI:GetUI("theend");
		if (theend and theend.active) then
			return;
		end

		local default = UI:GetUI("main");
		if (default and default.active) then
			return;
		end
	
		local lx0, ly0;
		local lx1, ly1;
		
		if (not alpha) then
			alpha = 1.0;
		elseif (alpha < 0.001) then
			return;
		end
		
		local black = UI:GetColorF(0, 0, 0, alpha*0.3);
		local rx = UI.GetScreenWidth()/800;
		local ry = UI.GetScreenHeight()/600;

		lx0 = cx-outradius; ly0 = cy-1;
		lx1 = cx+inradius; ly1 = cy-1;
		UI.DrawQuad(lx0*rx-1, ly0*ry, (outradius-inradius)*rx+2, 3, nil, black);
		UI.DrawQuad(lx1*rx-1, ly1*ry, (outradius-inradius)*rx+2, 3, nil, black);

		lx0 = cx-1; ly0 = cy-outradius;
		lx1 = cx-1; ly1 = cy+inradius;
		UI.DrawQuad(lx0*rx, ly0*ry-1, 3, (outradius-inradius)*ry+2, nil, black);
		UI.DrawQuad(lx1*rx, ly1*ry-1, 3, (outradius-inradius)*ry+2, nil, black);

		local b = 1.15;
		local color = UI:GetColorF(b*0.42, b*0.55, b*0.52, alpha);		
		
		lx0 = cx-outradius; ly0 = cy;
		lx1 = cx+inradius; ly1 = cy;
		UI.DrawLine(lx0*rx, ly0*ry, (lx0+outradius-inradius)*rx, ly0*ry, color);
		UI.DrawLine(lx1*rx, ly1*ry, (lx1+outradius-inradius)*rx, ly1*ry, color);

		lx0 = cx; ly0 = cy-outradius;
		lx1 = cx; ly1 = cy+inradius;
		UI.DrawLine(lx0*rx, ly0*ry, lx0*rx, (ly0+outradius-inradius)*ry, color);
		UI.DrawLine(lx1*rx, ly1*ry, lx1*rx, (ly1+outradius-inradius)*ry, color);
	end,
}



CrosshairLaser =
{
	Draw = function(self, cx, cy, weapon, inradius, outradius, alpha, frameTime)
		-- CXP HACK	
		local theend = UI:GetUI("theend");
		if (theend and theend.active) then
			return;
		end

		local default = UI:GetUI("main");
		if (default and default.active) then
			return;
		end

		local radius 		= 36;
		local minradius = 4;
		local trans			= 1.0;
		local mintrans	= 0.65;
		local mindist		= 1;
		local maxdist		= 200;
		local texture 	= "textures/weapons/laser_pointer.dds";
		local laser 		= true;

		local hit = weapon:GetViewTarget(maxdist);
		
		if (hit) then
			local d 			= hit.distance;

			if (d > mindist) then
				local t = (d/maxdist);
				radius 	= radius-t*(radius-minradius);
				trans		= trans-t*(trans-mintrans);
			end
		else
			laser = false;
		end
		
		if (laser) then
			if (not alpha) then
				alpha = 1.0;
			elseif (alpha < 0.001) then
				return;
			end
			
			if (not self.__uv) then self.__uv = {}; end;
			local uv = self.__uv;
			local du = 1/4;
			local idx= math.random(4);
			
			uv[1] = 0+(idx-1)*du;
			uv[2] = 0;
			uv[3] = uv[1]+du;
			uv[4] = uv[2]+1;
	
			local rx = UI.GetScreenWidth()/800;
			local ry = UI.GetScreenHeight()/600;

			local color = UI:GetColorF(1, 1, 1, alpha*trans);

			UI.DrawQuad((cx-radius*0.5)*rx, (cy-radius*0.5)*ry, radius*rx, radius*ry, UI:GetImage(texture), color, uv);
		end
	end,
}


local defaultScope =
{
	darkness =
	{
		class = "static",
		left 	= 0,
		top 	= 0,
		width = 800,
		height= 600,
		zorder= -2,
		color	= new(UIBlack),
	},
	
	overlay =
	{
		class = "static",
		left 	= 0,
		top 	= 0,
		width = 800,
		height= 600,
		color	= UIWhite,
		zorder= -1,

		skin =
		{
			normal = "textures/weapons/sniperscope.dds",
		},
	},
	
	OnActivate = function(self, activate)
		self.ui:ShowMouse(false);
	end,

	
	Reset = function(self)
		self.darkness.visible = false;
		self.overlay.visible = false;
		self.darkness_start = nil;
		self.darkness_duration = nil;
		self.smooth_start = nil;
		self.smooth_duration = nil;
		self.itemId = nil;
		self:Activate(false);
	end,
	
	Darken = function(self, darken, time, smooth_time)
		if (smooth_time) then
			if (darken) then
				self.smooth_start = _time+time;
			else
				self.smooth_start = _time;
			end
			self.smooth_duration = smooth_time;
		else
			self.smooth_start = nil;
			self.smooth_duration = 0;
		end

		if (darken) then
			self.darkness_start = _time;
		else
			self.darkness_start = _time+smooth_time;
		end

		self.darkness_duration = time;
		self.darkening = darken;
		self.overlay.visible = false;
		self.darkness.visible = false;
		
		if (not self.ui.active) then
			self.ui:Activate(true);
		end
		
		self:Activate(true);
	end,

	OnUpdate = function(self)
		if (self.itemId and (not System.GetEntity(self.itemId))) then
			self:Reset();
		end

		if (self.smooth_start and (self.smooth_start <= _time)) then
			self.darkness.visible = true;
			self.overlay.visible = false;

			local t = (_time-self.smooth_start)/self.smooth_duration;
			
			if (t > 1.0) then
				t = 1.0;
				self.smooth_start = nil;
				self.smooth_duration = nil;
				
				self.darkness.visible = false;

				if (not self.darkness_start) then
					self:Activate(false);
				end
			end
			
			local tt = t;

			if (tt < 0.1) then
				tt = 0;
			end
			tt = tt*tt;
						
			if (self.darkening) then
				self.darkness.color[4] = 255*(1-tt);
			else
				self.darkness.color[4] = 255*(tt);
			end
		end
		if (self.darkness_start and (self.darkness_start <= _time)) then
			self.darkness.visible = true;
			self.overlay.visible = true;

			local t = (_time-self.darkness_start)/self.darkness_duration;

			if (t > 1.0) then
				t = 1.0;
				self.darkness_start = nil;
				self.darkness_duration = nil;
				
				if (self.darkening and (not self.smooth_start)) then
					self:Activate(false);
				elseif (not self.smooth_start) then
					self.darkness.visible = false;
				end
			end
			
			local tt = t;

			if (tt < 0.1) then
				tt = 0;
			end
			tt = tt*tt;
			
			if (self.darkening) then
				self.darkness.color[4] = 255*(tt);
			else
				self.darkness.color[4] = 255*(1-tt);
			end
		end
	end,	
}


WeaponCrosshairs = {
	["default"] = CrosshairDefault,
	["laser"] = CrosshairLaser,
}


----------------------------------------------------------------------------------------------------
function WeaponResetScope(scope)
	local overlay = WeaponScopes[scope];
	if (overlay) then
		overlay:Reset();
	end
end


----------------------------------------------------------------------------------------------------
function WeaponActivateScope(scope, weaponId, activate, darktime, time)
	local overlay = WeaponScopes[scope];
	if (overlay) then
		ItemSystem.itemUI:Activate(activate);
		overlay:Activate(activate);

		if (activate) then
			overlay.weaponId = weaponId;
			overlay:Darken(false, darktime, time);
		else
			overlay:Darken(true, darktime, time*0.75);
		end
	end
end


binocularsScope = new(defaultScope);
binocularsScope.overlay.skin.normal = "textures/weapons/binoculars.dds";


--ItemSystem.itemUI = UI:BeginUI("itemUI");
--	UI:MakeScreen(defaultScope, "scope_default");
--	UI:MakeScreen(binocularsScope, "scope_binoculars");
--UI:EndUI();


WeaponScopes = {
--	["scope_default"] = ItemSystem.itemUI:GetScreen("scope_default"),
--	["scope_binoculars"] = ItemSystem.itemUI:GetScreen("scope_binoculars"),
}