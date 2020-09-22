--------------------------------------------------
-- SuitSniperAttack
--------------------------
--   created: Mikko Mononen 28-4-2007

STATE_SHOOT_SNIPER = 0;
STATE_RELOCATE = 1;
STATE_RELOCATE_BACK = 2;
STATE_RELOCATE_ADVANCE = 3;
STATE_AGGRESSIVE = 4;
STATE_INVALID = 5;

sniperCounter = 1;

AIBehaviour.SuitSniperAttack = {
	Name = "SuitSniperAttack",
	alertness = 2,

	-----------------------------------------------------
	Constructor = function (self, entity)
	
		entity:MakeAlerted();
		
		self:CheckBlackboard(entity);

		entity.AI.lastBulletReactionTime = _time - 10;
		entity.AI.lastTargetSeenTime = _time;
		
		AI.SetPFBlockerRadius(entity.id, PFB_ATT_TARGET, 10);
		
		AI.ChangeParameter(entity.id, AIPARAM_PROJECTILE_LAUNCHDIST, 0.65);
		
		entity.AI.meleeBlock = 0;
		entity.AI.reloadBlock = 0;
		entity.AI.stuntBlock = 0;
		entity.AI.lastStuntAnchorId = NULL_ENTITY;
		if(entity.AI.sniperState == nil) then
			entity.AI.sniperState = STATE_RELOCATE;
		end
		
		self:COVER_NORMALATTACK(entity);

		if (AI_Utils:CanThrowSmokeGrenade(entity) == 1) then
			AI.ChangeParameter(entity.id, AIPARAM_PROJECTILE_LAUNCHDIST, 1.0);
			entity:InsertSubpipe(AIGOALPIPE_NOTDUPLICATE,"su_throw_smoke");
		end

	end,

	-----------------------------------------------------
	Destructor = function(self,entity)
		entity.AI.sniperState = STATE_INVALID;
		
		if ( entity.AI.sniperState == STATE_AGGRESSIVE ) then
			local groupId = AI.GetGroupOf(entity.id);
			local aggressiveSnipers = AIBlackBoard[groupId].aggressiveSnipers;
			if (aggressiveSnipers) then
				AIBlackBoard[groupId].aggressiveSnipers = aggressiveSnipers - 1;
			end
		end
	end,
	
	-----------------------------------------------------
	CheckBlackboard = function ( self, entity )
		local groupId = AI.GetGroupOf(entity.id);
		if (not AIBlackBoard[groupId] or not AIBlackBoard[groupId].aggressiveSnipers) then
			AIBlackBoard[groupId] = {};
			AIBlackBoard[groupId].aggressiveSnipers = 0;
		end
	end,
	
	---------------------------------------------
	FOUND_CLOSE_CONTANT = function (self, entity, sender)
		entity.AI.sniper = false;
	end,
	
	---------------------------------------------
	COVER_NORMALATTACK = function (self, entity, sender)
	
		if (AI.GetTargetType(entity.id) ~= AITARGET_NONE) then
			entity.AI.meleeBlock = 0;
			entity.AI.reloadBlock = 0;
			entity.AI.stuntBlock = 0;

			local lastStuntTime = 0;
			if (entity.AI.lastStuntTime ~= nil) then
				lastStuntTume = entity.AI.lastStuntTime;
			end
			
			local stuntElapsed = _time - lastStuntTime;
			
			if (stuntElapsed > 25.0) then
				local	objectPos = g_Vectors.temp_v1;
				local	objectDir = g_Vectors.temp_v2;

				local anchorName = AI.FindObjectOfType(entity.id, 10.0, AIAnchorTable.SUIT_SPOT,
																							AIFO_NONOCCUPIED+AIFO_CHOOSE_RANDOM+AIFO_NONOCCUPIED_REFPOINT, objectPos, objectDir);
				
				if (anchorName) then
					local anchorEnt = System.GetEntityByName(anchorName);
					
					if (anchorEnt) then -- and entity.AI.lastStuntAnchorId ~= anchorId) then

						entity.AI.lastStuntTime = _time;
					
						-- do not allow to use the same anchor twice in a row.
						if (entity.AI.lastStuntAnchorId ~= anchorEnt.id) then
							entity.AI.lastStuntAnchorId = anchorEnt.id;
							-- If found attack anchor, goto to the anchor.
							AI.SetRefPointPosition(entity.id, objectPos);
							entity:SelectPipe(0,"su_stunt");
							entity.AI.stuntBlock = 1;
							do return end;
						end
					end
				end
			end
			
			local dist = AI.GetAttentionTargetDistance(entity.id);
			
			--If we are the closest non-aggressive sniper, and an aggression slot is available engage aggressively
			if ( entity.AI.sniperState ~= STATE_AGGRESSIVE ) then
				local groupId = AI.GetGroupOf(entity.id);
				self:CheckBlackboard( entity );
				local aggressiveSnipers = AIBlackBoard[groupId].aggressiveSnipers;

				if(entity.AI.sniperState > STATE_SHOOT_SNIPER) then
					if (groupId ~= 5400 or (dist > 30 and aggressiveSnipers > 1) ) then
						local fSniperLethalityFraction = System.GetCVar("ai_RODSniperLethalFraction");
						entity:SelectPrimaryWeapon();					
						if ( (fSniperLethalityFraction > 0.0) and (fSniperLethalityFraction >= (1.0 / sniperCounter) ) ) then
							entity:SelectPipe(0,"su_sniper_shoot_lethal");
							sniperCounter = 1.0;
						else
							entity:SelectPipe(0,"su_sniper_shoot");
							sniperCounter = sniperCounter + 1.0;
						end
						entity.AI.sniperState = STATE_SHOOT_SNIPER;
					else
						entity:SelectSecondaryWeapon();
						entity.AI.sniperState = STATE_AGGRESSIVE;
						AIBlackBoard[groupId].aggressiveSnipers = aggressiveSnipers + 1;
						self:ENGAGE_CLOSE_QUARTERS(entity, dist);
					end				
				else
					if ( dist < 30.0 ) then
						entity:SelectPipe(0,"su_sniper_relocate_backoff");
						entity.AI.sniperState = STATE_RELOCATE_BACK;
					elseif ( dist > 60 ) then
						entity:SelectPipe(0,"su_sniper_relocate_advance");
						entity.AI.sniperState = STATE_RELOCATE_ADVANCE;
					else
						entity:SelectPipe(0,"su_sniper_relocate");
						entity.AI.sniperState = STATE_RELOCATE;
					end
				end
			else
				self:ENGAGE_CLOSE_QUARTERS(entity, dist);
			end
		else
			AI.Signal(SIGNALFILTER_SENDER,1,"TO_THREATENED",entity.id);
		end
	end,
	
	---------------------------------------------
	ENGAGE_CLOSE_QUARTERS = function( self, entity, dist)
		if ( dist < 25.0 ) then
			entity:SelectPipe(0, "su_cqb");
		else
			local targetPos = {};
			AI.GetAttentionTargetPosition(entity.id,targetPos);
			AI.SetRefPointPosition(entity.id, targetPos);	
			entity:SelectPipe(0, "su_advance_cloaked");
		end
	end,

	---------------------------------------------
	OnPlayerSeen = function( self, entity, fDistance, data )
		entity:TriggerEvent(AIEVENT_DROPBEACON);
		AI.Signal(SIGNALFILTER_GROUPONLY_EXCEPT, 1, "ENEMYSEEN_DURING_COMBAT",entity.id);
	end,

	---------------------------------------------
	OnEnemyMemory = function( self, entity )
		entity:TriggerEvent(AIEVENT_DROPBEACON);
		entity.AI.lastTargetSeenTime = _time;
	end,

	--------------------------------------------------
	OnCloseContact = function ( self, entity, sender,data)
		-- Do melee at close range.
		if (entity.AI.meleeBlock == 0 and AI.CanMelee(entity.id)) then
			entity:NanoSuitMode( BasicAI.SuitMode.SUIT_POWER );
			AI.ChangeParameter(entity.id, AIPARAM_AIM_TURNSPEED, -1);
			AI.ChangeParameter(entity.id, AIPARAM_FIRE_TURNSPEED, -1);
			entity:SelectPipe(0,"su_melee");
			entity.AI.meleeBlock = 1;
		end
	end,

	---------------------------------------------
	MELEE_DONE = function (self, entity)
		entity:SelectPipe(0,"su_melee_retreat");
	end,
	
	---------------------------------------------
	OnMeleeExecuted = function (self, entity)
		entity:SelectPipe(0,"su_melee_retreat");
	end,
		
	--------------------------------------------------
	OnPlayerLooking = function(self, entity)
		System.Log("player looking");
	end,
	
	---------------------------------------------
	OnPlayerLookingAway = function(self,entity,sender,data)
		System.Log("player look away");
	end,
	
	---------------------------------------------
	OnNoTargetVisible = function (self, entity)
		if (entity.AI.sniperState ~= STATE_RELOCATE_BACK) then
			AI.Signal(SIGNALFILTER_SENDER,1,"TO_THREATENED",entity.id);
		end
	end,
	
	---------------------------------------------
	OnNoTargetAwareness = function (self, entity)
		if (entity.AI.sniperState ~= STATE_RELOCATE_BACK) then
			AI.Signal(SIGNALFILTER_SENDER,1,"TO_THREATENED",entity.id);
		end
	end,

	---------------------------------------------
	OnEnemyDamage = function(self, entity, sender)
	
		AI.Signal(SIGNALFILTER_GROUPONLY_EXCEPT, 1, "COVER_GRENADE",entity.id);
	
		local	dt = _time - entity.AI.lastBulletReactionTime;
		local reactionTime = 0.75;
		if (AI.IsMoving(entity.id,1) == 1) then
			reactionTime = 2.0;
		end
		if(dt > reactionTime and entity.AI.stuntBlock == 0) then
			entity.AI.lastBulletReactionTime = _time;
			entity:Readibility("bulletrain",1,2, 0,0.2);
			entity:SelectPipe(0,"do_nothing");
			entity:SelectPipe(0,"su_bullet_reaction");
		end
	
	end,
	
	---------------------------------------------
	OnBulletRain = function(self, entity, sender, data)
	
		local dist = 100.0;
		if (AI.GetTargetType(entity.id) ~= AITARGET_NONE) then
			dist = AI.GetAttentionTargetDistance(entity.id);
		end

		if (entity.AI.meleeBlock == 0 and entity.AI.stuntBlock == 0) then
			if (dist < 15.0) then
				entity:SelectPipe(0,"su_charge");
			end
		end
		
	end,

	--------------------------------------------------
	ENEMYSEEN_DURING_COMBAT = function (self, entity, sender)
	end,

	---------------------------------------------
	ENEMYSEEN_FIRST_CONTACT = function( self, entity )
	end,

	---------------------------------------------
	OnSomethingSeen = function( self, entity )
	end,
	
	---------------------------------------------
	OnInterestingSoundHeard = function( self, entity )
	end,

	---------------------------------------------
	OnThreateningSoundHeard = function( self, entity, fDistance )
	end,

	--------------------------------------------------	
	OnOutOfAmmo = function (self,entity, sender)	
		--TODO: Hide & cloak?
		AI.Signal(SIGNALFILTER_GROUPONLY_EXCEPT, 1, "COVER_GRENADE",entity.id);
	
		-- player would not have Reload implemented
		if (entity.Reload == nil) then
			do return end
		end

		local dist = 100.0;
		if (AI.GetTargetType(entity.id) ~= AITARGET_NONE) then
			dist = AI.GetAttentionTargetDistance(entity.id);
		end

		if (dist < 5.0 and entity.AI.meleeBlock == 0) then
			entity:SelectPipe(0,"su_melee");
			entity.AI.meleeBlock = 1;
			entity.AI.reloadBlock = 1;
		else
			if (entity.AI.reloadBlock == 0) then
				entity:Reload();
			end
		end
	end,
	
}
