-- Paste this line into the console window to reload the tweaks file.
-- #Script.ReloadScript("Scripts/Tweaks.lua")

Script.ReloadScript("Scripts/TweaksConfig.lua")

Tweaks.Menus.Main =
{
	MENU = "Main Menu",

	-- The Tweak menu configuration Tweaks
	tMenuTweaks,
	
	--- ItemTweaks menu - for modifying first person camera offsets
	{
		MENU = "ItemTweaks", 
		{
			NAME = "Item offset (right direction)",
			CVAR = "i_offset_right",
			DELTA = "0.01",
		},
		{
			NAME = "Item offset (up direction)",
			CVAR = "i_offset_up",
			DELTA = "0.01",
		},
		{
			NAME = "Item offset (front direction)",
			CVAR = "i_offset_front",
			DELTA = "0.01",
		},
	},

	{
		MENU = "FPAnimations",
	},
	--- Debug menu - Handy debug console vars
	{
		MENU = "Debug",
		{
			NAME = "t_Scale - slow the game down or speed it up",
			CVAR = "t_Scale",
			DELTA = "0.125",
		},	
		{
			NAME = "set p_draw_helpers from the console to show physics helpers",
			CVAR = "p_draw_helpers",
		},
		{
			MENU = "AI Debug",
			{
				NAME = "Enable AI debug drawing",
				CVAR = "ai_DebugDraw",
				DELTA = "1"
			},
			{
				NAME = "set ai_drawpath to an entity name to draw its path",
				CVAR = "ai_DrawPath",
			},
			{
				NAME = "set ai_stats_target to the name of the entity to track, or all",
				CVAR = "ai_StatsTarget",
			},
		},
	},
}


-- Player Preesets

local fp_animations_menu = nil;

for i,v in pairs(Tweaks) do
	if( type(v) == "table") then
		if( v.MENU=="FPAnimations" ) then
			fp_animations_menu = v;
		end
	end
end

function TestFPAction(action)
	--Log("TestFPAction %s",action);
	if not g_localActor then
		return;
	end
	local item = g_localActor.inventory:GetCurrentItem();
	if item then
		item.item:PlayAction(action);
	end
end

-- FIRST PERSON ANIMATION

if( fp_animations_menu ) then

	local test_file, test_file_error = io.open("Game\\Animations\\1st_person.menu", "r");

	if(test_file) then
		for t in test_file:lines() do
			local menu_item = {};
			local action_name = string.gsub(t,"%s*","");
			menu_item.NAME = action_name;
			menu_item.LUACMD = "TestFPAction(\""..action_name.."\");";

			table.insert(fp_animations_menu, menu_item);
		end
	else
		Log("Error reading 1st person test file : "..test_file_error);
	end
	
	--[[
	local test_actions = System.ScanDirectory("Animations\\1st_person\\TestMenu",1);
	for t1,t2 in pairs(test_actions) do
		local action_name = string.gsub(t2,".test","");
		local menu_item = {};
		menu_item.NAME = action_name;
		menu_item.LUACMD = "TestFPAction(\""..action_name.."\");";

		table.insert(fp_animations_menu,menu_item);
	end--]]
end


Tweaks.Scratchpad.RELOAD = true;