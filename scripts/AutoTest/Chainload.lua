
function WaitOnCVar(cvar, val, timeout)
	local startTime = System.GetCurrAsyncTime()
	local endTime = startTime + timeout
	while (System.GetCVar(cvar) ~= val and (timeout <= 0 or endTime > System.GetCurrAsyncTime())) do
		coroutine.yield()
	end
end

function WaitForSleep(t)
	local startTime = System.GetCurrAsyncTime()
	local endTime = startTime + t
	while (endTime > System.GetCurrAsyncTime()) do
		coroutine.yield()
	end
end

function DoMap(map)
	System.SetCVar("g_flythrough", 1)
	System.ExecuteDeferredCommand("map "..map.." nb");
	WaitOnCVar("g_flythrough", 0, 1800)
end

function InitCVarState()
	System.SetCVar("r_shadersnocompile", 1)
	System.SetCVar("i_forcefeedback", 0)
	System.SetCVar("g_godmode", 1)
	System.SetCVar("log_verbosity", -1)
	System.SetCVar("log_writetofileverbosity", -1)
end

function VillageSoak()
	InitCVarState()
	
	System.ExecuteDeferredCommand("map ".."village".." nb");
	WaitForSleep(60)
	
	System.ExecuteDeferredCommand("goto 1304 1532 106")
	WaitForSleep(4 * 60 * 60);
	
	System.ExecuteDeferredCommand("unload")
end

function VillageDeathSoak()
	InitCVarState()
	
	System.ExecuteDeferredCommand("map ".."village".." nb");
	WaitForSleep(60)
	
	for i = 1, 50 do
		System.ExecuteDeferredCommand("goto 1304 1532 106")
		WaitForSleep(10);
		System.SetCVar("g_godmode", 0)
		System.ExecuteDeferredCommand("kill")
		WaitForSleep(20);
		System.SetCVar("g_godmode", 1)
	end
	
	System.ExecuteDeferredCommand("unload")
end

function Chainload()
	System.SetCVar("g_chainloading", 1)
	InitCVarState()

	DoMap("island");
	DoMap("village");
	DoMap("rescue");
	DoMap("harbor");
	DoMap("tank");
	DoMap("mine");
	DoMap("core");
	DoMap("sphere");
	DoMap("ice");
	DoMap("fleet");
	
	VillageDeathSoak()
	
	VillageSoak()
	
	System.ExecuteDeferredCommand("memReplayStop")
	System.ExecuteDeferredCommand("g_chainloading 0")
	
	while true do
		coroutine.yield()
	end
end

Game.RegisterCoRoutine(coroutine.create(Chainload))
