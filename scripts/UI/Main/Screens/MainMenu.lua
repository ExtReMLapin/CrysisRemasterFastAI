----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the main menu!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 16:2:2005   13:01 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
local MainMenu =
{
	background =
	
	{
		class = "static",
		left 	= 0,
		top 	= 0,
		width = 800,
		height= 600,
		zorder= -1,

		skin =
		{
			normal = "textures/gui/bg.dds",
		},
	},
	
	OnUpdate = function(self, frameTime, frameId)
		if (g_gameRules) then

			if(not g_gameRules:IsMultiplayer()) then
				self.ReloadMapFast.visible = true;
			end
			
			for i,v in pairs(self) do
				if ((type(v) == "table") and (UI:IsWidget(v))) then
					if (v.level) then
						--v.visible = false;
					end
				end
			end
		else
			self.ReloadMapFast.visible = false;
		end
	end,
	
	OnActivate = function(self, activate)
		UI:ActivateBackgroundMusic(activate);
	end,
}

function MainMenu:AddLevelMenu(list)
	local ox = 160;
	local oy = 250;
	local w = 120;
	local h = 22;
	local s = 1;
	
	local template= 
	{
		class = "button",
		skin 	=
		{
			normal= "textures/gui/button_idle.dds",
			down	= "textures/gui/button_down.dds",
			over	= "textures/gui/button_idle.dds",
		},
		
		text_color 			= { 146, 167, 169, 255 },
		text_over_color	= { 198, 228, 231, 255 },
		text_down_color	= { 255, 204, 48, 255 },

		OnCommand = function(self)
			--MS hack
			local append = ""
			if((self.level_name=="mp_ps02") or (self.level_name=="mp_sm01"))then
				System.ExecuteCommand("sv_gamerules DeathMatch");
				append = " server"
			end;
			System.Log("LevelName: "..self.level_name);
			System.ExecuteCommand(string.format("map %s"..append, self.level_name));
		end,
	};
	
	local x 	 = ox;
	local y 	 = oy;
	local maxy = 0;
	
	local Act1 = new(template);
	self.Act1=Act1;
	Act1.left = x;
	Act1.top = y-40;
	Act1.width = w;
	Act1.height = h+2;
	Act1.text = "ACT 1       ACT 2       ACT 3";
		
	for i,v in ipairs(list) do
		if (v[1] == "-") then
			y=y+s*2;
		elseif (v[1] == "|") then
			y = oy;
			x=x+s*3+w;
		else
			local btn = new(template);
			btn.text = v[1];
			btn.level_name = v[2];
			
			btn.left = x;
			btn.top = y;
			btn.width = w;
			btn.height = h;
			btn.level = true;
			
			self["start_"..v[2]] = btn;
			y=y+h+s;
		end

		if (y > maxy) then
			maxy = y;
		end
	end

	x=ox;
	y=maxy+3;
	--[[
	local load = new(template);
	self.load = load;
	load.left = x;
	load.top = y;
	load.width = w;
	load.height = h;
	load.text = "Continue Game";
	load.OnCommand = function(self)
		System.ExecuteCommand("load");
	end;
	

	y=y+h+s;
	local ReloadMap = new(template);
	self.ReloadMap = ReloadMap;
	ReloadMap.left = x;
	ReloadMap.top = y;
	ReloadMap.width = w;
	ReloadMap.height = h;
	ReloadMap.text = "Reload Map";
	ReloadMap.OnCommand = function(self)
		if (g_localActor) then
			HUD.ReloadLevel();
		else
			self.ui:Activate(false);
			UI.PauseGame(false);
		end
	end;
	--]]
	--y=y+3;
	y=y+h+s;
	local ReloadMapFast = new(template);
	self.ReloadMapFast = ReloadMapFast;
	ReloadMapFast.left = x;
	ReloadMapFast.top = y;
	ReloadMapFast.width = w;
	ReloadMapFast.height = h;
	ReloadMapFast.text = "RESTART";
	ReloadMapFast.OnCommand = function(self)
		if (g_localActor) then --and g_localActor:IsDead()
			HUD.ReloadLevelSavegame();
		else
			self.ui:Activate(false);
			UI.PauseGame(false);
		end
	end;


	y=y+h+s;
	local options = new(template);
	self.options = options;
	options.left = x;
	options.top = y;
	options.width = w;
	options.height = h;
	options.text = "Graphics: Custom (Full)";
	options.quality = -1;
	options.OnCommand = function(self)
		if (self.ui.active) then
		
			options.quality=options.quality+1;
			
			if(options.quality>2) then
				options.quality=0;
			end;
			
			options.text = MainMenu:SetGraphicOptions(options.quality);
		end;
	end;
	y=y+h+s;

	y=y+h+s;
	local switchMenu = new(template);
	self.switchMenu = switchMenu;
	switchMenu.left = x;
	switchMenu.top = y;
	switchMenu.width = w;
	switchMenu.height = h;
	switchMenu.text = "Multiplayer Menu";
	switchMenu.OnCommand = function(self)
		System.ExecuteCommand("net_lanbrowser 1");
		UI:GetUI("main"):GetScreen("lanmenu"):Activate(true);
		UI:GetUI("main"):GetScreen("mainmenu"):Activate(false);
	end;

	x=x+150;
	local quit = new(template);
	self.quit = quit;
	quit.left = x;
	quit.top = y;
	quit.width = w;
	quit.height = h;
	quit.text = "QUIT";
	quit.OnCommand = function(self)
		if (self.ui.active) then
			System.Quit();
		end
	end;
end

function MainMenu:SetGraphicOptions(Quality)

	local name;
		
	if(Quality==0)then
		name="Graphics: Low";
		System.ExecuteCommand("LoadConfig lowspec.cfg");
	elseif(Quality==1)then
		name="Graphics: Med(HDR)";
		System.ExecuteCommand("LoadConfig medspec.cfg");
	else
		name="Graphics: High(HDR)";
		System.ExecuteCommand("LoadConfig highspec.cfg");
	end;

	System.Log("Graphics set to: " .. name);

	return name;
end;

MainMenu:AddLevelMenu({
	{ "Island",				"island"	},
	{ "Village",			"village"	},
	{ "Rescue",				"rescue"	},
	{ "Harbor",				"harbor"	},
	{ "Tank",					"tank"		},
	{ "Mine",					"mine"		},
	{ "|",},
	{ "Armada",				"armada"	},
	{ "Sphere",				"sphere"	},
	{ "Ice",					"ice"	},
	{ "Airfield",			"airfield"	},
	{ "Capture",			"capture"	},
	{ "Fleet",				"fleet"	},
	{ "|",},
	{ "Crater",				"crater"	},
	{ "Storage",			"storage"	},
	{ "Maintenance",	"maintenance"	},
	{ "Operations",		"operations"	},
	
});

UI:MakeScreen(MainMenu, "mainmenu");
--Disabled by request.
--MainMenu:SetGraphicOptions(1);


