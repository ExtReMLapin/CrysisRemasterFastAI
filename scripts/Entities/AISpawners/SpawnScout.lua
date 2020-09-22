-- AUTOMATICALLY GENERATED CODE
-- use sandbox (AI/Generate Spawner Scripts) to regenerate this file
Script.ReloadScript("Scripts/Entities/AI/Aliens/Scout.lua")
SpawnScout =
{
	spawnedEntity = nil,
	Properties =
	{
		autoDestructionTime = 10,
		strafingPitch = 16,
		commrange = 30,
		bExactPos = 0,
		bIdleStartOnSpawn = 0,
		ragdollPersistence = 0,
		nVoiceID = 0,
		SpawnedEntityName = "",
		AnimPack = "Basic",
		IdleSequence = "None",
		soclasses_SmartObjectClass = "Actor",
		bSquadMateIncendiary = 0,
		SoundPack = "Basic",
		shieldAbsorption = 0.9,
		bSquadMate = 0,
		attackrange = 100,
		bTrackable = 1,
		special = 0,
		autoDestructionProbability = 100,
		aicharacter_character = "Scout",
		Perception =
		{
			stanceScale = 1.8,
			sightrange = 100,
			bThermalVision = 1,
			velBase = 1,
			camoScale = 1,
			FOVSecondary = 300,
			FOVPrimary = 220,
			velScale = 0.03,
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
			dmgRatio = 1,
			effect_alien_head = "alien_special.Hunter.WoundedPlasmaBody",
			effect_alien_leg = "alien_special.Hunter.WoundedPlasma",
		},
		accuracy = 1.0,
		objFrozenModel = "",
		bCannotSwim = 0,
		fileModel = "Objects/Characters/Alien/Scout/Scout.cdf",
		bFactionHostility = 1,
		bGrenades = 0,
		rank = 4,
	},
	PropertiesInstance =
	{
		aibehavior_behaviour = "ScoutIdle",
		soclasses_SmartObjectClass = "",
		groupid = 173,
	},
}
SpawnScout.Properties.SpawnedEntityName = ""
function SpawnScout:Event_Spawn(sender,params)
	local params = {
		class = "Scout",
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
		if not evts.Spawned then evts.Spawned = {} end
		table.insert(evts.Spawned, {self.id, "Spawned"})
	end
	BroadcastEvent(self, "Spawned")
end
function SpawnScout:OnReset()
	if self.spawnedEntity then
		System.RemoveEntity(self.spawnedEntity)
		self.spawnedEntity = nil
	end
end
function SpawnScout:GetFlowgraphForwardingEntity()
	return self.spawnedEntity
end
function SpawnScout:Event_Spawned()
	BroadcastEvent(self, "Spawned")
end
function SpawnScout:Event_Dead(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Dead") end
end
function SpawnScout:Event_Disable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Disable(ent, sender, param)
		end
	end
end
function SpawnScout:Event_Enable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Enable(ent, sender, param)
		end
	end
end
function SpawnScout:Event_Kill(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Kill(ent, sender, param)
		end
	end
end
function SpawnScout:Event_Spawn(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Spawn(ent, sender, param)
		end
	end
end
function SpawnScout:Event_Spawned(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Spawned") end
end
SpawnScout.FlowEvents =
{
	Inputs = 
	{
		Spawn = { SpawnScout.Event_Spawn, "bool" },
		Disable = { SpawnScout.Event_Disable, "bool" },
		Enable = { SpawnScout.Event_Enable, "bool" },
		Hide = { SpawnScout.Event_Hide, "bool" },
		Kill = { SpawnScout.Event_Kill, "bool" },
		Spawn = { SpawnScout.Event_Spawn, "bool" },
	},
	Outputs = 
	{
		Spawned = "bool",
		Dead = "bool",
		Spawned = "bool",
	}
}
SpawnScout.Handle_Disable = Scout.FlowEvents.Inputs.Disable[1]
SpawnScout.Handle_Enable = Scout.FlowEvents.Inputs.Enable[1]
SpawnScout.Handle_Kill = Scout.FlowEvents.Inputs.Kill[1]
SpawnScout.Handle_Spawn = Scout.FlowEvents.Inputs.Spawn[1]
