-- AUTOMATICALLY GENERATED CODE
-- use sandbox (AI/Generate Spawner Scripts) to regenerate this file
Script.ReloadScript("Scripts/Entities/AI/Aliens/Hunter.lua")
SpawnHunter =
{
	spawnedEntity = nil,
	Properties =
	{
		commrange = 30,
		bExactPos = 0,
		bIdleStartOnSpawn = 0,
		ragdollPersistence = 0,
		nVoiceID = 0,
		Damage =
		{
			bLogDamages = 0,
			legsMult = 0.25,
			explosionMult = 0.5,
			health = 1000,
			playerMult = 1,
			bulletMult = 0.1,
			AIMult = 0.1,
			headMult = 1,
			torsoMult = 0.5,
		},
		AnimPack = "Basic",
		IdleSequence = "None",
		soclasses_SmartObjectClass = "Hunter",
		bSquadMateIncendiary = 0,
		SoundPack = "Basic",
		bSquadMate = 0,
		attackrange = 170,
		bTrackable = 1,
		special = 0,
		aicharacter_character = "Hunter",
		Perception =
		{
			stanceScale = 1.8,
			sightrange = 250,
			bThermalVision = 0,
			velBase = 1,
			FOV = 160,
			camoScale = 1,
			FOVSecondary = 160,
			FOVPrimary = 80,
			velScale = 0.1,
			FOVsure = 80,
			audioScale = 1,
			heatScale = 1,
		},
		fGroupHostility = 0,
		esFaction = "Aliens",
		bInvulnerable = 0,
		Vulnerability =
		{
			effect_alien_torso = "alien_special.Hunter.WoundedPlasmaBody",
			dmgMult = 1,
			dmgRatio = 0.1,
			effect_alien_head = "alien_special.Hunter.WoundedPlasmaBody",
			effect_alien_leg = "alien_special.Hunter.WoundedPlasma",
		},
		accuracy = 1.0,
		fileModel = "Objects/Characters/Alien/Hunter/Hunter.cdf",
		horizontal_fov = 270,
		bCannotSwim = 0,
		objFrozenModel = "",
		bFactionHostility = 1,
		bGrenades = 0,
		rank = 4,
	},
	PropertiesInstance =
	{
		aibehavior_behaviour = "HunterIdle",
		soclasses_SmartObjectClass = "",
		groupid = 173,
	},
}
SpawnHunter.Properties.SpawnedEntityName = ""
function SpawnHunter:Event_Spawn(sender,params)
	local params = {
		class = "Hunter",
		position = self:GetPos(),
		orientation = self:GetDirectionVector(1),
		scale = self:GetScale(),
		properties = self.Properties,
		propertiesInstance = self.PropertiesInstance,
	}
	if self.Properties.SpawnedEntityName ~= "" then
		params.name = self.Properties.SpawnedEntityName
	else
		params.name = self:GetName()
	end
	local ent = System.SpawnEntity(params)
	if ent then
		self.spawnedEntity = ent.id
		if not ent.Events then ent.Events = {} end
		local evts = ent.Events
		if not evts.Dead then evts.Dead = {} end
		table.insert(evts.Dead, {self.id, "Dead"})
	end
	BroadcastEvent(self, "Spawned")
end
function SpawnHunter:OnReset()
	if self.spawnedEntity then
		System.RemoveEntity(self.spawnedEntity)
		self.spawnedEntity = nil
	end
end
function SpawnHunter:GetFlowgraphForwardingEntity()
	return self.spawnedEntity
end
function SpawnHunter:Event_Spawned()
	BroadcastEvent(self, "Spawned")
end
function SpawnHunter:Event_Dead(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Dead") end
end
function SpawnHunter:Event_Disable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Disable(ent, sender, param)
		end
	end
end
function SpawnHunter:Event_Enable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Enable(ent, sender, param)
		end
	end
end
function SpawnHunter:Event_GrabVTOL(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_GrabVTOL(ent, sender, param)
		end
	end
end
function SpawnHunter:Event_Kill(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Kill(ent, sender, param)
		end
	end
end
function SpawnHunter:Event_ReleaseVTOL(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_ReleaseVTOL(ent, sender, param)
		end
	end
end
SpawnHunter.FlowEvents =
{
	Inputs = 
	{
		Spawn = { SpawnHunter.Event_Spawn, "bool" },
		Disable = { SpawnHunter.Event_Disable, "bool" },
		Enable = { SpawnHunter.Event_Enable, "bool" },
		GrabVTOL = { SpawnHunter.Event_GrabVTOL, "bool" },
		Kill = { SpawnHunter.Event_Kill, "bool" },
		ReleaseVTOL = { SpawnHunter.Event_ReleaseVTOL, "bool" },
	},
	Outputs = 
	{
		Spawned = "bool",
		Dead = "bool",
	}
}
SpawnHunter.Handle_Disable = Hunter.FlowEvents.Inputs.Disable[1]
SpawnHunter.Handle_Enable = Hunter.FlowEvents.Inputs.Enable[1]
SpawnHunter.Handle_GrabVTOL = Hunter.FlowEvents.Inputs.GrabVTOL[1]
SpawnHunter.Handle_Kill = Hunter.FlowEvents.Inputs.Kill[1]
SpawnHunter.Handle_ReleaseVTOL = Hunter.FlowEvents.Inputs.ReleaseVTOL[1]
