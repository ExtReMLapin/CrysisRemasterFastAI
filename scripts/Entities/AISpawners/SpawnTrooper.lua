-- AUTOMATICALLY GENERATED CODE
-- use sandbox (AI/Generate Spawner Scripts) to regenerate this file
Script.ReloadScript("Scripts/Entities/AI/Aliens/Trooper.lua")
SpawnTrooper =
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
		AnimPack = "Trooper",
		IdleSequence = "None",
		soclasses_SmartObjectClass = "Actor",
		bSquadMateIncendiary = 0,
		SoundPack = "Trooper",
		bSquadMate = 0,
		attackrange = 70,
		bTrackable = 1,
		special = 0,
		damageScale = 1,
		aicharacter_character = "Trooper",
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
		objFrozenModel = "objects/characters/alien/trooper/trooper_frozen_shatter.cgf",
		fileModel = "Objects/characters/alien/trooper/trooper.cdf",
		bCannotSwim = 0,
		horizontal_fov = 160,
		bFactionHostility = 1,
		bGrenades = 0,
		rank = 4,
	},
	PropertiesInstance =
	{
		aibehavior_behaviour = "TrooperIdle",
		soclasses_SmartObjectClass = "",
		groupid = 173,
	},
}
SpawnTrooper.Properties.SpawnedEntityName = ""
function SpawnTrooper:Event_Spawn(sender,params)
	local params = {
		class = "Trooper",
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
		if not evts.Cloak then evts.Cloak = {} end
		table.insert(evts.Cloak, {self.id, "Cloak"})
		if not evts.EnableCloaked then evts.EnableCloaked = {} end
		table.insert(evts.EnableCloaked, {self.id, "EnableCloaked"})
	end
	BroadcastEvent(self, "Spawned")
end
function SpawnTrooper:OnReset()
	if self.spawnedEntity then
		System.RemoveEntity(self.spawnedEntity)
		self.spawnedEntity = nil
	end
end
function SpawnTrooper:GetFlowgraphForwardingEntity()
	return self.spawnedEntity
end
function SpawnTrooper:Event_Spawned()
	BroadcastEvent(self, "Spawned")
end
function SpawnTrooper:Event_Dead(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Dead") end
end
function SpawnTrooper:Event_Disable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Disable(ent, sender, param)
		end
	end
end
function SpawnTrooper:Event_Enable(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Enable(ent, sender, param)
		end
	end
end
function SpawnTrooper:Event_Kill(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Kill(ent, sender, param)
		end
	end
end
function SpawnTrooper:Event_Spawn(sender, param)
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Spawn(ent, sender, param)
		end
	end
end
function SpawnTrooper:Event_Spawned(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Spawned") end
end

function SpawnTrooper:Event_Cloak(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "Cloak") end
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_Cloak(ent, sender, param)
		end
	end
end

function SpawnTrooper:Event_EnableCloaked(sender, param)
	if sender and sender.id == self.spawnedEntity then BroadcastEvent(self, "EnableCloaked") end
	if self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id)) then
		local ent = System.GetEntity(self.spawnedEntity)
		if ent and ent ~= sender then
			self.Handle_EnableCloaked(ent, sender, param)
		end
	end
end

SpawnTrooper.FlowEvents =
{
	Inputs = 
	{
		Spawn = { SpawnTrooper.Event_Spawn, "bool" },
		Disable = { SpawnTrooper.Event_Disable, "bool" },
		Enable = { SpawnTrooper.Event_Enable, "bool" },
		Hide = { SpawnTrooper.Event_Hide, "bool" },
		Kill = { SpawnTrooper.Event_Kill, "bool" },
		Spawn = { SpawnTrooper.Event_Spawn, "bool" },
		EnableCloaked = { SpawnTrooper.Event_EnableCloaked, "bool" },
		Cloak = { SpawnTrooper.Event_Cloak, "bool" },
	},
	Outputs = 
	{
		Spawned = "bool",
		Dead = "bool",
		Spawned = "bool",
		Cloak = "bool",
		EnableCloaked = "bool",
	}
}
SpawnTrooper.Handle_Disable = Trooper.FlowEvents.Inputs.Disable[1]
SpawnTrooper.Handle_Enable = Trooper.FlowEvents.Inputs.Enable[1]
SpawnTrooper.Handle_Kill = Trooper.FlowEvents.Inputs.Kill[1]
SpawnTrooper.Handle_Spawn = Trooper.FlowEvents.Inputs.Spawn[1]
SpawnTrooper.Handle_Cloak = Trooper.FlowEvents.Inputs.Cloak[1]
SpawnTrooper.Handle_EnableCloaked = Trooper.FlowEvents.Inputs.EnableCloaked[1]
