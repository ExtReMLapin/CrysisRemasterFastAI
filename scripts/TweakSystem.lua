-- Paste this line into the console window to reload the tweak system
-- 2009/02/09 Moved over for Warface_Frankfurt, by request of Alex McCarthy, but by no means any disrepect to Matthew Jack, by Kevin Kirst
-- #Script.ReloadScript("Scripts/TweakSystem.lua")

-----------------------------------------------------------------
-- Save utils are required for saving the Tweaks
Script.ReloadScript("Scripts/saveutils.lua")

-- Create a root table for the Tweaks system if none exists
if (not Tweaks) then
	Tweaks = {}
end

-- Create a scratchpad table for communication with C++ part of the system
if (not Tweaks.Scratchpad) then
	Tweaks.Scratchpad = 
	{
		SAVEVALUES = false, 		-- True signals that active profile should be saved to disk
		FORCESAVE = false,      -- True signals that _if you try to save_ a complete save of the profile should be forced
		SAVEONEXIT = false,			-- If true, save changes on exiting game
		RELOADVALUES = true, 		-- True signals that all values for all profiles should be (re)loaded from disk
		APPLYPROFILE = false,		-- True signals that the active profile should be applied
		WARNCHANGES = true,			-- If true, prevent switching profiles when there are changes
		DEBUG = false,					-- If true, dump extra debug info. Intended to just be set via Lua command like a cvar
		BLACKBACKGROUND = true, -- If true, displays a black background
		BLACKBACKGROUNDALPHA = 0.70,
		MENUACTIVE = false, 		-- This is set by C++ code only. Adding it here to let you know that it exists.
		VALUESLASTSAVED = { asString = "Not saved", timestampTable = nil, }, -- Used by the Tweak system (C++) when saving is successful
		REPEATRATE = 0.5,				-- Period of input repeat rate
		REPEATDELAY = 2.0,			-- Delay before first input repeat
		FONTSIZE = 1.5,
		VERTSPACE = 24,
		MOTD = false,
		SHOWHIDDEN = false,
		AINOUPDATE = false,
	}
end

-- 
Tweaks.Scratchpad.VALUESLASTSAVED.UpdateTimestamp = function()
	local self = Tweaks.Scratchpad.VALUESLASTSAVED;
	if (not self.timestampTable) then self.timestampTable = {}; end;
	local tsT = self.timestampTable;
	for i,v in pairs( System.GetLocalOSTime()) do
	 tsT[i]=v;
	end
	local profileName = System.GetCVar("g_TweakProfile");
	self.asString = string.format("Profile %s on %d/%d/%d at %02d:%02d", profileName, tsT.mday, tsT.mon, tsT.year+1900, tsT.hour, tsT.min);
end

-- Create a table for storing internal state, for INCREMENTER functions etc.
if (not Tweaks.State) then
	Tweaks.State = 
	{
		g_TweakProfile = {},
		RELOADVALUES = {},
	}
end

-- Initialise a feedback timer for a given state, for x seconds
Tweaks.State.InitFeedbackTimer = function(state, duration)
	state.time = System.GetLocalOSTime().sec;
	state.duration  = duration;
end

-- Check whether a feedback timer is still valid or has expired
Tweaks.State.CheckFeedbackTimer = function(state)
	if (state.time) then 
		local time = System.GetLocalOSTime().sec;
		if ((time - state.time)%60 <= state.duration) then
			return true;
		else
			state.time = nil;
			state.duration = nil;
			return false;
		end
	end
end

-- Create the table that stores all the different sections of the Tweak menu
if (not Tweaks.Menus) then
	Tweaks.Menus = 
	{
		MENU = "Tweak Menu", 
	}
end

-- Create an empty save table, in case we do not load another later
-- The system requires this table to exist or it cannot save
if (not Tweaks.Saving) then
	Tweaks.Saving = 
	{
		Saved = {},					-- Table for recent saved values
		Temp = {}, 					-- Temp table for tweak settings
		Defaults = {}, 			-- The values discovered before loading settings
		Diff = {}, 					-- Table used when finding differences between settings tables
		Profiles = {}, 			-- The different profiles that can be selected - indices are their names, values are the save tables
		SaveDump = {},			-- Table of text dumps of flattened table
	}
end

-- Create a text savefile of the current Tweak values
Tweaks.Saving.GetSaveValues = function()
	Tweaks.Saving.Saved = {};
	Tweaks.Saving.Temp = {};
	Tweaks.Saving.Diff = {};
	Tweaks.Saving.CollectValues(Tweaks.Menus, Tweaks.Saving.Temp);
	FlattenTree(Tweaks.Saving.Temp, Tweaks.Saving.Saved, "tweakssave"); 
	
	
	if ( Tweaks.Scratchpad.FORCESAVE == true ) then
		-- Diff against empty table, i.e. a deep copy :-)
		TableDifferenceRecursive(Tweaks.Saving.Saved, {}, Tweaks.Saving.Diff);
		Tweaks.Scratchpad.FORCESAVE = false;
	else
		-- Find table differences, so that we can save just changed files _in their entirety, not just the differences_
		local profileName = System.GetCVar("g_TweakProfile");
		local profileTable = Tweaks.Saving.Profiles[profileName];
		if (not profileTable) then
			 Tweaks.Saving.Profiles[profileName] = {};
			 profileTable = Tweaks.Saving.Profiles[profileName];
		end
		TableDifferenceRecursive(Tweaks.Saving.Saved, profileTable, Tweaks.Saving.Diff);
	end
	
	-- Convert flattened table into table of text dumps
	Tweaks.Saving.SaveDump = {};
	local tsT = System.GetLocalOSTime();
	local stamp = string.format("--By %s on %d/%d/%d at %02d:%02d\n", System.GetUserName(), tsT.mday, tsT.mon, tsT.year+1900, tsT.hour, tsT.min);

	-- First, create text dumps of _all_ the tables
	local dumps = {};
	for i,v in pairs(Tweaks.Saving.Saved) do
		dumps[i] = DumpTableAsLuaString( v, "Tweaks.Saving.Temp".."."..i, false );
	end
	
	-- Then, for tables we will actually save, concatenate all the other tables into a commented section of each table
	for i,v in pairs(dumps) do
		if (Tweaks.Saving.Diff[i]) then
			local commented = "--[[ State of other Tweaks at time of save was as follows:\n\n";
			for ii,vv in pairs(dumps) do
				if (i ~= ii) then
					commented = commented..(vv.."\n");
				end
			end
			Tweaks.Saving.SaveDump[i] = stamp..v..commented.."]]";
		end
	end
	
end

-- stepping thru the function above crashes editor (still?)

-- Collect defaults by storing all current values
Tweaks.Saving.GetDefaultValues = function()
	Tweaks.Saving.Defaults = {};
	local tempTree = {};
	Tweaks.Saving.CollectValues(Tweaks.Menus, tempTree);
	FlattenTree(tempTree, Tweaks.Saving.Defaults, "tweakssave");
end


-- Collect defaults by storing all current values
Tweaks.Saving.PrepareProfiles = function()
	for name, profile in pairs(Tweaks.Saving.Profiles) do
		-- If the profile doesn't include a value, add it from defaults
		-- This avoid beign forced to save, due to apparent changes
		TableAddRecursive( Tweaks.Saving.Defaults, profile );				
		-- If the defautls don't include a value, remove it from the profile
		-- It's probably obsolete and needs to be dropped
		TableIntersectKeysRecursive( Tweaks.Saving.Defaults, profile );				
	end
end


-- Collect Tweak settings recursively from a table
Tweaks.Saving.CollectValues = function( tweakTable, storeTable )
	for i,v in pairs(tweakTable) do
		-- Is this a table or just annotation (e.g. MENU="...")
		if (type(v) == "table") then
			-- Is the entry another menu?
			if ( v.MENU ) then
				if (v.FILE) then
					-- Save as a subtable, to make a separate file
					if (not storeTable[v.FILE]) then
						storeTable[v.FILE] = {};
					end
					-- Recurse, saving into subtable
					Tweaks.Saving.CollectValues( v, storeTable[v.FILE] );
				else
					-- Recurse
					Tweaks.Saving.CollectValues( v, storeTable );
				end
				
			-- Or is it a Tweak?
			elseif ( v.NAME and not v.NOSAVE ) then
				-- Is it a Lua value?
				if ( v.LUA ) then
					storeTable[v.LUA] = GetValueRecursive(v.LUA);
				elseif (v.CVAR and v.CVAR ~= "") then
					-- It's ok to ignore empty string cvars as they
					-- are useful for triggers with no visual feedback
					storeTable[v.CVAR] = System.GetCVar(v.CVAR);
				end
			end
			-- Otherwise we'll ignore it
		end
	end
end

-- The function called by C++ on a successful save
Tweaks.Saving.SaveComplete = function() 
	-- User feedback
	Tweaks.Scratchpad.VALUESLASTSAVED.UpdateTimestamp();
	-- Update the profiles appropriately
	local profileName = System.GetCVar("g_TweakProfile");
	Tweaks.Saving.Profiles[profileName] = Tweaks.Saving.Saved;
end


-- The function called by C++ on a failed save
Tweaks.Saving.SaveFailed = function(message) 
	-- User feedback
	Tweaks.Scratchpad.VALUESLASTSAVED.asString = message;
end

Tweaks.ReloadStructure = function()
  -- Force reload of this file
  Script.LoadScript("Scripts/Tweaks.lua",true,true);
end



-- Signal that the Tweak menu must be reconstructed		
Tweaks.Scratchpad.RELOAD = true;

-----------------------------------------------------------------
-- Load the Tweaks themselves
Tweaks.ReloadStructure();
