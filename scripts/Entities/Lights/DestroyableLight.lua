----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2008.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Destroyable Light Entity (Mix of destroyable object and light entity)
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 24:04:2008   Created by Benito G.R. 
--
----------------------------------------------------------------------------------------------------
DestroyableLight =
{
	Client = {},
	Server = {},
	States = {"Alive","Dead" },
	
	Properties =
	{
		-- All destroyable object properties -----------------------------------------------
		Model =
		{
				object_Model 					= "objects/library/lights/mine_lamp.cgf",							-- Pre-destroyed model/submodel.
				SubObject_Name				= "",
				object_ModelDestroyed	= "objects/library/lights/mine_lamp_broken.cgf",			-- Post-destroyed model/submodel (same as Model if blank).
				SubObject_NameDestroyed		= "",
		},

		Damage =
		{
				bPlayerOnly 			= 1,																	-- Damaged only by player.
				fHealth						= 100,
				fDamageTreshold		= 0,																	-- Only accept damage higher than this value.
				bExplode					= 0,																	-- Create explosion, using Explosion props
		},
		
		DamageMultipliers = 
		{
		  fCollision = 1.0,
		  fBullet    = 1.0,		  
		},

		Vulnerability	=
		{
			bExplosion = 1,
			bCollision = 1,
			bMelee		 = 1,
			bBullet		 = 1,
			bOther	   = 1,
		},

		Breakage =																							-- => BreakToPieces
		{
			fLifeTime = 10,																					-- Average lifetime of particle pieces
			fExplodeImpulse = 0,																		-- Applies central impulse to pieces, in addition to hit impulse
			bSurfaceEffects = 1,																		-- Generate secondary particle effects from surface type
		},
		
		Explosion =																							-- => Explosion
		{
			Delay 					= 0,																		
			Effect					= "explosions.grenade_air.explosion",
			EffectScale			= 1,
			MinRadius				= 5,
			Radius					= 10,
			MinPhysRadius		= 2.5,
			PhysRadius			= 5,
			Pressure				= 1000,
			Damage					= 1000,
			Decal						= "Materials/Decals/explosions/explo_decal",
			HoleSize				= 10,
			TerrainHoleSize	= 5,
			Direction				= {x=0, y=0, z=1},
			vOffset 				= {x=0, y=0, z=0},
			DelayEffect	=
			{
				bHasDelayEffect = 0,
				Effect					= "",
				vOffset					= {x=0, y=0, z=0},
				vRotation				= {x=0, y=0, z=0},
				Params ={
					SpawnPeriod			= 0,
					Scale						= 1,
					CountScale			= 1,
					bCountPerUnit		= 0,
					bSizePerUnit		= 0,
					AttachType			= "none",
					AttachForm			= "none",
					bPrime					= 0,
				},
			},
		},

		Sounds = {
			sound_Alive = "",
			sound_Dead = "",
			sound_Dying = "",
			fAISoundRadius = 30,
			bStopSoundsOnDestroyed = 1,
		},
				
		Physics = {																							-- Particle pieces always physicalised as rigid bodies
			bRigidBody=1,																						-- True if rigid body.
			bRigidBodyActive = 1,																		-- If rigid body is originally created (1) OR will be created only on OnActivate (0).
			bRigidBodyAfterDeath = 1,																-- True if rigid body after death too.
			bActivateOnDamage = 0,																	-- Activate when a rocket hit the entity.
			Density = -1,
			Mass = -1,
			bPushableByPlayers = 0,
			bCanBreakOthers = 0,
			Simulation =
			{
				max_time_step = 0.02,
				sleep_speed = 0.04,
				damping = 0,
			},
		},
		
		-- End of destroyable object properties
		
		-- Light properties ----------------------------------------------------
		
		LightProperties_Base = {
					
			bUseThisLight = 1,
			Radius = 10,
			vOffset					= {x=0, y=0, z=0},
			vDirection			= {x=0, y=1, z=0},
			Style =
			{
				fCoronaScale = 1,
				fCoronaDistSizeFactor = 1,
				fCoronaDistIntensityFactor = 1,
				nLightStyle = 0,
			},
			Projector =
			{
				texture_Texture = "",
				bProjectInAllDirs = 0,
				fProjectorFov = 90,
				fProjectorNearPlane = 0,
			},
			Color = {
				clrDiffuse = { x=1,y=1,z=1 },
				fDiffuseMultiplier = 1,
				fSpecularMultiplier = 1,
				fHDRDynamic = 0,		-- -1=darker..0=normal..1=brighter
			},
			Options = {
				bCastShadow = 0,
				fShadowBias = 1, --[0,1000,1,"Moves the shadow cascade toward or away from the shadow-casting object."]
				fShadowSlopeBias = 1, --[0,1000,1,"Allows you to adjust the gradient (slope-based) bias used to compute the shadow bias."]
				bIgnoreGeomCaster = 0,
				bAffectsThisAreaOnly = 1,
				bUsedInRealTime=1,
				bFakeLight=0,
				bDeferredLight = 0,
			},
			Test = {
				bFillLight=0,
				bNegativeLight=0,
			},
		},
		
		LightProperties_Destroyed = {
					
			bUseThisLight = 0,
			Radius = 10,
			vOffset					= {x=0, y=0, z=0},
			vDirection			= {x=0, y=1, z=0},
			Style =
			{
				fCoronaScale = 1,
				fCoronaDistSizeFactor = 1,
				fCoronaDistIntensityFactor = 1,
				nLightStyle = 0,
			},
			Projector =
			{
				texture_Texture = "",
				bProjectInAllDirs = 0,
				fProjectorFov = 90,
				fProjectorNearPlane = 0,
			},
			Color = {
				clrDiffuse = { x=1,y=1,z=1 },
				fDiffuseMultiplier = 1,
				fSpecularMultiplier = 1,
				fHDRDynamic = 0,		-- -1=darker..0=normal..1=brighter
			},
			Options = {
				bCastShadow = 0,
				fShadowBias = 1, --[0,1000,1,"Moves the shadow cascade toward or away from the shadow-casting object."]
				fShadowSlopeBias = 1, --[0,1000,1,"Allows you to adjust the gradient (slope-based) bias used to compute the shadow bias."]
				bIgnoreGeomCaster = 0,
				bAffectsThisAreaOnly = 1,
				bUsedInRealTime=1,
				bFakeLight=0,
				bDeferredLight = 0,
			},
			Test = {
				bFillLight=0,
				bNegativeLight=0,
			},
		},
		-- End of light properties ----------------------------------------------------
	},
	
	_LightTable = {},
	
	lightSlot = -1,
}

MakeUsable(DestroyableLight);
MakePickable(DestroyableLight);

-------------------------------------------------------
function DestroyableLight:OnLoad(table)	
	self.bTemporaryUsable = table.bTemporaryUsable;
	self.shooterId = table.shooterId;
	self.health = table.health;
	self.dead = table.dead;
	self.FXSlot = table.FXSlot;
	self.exploded = table.exploded;
	self.rigidBodySlot = table.rigidBodySlot;
	self.isRigidBody = table.isRigidBody;
	self.currentSlot = table.currentSlot;
	self.LastHit = table.LastHit;
	self.lightSlot = table.lightSlot;
		
	self:SetCurrentSlot(self.currentSlot);

	
	if (self.dead) then	
		if (self.Properties.Physics.bRigidBodyAfterDeath == 1) then
			-- temprarolly set bRigidBody to 1, because EntityCommon checks it!
			local aux = self.Properties.Physics.bRigidBody;
			self.Properties.Physics.bRigidBody = 1;
			self:PhysicalizeThis(self.currentSlot);
			self.Properties.Physics.bRigidBody = aux;
		end
	else
		self:PhysicalizeThis(self.currentSlot);
	end
	
	if (self:GetState() ~= table.state) then
	  self:GotoState(table.state)
	end
end

-------------------------------------------------------
function DestroyableLight:OnSave(table)  	
	table.bTemporaryUsable = self.bTemporaryUsable;
	table.shooterId = self.shooterId;
	table.health = self.health;
	table.FXSlot = self.FXSlot;
	table.dead = self.dead;
	table.exploded = self.exploded;
	table.rigidBodySlot = self.rigidBodySlot;
	table.isRigidBody = self.isRigidBody;
	table.currentSlot = self.currentSlot;
	table.LastHit = self.LastHit;
	table.state = self:GetState();
	table.lightSlot = self.lightSlot;
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:CommonInit()
	self.bReloadGeoms = 1;
	self.bTemporaryUsable=0;
	if (not self.bInitialized) then
		self.LastHit = {
			impulse = {x=0,y=0,z=0},
			pos = {x=0,y=0,z=0},
		};
		self:Reload();
		self.bInitialized = 1;
		self:GotoState( "Alive" );
	end
end

----------------------------------------------------------------------------------------------------
function DestroyableLight.Server:OnInit()
	self:CommonInit();
	self:PreLoadParticleEffect( self.Properties.Explosion.Effect );
end

----------------------------------------------------------------------------------------------------
function DestroyableLight.Client:OnInit()
	self:CommonInit();
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:OnPropertyChange()
	self.bReloadGeoms = 1;
	self:Reload();
end


----------------------------------------------------------------------------------------------------
function DestroyableLight:OnShutDown()
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:CanShatter()
	return false;
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:OnReset()
	self:RemoveEffect();
	
	if (self:GetState() ~= "Alive") then
		self:Reload();
	end
	self:AwakePhysics(0);
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:RemoveEffect()
	if(self.FXSlot)then
		self:FreeSlot(self.FXSlot);
		self.FXSlot= -1;
	end;
end;

----------------------------------------------------------------------------------------------------
function DestroyableLight:Reload()
	self:ResetOnUsed();
	local props = self.Properties;
	self.bTemporaryUsable=self.Properties.bUsable;
	self.shooterId = NULL_ENTITY;
	self.health = props.Damage.fHealth;
	self.dead = nil;
	self.exploded = nil;
	self.rigidBodySlot = nil;
	self.isRigidBody = nil;

	if (self.bReloadGeoms == 1) then
		if (not EmptyString(props.Model.object_Model)) then
			self:LoadObject(3,props.Model.object_Model); -- First load whole object in slot 3.
			self:DrawSlot(3,0); -- Make it invisible
			self:LoadSubObject(0,props.Model.object_Model, props.Model.SubObject_Name);
		end
	
		if (not EmptyString(props.Model.object_ModelDestroyed)) then
			self:LoadSubObject(1, props.Model.object_ModelDestroyed, props.Model.SubObject_NameDestroyed);
		elseif (not EmptyString(props.Model.SubObject_NameDestroyed)) then
			self:LoadSubObject(1, props.Model.object_Model, props.Model.SubObject_NameDestroyed);
		end
		
		self:SetCurrentSlot(0);
		self:PhysicalizeThis(0);
	end
	
	-- stop old sounds
	self:StopAllSounds();
	self.bReloadGeoms = 0;
	self:GotoState( "Alive" );
	self:SwitchBaseLight();
	
end

------------------------------------------------------------------------------------------------------
function DestroyableLight:PhysicalizeThis( nSlot )
	local Physics = self.Properties.Physics;
	-- Init physics.
	EntityCommon.PhysicalizeRigid( self,nSlot,Physics,self.bRigidBodyActive );
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:SetCurrentSlot(slot)
	if (slot == 0) then
		self:DrawSlot(0, 1);
		self:DrawSlot(1, 0);
	else
		self:DrawSlot(0, 0);
		self:DrawSlot(1, 1);
	end
	self.currentSlot = slot;
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:Explode()

	local Properties = self.Properties;
	self.bTemporaryUsable=0;
	self.bReloadGeoms = 1;
	
	local hitPos = self.LastHit.pos;
	local hitImp = self.LastHit.impulse;
		
	self:BreakToPieces( 
		0, 0,
		Properties.Breakage.fExplodeImpulse,
		hitPos,
		hitImp,
		Properties.Breakage.fLifeTime, 
		Properties.Breakage.bSurfaceEffects
	);
	
	self:RemoveDecals();
	local bDeleteEntity = false;
		
	self:SetCurrentSlot(1);
	
	if (Properties.Model.object_ModelDestroyed ~="" or Properties.Model.SubObject_NameDestroyed ~="") then
		if (Properties.Physics.bRigidBodyAfterDeath == 1) then
			-- temprarolly set bRigidBody to 1, because EntityCommon checks it!
			local aux = Properties.Physics.bRigidBody;
			Properties.Physics.bRigidBody = 1;
			self:PhysicalizeThis(1);
			Properties.Physics.bRigidBody = aux;
			self:AwakePhysics(1);
		else
			self:PhysicalizeThis(1);
			self:AwakePhysics(1);
		end	
	else
		-- if No destroyed model, this entity must be killed.
		bDeleteEntity = true;
	end

	
	if (NumberToBool(self.Properties.Damage.bExplode)) then
		local expl = self.Properties.Explosion;
		
		local pos = self:GetWorldPos();
		local dirX = self:GetDirectionVector(0);
		local dirY = self:GetDirectionVector(1);
		local dirZ = self:GetDirectionVector(2);
		local offset={x=0,y=0,z=0};
		CopyVector(offset,expl.vOffset);
		
		pos.x = pos.x + dirX.x * offset.x + dirY.x * offset.y + dirZ.x * offset.z;
		pos.y = pos.y + dirX.y * offset.x + dirY.y * offset.y + dirZ.y * offset.z;
		pos.z = pos.z + dirX.z * offset.x + dirY.z * offset.y + dirZ.z * offset.z;
		local explo_pos=pos;
		g_gameRules:CreateExplosion(self.shooterId,self.id,expl.Damage,explo_pos,expl.Direction,expl.Radius,nil,expl.Pressure,expl.HoleSize,expl.Effect,expl.EffectScale, expl.MinRadius, expl.MinPhysRadius, expl.PhysRadius);
	end
	
	-- play the dead sound after explosion
	if (self.dead ~= true) then
		self:PlaySoundEvent(self.Properties.Sounds.sound_Dying,g_Vectors.v000,g_Vectors.v001,0,SOUND_SEMANTIC_MECHANIC_ENTITY);
	end
	self:PlaySoundEvent(self.Properties.Sounds.sound_Dead,g_Vectors.v000,g_Vectors.v001,0,SOUND_SEMANTIC_MECHANIC_ENTITY);
	
	self.exploded = true;
	
	-- ai sound event	
	local aiRadius = self.Properties.Sounds.fAISoundRadius;
	if (aiRadius > 0) then
		if(self.shooterId) then
			AI.SoundEvent(self:GetWorldPos(), aiRadius, AISOUND_EXPLOSION, self.shooterId);
		else
			Log("AI.SoundEvent invalid parameter self.shooterId");
		end
	end
	BroadcastEvent( self,"Explode" );
	
	-- Must be in the last line.
	if (bDeleteEntity == true) then
		--self:DeleteThis();
		self:Hide(1);
	end
end


----------------------------------------------------------------------------------------------------
function DestroyableLight:Die(shooterId)
	self.shooterId = shooterId;
	self.dead = true;
	if (self.health > 0) then
		self.health = 0;
	end
	
	self:PlaySoundEvent(self.Properties.Sounds.sound_Dying,g_Vectors.v000,g_Vectors.v001,0,SOUND_SEMANTIC_MECHANIC_ENTITY);

	-- if we didn't explode yet
	if (not self.exploded) then
		local explosion=self.Properties.Explosion;
		if(explosion.Delay>0 and not explosion.DelayEffect.bHasDelayEffect==1)then
			self:SetTimer(0,explosion.Delay*1000);
		else
			self:GotoState("Dead");
		end
	end
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:IsDead()
	return (self.health <= 0) or self.dead == true;
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:GetHealth()
  return self.health;
end

----------------------------------------------------------------------------------------------------
function DestroyableLight.Server:OnHit(hit)
	if (hit.dir) then
		self:AddImpulse(hit.partId or -1,hit.pos,hit.dir, hit.damage, 1);
	end
		
	CopyVector(self.LastHit.pos, hit.pos);
	CopyVector(self.LastHit.impulse, hit.dir or g_Vectors.v000);
	self.LastHit.impulse.x = self.LastHit.impulse.x * hit.damage;
	self.LastHit.impulse.y = self.LastHit.impulse.y * hit.damage;
	self.LastHit.impulse.z = self.LastHit.impulse.z * hit.damage;
	
	local damage = hit.damage;	
	local vul = self.Properties.Vulnerability;
	local mult = self.Properties.DamageMultipliers;
	
	local pass = true;
	if (hit.explosion) then pass = NumberToBool(vul.bExplosion);
	elseif (hit.type=="collision") then pass = NumberToBool(vul.bCollision); damage = damage * mult.fCollision;
	elseif (hit.type=="bullet") then pass = NumberToBool(vul.bBullet); damage = damage * mult.fBullet;
	elseif (hit.type=="melee") then pass = NumberToBool(vul.bMelee); 
	else pass = NumberToBool(vul.bOther); end	
	
	pass = pass and damage > self.Properties.Damage.fDamageTreshold;	-- damage needs to be higher than treshold
	--Log("%s != %s", tostring(hit.shooterId), tostring(g_localActorId));

	-- damage must come from a player	---------------
	if (pass and NumberToBool(self.Properties.Damage.bPlayerOnly) and (not g_gameRules.game:IsPlayer(hit.shooterId)) ) then     
		pass=false;
	end
	
	BroadcastEvent( self,"Hit" );

	if (pass) then
		self.health = self.health - damage;
	
		if (self.health <= 0) then
			self:Die(hit.shooterId);
		end
		
		if (NumberToBool(self.Properties.bActivateOnDamage)) then
			self:AwakePhysics(1);
		end		
		local explosion=self.Properties.Explosion;
		if(explosion.DelayEffect.bHasDelayEffect==1)then
			if(not self.FXSlot or self.FXSlot==(-1))then
				local rnd=randomF(0,1.5)
				--Log("Setting Delay on "..self:GetName()..": "..explosion.Delay+rnd);
				self:SetTimer(0,(explosion.Delay+rnd)*1000);
				if(not EmptyString(explosion.DelayEffect.Effect))then
					self.FXSlot=self:LoadParticleEffect( -1,explosion.DelayEffect.Effect,explosion.DelayEffect.Params);
					self:SetSlotPos(self.FXSlot,explosion.DelayEffect.vOffset);
					self:SetSlotAngles(self.FXSlot,explosion.DelayEffect.vRotation);
				end;
			end;
		end;
	end
	
	return (self.health <= 0);
end


----------------------------------------------------------------------------------------------------
function DestroyableLight.Server:OnTimer(timerId, msec)
	if (timerId == 0) then
		self:GotoState("Dead");
	end
end

----------------------------------------------------------------------------
function DestroyableLight:UseLight( lightIdx )
	local props;
	if( lightIdx == 0) then 
	 props = self.Properties.LightProperties_Destroyed;
	else
	 props = self.Properties.LightProperties_Base;
	end
	local Style = props.Style;
	local Projector = props.Projector;
	local Color = props.Color;
	local Options = props.Options;

	local diffuse_mul = Color.fDiffuseMultiplier;
	local specular_mul = Color.fSpecularMultiplier;
	
	local lt = self._LightTable;
	lt.style = Style.nLightStyle;
	lt.corona_scale = Style.fCoronaScale;
	lt.corona_dist_size_factor = Style.fCoronaDistSizeFactor;
	lt.corona_dist_intensity_factor = Style.fCoronaDistIntensityFactor;
	lt.radius = props.Radius;
	lt.diffuse_color = { x=Color.clrDiffuse.x*diffuse_mul, y=Color.clrDiffuse.y*diffuse_mul, z=Color.clrDiffuse.z*diffuse_mul };
	if (diffuse_mul ~= 0) then
		lt.specular_multiplier = specular_mul / diffuse_mul;
	else
		lt.specular_multiplier = 1;
	end
	
	lt.hdrdyn = Color.fHDRDynamic;
	lt.projector_texture = Projector.texture_Texture;
	lt.proj_fov = Projector.fProjectorFov;
	lt.proj_nearplane = Projector.fProjectorNearPlane;
	lt.cubemap = Projector.bProjectInAllDirs;
	lt.this_area_only = Options.bAffectsThisAreaOnly;
	lt.realtime = Options.bUsedInRealTime;
	lt.heatsource = 0;
	lt.fake = Options.bFakeLight;
	lt.deferred_light = Options.bDeferredLight;
	lt.fill_light = props.Test.bFillLight;		
	lt.negative_light = props.Test.bNegativeLight;
	lt.indoor_only = 0;
	lt.has_cbuffer = 0;
	lt.cast_shadow = Options.bCastShadow;
	lt.shadow_bias = Options.fShadowBias;
	lt.shadow_slope_bias = Options.fShadowSlopeBias;
		
	lt.lightmap_linear_attenuation = 1;
	lt.is_rectangle_light = 0;
	lt.is_sphere_light = 0;
	lt.area_sample_number = 1;
	
	lt.RAE_AmbientColor = { x = 0, y = 0, z = 0 };
	lt.RAE_MaxShadow = 1;
	lt.RAE_DistMul = 1;
	lt.RAE_DivShadow = 1;
	lt.RAE_ShadowHeight = 1;
	lt.RAE_FallOff = 2;
	lt.RAE_VisareaNumber = 0;

	self.lightSlot = self:LoadLight( -1 ,lt );
	self:SetSlotPosAndDir(self.lightSlot,props.vOffset,props.vDirection);
	
	if ((props.Options.bCastShadows ~= 0) and (props.Options.bIgnoreGeomCaster ~= 0)) then
		self:SetSelfAsLightCasterException( self.lightSlot );
	end
end

-------------------------------------------------------------------
function DestroyableLight:SwitchBaseLight()
	if (self.lightSlot ~= (-1)) then
		self:FreeSlot(self.lightSlot);
		self.lightSlot = -1;
	end
	if (self.Properties.LightProperties_Base.bUseThisLight ~= 0) then
		self:UseLight(1);
	end
end

-------------------------------------------------------------------
function DestroyableLight:SwitchDestroyedLight()
	if (self.lightSlot ~= (-1)) then
		self:FreeSlot(self.lightSlot);
		self.lightSlot = -1;
	end
	if (self.Properties.LightProperties_Destroyed.bUseThisLight ~= 0) then
		self:UseLight(0);
	end
end
----------------------------------------------------------------------------------------------------
-- Alive State
----------------------------------------------------------------------------------------------------
DestroyableLight.Client.Alive =
{
	OnBeginState=function(self)
		self:PlaySoundEvent(self.Properties.Sounds.sound_Alive,g_Vectors.v000,g_Vectors.v001,0,SOUND_SEMANTIC_MECHANIC_ENTITY);
		self:SwitchBaseLight();
	end,
}
DestroyableLight.Server.Alive =
{
	OnTimer = function(self,timerId,msec)
		if (timerId == 0) then
			self:GotoState( "Dead" );
		end
	end,
}

----------------------------------------------------------------------------------------------------
-- Dead State
----------------------------------------------------------------------------------------------------
DestroyableLight.Client.Dead =
{
	OnBeginState=function(self)
		if(self.Properties.Sounds.bStopSoundsOnDestroyed == 1) then
			self:StopAllSounds();
		end
		self:SwitchDestroyedLight();
		if (not CryAction.IsServer()) then
			self:RemoveEffect();
			self:Explode();
			self.dead = true;	
		end
	end,
}
DestroyableLight.Server.Dead =
{
	OnBeginState=function(self)
		self:RemoveEffect();
		self:Explode();
		self.dead = true;
	end,
}

----------------------------------------------------------------------------------------------------
function DestroyableLight:Event_Reset( sender )
	self:OnReset();
	BroadcastEvent( self,"Reset" );
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:Event_Hit( sender )
	BroadcastEvent( self,"Hit" );
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:Event_Explode( sender )
	if self:GetState()=="Dead" then return end
	if self.exploded then return end

	BroadcastEvent( self,"Explode" );
	BroadcastEvent( self, "Break" )

	self:Die(NULL_ENTITY);
end

function DestroyableLight:OnUsed(user, idx)
	if idx == 2 then
		BroadcastEvent(self, "Used")
	end
end

------------------------------------------------------------------------------------------------------
function DestroyableLight.Client:OnPhysicsBreak( vPos,nPartId,nOtherPartId )
	self:ActivateOutput("Break",nPartId+1 );
end

----------------------------------------------------------------------------------------------------
function DestroyableLight:IsUsable(user)

	local ret = nil
	if (self.Properties.bUsable == 1 and self.bTemporaryUsable == 1) then
		ret = 2
	else
		local PhysProps = self.Properties.Physics;
		if (PhysProps.bRigidBody == 1 and PhysProps.bRigidBodyActive == 1 and user.CanGrabObject) then
			ret = user:CanGrabObject(self);
		end
	end
		
	return ret or 0
end

function DestroyableLight:GetUsableMessage(idx)
	if (self.Properties.bUsable == 1 and self.bTemporaryUsable == 1) then
		return self.Properties.UseText;
	else
		return "@grab_object";
	end;
end

------------------------------------------------------------------------------------------------------
function DestroyableLight:Event_Hide()
	self:Hide(1);
	BroadcastEvent( self, "Hide" );
	--self:DrawObject(0,0);
	--self:DestroyPhysics();
end

------------------------------------------------------------------------------------------------------
function DestroyableLight:Event_UnHide()
	self:Hide(0);
	BroadcastEvent( self, "UnHide" );
	--self:DrawObject(0,1);
	--self:SetPhysicsProperties( 1,self.bRigidBodyActive );
end

DestroyableLight.FlowEvents =
{
	Inputs =
	{
		Explode = { DestroyableLight.Event_Explode, "bool" },
		Reset = { DestroyableLight.Event_Reset, "bool" },
		Used = { DestroyableLight.Event_Used, "bool" },
		EnableUsable = { DestroyableLight.Event_EnableUsable, "bool" },
		DisableUsable = { DestroyableLight.Event_DisableUsable, "bool" },
		Hit = { DestroyableLight.Event_Hit, "bool" },
		Hide = { DestroyableLight.Event_Hide, "bool" },
		UnHide = { DestroyableLight.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Explode = "bool",
		Reset = "bool",
		Used = "bool",
		EnableUsable = "bool",
		DisableUsable = "bool",
		Hit = "bool",
		Hide = "bool",
		UnHide = "bool",
		Break = "int",
	},
}
