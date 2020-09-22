-- AUTOMATICALLY GENERATED CODE
-- use sandbox (AI/Generate Spawner Scripts) to regenerate this file
Script.ReloadScript("Scripts/Entities/AI/Aliens/Alien.lua")
SpawnAlien =
{
	spawnedEntity = nil,
	Properties =
	{
		commrange = 30,
		bExactPos = 0,
		bIdleStartOnSpawn = 0,
		ragdollPersistence = 0,
		nVoiceID = 0,
		SpawnedEntityName = "",
		bFactionHostility = 1,
		IdleSequence = "None",
		soclasses_SmartObjectClass = "Actor",
		bSquadMateIncendiary = 0,
		SoundPack = "Alien",
		bSquadMate = 0,
		attackrange = 70,
		bTrackable = 1,
		special = 0,
		damageScale = 1,
		aicharacter_character = "GuardAssault",
		Perception =
		{
			stanceScale = 1.8,
			sightrange = 50,
			bThermalVision = 1,
			velBase = 1,
			camoScale = 1,
			FOVSecondary = 160,
			FOVPrimary = 80,
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
		AnimPack = "Alien",
		bCannotSwim = 0,
		fileModel = "Objects/characters/alien/alienbase/alienBase.chr",
		Behavior =
		{
			targetEntity = "",
			targetRange = 18,
			aggressionLevel = 2,
			alarmLevel = 1,
			cloakLevel = 0,
		},
		bGrenades = 0,
		rank = 4,
	},
	PropertiesInstance =
	{
		aibehavior_behaviour = "GuardIdle",
		soclasses_SmartObjectClass = "",
		groupid = 173,
	},
}
SpawnAlien.Properties.SpawnedEntityName = ""
function SpawnAlien:Event_Spawn(sender,params)
	local params = {
		class = "Alien",
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
function SpawnAlien:OnReset()
	if self.spawnedEntity then
		System.RemoveEntity(self.spawnedEntity)
		self.spawnedEntity = nil
	end
end
function SpawnAlien:GetFlowgraphForwardingEntity()
	return self.spawnedEntity
end
function SpawnAlien:Event_Spawned()
	BroadcastEvent(self, "Spawned")
end
function SpawnAlien:Event_Dead(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Dead") end
end
function SpawnAlien:Event_Disable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Disable(ent, sender, param)
		end
	end
end
function SpawnAlien:Event_Enable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Enable(ent, sender, param)
		end
	end
end
--function SpawnAlien:Event_Hide(sender, param)
--	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
--		local ent = System.GetEntity(self.spawnedEntity)
--		if ent and ent ~= sender then
--			self.Handle_Hide(ent, sender, param)
--		end
--	end
--end
function SpawnAlien:Event_Kill(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Kill(ent, sender, param)
		end
	end
end
function SpawnAlien:Event_Spawn(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Spawn(ent, sender, param)
		end
	end
end
function SpawnAlien:Event_Spawned(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Spawned") end
end
SpawnAlien.FlowEvents =
{
	Inputs = 
	{
		Spawn = { SpawnAlien.Event_Spawn, "bool" },
		Disable = { SpawnAlien.Event_Disable, "bool" },
		Enable = { SpawnAlien.Event_Enable, "bool" },
		Hide = { SpawnAlien.Event_Hide, "bool" },
		Kill = { SpawnAlien.Event_Kill, "bool" },
		Spawn = { SpawnAlien.Event_Spawn, "bool" },
	},
	Outputs = 
	{
		Spawned = "bool",
		Dead = "bool",
		Spawned = "bool",
	}
}
SpawnAlien.Handle_Disable = Alien.FlowEvents.Inputs.Disable[1]
SpawnAlien.Handle_Enable = Alien.FlowEvents.Inputs.Enable[1]
SpawnAlien.Handle_Kill = Alien.FlowEvents.Inputs.Kill[1]
SpawnAlien.Handle_Spawn = Alien.FlowEvents.Inputs.Spawn[1]

