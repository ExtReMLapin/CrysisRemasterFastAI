Script.ReloadScript("SCRIPTS/Entities/AI/Shared/BasicAI.lua");
Script.ReloadScript("scripts/entities/actor/basicalien.lua");

Observer_x = {

	AnimationGraph = "Observer.xml",

	foreignCollisionDamageMult = 0.1,	
	selfCollisionDamageMult = 0.01,	
	isAlien = 1,
	isBlind = false,
------------------------------------------------------------------------------------

	PropertiesInstance = {
		aibehavior_behaviour = "ObserverIdle",
	},

	Properties = {
		walkSpeed = 3.0,
		runSpeed = 5.0,
		sprintSpeed = 10.0,
		maneuverSpeed = 3.0,
	  bExactPos = 0,
		commrange = 100.0,
		attackrange = 70,
--		horizontal_fov = 45,
		accuracy = 1.0,
		esFaction = "Aliens",
		aicharacter_character = "Observer",
		soclasses_SmartObjectClass = "Observer",
		fileModel = "Objects/characters/alien/observer/observer.chr",
		damageScale = 1,
		
		Perception =
		{
			--how visible am I
			camoScale = 1,
			--movement related parameters
			--VELmultyplier = (velBase + velScale*CurrentVel^2);
			--current priority gets scaled by VELmultyplier
			velBase = 1,
			velScale = .03,
			--fov/angle related
			FOVPrimary = 40,			-- normal fov
			FOVSecondary = 160,		-- periferial vision fov
			--ranges			
			sightrange = 50,
			--how heights of the target affects visibility
			--// compare against viewer height
			-- fNewIncrease *= targetHeight/stanceScale
			stanceScale = 1.8,
			-- Equivalent to camo scale, used with thermal vision.
			heatScale = 1.0,
			-- Flag indicating that the agent has thermal vision.
			bThermalVision = 1,
		},		
		
	},
	
	physicsParams =
	{
	},
	
	gameParams =
	{
		stance =
		{
			{
				stanceId = STANCE_STAND,
				normalSpeed = 1.5,
				maxSpeed = 3.0,

				heightCollider = 1.5,
				heightPivot = 1.3,
				size = {x=0.2,y=0.2,z=0.2},
				modelOffset = {x=0,y=0,z=0.25},

				viewOffset = {x=0,y=0.15,z=0.9},
				name = "stand",
			},
			{
				stanceId = STANCE_PRONE,
				normalSpeed = 2.5,
				maxSpeed = 5.0,
				
				heightCollider = 0.7,
				heightPivot = 0.6,
				size = {x=0.2,y=0.2,z=0.2},
				modelOffset = {x=0,y=0,z=0.25},

				viewOffset = {x=0,y=0.15,z=0.9},
				name = "prone",
			},
		},
	
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
		b3DMove = 0,
		minTurnRadius = 0.1,		-- meters
		maxTurnRadius = 0.5,		-- meters
		pathType = AIPATH_TROOPER,
		pathLookAhead = 2,
		cornerSlowDown = 0.5,
		pathRadius = 1,
		passRadius = 0.6,		-- the radius used in path finder. 
	},	
	
	Client = {};
	Server = {};

}

-----------------------------------------------------------------------------------------------------
function Observer_x:DoPlayerSeen()
	
	BasicAlien.DoPlayerSeen(self);
	
	self:StopAnimation(0,3);
	self:StartAnimation(0, "enemy_sighting_01", 3, 0.15, 1.0, false,true);
end

-----------------------------------------------------------------------------------------------------
function Observer_x:DoCallFormation()
	self:PlaySound(self.voiceTable.call_formation, 1);
end

-----------------------------------------------------------------------------------------------------
function Observer_x:DoIdleFixMachine()
	
	self:StopAnimation(0,3);
	self:StartAnimation(0, "operate_bubble", 3, 0.15, 1.0, false,true);
end


function Observer_x:Kill(ragdoll, shooterId, weaponId)
	BasicAlien.Kill(self,ragdoll,shooterId,weaponId);
		
	if (ragdoll) then
		self.actor:RagDollize();
	end
	
	local pos = self:GetWorldPos();
	Particle.SpawnEffect("alien_special.scout.ScoutExplosion", pos, g_Vectors.v001, 0.25);
	g_gameRules:ClientViewShake(pos,nil,0,10,20,0.25,0.09);
	
--	System.RemoveEntity(self.id);
end

function Observer_x.Client:OnHit(hit, remote)
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
function Observer_x:MakeParalyzed( dir, strength )
	-- dir - direction from the player to the alien, can be used as push direction.
	-- strength - value based on the distance to the center of the blast (1=at players position, 0=at outer range)
	
	-- The alien paralyze goal pipe will reset the attention target, and make the alien to wait for a moment.
	self:InsertSubpipe(0,"alien_paralyze");
	
	-- Push the entity around (this may not make any movememnt, depends on the game code).
	local stats = self:GetPhysicalStats();
	self:AddImpulse(-1, pos, dir, stats.mass*2, 1);
end

-----------------------------------------------------------------------------------------------------

