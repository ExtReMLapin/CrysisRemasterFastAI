----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2006.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: 
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 09:06:2006   13:01 : Created by Jan Müller
--
----------------------------------------------------------------------------------------------------
local LANMenu =
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
		if (self.active and (_time - self.lastUpdate > 1)) then
			self.lastUpdate = _time;
			local noMoreServers = false;
			for i	= 1, 10 do
				local btnName = "server"..i;
				local btn = self[btnName];
				if(noMoreServers) then
					btn.text = ""..(self.firstButton+i)..". ".."No server running";
					btn.server_name = nil;
				else
					local server, data, ping = CryAction.GetServer(self.firstButton+i-1);
					if(not server) then
						btn.text = ""..(self.firstButton+i)..". ".."No server running";
						btn.ping = 9999;
						btn.server_name = nil;
						noMoreServers = true;
					else
						btn.server_data = data;
						btn.ping = ping;
						btn.text = ""..(self.firstButton+i)..". "..server.." Ping: "..btn.ping.."  "..btn.server_data;
						btn.server_name = server;
					end
				end
				self[btnName] = btn;
			end
		end
	end,
	
	OnActivate = function(self, activate)
		local firstButton = 0;
		self.firstButton = firstButton;
		local lastUpdate = 0;
		self.lastUpdate = lastUpdate;
	end,
}

function LANMenu:CreateServerList(list)
	local ox = 35;
	local oy = 250;
	local w = 108;
	local h = 20;
	local s = 1;
	
	local serverbutton= 
	{
		class = "button",
		skin 	=
		{
			normal= "textures/gui/button_idle.dds",
			down	= "textures/gui/button_down.dds",
			over	= "textures/gui/button_idle.dds",
		},
		
		text_color 			= { 146, 167, 169, 255 },
		text_over_color	= { 253, 22, 23, 255 },
		text_down_color	= { 255, 204, 48, 255 },
		
		OnUpdate = function(self)
		end,

		OnCommand = function(self)
			if((not (self.name == "MPMenu")) and self.server_name) then
				local append = ""
				System.ExecuteCommand("sv_gamerules DeathMatch");
				append = " server";
				System.Log("ServerName: "..self.server_name);
				CryAction.ConnectToServer(self.server_name);
			end
		end,
	};
	
	local x 	 = ox;
	local y 	 = oy;
	local maxy = 0;
	
	local MPMenu = new(serverbutton);
	self.MPMenu=MPMenu;
	MPMenu.left = x;
	MPMenu.top = y-45;
	MPMenu.width = w;
	MPMenu.height = h+2;
	MPMenu.text = "Multiplayer Menu";

	for i,v in ipairs(list) do
		local btn = new(serverbutton);
		btn.text = v[1];
		btn.server_name = nil;
		btn.server_data = nil;
		btn.ping = 9999;
		btn.left = x;
		btn.top = y;
		btn.width = w;
		btn.height = h;
		
		self[v[2]] = btn;
		y=y+h+s;

		if (y > maxy) then
			maxy = y;
		end
	end;
	
	y=470;
	local scrollUp = new(serverbutton);
	self.scrollUp = scrollUp;
	scrollUp.left = x;
	scrollUp.top = y;
	scrollUp.width = w;
	scrollUp.height = h;
	scrollUp.text = "Scroll UP";
	scrollUp.OnCommand = function(self)
		local firstButton = UI:GetUI("main"):GetScreen("lanmenu").firstButton;
		if(firstButton > 0) then
			firstButton = firstButton - 1;
			UI:GetUI("main"):GetScreen("lanmenu").firstButton = firstButton;
		end
	end;
	local scrollDown = new(serverbutton);
	self.scrollDown = scrollDown;
	scrollDown.left = x+100;
	scrollDown.top = y;
	scrollDown.width = w;
	scrollDown.height = h;
	scrollDown.text = "Scroll DOWN";
	scrollDown.OnCommand = function(self)
		local firstButton = UI:GetUI("main"):GetScreen("lanmenu").firstButton;
		if(firstButton < 989) then
			firstButton = firstButton + 1;
			UI:GetUI("main"):GetScreen("lanmenu").firstButton = firstButton;
		end
	end;
	local refresh = new(serverbutton);
	self.refresh = refresh;
	refresh.left = x+200;
	refresh.top = y;
	refresh.width = w;
	refresh.height = h;
	refresh.text = "Refresh Pings";
	refresh.OnCommand = function(self)
		CryAction.RefreshPings();
	end;
	
	y=y+30;
	local switchMenu = new(serverbutton);
	self.switchMenu = switchMenu;
	switchMenu.left = x;
	switchMenu.top = y;
	switchMenu.width = w;
	switchMenu.height = h;
	switchMenu.text = "Main Menu";
	switchMenu.OnCommand = function(self)
		UI:GetUI("main"):GetScreen("mainmenu"):Activate(true);
		System.ExecuteCommand("net_lanbrowser 0");
		UI:GetUI("main"):GetScreen("lanmenu"):Activate(false);
	end;	
	
	x=700;
	local quit = new(serverbutton);
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

LANMenu:CreateServerList({
		{ "No server running",				"server1"	},
		{ "No server running",				"server2"	},
		{ "No server running",				"server3"	},
		{ "No server running",				"server4"	},
		{ "No server running",				"server5"	},
		{ "No server running",				"server6"	},
		{ "No server running",				"server7"	},
		{ "No server running",				"server8"	},
		{ "No server running",				"server9"	},
		{ "No server running",				"server10"	},
});

UI:MakeScreen(LANMenu, "lanmenu");