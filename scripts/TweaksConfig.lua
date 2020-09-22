-- Tweaks menu configuration Tweaks
-- 2007/02/08 - Moved here by Matthew Jack
-- 2009/02/09 Moved over for Warface_Frankfurt, by request of Alex McCarthy, but by no means any disrepect to Matthew Jack, by Kevin Kirst

tMenuTweaks =
{
	MENU = "Menu Configuration",

	-- Change current profile
	{
		NAME = "Active Tweak profile:",
		CVAR = "g_TweakProfile",
		NOSAVE = true,
		EVALUATOR = function()
			-- Give user feedback for short period, if it was signalled
			local state = Tweaks.State.g_TweakProfile;
			if (Tweaks.State.CheckFeedbackTimer(state)) then
					return "There are changes - save or revert";
			end
			-- Return nothing to display default value
		end,
		INCREMENTER = function( delta )
			-- Ooooooh yay for the evil function of doom
			local profileName = System.GetCVar("g_TweakProfile");
			-- Collect all values
			Tweaks.Saving.Temp = {};
			Tweaks.Saving.Diff = {};
			Tweaks.Saving.CollectValues(Tweaks.Menus, Tweaks.Saving.Temp);
			local flat = {};
			FlattenTree( Tweaks.Saving.Temp, flat,  "tweakssave");
			Tweaks.Saving.Temp = flat;
			-- Test for changes compared to original profile
			local profileTable = Tweaks.Saving.Profiles[profileName];
			if (not profileTable) then
				profileTable = {};
			end
			-- Add defaults for any missing values, to the saved values
			TableDifferenceRecursive(Tweaks.Saving.Temp, profileTable, Tweaks.Saving.Diff);
			-- Test presence of changes
			local first = pairs(Tweaks.Saving.Diff)(Tweaks.Saving.Diff);
			if (first) then
				if (Tweaks.Scratchpad.WARNCHANGES) then
					-- There are changes - refuse to change, give feedback
					Tweaks.State.InitFeedbackTimer(Tweaks.State.g_TweakProfile, 3);
					if (Tweaks.Scratchpad.DEBUG) then
						-- New items appear with default values and it's best to get them saved out, but this can be confusing
						-- Occaisonally, other code may change the cvars, which is very confusing
						-- Hence it's useful to dump all this at times (but very slow, hence the scratchpad approach)
						System.Log("There were changes - description follows of Tweaks.Saving.Temp, profileTable, Tweaks.Saving.Diff (last is crucial)");
						LogTable(Tweaks.Saving.Temp,"Tweaks.Saving.Temp");
						LogTable(profileTable,"profileTable");
						LogTable(Tweaks.Saving.Diff,"Tweaks.Saving.Diff");
					end
				else
					-- Just store these settings in memory for now
					Tweaks.Saving.Profiles[profileName] = Tweaks.Saving.Temp;
					Tweaks.Saving.Temp = {};
				end
				return;
			end

			-- Find entry before or after current entry. This is totally, utterly evil.
			local found = false;
			local success = false;
			local newProfileName = nil;
			local prevProfileName = nil;
			for i,v in pairs(Tweaks.Saving.Profiles) do
				if (found) then
				  if (delta > 0.0) then
						newProfileName = i;
					end
					found = false; -- Keep going, to find last entry...
				end
				if (i == profileName) then
					found = true;
					if (delta <= 0.0) then
						newProfileName = prevProfileName;
					end
				end
				prevProfileName = i;
			end	
			-- Check for running off the end of the list or failing to find it - use first/last entry
			if (not newProfileName) then
				if (delta > 0.0) then
					local first = pairs(Tweaks.Saving.Profiles)(Tweaks.Saving.Profiles);
					newProfileName = first;
				else
					newProfileName = prevProfileName; -- Should be the last entry...
				end
			end
			
			-- Set that as the new profile
			System.SetCVar("g_TweakProfile",newProfileName);
			
			-- We must now apply those changes
			Tweaks.Scratchpad.APPLYPROFILE = true;
			-- Clear any feedback
			Tweaks.State.g_TweakProfile.time = nil;
		end,
	},	
	-- Profile comment
	--{
	--	NAME = "Profile comment: ",
	--	CVAR = "g_TweakComment",
	--},
	-- Change background visibility
	{		
		NAME = "Black menu background",
		LUA = "Tweaks.Scratchpad.BLACKBACKGROUND",
	},		
	-- Change background alpha
	{		
		NAME = "Black menu background alpha",
		LUA = "Tweaks.Scratchpad.BLACKBACKGROUNDALPHA",
		DELTA = "0.1",
	},
	-- Change input repeat rate
	{		
		NAME = "Tweaks menu input repeat rate",
		LUA = "Tweaks.Scratchpad.REPEATRATE",
		DELTA = "0.1",
	},
	-- Change input repeat delay
	{		
		NAME = "Tweaks menu input repeat delay (until first repeat)",
		LUA = "Tweaks.Scratchpad.REPEATDELAY",
		DELTA = "0.1",
		MINIMUM = 0.1,
		MAXIMUM = 5,
	},
	-- Change font size
	{
		NAME = "Tweak menu font size",
		LUA = "Tweaks.Scratchpad.FONTSIZE",
		DELTA = "0.1",
		MINIMUM = 0.1,
		MAXIMUM = 5,
	},
	-- Change vertical spacing
	{
		NAME = "Tweak menu vertical spacing",
		LUA = "Tweaks.Scratchpad.VERTSPACE",
		DELTA = "1",
		MINIMUM = 10,
		MAXIMUM = 50,
	},
	-- Message of the day
	{		
		NAME = "Display MotD:",
		HIDDEN = true,
		LUA = "Tweaks.Scratchpad.MOTD",
		INCREMENTER = function()
			Tweaks.Scratchpad.MOTD = not Tweaks.Scratchpad.MOTD;
			Script.ReloadScript("Scripts/Tweaks.lua");
		end,
	},
	-- Save LUA changes on exit
	{
		NAME = "Save active profile on exit",
		NOSAVE = true,
		LUA = "Tweaks.Scratchpad.SAVEONEXIT",
	},	
	-- Save LUA changes now
	{		
		NAME = "Save active profile now, last saved this session:",
		LUA = "Tweaks.Scratchpad.VALUESLASTSAVED.asString",
		NOSAVE = true,
		INCREMENTER = function()
			Tweaks.Scratchpad.SAVEVALUES = true;
		end,
	},	
	-- Save LUA changes now
	{		
		NAME = "Force complete save of active profile now",
		LUA = "",
		EVALUATOR = function() return "" end,
		NOSAVE = true,
		INCREMENTER = function()
			Tweaks.Scratchpad.SAVEVALUES = true;
			Tweaks.Scratchpad.FORCESAVE = true;
		end,
	},	
	-- Reload the Tweak changes 
	{		
		NAME = "Revert all values in all profiles",
		LUA = "Tweaks.Scratchpad.RELOADVALUES",
		NOSAVE = true,
		EVALUATOR = function()
			local message = "";
			if (Tweaks.State.CheckFeedbackTimer(Tweaks.State.RELOADVALUES)) then
				message = "Loaded...";
			end
			return message;
		end,
		INCREMENTER = function()
			Tweaks.Scratchpad.RELOADVALUES = true;
			Tweaks.State.InitFeedbackTimer(Tweaks.State.RELOADVALUES, 2);
		end,
	},
	-- Reload the Tweak file
	{		
		NAME = "Reload Tweak menu structure",
		LUA = "Dummy",
		NOSAVE = true,
		EVALUATOR = function()
			return "";
		end,
		INCREMENTER = function()
			Tweaks.ReloadStructure();
		end,
	},
}	
