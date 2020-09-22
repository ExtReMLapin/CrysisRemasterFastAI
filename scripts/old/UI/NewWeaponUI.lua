----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Item UIs
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 17:1:2005   16:52 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------

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
			normal = "textures/weapons/scope.dds",
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


local defaultModify =
{
	screen = 
	{
		class = "static",
		left = 0,
		top = 0,
		width = 800,
		height = 600,
		color = {0,0,0,0},
		
		OnMouseDown = function(self, btn, x, y)
			self.screen:OnClick(btn, x, y);
		end,		
	},

	Reset = function(self, item)
		self.itemId = item.id;
		
		self.available_acc = {};

		-- gather available stuff
		local shooter = item.weapon:GetShooter();
		if (shooter and shooter.inventory) then
			local inventory = shooter.inventory;
			local inventoryTest = inventory:GetInventoryTable();
			if (inventoryTest) then
				for i,accId in ipairs(inventoryTest) do
					local acc = System.GetEntity(accId);
					
					if (acc) then
						if (item.weapon:SupportsAccessory(acc.class)) then
							local ignore = false;
							
							for k,a in ipairs(self.available_acc) do
								if (a.class == acc.class) then
									ignore = true;
									break;
								end
							end

							if (not ignore) then
								table.insert(self.available_acc, acc);
							end
						end
					end
				end
			end
		end
		-- initialize spots
		for i,spot in pairs(self.AccessorySlots) do
			-- set available accessories
			spot.available = {};

			for j,accName in pairs(spot.supports) do	
				for k,acc in pairs(self.available_acc) do
					if (accName == acc.class) then
						table.insert(spot.available, acc);
					end
				end
			end

			-- set current spot
			spot.original_acc = 0;
			for j,acc in pairs(spot.available) do
				if (item.weapon:GetAccessory(acc.class)) then
					spot.original_acc = j;
					break;
				end
			end
			spot.last_acc = spot.original_acc;
			spot.current_acc = spot.original_acc;
		end
	end,
	
	UpdateSpots = function(self)
		local item = System.GetEntity(self.itemId);
		
		for i,spot in pairs(self.AccessorySlots) do
			if (spot.current_acc > 0) then
				item.weapon:AttachAccessoryPlaceHolder(spot.available[spot.current_acc], true);
			elseif (spot.last_acc > 0) then
				item.weapon:AttachAccessoryPlaceHolder(spot.available[spot.last_acc], false);
			end
		end
	end,
	
	Commit = function(self)
		--System.Log("commit")
		local item = System.GetEntity(self.itemId);
		
		if (not item) then
			return;
		end
		-- remove all placeholders		
		for i,spot in pairs(self.AccessorySlots) do
			if (spot.current_acc > 0) then
				item.weapon:AttachAccessoryPlaceHolder(spot.available[spot.current_acc], false);
			end
		end
		item.weapon:ModifyCommit();
		-- restore everything
		
		-- queue the actions
		for i,spot in pairs(self.AccessorySlots) do
			if (spot.current_acc ~= spot.original_acc) then
				if (spot.original_acc > 0) then
					local acc = spot.available[spot.original_acc];
					item.weapon:ScheduleAttach(acc.class, false);
				end
				
				if (spot.current_acc > 0) then
					local acc = spot.available[spot.current_acc];
					item.weapon:ScheduleAttach(acc.class, true);
				end
			end
		end
	end,
	
	UpdateCircles = function(self)
		local item = System.GetEntity(self.itemId);

		-- update slot positions
		for name,spot in pairs(self.AccessorySlots) do
			vecCopy(spot.circle, item.weapon:GetAttachmentHelperPos(name));
			System.ProjectToScreen(spot.circle, spot.circle);
		end	
	end,
	
	OnClick = function(self, btn, x, y)
		for i,spot in pairs(self.AccessorySlots) do
			local n = table.getn(spot.available);
			if (n > 0) then
				if (PointInCircle(x, y, spot.circle, spot.circle.r)) then
					spot.last_acc = spot.current_acc;
					spot.current_acc = spot.current_acc+1;
					
					if (spot.current_acc > n) then
						if (spot.not_empty) then
							spot.current_acc = 1;
						else
							spot.current_acc = 0;
						end
					end
				end
			end
		end
		
		self:UpdateSpots();
	end,

	OnActivate = function(self, activate)
		local item = System.GetEntity(self.itemId);
		self.ui:ShowMouse(activate);
		self.ui:SetMouseXY(400, 300);
		
		self.ui:Focus(activate);
		
		if (not activate) then
			self:Commit();
		end
	end,
	
	OnDraw = function(self)
		local rw = self.ui:GetWidth()/800;
		local rh = self.ui:GetHeight()/600;

		self:UpdateCircles();
		for i,spot in pairs(self.AccessorySlots) do
			if (table.getn(spot.available) > 0) then
				if ((not spot.not_empty) or (table.getn(spot.available) > 1)) then
					UI.DrawCircle(spot.circle.x*rw, spot.circle.y*rh, spot.circle.r*0.5*(rw+rh), nil, {192, 0, 0, 64 });
				end
			end
		end
	end,
};

SCARModify = new(defaultModify);
SCARModify.AccessorySlots =
{
	silencer_attach = 
	{
		circle = { x=385, y=79, r=26, },
		--supports 	= { "SCARSilencer", },
		supports 	= { "Silencer", },
	},

	attachment_top =
	{
		circle = { x=727, y=238, r=26, },
		--supports 	= { "SCARReflex", "SCARScope", },
		supports 	= { "Reflex", "AssaultScope", },
		--not_empty	= true,
	},

	attachment_side =
	{
		circle = { x=470, y=167, r=26, },
		supports	= { "SCARFlashLight", "SCARLaser", },
	},
	
	magazine =
	{
		circle = { x=416, y=384, r=26, },
		supports 	= { "SCARNormalAmmo", "SCARIncendiaryAmmo", },
		not_empty	= true,
	},
};


GaussRiffleModify = new(defaultModify);
GaussRiffleModify.AccessorySlots =
{
	attachment_top =
	{
		circle = { x=727, y=238, r=26, },
		supports 	= { "SCARReflex", "SCARScope", },
	},
};


BinocularsScope = new(defaultScope);
BinocularsScope.overlay.skin.normal = "textures/weapons/binoculars.dds";

ItemSystemUI = UI:BeginUI("SCARModify");
	UI:MakeScreen(SCARModify, "SCARModify");
UI:EndUI();

ItemSystemUI.mouseCursor 	= "textures/gui/mouse.dds";
ItemSystemUI.mouseSize		=	24;

modifyScreen = ItemSystemUI:GetScreen("SCARModify");

modifyScreen.ActivateProxy = function(activate)
	ItemSystemUI:Activate(activate);
	ItemSystemUI:GetScreen("SCARModify"):Activate(activate);
end
	
ItemSystemUI:ShowMouse(false);

WeaponModify = {
	["SCARModify"] = SCARModify,
}