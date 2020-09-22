Script.ReloadScript( "SCRIPTS/Entities/AI/Shared/BasicAI.lua");
Script.ReloadScript("scripts/entities/actor/basicalien.lua");

Coordinator_x = {

	AnimationGraph = "Observer.xml",

	foreignCollisionDamageMult = 0.1,	
	selfCollisionDamageMult = 0.01,	
	isAlien = 1,
	isBlind = false,
------------------------------------------------------------------------------------

	PropertiesInstance = {
		aibehavior_behaviour = "CoordinatorIdle",
	},

	Properties = {
		attackrange = 70,
		horizontal_fov = 160,
		accuracy = 1.0,
		esFaction = "Aliens",
		aicharacter_character = "Coordinator",
		fileModel = "Objects/characters/alien/coordinator/coordinator.chr",
		damageScale = 1,

		Perception =
		{
			-- Equivalent to camo scale, used with thermal vision.
			heatScale = 1.0,
			-- Flag indicating that the agent has thermal vision.
			bThermalVision = 1,
		},

	},
	
	physicsParams =
	{
		flags = 0,
		mass = 20,
		stiffness_scale = 73,
					
		Living = 
		{
			gravity = 15,--REMINDER: if there is a ZeroG sphere in the map, gravity is set to 9.81.
						 --It will be fixed, but for now just do all the tweaks without any zeroG sphere in the map.
			mass = 20,
			air_resistance = 0.0,
		},
	},
	
	gameParams =
	{
		stance =
		{
			{
				stanceId = STANCE_STAND,
				normalSpeed = 2.0,
				maxSpeed = 4.0,
				heightCollider = 1.2,
				heightPivot = 1.0,
				size = {x=0.2,y=0.2,z=0.25},
				viewOffset = {x=0,y=0,z=0},
				modelOffset = {x=0,y=0,z=0.2},
				name = "fly",
			},
		},
		
		speedInertia = 20.0,--the more, the faster the speed change: 1 is very slow, 10 is very fast already 
		rollAmount = 0.3, --3.0,
		
		sprintMultiplier = 2.0,--speed is multiplied by this ammount when alien is sprinting
		sprintDuration = 0.4,--how long the sprint is
		
		rotSpeed_min = 5.0,--rotation speed at min speed
		rotSpeed_max = 8.0,--rotation speed at max speed
		
		speed_min = 0.0,--used by the above parameters
		
		forceView = 2.0,--multiply how much the view is taking into account when moving
		
		--graphics related
		modelOffset = {x=0,y=0,z=0},
	},
	
	--melee stuff
	melee =
	{
		melee_animations =
		{
			{
				"melee_03",
				"melee_04",
				1,
			},
		},
		
		damage = 40,			-- damage when doing melee from front
		damageSmall = 16,	-- damage when doing melee from back
		damageOffset = {x=0,y=-2,z=0};		-- Local offset of the damage box
		damageRadius = 1.5,								-- size of the damage box.
		approachLookat = 1,
		alignTime = 0.5,
		damageTime = 0.7,
	},
	
	-- the AI movement ability of the vehicle.
	AIMovementAbility =
	{
		walkSpeed = 3.0,
		runSpeed = 5.0,
		sprintSpeed = 10.0,
		maneuverSpeed = 3.0,
		minTurnRadius = 1,		-- meters
		maxTurnRadius = 10,		-- meters
		b3DMove = 0,-- TO DO: restore it to 1, trooper can navigate in 3D - the problem now is
								-- that 2D navigation (approack, stick) should not consider z displacement
								-- with navigation targets when checking distance
		pathLookAhead = 5,
		cornerSlowDown = 0.5,
		pathRadius = 2,
	},	
	
	Client = {};
	Server = {};

}

-----------------------------------------------------------------------------------------------------
function Coordinator_x:DoPlayerSeen()
	
	BasicAlien.DoPlayerSeen(self);
	
	self:StopAnimation(0,3);
	self:StartAnimation(0, "enemy_sighting_01", 3, 0.15, 1.0, false,true);
end

-----------------------------------------------------------------------------------------------------
function Coordinator_x:DoCallFormation()
	self:PlaySound(self.voiceTable.call_formation, 1);
end

-----------------------------------------------------------------------------------------------------
function Coordinator_x:DoIdleFixMachine()
	
	self:StopAnimation(0,3);
	self:StartAnimation(0, "operate_bubble", 3, 0.15, 1.0, false,true);
end


function Coordinator_x:Kill(ragdoll, shooterId, weaponId)
	BasicAlien.Kill(self,ragdoll,shooterId,weaponId);
		
	if (ragdoll) then
		self.actor:RagDollize();
	end
	
	local pos = self:GetWorldPos();
	Particle.SpawnEffect("alien_special.scout.ScoutExplosion", pos, g_Vectors.v001, 0.25);
	g_gameRules:ClientViewShake(pos,nil,0,10,20,0.25,0.09);
	AI.Signal(SIGNALFILTER_SENDER, 1, "Destructor", self.id);
	-- Notify AI system about this
	self:TriggerEvent(AIEVENT_AGENTDIED);
	self:Hide(1);
end

function Coordinator_x.OnDeathCustom(self)
	System.RemoveEntity(self.id);
end


function Coordinator_x.Client:OnHit(hit, remote)
	if (not BasicAlien.Client.OnHit(self,hit,remote)) then
		return false;
	end
			
	--FIXME: not hardcoded like this
--		if( hit.damage > 90 ) then
		self:StartAnimation(0, "receive_damage_large_front_01", 3, 0.1, 1.0, false,true);
--		else
--			self:StartAnimation(0, "receive_damage_small_front_01", 3, 0.1, 1.0, false,true);
--		end
		
	if(hit.shooter~=nil) then
		g_SignalData.id = hit.shooter.id;
		g_SignalData.fValue = hit.damage;
		CopyVector(g_SignalData.point, hit.shooter:GetWorldPos());
		if (self.Properties.esFaction ~= hit.shooter.Properties.esFaction) then
			if(self == g_localActor) then
				-- manage here the player's CLeader since player doesn't have a character/behaviour
				AI.Signal(SIGNALFILTER_LEADER,0,"ORD_ATTACK",self.id,g_SignalData);
			else
				AI.Signal(SIGNALFILTER_SENDER,0,"OnEnemyDamage",self.id,g_SignalData);
			end
		elseif (self.Behaviour.OnFriendlyDamage ~= nil) then
			AI.Signal(SIGNALFILTER_SENDER,0,"OnFriendlyDamage",self.id,g_SignalData);
		else
			AI.Signal(SIGNALFILTER_SENDER,0,"OnDamage",self.id,g_SignalData);
		end		
	else
		g_SignalData.id = 0;
		g_SignalData.fValue = damage;
		CopyVector(g_SignalData.point, g_Vectors.v000);
		AI.Signal(SIGNALFILTER_SENDER,0,"OnDamage",self.id,g_SignalData);
	end
end

-----------------------------------------------------------------------------------------------------
function Coordinator_x:MakeParalyzed( dir, strength )
	-- dir - direction from the player to the alien, can be used as push direction.
	-- strength - value based on the distance to the center of the blast (1=at players position, 0=at outer range)
	
	-- The alien paralyze goal pipe will reset the attention target, and make the alien to wait for a moment.
	self:InsertSubpipe(0,"alien_paralyze");
	
	-- Push the entity around (this may not make any movememnt, depends on the game code).
	local stats = self:GetPhysicalStats();
	self:AddImpulse(-1, pos, dir, stats.mass*2, 1);
end

-----------------------------------------------------------------------------------------------------
