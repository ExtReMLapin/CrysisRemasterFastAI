EntityCommon = {
	TempPhysParams = { mass=0,density=0 },
	TempPhysicsFlags = { flags_mask=0, flags=0 };
}

----------------------------------------------------------
-- Creates a new table that is derived class of parent entity.
----------------------------------------------------------
function MakeDerivedEntity( _DerivedClass,_Parent )
	local derivedProperties = _DerivedClass.Properties;
	_DerivedClass.Properties = {};
	mergef(_DerivedClass,_Parent,1);
	
	-- Add derived class properties.
	mergef(_DerivedClass.Properties,derivedProperties,1);
	
	_DerivedClass.__super = BasicEntity;
	return _DerivedClass;
end

----------------------------------
function BroadcastEvent( sender,Event  )
	-- Check if Event Target for this input event exists.
	sender:ProcessBroadcastEvent( Event );
	if (sender.Events) then
		--System.Log( "Events found" );
		local eventTargets = sender.Events[Event];
		if (eventTargets) then
			--System.Log( "Events Targets found" );
			for i, target in pairs(eventTargets) do
				local TargetId = target[1];
				local TargetEvent = target[2];
				--System.Log( "Target: "..TargetId.."/"..TargetEvent );
				--System.Log( "Target: "..TargetEvent );
				
				if (TargetId == 0) then
					-- If TargetId refer to global Mission table.
					if Mission then
						local func = Mission["Event_"..TargetEvent];
						if (func ~= nil) then
							func( sender )
						else
							System.Log( "Mission does not support event "..TargetEvent );
						end
					end
				else
					-- If TargetId refere to Entity.
					local entity = System.GetEntity(TargetId);
					if (entity ~= nil) then
						
						local TargetName=entity:GetName();
						--System.Log( "Entity Named "..TargetName.." Found." );
						--System.Log( "Calling method: "..TargetName..":Event_"..TargetEvent );
						local func = entity["Event_"..TargetEvent];
						if (func ~= nil) then
							func( entity,sender )
--						else
--							System.Log( "Entity "..TargetName.." does not support event "..TargetEvent );
						end
--					else
--						System.Log( "Entity Named "..TargetName.." Not Found." );
					end
				end
 			end
 		end
 	end
end

function DumpEntities()
	local ents=System.GetEntities();
	System.Log("Entities dump");
	for idx,e in pairs(ents) do
		local pos=e:GetPos();
		local ang=e:GetAngles();
		System.Log("["..tostring(e.id).."]..name="..e:GetName().." clsid="..e.class..format(" pos=%.03f,%.03f,%.03f",pos.x,pos.y,pos.z)..format(" ang=%.03f,%.03f,%.03f",ang.x,ang.y,ang.z));
	end
end

-- makes an OnUsed event for designers on an entity...
-- usage:
-- MyEntity = { ... whatever you usually put here ... }
-- MakeUsable(MyEntity)
-- function MyEntity:OnSpawn() ...
-- function MyEntity:OnReset()
--   self:ResetOnUsed()
--   ...
-- end
function MakeUsable( entity )
	if not entity.Properties then entity.Properties = {} end
	entity.Properties.UseText = "";
	entity.Properties.bUsable = 0;
	function entity:IsUsable()
		if not self.__usable then self.__usable = self.Properties.bUsable end;
		return self.__usable;
	end
	function entity:ResetOnUsed()
		self.__usable = nil;
	end
	function entity:GetUsableMessage()
		return self.Properties.UseText;
	end
	function entity:OnUsed(user, idx)
		BroadcastEvent(self, "Used");
	end
	function entity:Event_Used()
		BroadcastEvent(self, "Used");
	end
	function entity:Event_EnableUsable()
		self.__usable = 1;
		BroadcastEvent(self, "EnableUsable");
	end
	function entity:Event_DisableUsable()
		self.__usable = 0;
		BroadcastEvent(self, "DisableUsable");
	end
end

function MakePickable( entity )
	if not entity.Properties then entity.Properties = {} end;
	entity.Properties.bPickable = 0;
end

function MakeSpawnable( entity )
	entity.spawnedEntity = nil
	-- setup some basic properties
	if not entity.Properties then entity.Properties = {} end
	local p = entity.Properties;
	p.bSpawner = false;
	p.SpawnedEntityName = "";
	
	local _OnDestroy = entity.OnDestroy;
	
	function entity:OnDestroy()
		-- System.Log("OnDestroy"..tostring(self.id));
		if self.whoSpawnedMe then
			-- inform that I'm dead
			self.whoSpawnedMe:NotifyRemoval(self.id);
		end
		if _OnDestroy then
			_OnDestroy(self);
 		end
	end

	function entity:NotifyRemoval(spawnedEntityId)
		-- System.Log("NotifyRemoval"..tostring(self.id).." spawned="..tostring(spawnedEntityId));
		-- clear spawnedEntity on original
		if (self.spawnedEntity and self.spawnedEntity == spawnedEntityId) then
 			--System.Log("...Cleared");
			self.spawnedEntity = nil;
		end
	end		
		
	-- override some functions to have our code called also
	local _OnReset = entity.OnReset;
	function entity:OnReset()
		--System.Log("reset");
		if self.spawnedEntity then
			System.RemoveEntity(self.spawnedEntity);
			self.spawnedEntity = nil;
		end
		if self.whoSpawnedMe then
			System.RemoveEntity( self.id );
			return
		end
		_OnReset(self);
	end
	-- allow flowgraph forwarding
	function entity:GetFlowgraphForwardingEntity()
		return self.spawnedEntity
	end
	-- OnSpawned event
	function entity:Event_Spawned()
		BroadcastEvent(self, "Spawned")
	end

	if not entity.FlowEvents then entity.FlowEvents = {} end
	local fe = entity.FlowEvents
	-- normalize events
	fe.Inputs = fe.Inputs or {}
	fe.Outputs = fe.Outputs or {}

	-- collate events
	local allEvents = {}
	local name, data
	for name, data in pairs(fe.Outputs) do
		allEvents[name] = data
	end
	for name, data in pairs(fe.Inputs) do
		allEvents[name] = data
	end

	-- event rebinding
	for name, data in pairs(allEvents) do
		local isInput = fe.Inputs[name]
		local isOutput = fe.Outputs[name]
		local isDeath = (name=="Dead")
		local _event = data
		if type(_event) == "table" then
			_event = _event[1]
		else
			_event = nil
		end
		entity["Event_"..name] = function(self, sender, param)
			-- auto broadcast received things for outputs
			if isOutput and (sender and sender.id == self.spawnedEntity or sender==self) then
--				AI.LogEvent( ">>broadcasting output event "..name );
				BroadcastEvent(self, name)
			end
			-- forward events where necessary
			if isInput and (self.spawnedEntity and ((not sender) or (self.spawnedEntity ~= sender.id))) then
				local ent = System.GetEntity(self.spawnedEntity)
				if _event and ent and ent ~= sender then
					_event(ent, sender, param)
				end
			elseif _event and not self.spawnedEntity then
				-- and pass through where not
				_event(self, sender, param)
			end
			-- handle death events
			if isDeath and (sender and sender.id == self.spawnedEntity) then
				self.spawnedEntity = nil
			end
		end
	end

	-- spawn event
	function entity:Event_Spawn()
		if self.whoSpawnedMe then
			-- we were spawned (and not placed on a level)...
			-- GetForwardingEntity will make sure that this event
			-- is sent here first, but this event *MUST* be handled
			-- by our spawner
			self.whoSpawnedMe:Event_Spawn()
		else
			if self.spawnedEntity then
				return
			end
			local params = {
				class = self.class;
				position = self:GetPos(),
				orientation = self:GetDirectionVector(1),
				scale = self:GetScale(),
				archetype = self:GetArchetype(),
				properties = self.Properties,
				propertiesInstance = self.PropertiesInstance,
			}
			if self.Properties.SpawnedEntityName ~= "" then
				params.name = self.Properties.SpawnedEntityName
			else
				params.name = self:GetName().."_s"
				
			end
			local ent = System.SpawnEntity(params, self.id)
			if ent then
				self.spawnedEntity = ent.id
				if not ent.Events then ent.Events = {} end
				local evts = ent.Events
				for name, data in pairs(self.FlowEvents.Outputs) do
					if not evts[name] then evts[name] = {} end
					table.insert(evts[name], {self.id, name})
				end
				ent.whoSpawnedMe = self;
		
				--self:Event_Spawned();
				self:ActivateOutput("Spawned", ent.id);
			end
		end
	end

	-- spawn event keep
	function entity:Event_SpawnKeep()
		local params = {
			class = self.class;
			position = self:GetPos(),
			orientation = self:GetDirectionVector(1),
			scale = self:GetScale(),
			archetype = self:GetArchetype(),
			properties = self.Properties,
			propertiesInstance = self.PropertiesInstance,
		}
		local rndOffset = 1;
		params.position.x = params.position.x + random(0,rndOffset*2)-rndOffset;
		params.position.y = params.position.y + random(0,rndOffset*2)-rndOffset;
		params.name = self:GetName()
		local ent = System.SpawnEntity(params, self.id)
		if ent then
			self.spawnedEntity = ent.id
			if not ent.Events then ent.Events = {} end
			local evts = ent.Events
			for name, data in pairs(self.FlowEvents.Outputs) do
				if not evts[name] then evts[name] = {} end
				table.insert(evts[name], {self.id, name})
			end
--			ent.whoSpawnedMe = self;
			--self:Event_Spawned();
			self:ActivateOutput("Spawned", ent.id);
		end
	end
	
--hidhing/unhiding should be done inside desable/enable	
--	function entity:Event_Hide()
--		self:Hide(1)
--	end

	fe.Inputs["Spawn"] = {entity.Event_Spawn, "bool"}
--	fe.Inputs["Hide"] = {entity.Event_Hide, "bool"}
	fe.Outputs["Spawned"] = "entity";
end

---------------------------------------------------------------------------------------------------
-- Physicalize rigid body.
---------------------------------------------------------------------------------------------------
--GlobalPhysicsSimParams = { max_logged_collisions = 1 };


EntityCommon.PhysicalizeRigid = function( entity,nSlot,Properties,bActive )
  local Mass = Properties.Mass; 
  local Density = Properties.Density;
  
  local physType;
  
  if (Properties.bArticulated == 1) then
		physType = PE_ARTICULATED;
	else
		if (Properties.bRigidBody == 1) then
			physType = PE_RIGID;
		else
			physType = PE_STATIC;
		end
		
	end
	
	local TempPhysParams = EntityCommon.TempPhysParams;

	TempPhysParams.density = Density;
	TempPhysParams.mass = Mass;
	TempPhysParams.flags = 0;
		
	entity:Physicalize( nSlot, physType, TempPhysParams );
	
	--entity:SetPhysicParams(PHYSICPARAM_SIMULATION, GlobalPhysicsSimParams );
	
	
	local Simulation = Properties.Simulation;
	if (Simulation) then
		entity:SetPhysicParams(PHYSICPARAM_SIMULATION, Simulation);
	end
	
	local Buoyancy = Properties.Buoyancy;
	if (Buoyancy) then
		entity:SetPhysicParams(PHYSICPARAM_BUOYANCY, Buoyancy);
	end
	
	-----------------------------------------------------------------------------
	-- Set physical flags.
	-----------------------------------------------------------------------------
	local PhysFlags = EntityCommon.TempPhysicsFlags;
	PhysFlags.flags =  0;
	if (Properties.bPushableByPlayers == 1) then
	  PhysFlags.flags = pef_pushable_by_players;
	end
	if (Simulation and Simulation.bFixedDamping and Simulation.bFixedDamping==1) then
		PhysFlags.flags = PhysFlags.flags+pef_fixed_damping;
	end
	if (Simulation and Simulation.bUseSimpleSolver and Simulation.bUseSimpleSolver==1) then
		PhysFlags.flags = PhysFlags.flags+ref_use_simple_solver;
	end
	if (Properties.bCanBreakOthers==nil or Properties.bCanBreakOthers==0) then
		PhysFlags.flags = PhysFlags.flags+pef_never_break;
	end
	PhysFlags.flags_mask = pef_fixed_damping + ref_use_simple_solver + pef_pushable_by_players + pef_never_break;
	entity:SetPhysicParams( PHYSICPARAM_FLAGS,PhysFlags );
	-----------------------------------------------------------------------------

	if (Properties.bResting == 0) then
		entity:AwakePhysics(1);
	else
		entity:AwakePhysics(0);
	end
end

-------------------------------------------------------------------------------
-- Compare entities by name (for table.sort)
-------------------------------------------------------------------------------

function CompareEntitiesByName( ent1, ent2 )
	return ent1:GetName() < ent2:GetName()
end

function MakeCompareEntitiesByDistanceFromPoint( point )
	function CompareEntitiesByDistanceFromPoint( ent1, ent2 )
		distance1 = DistanceSqVectors( ent1:GetWorldPos(), point )
		distance2 = DistanceSqVectors( ent2:GetWorldPos(), point )
		return distance1 > distance2
	end
	return CompareEntitiesByDistanceFromPoint
end
