--------------------------------------------------
--    Created By: Luciano Morpurgo
--   Description: Trooper group combat behaviour
--------------------------
--

AIBehaviour.TrooperHideShoot = {
	Name = "TrooperHideShoot",
	Base = "TROOPERDEFAULT",
	alertness = 2,

	Constructor = function ( self, entity,sender,data )
	
		if(entity.AI.RefPointMemory==nil) then 
			entity.AI.RefPointMemory = {};	
		end
 		
 		if(data == nil or data.point==nil or IsNullVector(data.point)) then 
 			CopyVector(entity.AI.RefPointMemory,entity:GetPos());
		else
			CopyVector(entity.AI.RefPointMemory, data.point);
		end
 		AI.SetRefPointPosition(entity.id,entity.AI.RefPointMemory);
		
		if(data.iValue==1) then
			entity:SelectPipe(0, "tr_hide_near","refpoint");
		else
			local targetName = AI.GetAttentionTargetOf(entity.id);
			if(targetName and AI.Hostile(entity.id,targetName)) then 
				entity:SelectPipe(0,"tr_short_cover_fire",targetName);
			else
				entity:SelectPipe(0,"tr_short_cover_fire","beacon");
			end
		end
		
		if(data and data.fValue) then 
			if(data.fValue>0) then
				--limited duration
				entity.iTimer = Script.SetTimerForFunction(data.fValue*1000,"AIBehaviour.TrooperHideShoot.OnEnd",entity);
			elseif(data.fValue ==0) then
				--no duration; ready for next task since beginning
				AI.Signal(SIGNALFILTER_LEADER,10,"ORD_DONE",entity.id);
			--else
				-- infinite duration
			end
		end
		entity:MakeAlerted();
	end,

	---------------------------------------------
	Destructor = function(self,entity)
		if(entity.iTimer) then
			Script.KillTimer(entity.iTimer);
			entity.iTimer = nil;
		end
	end,
	---------------------------------------------
	END_COVER_FIRE = function(self,entity,sender)
		entity:SelectPipe(0, "tr_hide_near","refpoint");
	end,

	---------------------------------------------
	OnEnemyDamage = function ( self, entity, sender, data)
		-- data.id: the shooter
	end,

	---------------------------------------------
	OnDamage = function ( self, entity, sender, data)
		-- data.id: the shooter
	end,

	---------------------------------------------
	CORD_ATTACK = function( self, entity, sender )
		-- Ignore this order!
	end,

	---------------------------------------------	
	-- Orders --
	---------------------------------------------


	-- SYSTEM EVENTS			-----
	---------------------------------------------
	OnSelected = function( self, entity )	
	end,
	---------------------------------------------
	OnSpawn = function( self, entity )
		-- called when enemy spawned or reset
	end,
	---------------------------------------------
	OnActivate = function( self, entity )
		-- called when enemy receives an activate event (from a trigger, for example)
	end,
	---------------------------------------------
	OnNoTarget = function( self, entity )
		-- called when the enemy stops having an attention target
	end,
	---------------------------------------------
	OnPlayerSeen = function( self, entity, fDistance )
		-- first send him OnSeenByEnemy signal
--		local target = AI.GetAttentionTargetEntity(entity.id);
--		if(target) then 
--			AI.Signal(SIGNALFILTER_SUPERGROUP, 1, "OnSeenByEnemy", target.id);
--		end
		-- called when the enemy sees a living player
--		entity:InsertSubpipe(0, "DropBeaconAt");
	end,
	---------------------------------------------
	OnGrenadeSeen = function( self, entity, fDistance )
		-- called when the enemy sees a grenade
	end,
	---------------------------------------------
--	OnEnemySeen = function( self, entity )
--		-- called when the enemy sees a foe which is not a living player
--	end,
	---------------------------------------------
	OnSomethingSeen = function( self, entity )
		-- called when the enemy sees something that it cant identify
	end,
	---------------------------------------------
	OnEnemyMemory = function( self, entity )
		-- called when the enemy can no longer see its foe, but remembers where it saw it last
	end,
	---------------------------------------------
	OnInterestingSoundHeard = function( self, entity )
		-- called when the enemy hears an interesting sound
	end,
	---------------------------------------------
	OnThreateningSoundHeard = function( self, entity )
		-- first send him OnSeenByEnemy signal
--		local target = AI.GetAttentionTargetEntity(entity.id);
--		if(target) then 
--			AI.Signal(SIGNALFILTER_SUPERGROUP, 1, "OnSeenByEnemy", target.id);
--		end

		-- called when the enemy hears a scary sound
	end,
	---------------------------------------------
	OnReload = function( self, entity )
		-- called when the enemy goes into automatic reload after its clip is empty
		--entity:InsertSubpipe(0, "reload_combat");
	end,
	---------------------------------------------
	OnGroupMemberDied = function( self, entity )
		-- called when a member of the group dies
		AI.LogEvent(entity:GetName().." received OnGroupMemberDied");
		--entity:CheckReinforcements();

	end,
	---------------------------------------------
	OnNoHidingPlace = function( self, entity, sender )
	--	entity:SelectPipe(0,"tr_just_shoot");
	end,	
	---------------------------------------------
	OnHideSpotReached = function( self, entity, sender )

	end,	
	---------------------------------------------
	OnFriendInWay = function(self,entity,sender,data)
	
		if(not entity.AI.bStrafing) then
			AIBehaviour.TROOPERDEFAULT:StrafeObstacle(entity);
		end
	end,
--	---------------------------------------------
	STRAFE_POINT_REACHED = function(self,entity,sender)
		entity.AI.bStrafing = false;
		local targetName = AI.GetAttentionTargetOf(entity.id);
		if(targetName and AI.Hostile(entity.id,targetName)) then 
			entity:SelectPipe(0,"tr_short_cover_fire",targetName);
		else
			entity:SelectPipe(0,"tr_short_cover_fire","beacon");
		end
		
	end,	

--
	---------------------------------------------
--	OnCloseContact = function(self,entity,sender)
----		entity:InsertSubpipe(0,"tr_backoff_fire");
--	end,

--	---------------------------------------------
	OnLowHideSpot = function( self, entity, sender )
--		entity:SelectPipe(0,"tr_dig_in_shoot_on_spot");
	end,	

	--------------------------------------------------
	OnNoFormationPoint = function ( self, entity, sender)
		-- called when the enemy found no formation point
	end,
	---------------------------------------------
	OnReceivingDamage = function ( self, entity, sender)
		-- called when the enemy is damaged
	end,
	---------------------------------------------
	OnCoverRequested = function ( self, entity, sender)
		-- called when the enemy is damaged
	end,
	--------------------------------------------------
	OnBulletRain = function ( self, entity, sender)
		-- called when the enemy detects bullet trails around him
--		entity:InsertSubpipe(0, "hide_on_bullet_rain");
	end,
	
	---------------------------------------------
	OnSomebodyDied = function ( self, entity, sender)

	end,
	--------------------------------------------------
	ORDER_MOVE = function(self,entity,sender,data)
		AI.SetRefPointPosition(entity.id,data.point);
		entity:SelectPipe(0,"tr_approach_refpoint");
		entity:InsertSubpipe(0,"stop_fire");

	end,

	--------------------------------------------------
	REFPOINT_REACHED = function ( self, entity, sender)
		AI.Signal(SIGNALFILTER_LEADER,10,"ORD_DONE",entity.id);
	end,
	
	--------------------------------------------------
	APPROACH_DISTANCE = function(self,entity,sender,data)
		--data.fValue = distance
		g_StringTemp1 = "suborder_stick"..data.fValue;
		AI.CreateGoalPipe(g_StringTemp1);
--		AI.PushGoal(g_StringTemp1,"bodypos",1,BODYPOS_PRONE);
		AI.PushGoal(g_StringTemp1,"run",1,1);
		AI.PushGoal(g_StringTemp1,"stick",1,data.fValue,0,1);
		--AI.PushGoal(g_StringTemp1,"signal",1,10,"ORDER_APPROACH_END",SIGNALFILTER_SENDER);
		--AI.PushGoal(g_StringTemp1,"signal",1,10,"ORD_DONE",SIGNALFILTER_LEADER);
		entity:SelectPipe(0, "tr_stay_hidden");
    entity:InsertSubpipe(0, "tr_order_hide");
    entity:InsertSubpipe(0,g_StringTemp1);
		if(not AI.Hostile(entity.id,AI.GetAttentionTargetOf(entity.id))) then
			entity:InsertSubpipe(0,"acquire_beacon");
		end
		
	end,	
	
	--------------------------------------------------
	INCOMING_FIRE = function(self,entity)
	
	end,
	
	--------------------------------------------------
	HEADS_UP_GUYS = function(self,entity)
	
	end,
	
	OnEnd = function(entity,timerId)
		entity.iTimer = nil;
		AI.Signal(SIGNALFILTER_LEADER,10,"ORD_DONE",entity.id);
	end,
	
}
