-- AUTOMATICALLY GENERATED CODE
-- use sandbox (AI/Generate Spawner Scripts) to regenerate this file
Script.ReloadScript("Scripts/Entities/AI/Aliens/Observer.lua")
SpawnObserver =
{
	spawnedEntity = nil,
	Properties =
	{
		commrange = 100,
		bExactPos = 0,
		bIdleStartOnSpawn = 0,
		ragdollPersistence = 0,
		nVoiceID = 0,
		SpawnedEntityName = "",
		bFactionHostility = 1,
		IdleSequence = "None",
		soclasses_SmartObjectClass = "Actor",
		bSquadMateIncendiary = 0,
		SoundPack = "Basic",
		bSquadMate = 0,
		attackrange = 70,
		bTrackable = 1,
		special = 0,
		damageScale = 1,
		aicharacter_character = "Observer",
		Perception =
		{
			stanceScale = 1.8,
			sightrange = 50,
			bThermalVision = 1,
			velBase = 1,
			camoScale = 1,
			FOVSecondary = 160,
			FOVPrimary = 40,
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
		AnimPack = "Basic",
		bCannotSwim = 0,
		fileModel = "Objects/characters/alien/observer/observerprototype.chr",
		objFrozenModel = "",
		bGrenades = 0,
		rank = 4,
	},
	PropertiesInstance =
	{
		aibehavior_behaviour = "ObserverIdle",
		soclasses_SmartObjectClass = "",
		groupid = 173,
	},
}
SpawnObserver.Properties.SpawnedEntityName = ""
function SpawnObserver:Event_Spawn(sender,params)
	local params = {
		class = "Observer",
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
function SpawnObserver:OnReset()
	if self.spawnedEntity then
		System.RemoveEntity(self.spawnedEntity)
		self.spawnedEntity = nil
	end
end
function SpawnObserver:GetFlowgraphForwardingEntity()
	return self.spawnedEntity
end
function SpawnObserver:Event_Spawned()
	BroadcastEvent(self, "Spawned")
end
function SpawnObserver:Event_Dead(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Dead") end
end
function SpawnObserver:Event_Disable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Disable(ent, sender, param)
		end
	end
end
function SpawnObserver:Event_Enable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Enable(ent, sender, param)
		end
	end
end
function SpawnObserver:Event_Kill(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Kill(ent, sender, param)
		end
	end
end
function SpawnObserver:Event_Spawn(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Spawn(ent, sender, param)
		end
	end
end
function SpawnObserver:Event_Spawned(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Spawned") end
end
SpawnObserver.FlowEvents =
{
	Inputs = 
	{
		Spawn = { SpawnObserver.Event_Spawn, "bool" },
		Disable = { SpawnObserver.Event_Disable, "bool" },
		Enable = { SpawnObserver.Event_Enable, "bool" },
		Hide = { SpawnObserver.Event_Hide, "bool" },
		Kill = { SpawnObserver.Event_Kill, "bool" },
		Spawn = { SpawnObserver.Event_Spawn, "bool" },
	},
	Outputs = 
	{
		Spawned = "bool",
		Dead = "bool",
		Spawned = "bool",
	}
}
SpawnObserver.Handle_Disable = Observer.FlowEvents.Inputs.Disable[1]
SpawnObserver.Handle_Enable = Observer.FlowEvents.Inputs.Enable[1]
SpawnObserver.Handle_Kill = Observer.FlowEvents.Inputs.Kill[1]
SpawnObserver.Handle_Spawn = Observer.FlowEvents.Inputs.Spawn[1]
