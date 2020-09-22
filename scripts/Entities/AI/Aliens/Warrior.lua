--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2007.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Warrior class
--  
--------------------------------------------------------------------------
--  History:
--  - 01/2007     : Created by Sascha Gundlach
--
--------------------------------------------------------------------------

Warrior = 
{
	Client = {},
	Server = {},
	Properties=
	{
		esFaction = "Aliens",
		fileModel 					= "objects/characters/alien/warrior/warrior_body_anim.cga",
		Spawn = {
			fTrooperInterval = 10;
		},
		Hover = {
			MoveSpeed = 10,
			TurnSpeed = 10,
			SlowDistance = 2,
			fInterval = 1,
		},
		Hatch = {
			fHatchOpen = 30,
			fHatchClose = 5,
		},
		Reminder = {
			fTurrets = 25,
			fScouts = 25,
		},
		Freezebeam = {
			fInterval = 10,
			fActiveTime = 15
		},
		SingularityCannons = {
			bAlwaysAimAtPlayer = 0,
			DestroyTrigger =4,
			fInterval = 20,
			fHealth = 200,
		},
		Vulnerability	=
		{
			fDamageTreshold = 0,
			bExplosion = 1,
			bCollision = 1,
			bMelee		 = 1,
			bBullet		 = 1,
			bOther	   = 1,
		},
		
	},
	LastHit =
	{
		impulse = {x=0,y=0,z=0},
		pos = {x=0,y=0,z=0},
	},
		
	Editor=
	{
		Icon="Item.bmp",
		ShowBounds = 1,
		Links = {
			"SingularityCannon_01",		--00
			"SingularityCannon_02",		--01
			"Scout_1",								--02
			"Scout_2",								--03
			"Scout_3",								--04
			"Turret_1",								--05
			"Turret_2",								--06
			"Turret_3",								--07
			"Turret_4",								--08
			"Turret_5",								--09 - disabled
			"Turret_6",								--10 - disabled
			"FreezeBeam",							--11
			"Hatch",									--12
			"Interior",								--13 - unused
			"Trooper_1",							--14
			"Trooper_2",							--15
			"Trooper_3",							--16
			"Scout_4",								--17
			"Scout_5",								--18
			"Scout_6",								--19
		},
	},
	States = {"Disabled","PhaseOne","PhaseTwo"},
	
	DestroyedTurrets = 0;
	Turrets = {},
	SingularityCannons = {},
	Interior=nil,
	HoverSpots = {},
	DeckDestructionAnchors ={},
	SCFirePos=nil,
	PhaseTwoPos=nil,
	iScoutWavesDefeated=0,
	hatchdestroyed=0,
	hatchdamage=0,
	troopertime=0,
	freezebeam_active=0,
	Physics = {
		Density= -1,
		Mass= -1,
		bRigidBody=0,
		bRigidBodyActive=0,
		bRigidBodyAfterDeath=0;
	};
	pos = {x=0,y=0,z=0},
	tmp = {x=0,y=0,z=0},
	dir = {x=0,y=0,z=0},
	bSCFired=0,
	NextSC=0,
	bSC1Intact=true,
	bSC2Intact=true,
	turretsdestroyed=0,
	freezbeam_preactivated=0,
	freezebeamstate="",
	hatchstate="",
	cannons_ready=0,
	defeated=0,
	bPostLoadUpdate=0,
}
-----------------------------------------------------------------------------------------
WARRIOR_FIRE_SC										= 1;
WARRIOR_CHECK_TURRETS							= 2;
WARRIOR_ACTIVATE_FREEZEBEAM 			= 3;
WARRIOR_DEACTIVATE_FREEZEBEAM			= 4;
WARRIOR_CHECK_SCOUTS							= 5;
WARRIOR_CHECK_SINGULARITYCANNONS	= 6;
WARRIOR_PHASE_TWO									= 7;
WARRIOR_HOVER											= 8;
WARRIOR_OPEN_HATCH								= 9;
WARRIOR_CLOSE_HATCH								= 10;
WARRIOR_CHECK_TROOPERS						= 11;
WARRIOR_REMINDER_TURRETS					= 12;
WARRIOR_REMINDER_SCOUTS						= 13;
WARRIOR_REMINDER_TAC							= 14;
WARRIOR_REMINDER_HATCH						= 15;
WARRIOR_INTERIOR_DESTRUCTION			= 16;
WARRIOR_SCOUTS_OVERRIDE						= 17;
WARRIOR_CANNONS_READY							= 18;
WARRIOR_REMINDER_TAC2							= 19;

-----------------------------------------------------------------------------------------
function Warrior:OnDestroy()	
	local size=table.getn(self.Turrets);
	self.Turrets={};
	if(self.Interior~=nil)then
		Entity.DetachThis(self.Interior.id,0);
		System.RemoveEntity(self.Interior.id);
	end;
		
	local size=table.getn(self.SingularityCannons);
	for i=1,size do
		Entity.DetachThis(self.SingularityCannons[i].id,0);
		System.RemoveEntity(self.SingularityCannons[i].id);
	end;
	self.SingularityCannons={};
end

function Warrior:OnReset()
	local props=self.Properties;
 	if(not EmptyString(props.fileModel))then
 		self:LoadObject(0,props.fileModel);
 	end;
	self.Movement= {
		active=0,
		positon={x=0,y=0,z=0},
		lasthoverspot=0,
		dir={x=0,y=0,z=0},
		vel={x=0,y=0,z=0},
		rot={x=0,y=0,z=0},
	};
	
	--self:InitExternalObjects();
	
	self.bSCFired=0;
	self.NextSC=0;
	self.bSC1Intact=true;
	self.bSC2Intact=true;
	self.bFirstWaveSpawn=1;
	self.iScoutWavesDefeated=0;
		
	self.Movement.position={x=0,y=0,z=0};
	self.pos={x=0,y=0,z=0};
	self.dir={x=0,y=1,z=0};
	self.Movement.active=0;
	self.DestroyedTurrets=0;

	self:PhysicalizeThis();
	self:ActivateTurrets(false);
	self.freezebeamstate="Closed";
	self.hatchstate="Closed";
	self.cannons_ready=0;
	self.defeated=0;
		
	self:GotoState("Disabled");
end;

function Warrior:PhysicalizeThis()
	EntityCommon.PhysicalizeRigid(self,0,self.Physics,0);
	self:SetPhysicParams(PHYSICPARAM_FLAGS, {flags_mask=pef_disabled, flags=pef_disabled});
end;

function Warrior:OnPropertyChange()
	self:OnReset();
end;

function Warrior:OnPreFreeze(freeze, vapor)
	if (freeze) then
		return false; -- don't allow freezing
	end
end;

function Warrior:InitExternalObjects()

	self:CreateTurrets();
	self:CreateSingularityCannons();
	self:CreateHoverSpotTable();
	self:CreateDeckDestructionTable();
	self:CreateInterior();
			
	self.Scouts={};
	self.Scouts[1]=self:GetLinkTarget("Scout_1");
	self.Scouts[2]=self:GetLinkTarget("Scout_2");
	self.Scouts[3]=self:GetLinkTarget("Scout_3");
	
	self.Scouts2={};
	self.Scouts2[1]=self:GetLinkTarget("Scout_4");
	self.Scouts2[2]=self:GetLinkTarget("Scout_5");
	self.Scouts2[3]=self:GetLinkTarget("Scout_6");
	
	self.Troopers={};
	self.Troopers[1]=self:GetLinkTarget("Trooper_1");
	self.Troopers[2]=self:GetLinkTarget("Trooper_2");
	self.Troopers[3]=self:GetLinkTarget("Trooper_3");
	
	local size=table.getn(self.Turrets);
	for i=1,size do
		if(self.Turrets[i]~=nil)then
			if(self.Turrets[i]:GetName()=="Warrior_Freezebeam")then
				self.Turrets[i].Properties.GunTurret.bEnabled=0;
				break;
			end;
		end;
	end;
end;

----------------------------------------------------------------------------------------------------
function Warrior.Server:OnInit()
	if(not self.bInitialized)then
		self:OnReset();
		self.bInitialized=1;
	end;
end;

------------------------------------------------------------------------------------------------------
function Warrior:Event_Reset()
	--hack
	self:InitExternalObjects();
	local size=table.getn(self.Turrets);
	--Log("Turrets: "..size.." !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	for i=1,size do
		--Log(self.Turrets[i]:GetName()..": "..i);
	end;
	
	--hack
end;
----------------------------------------------------------------------------------------------------
function Warrior.Client:OnInit()
	if(not self.bInitialized)then
		self:OnReset();
		self.bInitialized=1;
	end;
end;

--Create and attach singularity cannons.
function Warrior:CreateSingularityCannons()
	local size=table.getn(self.SingularityCannons);
	for i=1,size do
		Entity.DetachThis(self.SingularityCannons[i].id,0);
		System.RemoveEntity(self.SingularityCannons[i].id);
	end;
	self.SingularityCannons={};
	
	self:SpawnSingularityCannon(0);
	self:SpawnSingularityCannon(1);
	
	--Singularity Cannon 1: 0 
	--Singularity Cannon 2: 1
	self.SingularityCannon_Weapon1=self:GetLinkTarget("SingularityCannon_01");
	self.SingularityCannon_Weapon2=self:GetLinkTarget("SingularityCannon_02");
end;

--Create and attach mounted turrets.
function Warrior:CreateTurrets()

	self.Turrets={};
	self.Turrets[1]=self:GetLinkTarget("Turret_1");
	self.Turrets[2]=self:GetLinkTarget("Turret_2");
	self.Turrets[3]=self:GetLinkTarget("Turret_3");
	self.Turrets[4]=self:GetLinkTarget("Turret_4");
	self.Turrets[5]=self:GetLinkTarget("Turret_5");
	self.Turrets[6]=self:GetLinkTarget("Turret_6");
	self.Turrets[7]=self:GetLinkTarget("FreezeBeam");
	--Log("Turrets!!!!");
	self:ActivateTurrets(false);
	self:MakeTurretsVulnerable(0);
end;

-- Create list of designer placed hoverspots. The Warrior will move between these
-- spots while in phase one of the fight.
function Warrior:CreateHoverSpotTable()
	self.HoverSpots={};
	self.SCFirePos=nil;
	local tmp=System.GetEntitiesInSphere(self:GetPos(),500);
	for i,v in ipairs(tmp)do
		if(v~=nil and System.GetEntityClass(v.id)=="SmartObject")then
			if(v.Properties and v.Properties.soclasses_SmartObjectClass=="Warrior_Hoverspot")then
				table.insert(self.HoverSpots,v);
			elseif(v.Properties and v.Properties.soclasses_SmartObjectClass=="Warrior_SCFireSpot")then
				self.SCFirePos=v;
			elseif(v.Properties and v.Properties.soclasses_SmartObjectClass=="Warrior_Phase_2_Position")then
				self.PhaseTwoPos=v;
			end;
		end;
	end;
	--Log(table.getn(self.HoverSpots).." hoverspots found.");
end;

function Warrior:CreateDeckDestructionTable()
	self.DeckDestructionAnchors={};
	local tmp=System.GetEntitiesInSphere(self:GetPos(),500);
	for i,v in ipairs(tmp)do
		if(v~=nil and System.GetEntityClass(v.id)=="SmartObject")then
			if(v.Properties and v.Properties.soclasses_SmartObjectClass=="Warrior_FirePos")then
				table.insert(self.DeckDestructionAnchors,v);
			end;
		end;
	end;
	--Log(table.getn(self.DeckDestructionAnchors).." deck destruction objects found.");
end;

--Create and attach interior.
function Warrior:CreateInterior()
	if(self.Interior~=nil)then
		Entity.DetachThis(self.Interior.id,0);
		System.RemoveEntity(self.Interior.id);
		self.Interior=nil;
	end;
	
	local spawnParams = {};
	
	spawnParams.name = "Interior";
	spawnParams.class = "DestroyableObject";
	spawnParams.archetype="Aliens.Warriors.Warrior_Interior";
	spawnParams.position=self:GetPos();
	spawnParams.orientation=self:GetDirectionVector();
	spawnParams.properties={};
	spawnParams.properties.bExplode=1;
	spawnParams.properties.Physics={};
	--spawnParams.properties.Physics.Density= -1;
	--spawnParams.properties.Physics.Mass= -1;
	spawnParams.properties.Physics.bRigidBody=0;
	spawnParams.properties.Physics.bRigidBodyActive=0;
	spawnParams.properties.Physics.bRigidBodyAfterDeath=0;
	spawnParams.properties.Explosion=
	{
		Delay 					= 0,																		
		Effect					= "explosions.grenade_air.explosion",
		EffectScale			= 3,
		Radius					= 0,
		Pressure				= 0,
		Damage					= 0,
		Decal						= "Materials/Decals/explosions/explo_decal",
		HoleSize				= 0,
		TerrainHoleSize	= 0,
		Direction				= {x=0, y=0, z=1},
	};
	spawnParams.properties.Vulnerability	=
	{
		bExplosion = 0,
		bCollision = 0,
		bMelee		 = 0,
		bBullet		 = 0,
		bOther	   = 0,
	};
	--Don't use main/remain
	spawnParams.properties.DestroyedSubObject="";
	spawnParams.properties.ModelSubObject="";
	local tmp;
	spawnParams.properties.object_Model="objects/characters/alien/warrior/warrior_hatch.cgf";
	
	spawnParams.properties.object_ModelDestroyed="objects/characters/alien/warrior/warrior_hatch.cgf";
	tmp=System.SpawnEntity(spawnParams,self.id);
	tmp.Properties.Explosion.vOffset={x=0, y=0, z=0};

	local pos = self:GetWorldPos();
	local dirX = self:GetDirectionVector(0);
	local dirY = self:GetDirectionVector(1);
	local dirZ = self:GetDirectionVector(2);
	local offset= g_Vectors.temp_v1;
	
	CopyVector(offset,{x=0,y=-36.5,z=-14});
		
	pos.x = pos.x + dirX.x * offset.x + dirY.x * offset.y + dirZ.x * offset.z;
	pos.y = pos.y + dirX.y * offset.x + dirY.y * offset.y + dirZ.y * offset.z;
	pos.z = pos.z + dirX.z * offset.x + dirY.z * offset.y + dirZ.z * offset.z;
		
	if(tmp~=nil)then
		self:AttachChild(tmp.id,0);
		self.Interior=tmp;
		self.Interior:SetWorldPos(pos);
		self.Interior:SetDirectionVector(self:GetDirectionVector());
	else
		--Log("Couldn't create interior");
	end;
end;

function Warrior:SpawnSingularityCannon(side)
	
	local spawnParams = {};
	local model;
	if(side==0)then
		spawnParams.archetype="Aliens.Warriors.Warrior_SC_1";
		model="objects/characters/alien/warrior/warrior_arm1_cannon_anim.cga";
	else
		spawnParams.archetype="Aliens.Warriors.Warrior_SC_2";
		model="objects/characters/alien/warrior/warrior_arm2_cannon_anim.cga";
	end;
	spawnParams.name = "SC_"..side;
	spawnParams.class = "DestroyableObject";
	spawnParams.position=self:GetPos();
	spawnParams.orientation=self:GetDirectionVector();
	
	local tmp;
	tmp=System.SpawnEntity(spawnParams,self.id);
	if(tmp~=nil)then
		--overwrite slot 0 
		tmp:LoadObject(0,model);
		tmp:CharacterUpdateOnRender(0,1);
		self:AttachChild(tmp.id,0);
		tmp:SetWorldPos(self:GetPos());
		tmp.health=self.Properties.SingularityCannons.fHealth;
		tmp.Properties.Vulnerability.bBullet=0;
		tmp.Properties.Vulnerability.bExplosion=0;
		table.insert(self.SingularityCannons,tmp);
		tmp:SetDirectionVector(self:GetDirectionVector());
	else
		--Log("Couldn't create SC "..side);
	end;
end;

function Warrior:MakeTurretsVulnerable(vulnerable)
	local size=table.getn(self.Turrets);
	for i=1,size do
		if(self.Turrets[i]~=nil)then
			if(self.Turrets[i]:GetName()~="Warrior_Freezebeam")then
				self.Turrets[i].Properties.GunTurret.bVulnerable=vulnerable;
			end;
		end;
	end;
end;

function Warrior:ActivateTurrets(activated)
	local size=table.getn(self.Turrets);
	for i=1,size do
		if(self.Turrets[i]~=nil)then
			if(self.Turrets[i]:GetName()~="Warrior_Freezebeam")then
				self.Turrets[i].Properties.GunTurret.bEnabled=activated;
			end;
		end;
	end;
end;

function Warrior:SpawnTroopers()
	local size=table.getn(self.Troopers);
	local num=0;
	for i=1,size do
		local entity = self.Troopers[i];
		if(self.Troopers[i]~=nil)then
			self.Troopers[i]:Event_Spawn();
		end;
	end;
	self:SetTimer(WARRIOR_CHECK_TROOPERS,5*1000);
end;

function Warrior:CheckTrooperWave()
	self.troopertime=self.troopertime+1;
	if(self.Interior and not self.Interior:IsDead())then
		if(self:TrooperWaveDefeated())then
			Log("Trooper Wave defeated!");
			self:OpenHatch();
			self:SpawnTroopers();
			self.troopertime=0;
		else
			Log("Trooper Wave alive!");
			if(self.hatchdestroyed==0)then
				self:SetTimer(WARRIOR_CHECK_TROOPERS,5*1000);
				Log("self.troopertime: "..self.troopertime);
				if(self.troopertime>self.Properties.Hatch.fHatchOpen)then
					Log("self.troopertime: "..self.troopertime);
					Log("fOpenHatch: "..self.Properties.Hatch.fHatchOpen);
					Log("Force Open Hatch!");
					self:OpenHatch();
					self.troopertime=0;
					--respawn dead troopers
					local size=table.getn(self.Troopers);
					local num=0;
					if(self.Troopers[i]~=nil)then
						Log("self.Troopers[i]==valid");
					else
						Log("self.Troopers[i]==invalid");	
					end;
					
					if(self.Troopers[i].spawnedEntity~=nil)then
						Log("spawnedEntity[i]==valid");
					else
						Log("spawnedEntity[i]==invalid");	
					end;
					
					for i=1,size do
						if(self.Troopers[i]:IsDead())then
							self.Troopers[i]:Event_Spawn();
						end;
					end;
				end;
			end;
		end;
	end;
end;

function Warrior:SpawnScouts(wave)
	self.wave=wave;
	if(wave==1)then
		local size=table.getn(self.Scouts);
		local num=0;
		for i=1,size do
			local entity = self.Scouts[i];
			if(self.Scouts[i]~=nil)then
				self.Scouts[i]:Event_Enable();
			end;
		end;
	elseif(wave==2)then
		local size=table.getn(self.Scouts2);
		local num=0;
		for i=1,size do
			local entity = self.Scouts2[i];
			if(self.Scouts2[i]~=nil)then
				self.Scouts2[i]:Event_Enable();
			end;
		end;
	end;
end;

function Warrior:CheckScouts()
	if(self:ScoutWaveDefeated())then
		self.iScoutWavesDefeated=self.iScoutWavesDefeated+1;
		self.SingularityCannons[self.iScoutWavesDefeated].Properties.Vulnerability.bExplosion=1;
		Log("Scout Wave defeated: "..self.iScoutWavesDefeated);
		self:ActivateOutput("ScoutWaves_Defeated",self.iScoutWavesDefeated);
		self:KillTimer(WARRIOR_SCOUTS_OVERRIDE);
		if(self.iScoutWavesDefeated==1)then
			self:SetTimer(WARRIOR_REMINDER_TAC,25*1000);
		elseif(self.iScoutWavesDefeated==2)then
			self:SetTimer(WARRIOR_REMINDER_TAC2,25*1000);
		end;
	else
		Log("Scout Wave alive!");
		self:SetTimer(WARRIOR_CHECK_SCOUTS,3*1000);
	end;
end;


----------------------------------------------------------------------------------------------------
function Warrior.Server:OnHit(hit)
	local dmg=hit.damage;
	CopyVector(self.LastHit.pos, hit.pos);
	CopyVector(self.LastHit.impulse, hit.dir);
	self.LastHit.impulse.x = self.LastHit.impulse.x * hit.damage;
	self.LastHit.impulse.y = self.LastHit.impulse.y * hit.damage;
	self.LastHit.impulse.z = self.LastHit.impulse.z * hit.damage;
	if(hit.explosion)then
		dmg=dmg*5.0;
	end;
	if(self.hatchdestroyed==1)then
		if(dmg>10000)then
			Log("Tac hit registered!");
			--TAC hit;
			self.defeated=1;
			Log("Interior Destroyed!!!");
			self:ActivateTurrets(false);
			self:ActivateOutput("Interior_Destroyed",true);
		end;
	end;
	--Log("Hit: "..dmg);
	
	if (dmg>=1) then
		if (hit.shooter and hit.shooter.actor and hit.shooterId~=hit.targetId and hit.shooter.actor:IsPlayer()) then
			if (g_gameRules) then
				g_gameRules.game:SendHitIndicator(hit.shooterId, hit.explosion or false);
			end
		end
	end


	if(self:GetState()=="PhaseTwo" and self.hatchdestroyed==0)then
		self.hatchdamage=self.hatchdamage+dmg;
		Log("Hatchdamage: "..self.hatchdamage);
		if(self.hatchdamage>5500)then
			self:StartAnimation(0,"body_anim_05",0,0,1,0);
			self:SetAnimationSpeed(0,0,1.0);
			self.hatchdestroyed=1;
			self.hatchstate="Destroyed";
			self:ActivateOutput("HatchDestroyed",self.Interior.id);
			self.Interior.Properties.Vulnerability.bExplosion=1;
		elseif(self.hatchdamage>4000)then
			self:ActivateOutput("HatchDamage",70);
		elseif(self.hatchdamage>3000)then
			self:ActivateOutput("HatchDamage",50);
		elseif(self.hatchdamage>1000)then
			self:ActivateOutput("HatchDamage",30);
		elseif(self.hatchdamage>250)then
			self:ActivateOutput("HatchDamage",10);
		end;
	end;
	
end;

function Warrior:OnSave(tbl)
	tbl.Movement=self.Movement;
	tbl.Turrets=self.Turrets;
	tbl.SingularityCannons=self.SingularityCannons;
	tbl.HoverSpots=self.HoverSpots;
	tbl.DestroyedTurrets=self.DestroyedTurrets;
	tbl.SCFirePos=self.SCFirePos
	tbl.PhaseTwoPos=self.PhaseTwoPos;
	tbl.iTurretActivationTimer=self.iTurretActivationTimer;
	tbl.pos=self.pos;
	tbl.dir=self.dir;
	tbl.bSCFired=self.bSCFired;
	tbl.Interior=self.Interior;
	tbl.bSC1Intact=self.bSC1Intact;
	tbl.bSC2Intact=self.bSC2Intact;
	tbl.hatchdestroyed=self.hatchdestroyed;
	tbl.hatchdamage=self.hatchdamage;
	tbl.NextSC=self.NextSC;
	tbl.bFirstWaveSpawn=self.bFirstWaveSpawn;
	tbl.Scouts=self.Scouts;
	tbl.Scouts2=self.Scouts2;
	tbl.Troopers=self.Troopers;
	tbl.bInitialized=self.bInitialized;
	tbl.SingularityCannon_Weapon1=self.SingularityCannon_Weapon1;
	tbl.SingularityCannon_Weapon2=self.SingularityCannon_Weapon2;
	tbl.DeckDestructionAnchors=self.DeckDestructionAnchors;
	tbl.wave=self.wave;
	tbl.iScoutWavesDefeated=self.iScoutWavesDefeated;
	tbl.turretsdestroyed=self.turretsdestroyed;
	tbl.troopertime=self.troopertime;
	tbl.freezebeam_active=self.freezebeam_active;
	tbl.freezbeam_preactivated=self.freezbeam_preactivated;
	tbl.freezebeamstate=self.freezebeamstate;
	tbl.hatchstate=self.hatchstate;
	tbl.cannons_ready=self.cannons_ready;
	tbl.animname="";
	tbl.animtime=0;
	tbl.sc1_animname="";
	tbl.sc2_animname=""; 
	tbl.sc1_animtime=0;
	tbl.sc2_animtime=0;
	
	if(self.SingularityCannons[1])then
		tbl.sc1_vulnerable=self.SingularityCannons[1].Properties.Vulnerability.bExplosion;
	end;
	if(self.SingularityCannons[2])then
		tbl.sc2_vulnerable=self.SingularityCannons[2].Properties.Vulnerability.bExplosion;
	end;
	if(self.Interior)then
		tbl.interior_vulnerable=self.Interior.Properties.Vulnerability.bExplosion;
	end;

	--Body
	if(self:GetState()=="PhaseOne")then
		if(self:IsAnimationRunning(0,0))then
			if(self.freezebeamstate=="Opening")then
				tbl.animname="body_anim_01";
			elseif(self.freezebeamstate=="Closing")then
				tbl.animname="body_anim_02";
			end;
			tbl.animtime=self:GetAnimationTime(0,0);
		else
			if(self.freezebeamstate=="Opening")then
				tbl.animname="body_anim_01";
				tbl.animtime=1
			elseif(self.freezebeamstate=="Closing")then
				tbl.animname="body_anim_02";
				tbl.animtime=1
			end;
		end;
	elseif(self:GetState()=="PhaseTwo")then
		if(self:IsAnimationRunning(0,0))then
			if(self.hatchstate=="Opening")then
				tbl.animname="body_anim_03";
			elseif(self.hatchstate=="Closing")then
				tbl.animname="body_anim_04";
			elseif(self.hatchstate=="Destroyed")then
				tbl.animname="body_anim_05";
			end;
			tbl.animtime=self:GetAnimationTime(0,0);
		else
			if(self.hatchstate=="Opening")then
				tbl.animname="body_anim_03";
				tbl.animtime=1
			elseif(self.hatchstate=="Closing")then
				tbl.animname="body_anim_04";
				tbl.animtime=1
			elseif(self.hatchstate=="Destroyed")then
				tbl.animname="body_anim_05";
				tbl.animtime=1
			end;
		end;
	end;
	Log("Saving Bodyanim: "..tbl.animname.." at "..tbl.animtime);	
	
	--SC1
	if(self.SingularityCannons[1])then
		if(self.SingularityCannons[1]:IsAnimationRunning(0,0))then
			if(self.cannons_ready==1)then
				tbl.sc1_animname="arm1_cannon_anim_02";
			else
				tbl.sc1_animname="arm1_cannon_anim_01";
			end;
			tbl.sc1_animtime=self.SingularityCannons[1]:GetAnimationTime(0,0);
		else
			if(self.cannons_ready==1)then
				tbl.sc1_animname="arm1_cannon_anim_01";
				tbl.sc1_animtime=1
			else
				tbl.sc1_animname="";
				tbl.sc1_animtime=0;
			end;
		end;
	end;
	--SC2
	if(self.SingularityCannons[2])then
		if(self.SingularityCannons[2]:IsAnimationRunning(0,0))then
			if(self.cannons_ready==1)then
				tbl.sc2_animname="arm2_cannon_anim_02";
			else
				tbl.sc2_animname="arm2_cannon_anim_01";
			end;
			tbl.sc2_animtime=self.SingularityCannons[2]:GetAnimationTime(0,0);
		else
			if(self.cannons_ready==1)then
				tbl.sc2_animname="arm2_cannon_anim_01";
				tbl.sc2_animtime=1
			else
				tbl.sc2_animname="";
				tbl.sc2_animtime=0;
			end;
		end;
	end;

	Log("Saving SC1: "..tbl.sc1_animname.." at "..tbl.sc1_animtime);	
	Log("Saving SC2: "..tbl.sc2_animname.." at "..tbl.sc2_animtime);	

end;

function Warrior:OnLoad(tbl)
	self.Movement=tbl.Movement;
	self.Turrets=tbl.Turrets;
	self.SingularityCannons=tbl.SingularityCannons;
	self.HoverSpots=tbl.HoverSpots;
	self.DestroyedTurrets=tbl.DestroyedTurrets;
	self.SCFirePos=tbl.SCFirePos
	self.PhaseTwoPos=tbl.PhaseTwoPos;
	self.iTurretActivationTimer=tbl.iTurretActivationTimer;
	self.pos=tbl.pos;
	self.dir=tbl.dir;
	self.bSCFired=tbl.bSCFired;
	self.Interior=tbl.Interior;
	self.bSC1Intact=tbl.bSC1Intact;
	self.bSC2Intact=tbl.bSC2Intact;
	self.hatchdestroyed=tbl.hatchdestroyed;
	self.hatchdamage=tbl.hatchdamage;
	self.NextSC=tbl.NextSC;
	self.bFirstWaveSpawn=tbl.bFirstWaveSpawn;
	self.Scouts=tbl.Scouts;
	self.Scouts2=tbl.Scouts2;
	self.Troopers=tbl.Troopers;
	self.bInitialized=tbl.bInitialized;
	self.SingularityCannon_Weapon1=tbl.SingularityCannon_Weapon1;
	self.SingularityCannon_Weapon2=tbl.SingularityCannon_Weapon2;
	self.DeckDestructionAnchors=tbl.DeckDestructionAnchors;
	self.wave=tbl.wave;
	self.iScoutWavesDefeated=tbl.iScoutWavesDefeated;	
	self.turretsdestroyed=tbl.turretsdestroyed;
	self.troopertime=tbl.troopertime;
	self.freezebeam_active=tbl.freezebeam_active;
	self.freezbeam_preactivated=tbl.freezbeam_preactivated;
	self.freezebeamstate=tbl.freezebeamstate;
	self.hatchstate=tbl.hatchstate;
	if(self.hatchstate == "Closed") then
		self:CloseHatch();
	end;
	self.animtime=tbl.animtime;
	self.animname=tbl.animname;
	self.cannons_ready=tbl.cannons_ready;
	self.sc1_animname=tbl.sc1_animname;
	self.sc1_animtime=tbl.sc1_animtime;
	self.sc2_animname=tbl.sc2_animname;
	self.sc2_animtime=tbl.sc2_animtime;
	
	if(self.SingularityCannons[1])then
		self.SingularityCannons[1].Properties.Vulnerability.bExplosion=tbl.sc1_vulnerable;
	end;
	if(self.SingularityCannons[2])then
		self.SingularityCannons[2].Properties.Vulnerability.bExplosion=tbl.sc2_vulnerable;
	end;
	if(self.Interior)then
		self.Interior.Properties.Vulnerability.bExplosion=tbl.interior_vulnerable;
	end;
	
	self:ResetAnimation(0,-1);
	if(self.animname~="")then
		self:StartAnimation(0,self.animname,0,0,1,0);
		self:SetAnimationTime(0,0,self.animtime);
		Log("Loading body anim "..self.animname.." at "..self.animtime);
	end;
	
	
	self.bPostLoadUpdate=1;
	
end;

function Warrior:CheckSingularityCannons()
	Log("Check Cannons");
	if(self.bSC1Intact or self.bSC2Intact)then
		self:SetTimer(WARRIOR_CHECK_SINGULARITYCANNONS,500);
	end;
	
	if(self.bSC1Intact)then
		if(self.SingularityCannons[1]:IsDead())then
			Log("Cannon 1 destroyed!");
			self.bSC1Intact=false;
			self:ActivateOutput("SC1_Destroyed",1);
			Log("Spawn Scouts!!!!!!!!!!!!!");
			self:SpawnScouts(2);
			self:SetTimer(WARRIOR_CHECK_SCOUTS,3*1000);
			self:SetTimer(WARRIOR_SCOUTS_OVERRIDE,40*1000);
			return;
		end;
	else
		if(self.bSC2Intact)then
			if(self.SingularityCannons[2]:IsDead())then
				Log("Cannon 2 destroyed!");
				self.bSC2Intact=false;
				self:ActivateOutput("SC2_Destroyed",self.Interior.id);
				self.Interior.Properties.Vulnerability.bExplosion=0;
				self:SetTimer(WARRIOR_PHASE_TWO,3*1000);
				return;
			end;
		end;
	end;
end;

function Warrior:OnPostLoad()
	self:GotoPostSerializedState();
	if(self.bSC2Intact == false) then
		self:SetTimer(WARRIOR_PHASE_TWO,3*1000);
	end;
end

function Warrior:ActivateFreezebeam()
	self.freezebeamstate="Opening";
	self:StartAnimation(0,"body_anim_01",0,0,1,0);
	self:PlaySoundEvent("sounds/weapons:moar_warrior:spin_up",{x=0,y=0,z= 0} ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_LIVING_ENTITY);	
	
	local size=table.getn(self.Turrets);
	for i=1,size do
		if(self.Turrets[i]~=nil)then
			if(self.Turrets[i]:GetName()=="Warrior_Freezebeam")then
				self.Turrets[i].Properties.GunTurret.bEnabled=1;
				self.freezebeam_active=1;
				break;
			end;
		end;
	end;
end;

function Warrior:DeactivateFreezebeam()
	self.freezebeamstate="Closing";
	self:StartAnimation(0,"body_anim_02",0,0,1,0);
	self:PlaySoundEvent("sounds/weapons:moar_warrior:spin_down",{x=0,y=0,z= 0} ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_LIVING_ENTITY);	
	local size=table.getn(self.Turrets);
	for i=1,size do
		if(self.Turrets[i]~=nil)then
			if(self.Turrets[i]:GetName()=="Warrior_Freezebeam")then
				self.Turrets[i].Properties.GunTurret.bEnabled=0;
				self.freezebeam_active=0;
				break;
			end;
		end;
	end;
end;

--Check if the SC should be fired
function Warrior:CheckTurrets()
	if(self:GetState()~="PhaseTwo")then
		if(self.DestroyedTurrets~=self:GetDestroyedTurrets())then
			self.DestroyedTurrets=self:GetDestroyedTurrets();
			Log("self.DestroyedTurrets: "..self.DestroyedTurrets);
			Log("Mod: "..self.DestroyedTurrets%self.Properties.SingularityCannons.DestroyTrigger);
			--Log("--------------------------------");
			if((self.DestroyedTurrets%self.Properties.SingularityCannons.DestroyTrigger)==0)then
				self:ActivateTurrets(false);
				if (self.turretsdestroyed == 0) then
					self.turretsdestroyed=1;
					self:ActivateOutput("Turrets_Destroyed",1);
				end
				self:SpawnScouts(1);
				--Activate SC's and Icebeam
				self:SetTimer(WARRIOR_FIRE_SC,self.Properties.SingularityCannons.fInterval*1000);
				
				self:KillTimer(WARRIOR_ACTIVATE_FREEZEBEAM);
				self:KillTimer(WARRIOR_DEACTIVATE_FREEZEBEAM);
				if(self.freezebeam_active==1)then
					self:DeactivateFreezebeam();
				end;
				self:SetTimer(WARRIOR_ACTIVATE_FREEZEBEAM,self.Properties.Freezebeam.fInterval*1000);
				self:SetTimer(WARRIOR_CHECK_SCOUTS,3*1000);
				self:SetTimer(WARRIOR_SCOUTS_OVERRIDE,40*1000);
				self:SetTimer(WARRIOR_CHECK_SINGULARITYCANNONS,500);
				self:SetTimer(WARRIOR_REMINDER_SCOUTS,25*1000);
				return;
			elseif(self.DestroyedTurrets>=2 and self.freezbeam_preactivated==0)then
				if(self.Turrets[1].item:IsDestroyed() and self.Turrets[3].item:IsDestroyed())then
					self.freezbeam_preactivated=1;
					self:SetTimer(WARRIOR_ACTIVATE_FREEZEBEAM,self.Properties.Freezebeam.fInterval*1000);
				elseif(self.Turrets[2].item:IsDestroyed() and self.Turrets[4].item:IsDestroyed())then
					self.freezbeam_preactivated=1;
					self:SetTimer(WARRIOR_ACTIVATE_FREEZEBEAM,self.Properties.Freezebeam.fInterval*1000);
				end;
			end;
		end;
		self:SetTimer(WARRIOR_CHECK_TURRETS,1000);
	end;
end;

--Check next hoverspot
function Warrior:CheckForHoverSpot()
	--Log("Check for Hoverspot!");
	if(table.getn(self.HoverSpots)==0)then
		Log("No hoverspots found for the Warrior!");
		return;
	end;
	repeat
		i=random(1,table.getn(self.HoverSpots));
	until i~=self.Movement.lasthoverspot;
	self.Movement.lasthoverspot=i;
	LogVec("Hoverspot: ",self.Movement.position);
	self.HoverSpots[i]:GetPos(self.Movement.position);
	CopyVector(self.Movement.dir,self.HoverSpots[i]:GetDirectionVector(1));
	self.Movement.active=1;
	
	self:PlaySoundEvent("Sounds/alien:warrior:warrior_moves_1",{x=0,y=0,z= -20} ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_LIVING_ENTITY);
	--Log("Check for Hoverspot! Selected: "..i);
end;

--Check from where to fire the SC
Warrior.CheckForSCFireSpot=function(self)
	if(self.SCFirePos~=nil)then
		self.Movement.position=self.SCFirePos:GetPos();
		LogVec("Getting SCFirePos: ",self.SCFirePos:GetPos());
		CopyVector(self.Movement.dir,self.SCFirePos:GetDirectionVector(1));
		self.Movement.active=1;
	else
		Log("No SCFireSpot for the Warrior found!");
	end;
end;

function Warrior:CheckInterior()
	if(self.defeated==1)then
		return;
	end;
	if(self.Interior and self.Interior:IsDead())then
		self.defeated=1;
		Log("Interior Destroyed!!!");
		self:ActivateTurrets(false);
		self:ActivateOutput("Interior_Destroyed",true);
	else
		self:SetTimer(WARRIOR_INTERIOR_DESTRUCTION,0.5*1000);
		Log("Interior still intact!!!"..self.Interior.health);
	end;
end;

function Warrior:OpenHatch()
	if(self.hatchdestroyed==0)then
		Log("Opening Hatch!");
		self.hatchstate="Opening";
		self:ResetAnimation(0,-1);
		self:PlaySoundEvent("Sounds/alien:warrior:hatch_open",{x=0,y=0,z= -20} ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_LIVING_ENTITY);
		self:StartAnimation(0,"body_anim_03",0,0,1,0);
		self:SetAnimationSpeed(0,0,1.0);
		self:SetTimer(WARRIOR_CLOSE_HATCH,self.Properties.Hatch.fHatchClose*1000);
	end;
end;

function Warrior:CloseHatch()
	if(self.hatchdestroyed==0)then
		Log("Closing Hatch!!!!!!!!!!!!!!");
		self.hatchstate="Closing";
		self:ResetAnimation(0,-1);
		self:PlaySoundEvent("Sounds/alien:warrior:hatch_close",{x=0,y=0,z= -20} ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_LIVING_ENTITY);
		self:StartAnimation(0,"body_anim_04",0,0,1,0);
		self:SetAnimationSpeed(0,0,1.0);
		--self:SetTimer(WARRIOR_OPEN_HATCH,self.Properties.Hatch.fHatchOpen*1000);		
	end;
end;

--Transition to hoverspot
function Warrior:Move(dt)
	self:GetPos(self.pos);

	local desiredVel = g_Vectors.temp_v1;
	local steering = g_Vectors.temp_v2;
	
	FastDifferenceVectors(desiredVel,self.Movement.position,self.pos);
	local distToTarget=LengthVector(desiredVel);
	
	local props=self.Properties.Hover;
	
	local rampedSpeed=props.MoveSpeed*(distToTarget/props.SlowDistance);
	local clampedSpeed=math.min(rampedSpeed,props.MoveSpeed*2.0);
	ScaleVectorInPlace(desiredVel,clampedSpeed/distToTarget);
	
	if(distToTarget>0.1)then
		
		FastDifferenceVectors(steering, desiredVel, self.Movement.vel);
		local drag = math.min(1.0*dt,1.0);
		self.Movement.vel.x = self.Movement.vel.x - self.Movement.vel.x * drag;
		self.Movement.vel.y = self.Movement.vel.y - self.Movement.vel.y * drag;
		self.Movement.vel.z = self.Movement.vel.z - self.Movement.vel.z * drag;
		
		self.Movement.vel.x = self.Movement.vel.x + steering.x * dt;
		self.Movement.vel.y = self.Movement.vel.y + steering.y * dt;
		self.Movement.vel.z = self.Movement.vel.z + steering.z * dt;
		
		self.pos.x = self.pos.x + self.Movement.vel.x * dt;
		self.pos.y = self.pos.y + self.Movement.vel.y * dt;
		self.pos.z = self.pos.z + self.Movement.vel.z * dt;
	
		local p={x=0,y=0,z=0};
		CopyVector(p,self.pos);
		self:SetWorldPos(p);
	end;
	-------------------
	
	ZeroVector(desiredVel);
	ZeroVector(steering);
	
	CopyVector(self.dir,self:GetDirectionVector(1));
	FastDifferenceVectors(desiredVel,self.Movement.dir,self.dir);
	local distToTarget2=LengthVector(desiredVel);
	
	local rampedSpeed2=props.MoveSpeed*(distToTarget2/10);
	local clampedSpeed2=math.min(rampedSpeed2,(props.TurnSpeed*10)*2.0);
	ScaleVectorInPlace(desiredVel,clampedSpeed2/distToTarget2);
	
	if(distToTarget2>0.01)then
		FastDifferenceVectors(steering, desiredVel, self.Movement.rot);
		local drag = math.min(1.0*dt,1.0);
											
		self.Movement.rot.x = self.Movement.rot.x - self.Movement.rot.x * drag;
		self.Movement.rot.y = self.Movement.rot.y - self.Movement.rot.y * drag;
		self.Movement.rot.z = self.Movement.rot.z - self.Movement.rot.z * drag;
		
		self.Movement.rot.x = self.Movement.rot.x + steering.x * dt;
		self.Movement.rot.y = self.Movement.rot.y + steering.y * dt;
		self.Movement.rot.z = self.Movement.rot.z + steering.z * dt;
		
		self.dir.x = self.dir.x + self.Movement.rot.x * dt;
		self.dir.y = self.dir.y + self.Movement.rot.y * dt;
		self.dir.z = self.dir.z + self.Movement.rot.z * dt;
		
		NormalizeVector(self.dir);
		self:SetDirectionVector(self.dir);
	end;
	-------------------
	
	if(distToTarget<0.1 and distToTarget2<0.1)then
		Log("Hoverspot reached!");
		self.Movement.active=0;
		if(self:GetState()=="PhaseOne")then
			self:SetTimer(WARRIOR_HOVER,self.Properties.Hover.fInterval*1000);
		elseif(self:GetState()=="PhaseTwo")then
			self:ActivateOutput("PhaseTwoStart",1);
			self.Properties.Vulnerability.bExplosion=1;
			self:SetTimer(WARRIOR_REMINDER_HATCH,60*1000);
		end;
	end;
end;

function Warrior:GetDestroyedTurrets()
	local size=table.getn(self.Turrets);
	local num=0;
	for i=1,size do
		if(self.Turrets[i].item:IsDestroyed())then
			num=num+1
		end;
	end;
	return num;
end;

function Warrior:ScoutWaveDefeated()
	if(self.wave==1)then
		local size=table.getn(self.Scouts);
		local num=0;
		for i=1,size do
			if(self.Scouts[i]~=nil)then
				if(self.Scouts[i]:IsDead())then
					num=num+1;
				else
					Log(self.Scouts[i]:GetName().." is alive! "..self.Scouts[i].actor:GetHealth());
				end;
			end;
		end;
		return num==size;
	elseif(self.wave==2)then
		local size=table.getn(self.Scouts2);
		local num=0;
		for i=1,size do
			if(self.Scouts2[i]~=nil)then
				if(self.Scouts2[i]:IsDead())then
					num=num+1;
				else
					Log(self.Scouts2[i]:GetName().." is alive! "..self.Scouts2[i].actor:GetHealth());
				end;
			end;
		end;
		return num==size;
	end;
end;

function Warrior:TrooperWaveDefeated()

	local size=table.getn(self.Troopers);
	local num=0;
	for i=1,size do
		if(self.Troopers[i]~=nil and self.Troopers[i].spawnedEntity~=nil)then
			local entity=System.GetEntity(self.Troopers[i].spawnedEntity);
			if(entity~=nil)then
				if(entity:IsDead())then
					Log(entity:GetName().." is dead!");
					num=num+1;
				else
					Log(entity:GetName().." is alive! "..entity.actor:GetHealth());
				end;
			end;
		else
			num=num+1;
		end;
	end;
	return num==size;
end;

function Warrior:ReadySingularityCannons()
	
	self.SingularityCannons[1]:ResetAnimation(0,-1);
	self.SingularityCannons[1]:SetAnimationSpeed( 0, 0, 1.0);
	self.SingularityCannons[1]:StartAnimation(0,"arm1_cannon_anim_01",0,0,1,0)
	
	self.SingularityCannons[2]:ResetAnimation(0,-1);
	self.SingularityCannons[2]:SetAnimationSpeed( 0, 0, 1.0);
	self.SingularityCannons[2]:StartAnimation(0,"arm2_cannon_anim_01",0,0,1,0)
	
	self:SetTimer(WARRIOR_CANNONS_READY,1000*self.SingularityCannons[1]:GetAnimationLength(0,"arm1_cannon_anim_01"));
end;

function Warrior:AquireTarget()
	if(self.Properties.SingularityCannons.bAlwaysAimAtPlayer==1)then
		self:ActivateOutput("TargetId",g_localActor.id);
	end;
	
	Log("AquireTarget!!!");
	local size=table.getn(self.DeckDestructionAnchors);
	local vec={x=0,y=0,z=0};
	local nearest;
	local lastdist=9999;
	
	for i=1,size do
		SubVectors(vec,self.DeckDestructionAnchors[i]:GetPos(),g_localActor:GetPos());
		if(LengthVector(vec)<lastdist)then
			lastdist=LengthVector(vec);
			nearest=i;
			--Log("Nearest: "..i.." "..lastdist.."m away.");
		end;
	end;
	if(self.DeckDestructionAnchors[nearest])then
		self:ActivateOutput("TargetId",self.DeckDestructionAnchors[nearest].id);
	end;
end;

function Warrior:FireSingularityCannon()
	self:AquireTarget();
	if(self.bSC1Intact==false)then
		self.NextSC=1;
	end;
	if(self.bSC2Intact==false)then return;end;
	
	if(self.NextSC==0)then
		self.SingularityCannons[1]:ResetAnimation(0,-1);
		self.SingularityCannons[1]:SetAnimationSpeed( 0, 0, 1.0);
		self.sc1_animname="arm1_cannon_anim_02";
		self.SingularityCannons[1]:StartAnimation( 0,"arm1_cannon_anim_02",0,0,1,0)
		self:PlaySoundEvent("Sounds/weapons:singularity_cannon_warrior:open",g_Vectors.v000 ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_WEAPON);		
		self:ActivateOutput("StartFire_1",1);
		self.NextSC=1;
	elseif(self.NextSC==1)then
		self.SingularityCannons[2]:ResetAnimation(0,-1);
		self.SingularityCannons[2]:SetAnimationSpeed( 0, 0, 1.0);
		self.sc2_animname="arm2_cannon_anim_02";
		self.SingularityCannons[2]:StartAnimation( 0,"arm2_cannon_anim_02",0,0,1,0)
		self:PlaySoundEvent("Sounds/weapons:singularity_cannon_warrior:open",g_Vectors.v000 ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_WEAPON);		
		self:ActivateOutput("StartFire_2",1);
		self.NextSC=0;
	end;
	self:SetTimer(WARRIOR_FIRE_SC,self.Properties.SingularityCannons.fInterval*1000);
	Log("Next SC to fire: "..self.NextSC);

end;

function Warrior:SerializeAnims()
	Log("Loading anim: "..self.sc1_animname.." at "..self.sc1_animtime);
	Log("Loading anim: "..self.sc2_animname.." at "..self.sc2_animtime);
	--SC1
	if(self.SingularityCannons[1] and not self.SingularityCannons[1]:IsDead())then
		self.SingularityCannons[1]:LoadObject(0,"objects/characters/alien/warrior/warrior_arm1_cannon_anim.cga");
		self.SingularityCannons[1]:CharacterUpdateOnRender(0,1);
		self.SingularityCannons[1]:ResetAnimation(0,-1);
		self.SingularityCannons[1]:SetAnimationSpeed( 0, 0, 1.0);
		self.SingularityCannons[1]:StartAnimation(0,self.sc1_animname,0,0,1,0)
		self.SingularityCannons[1]:SetAnimationTime(0,0,self.sc1_animtime);
	end;
	--SC2
	if(self.SingularityCannons[2] and not self.SingularityCannons[2]:IsDead())then
		self.SingularityCannons[2]:LoadObject(0,"objects/characters/alien/warrior/warrior_arm2_cannon_anim.cga");
		self.SingularityCannons[2]:CharacterUpdateOnRender(0,1);
		self.SingularityCannons[2]:ResetAnimation(0,-1);
		self.SingularityCannons[2]:SetAnimationSpeed( 0, 0, 1.0);
		self.SingularityCannons[2]:StartAnimation(0,self.sc2_animname,0,0,1,0)
		self.SingularityCannons[2]:SetAnimationTime(0,0,self.sc2_animtime);
	end;
end;

----------------------------------------------------------------------------------
------------------------------------States----------------------------------------
----------------------------------------------------------------------------------
--Warrior is disabled initially
Warrior.Server.Disabled =
{
	OnBeginState = function( self )
		Log("Warrior: Disabled!");
		self:Activate(1);
		self:ActivateTurrets(false);
	end,
	OnUpdate = function(self, dt)
		if(self.bPostLoadUpdate==1)then
			self.bPostLoadUpdate=0;
			self:SerializeAnims();
			--just in case
			if(self.SingularityCannons[1] and self.SingularityCannons[2])then
				self:ActivateOutput("SC1_Id",self.SingularityCannons[1].id);
				self:ActivateOutput("SC2_Id",self.SingularityCannons[2].id);
			end;
		end;
	end,
	OnEndState = function( self )
	end,
	OnTimer = function(self,timerId)
		if(timerId==WARRIOR_CANNONS_READY)then
			Log("Cannons marked ready!");
			self.cannons_ready=1;
		end;
	end,
	
}

--Fight Phase One
Warrior.Server.PhaseOne =
{
	OnBeginState = function( self )
		Log("Warrior: Phase One!");
		self.sc1_animname="";
		self.sc2_animname="";
		self:Activate(1);
		self:ActivateTurrets(true);
		self.bSCFired=0;
		self.DestroyedTurrets = 0;
		self:ActivateOutput("SC1_Id",self.SingularityCannons[1].id);
		self:ActivateOutput("SC2_Id",self.SingularityCannons[2].id);
		if(self.Movement.active==0)then
			self:CheckForHoverSpot();
		end;
		self:SetTimer(WARRIOR_CHECK_TURRETS,1000);
		self:SetTimer(WARRIOR_REMINDER_TURRETS,25*1000);
	end,
	OnUpdate = function(self, dt)
		if(self.Movement.active==1)then
			self:Move(dt);
		end;
		if(self.bPostLoadUpdate==1)then
			self.bPostLoadUpdate=0;
			self:SerializeAnims();
		end;
	end,
	
	OnTimer = function(self,timerId)
		if(timerId==WARRIOR_FIRE_SC)then
			self:FireSingularityCannon();
		elseif(timerId==WARRIOR_CHECK_TURRETS)then
			self:CheckTurrets();
		elseif(timerId==WARRIOR_ACTIVATE_FREEZEBEAM)then
			self:ActivateFreezebeam();
			self:SetTimer(WARRIOR_DEACTIVATE_FREEZEBEAM,self.Properties.Freezebeam.fActiveTime*1000);
		elseif(timerId==WARRIOR_DEACTIVATE_FREEZEBEAM)then
			self:DeactivateFreezebeam();
			self:SetTimer(WARRIOR_ACTIVATE_FREEZEBEAM,self.Properties.Freezebeam.fInterval*1000);
		elseif(timerId==WARRIOR_CHECK_SCOUTS)then
			self:CheckScouts();
		elseif(timerId==WARRIOR_SCOUTS_OVERRIDE)then
			self:KillTimer(WARRIOR_CHECK_SCOUTS);
			self.iScoutWavesDefeated=self.iScoutWavesDefeated+1;
			self.SingularityCannons[self.iScoutWavesDefeated].Properties.Vulnerability.bExplosion=1;
			if(self.iScoutWavesDefeated==1)then
				self:SetTimer(WARRIOR_REMINDER_TAC,25*1000);
			elseif(self.iScoutWavesDefeated==2)then
				self:SetTimer(WARRIOR_REMINDER_TAC2,25*1000);
			end;
			Log("Scout Wave defeated: "..self.iScoutWavesDefeated);
			self:ActivateOutput("ScoutWaves_Defeated",self.iScoutWavesDefeated);
		elseif(timerId==WARRIOR_CHECK_SINGULARITYCANNONS)then
			self:CheckSingularityCannons();
		elseif(timerId==WARRIOR_PHASE_TWO)then
			self:GotoState("PhaseTwo");
		elseif(timerId==WARRIOR_HOVER)then
			self:CheckForHoverSpot();
		elseif(timerId==WARRIOR_REMINDER_TURRETS)then
			if(self.turretsdestroyed==0)then
				self:ActivateOutput("Reminder",0); --turret reminder
				self:SetTimer(WARRIOR_REMINDER_TURRETS,25*1000);
			end;
		elseif(timerId==WARRIOR_REMINDER_SCOUTS)then
			if(self.iScoutWavesDefeated==0)then
				self:ActivateOutput("Reminder",1); --scoutwave reminder
				self:SetTimer(WARRIOR_REMINDER_SCOUTS,25*1000);
			end;
		elseif(timerId==WARRIOR_REMINDER_TAC)then
			if(self.bSC1Intact==true)then
				self:ActivateOutput("Reminder",2); --tac reminder
				self:SetTimer(WARRIOR_REMINDER_TAC,25*1000);
			else
				Log("self.bSC1Intact==false!!!");
			end;
		elseif(timerId==WARRIOR_REMINDER_TAC2)then
			if(self.bSC2Intact==true)then
				self:ActivateOutput("Reminder",4); --tac2 reminder
				self:SetTimer(WARRIOR_REMINDER_TAC2,25*1000);
			else
				Log("self.bSC1Intact==false!!!");
			end;
		end;
	end,
	
	OnEndState = function( self )
	end,
}
--Fight Phase Two
Warrior.Server.PhaseTwo =
{
	OnBeginState = function( self )
		Log("Entering PhaseTwo!");
		self:ActivateTurrets(true);
		self:KillTimer(WARRIOR_ACTIVATE_FREEZEBEAM);
		self:KillTimer(WARRIOR_DEACTIVATE_FREEZEBEAM);
		if(self.freezebeam_active==1)then
			self:DeactivateFreezebeam();
		end;
		if(self.PhaseTwoPos~=nil)then
			self.Movement.position=self.PhaseTwoPos:GetPos();
			CopyVector(self.Movement.dir,self.PhaseTwoPos:GetDirectionVector(1));
			self.Movement.active=1;
			self.PhaseTwoPos=nil;
		else
			Log("No position for phase two found!");
		end;
		self:PlaySoundEvent("Sounds/alien:warrior:warrior_over_deck",g_Vectors.v000 ,g_Vectors.v010 , SOUND_DEFAULT_3D, SOUND_SEMANTIC_LIVING_ENTITY);
		Log("Setting WARRIOR_OPEN_HATCH timer");
		self:SetTimer(WARRIOR_OPEN_HATCH,31*1000);
		self:SetTimer(WARRIOR_INTERIOR_DESTRUCTION,0.5*1000);
	end,
	OnUpdate = function(self, dt)
		if(self.Movement.active==1)then
			self:Move(dt);
		end;
		if(self.bPostLoadUpdate==1)then
			self.bPostLoadUpdate=0;
			self:SerializeAnims();
		end;
	end,
	
	OnTimer = function(self,timerId)
		Log("PhaseTwoTimer: "..timerId)
		if(timerId==WARRIOR_OPEN_HATCH)then
			Log("Open hatch now!");
			self:OpenHatch();
			self:SpawnTroopers();
		elseif(timerId==WARRIOR_CLOSE_HATCH)then
			self:CloseHatch();
		elseif(timerId==WARRIOR_CHECK_TROOPERS)then
			self:CheckTrooperWave();
		elseif(timerId==WARRIOR_REMINDER_HATCH)then
			if(self.hatchdestroyed==0)then
				self:ActivateOutput("Reminder",3); --hatch reminder
				self:SetTimer(WARRIOR_REMINDER_HATCH,25*1000);
			end;
		elseif(timerId==WARRIOR_INTERIOR_DESTRUCTION)then
			Log("Call check interior!");
			self:CheckInterior();
		end;
	end,
	OnEndState = function( self )
		Log("Leaving PhaseTwo");
	end,
}

----------------------------------------------------------------------------------
------------------------------------Events----------------------------------------
----------------------------------------------------------------------------------

function Warrior:Event_ScoutHack()
	--Hack until Kirill fixed the scouts
	self.SingularityCannons[1].Properties.Vulnerability.bExplosion=1;
	self.SingularityCannons[1].Properties.Vulnerability.bBullet=1;
	self.SingularityCannons[2].Properties.Vulnerability.bExplosion=1;
	self.SingularityCannons[2].Properties.Vulnerability.bBullet=1;
	self:ActivateOutput("ScoutWaves_Defeated",2);
end;

function Warrior:Event_Enable()
	self:MakeTurretsVulnerable(1);
	self:GotoState("PhaseOne");
end;

function Warrior:Event_Disable()
	self:GotoState("Disabled");
end;

function Warrior:Event_DebugPhaseTwo()
	self.bSC1Intact=false;
	self.bSC2Intact=false;
	self.Movement.active=0;
	self:GotoState("PhaseTwo");
end;

function Warrior:Event_Hide()
	local size=table.getn(self.SingularityCannons);
	for i=1,size do
		self.SingularityCannons[i]:Hide(1);
	end;
	self:Hide(1);
end;

function Warrior:Event_UnHide()
	local size=table.getn(self.SingularityCannons);
	for i=1,size do
		self.SingularityCannons[i]:Hide(0);
	end;
	self:Hide(0);
end;

function Warrior:Event_ReadyCannons()
	self:ReadySingularityCannons();	
end;

-----------------------------------------------------------------------------------

Warrior.FlowEvents =
{
	Inputs =
	{
		Enable = { Warrior.Event_Enable, "bool" },
		Disable = { Warrior.Event_Disable, "bool" },
		DebugPhaseTwo = { Warrior.Event_DebugPhaseTwo, "bool" },
		Hide = { Warrior.Event_Hide, "bool" },
		UnHide = { Warrior.Event_UnHide, "bool" },
		ReadyCannons = { Warrior.Event_ReadyCannons, "bool" },
		ScoutHack = {Warrior.Event_ScoutHack, "bool" },
		Reset = { Warrior.Event_Reset, "bool" },
	},
	Outputs =
	{
		TargetId = "entity",
		StartFire_1 = "bool",
		StartFire_2 = "bool",
		SC1_Destroyed = "bool",
		SC2_Destroyed = "entity",
		Turrets_Destroyed = "bool",
		ScoutWaves_Defeated = "int",
		Interior_Destroyed = "bool",
		HatchDestroyed = "entity",
		Reminder = "int",
		PhaseTwoStart = "bool",
		SC1_Id = "entity",
		SC2_Id = "entity",
		HatchDamage = "int",
		
	},
	
}
