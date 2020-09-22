Script.ReloadScript( "Scripts/Entities/Physics/BasicEntity.lua" );

AnimObject = {
	Properties = 
	{
		Animation = {
			Animation = "Default",
			Speed=1,
			bLoop=0,
			bPlaying=0,
			bAlwaysUpdate=0,

			playerAnimationState="",
			bPhysicalizeAfterAnimation=0,
		},
		Physics = {
			bArticulated = 0,
		},
		ActivatePhysicsThreshold = 0,
		ActivatePhysicsDist = 50,
		bNoFriendlyFire = 0,
	},

	PHYSICALIZEAFTER_TIMER = 1,
	POSTQL_TIMER = 2,

	Client = {},
	Server = {},

	Editor={
		Icon = "animobject.bmp",
		IconOnTop=1,
	}
};


MakeDerivedEntity( AnimObject,BasicEntity )

------------------------------------------------------------------------------------------------------
function AnimObject:SetFromProperties()
	self.__super.SetFromProperties(self); -- Call parent function.
	self.controllingAnimHere = true;
	self.animstarted = 0;
	
	local Properties = self.Properties;

--	if (Properties.Animation.bPlaying ~= self.bAnimPlaying or Properties.Animation.bLoop ~= self.bAnimLoop or 
--			Properties.Animation.Animation ~= self.AnimName or Properties.Animation.Speed ~= self.animationSpeed) then
			
		self.bAnimPlaying = Properties.Animation.bPlaying;
		self.bAnimLoop = Properties.Animation.bLoop;
		self.AnimName = Properties.Animation.Animation;
		if (Properties.Animation.bPlaying == 1) then
			self:DoStartAnimation();
			
		else
			self:ResetAnimation(0, -1);
		end
--	end
	if (Properties.Animation.bAlwaysUpdate == 1) then
		self:Activate(1);
	end
	self:SetAnimationSpeed( 0, 0, Properties.Animation.Speed )
	self.animationSpeed = Properties.Animation.Speed;
	self.curAnimTime = 0;
	if (self.Properties.ActivatePhysicsThreshold>0) then
		local apd = { threshold = self.Properties.ActivatePhysicsThreshold, detach_distance = self.Properties.ActivatePhysicsDist }
		self:SetPhysicParams(PHYSICPARAM_AUTO_DETACHMENT, apd);
	end
end

------------------------------------------------------------------------------------------------------
function AnimObject:OnSpawn()
	self.__super.OnSpawn(self); -- Call parent
	
	if (self.Properties.Animation.bAlwaysUpdate == 1) then
		CryAction.CreateGameObjectForEntity(self.id);
		CryAction.BindGameObjectToNetwork(self.id);
		CryAction.ForceGameObjectUpdate(self.id, true);	
		self:Activate(1);
	end

end

------------------------------------------------------------------------------------------------------
function AnimObject:OnReset()
	self.__super.OnReset(self); -- Call parent
	self.bAnimPlaying = 0;
	self:SetFromProperties();
end


------------------------------------------------------------------------------------------------------
function AnimObject:Event_ResetAnimation()

	self.controllingAnimHere = true;
	self:ResetAnimation(0, -1);
	self.animstarted=0;
	--
	local PhysProps = self.Properties.Physics;
	if( PhysProps.Mass>0 ) then
		self:OnReset();
	else
		self:StartAnimation( 0,self.Properties.Animation.Animation,0,0,0,false );	
	end;
	-- net
	self.Client.ClEvent_ResetAnimation(self);

end

------------------------------------------------------------------------------------------------------
function AnimObject:Event_StartAnimation(sender)
	self.controllingAnimHere = true;
	self:StartEntityAnimation();
	self.animstarted=1;

	self.Client.ClEvent_StartAnimation(self, CryAction.GetServerTime());
	--Log("Server:ClEvent_StartAnimation call"..self:GetName());

end

------------------------------------------------------------------------------------------------------
function AnimObject:Event_StopAnimation(sender)
	self.controllingAnimHere = true;
	if (self.animstarted == 1 and self:IsAnimationRunning(0,0)) then
		self.curAnimTime = self:GetAnimationTime(0,0);
	else
		self.curAnimTime = 0;
	end
	self:StopAnimation(0, -1);	-- all layers
	self.animstarted = 0;
end

------------------------------------------------------------------------------------------------------
function AnimObject:DoStartAnimation()
	self:StartAnimation( 0,self.Properties.Animation.Animation,0,0,self.Properties.Animation.Speed,self.Properties.Animation.bLoop,1 );			
	self:ForceCharacterUpdate(0, true);
	self.animstarted = 1;
	
	-- save curAnimTime for QS/QL
	if (self.Properties.Animation.Speed < 0) then
		self.curAnimTime = 0;
	else
		self.curAnimTime = self:GetAnimationLength(0, self.Properties.Animation.Animation);
	end

--	local currTime = System.GetCurrTime();
	self.startTime = CryAction.GetServerTime();--System.GetCurrAsyncTime();
	if( self.timeDiff ) then
		self.startTime=self.startTime-self.timeDiff;
	end


end

------------------------------------------------------------------------------------------------------
function AnimObject:StartEntityAnimation()
	self:StopAnimation(0, -1);
	self:DoStartAnimation();	
	self.bStopAnimAfterQL = false;
	self:KillTimer(self.POSTQL_TIMER);
	
-- Hacky code for VS2	
	local playerAnimationState = self.Properties.Animation.playerAnimationState;
	if (g_localActor and playerAnimationState ~= "") then
		g_localActor.actor:CreateCodeEvent(
		{
			event = "animationControl",pos=self:GetWorldPos(),angle=self:GetWorldAngles()
		}
		); --,entId=self.id})
		g_localActor.actor:QueueAnimationState(playerAnimationState);
		if (self.Properties.Animation.bPhysicalizeAfterAnimation == 1) then
			local animLen = self:GetAnimationLength(0,self.Properties.Animation.Animation) * 1000.0 / self.Properties.Animation.Speed;
			self:SetTimer(self.PHYSICALIZEAFTER_TIMER,animLen);
			--Log("timer set to:"..animLen.."ms");
		end
	end
end

------------------------------------------------------------------------------------------------------
function AnimObject.Client:OnTimer(timerId,mSec)
	if (timerId == self.PHYSICALIZEAFTER_TIMER) then
		local PhysProps = self.Properties.Physics;
		
		PhysProps.bRigidBodyActive = 1;
		PhysProps.bPhysicalize=1;
		PhysProps.bRigidBody=1;
		PhysProps.bResting = 0;
					
		if (self.bRigidBodyActive ~= PhysProps.bRigidBodyActive) then
			self.bRigidBodyActive = PhysProps.bRigidBodyActive;
			self:PhysicalizeThis();
		end
		if (PhysProps.bRigidBody == 1) then
			self:AwakePhysics(1-PhysProps.bResting);
			self.bRigidBodyActive = PhysProps.bRigidBodyActive;
		end
	end
	if (timerId == self.POSTQL_TIMER) then
		--System.Log("Stopping Anim");
		self:StopAnimation(0, -1);
	end
end

function AnimObject:CorrectTiming(frameTime)

--	local skip = 0;
--	if( skip==0 ) then
	if( self.animstarted==1 and self:IsAnimationRunning(0,0) and self.Properties.Animation.Speed>0 ) then
		local curTime = CryAction.GetServerTime();--System.GetCurrAsyncTime();
		local diffRealTime = (curTime-self.startTime)*self.Properties.Animation.Speed;
		local curAnimTime = self:GetAnimationTime(0,0) * self:GetAnimationLength(0,self.Properties.Animation.Animation)
		if( curAnimTime<=self.curAnimTime ) then 
			local diff = diffRealTime-curAnimTime;
			if( diff<-0.02 ) then
					-- correct speed
					local frameTimeAnim = self.Properties.Animation.Speed*frameTime;
					local reqTime = frameTimeAnim-diff;
					local ratio = (frameTimeAnim)/reqTime;
					if( ratio<0.5 ) then
						-- clamp
						ratio=0.5;
					end
					--
					newSpeed = ratio*self.Properties.Animation.Speed;
					self:SetAnimationSpeed( 0, 0, newSpeed );
	        --
					--System.LogToConsole(self:GetName().." RealLess="..diff.." Speed="..newSpeed);
			else
				if( diff>0.02 ) then
					-- correct speed
					local frameTimeAnim = self.Properties.Animation.Speed*frameTime;
					local reqTime = frameTimeAnim+diff;
					local ratio = reqTime/(frameTimeAnim);
					if( ratio>1.1 ) then
						-- clamp
						ratio=1.1;
					end
					--
					newSpeed = ratio*self.Properties.Animation.Speed;
					self:SetAnimationSpeed( 0, 0, newSpeed );
	        --
					--System.LogToConsole(self:GetName().." RealMore="..diff.." Speed="..newSpeed);
				else
					-- restore speed
					if( self.Properties.Animation.Speed>0 ) then
						self:SetAnimationSpeed( 0, 0, self.Properties.Animation.Speed );
					end
				end
			end
		end
	end	
--	end
end

--function AnimObject.Server:OnUpdate(dt)
	--if( CryAction.IsServer() ) then
		--self:CorrectTiming(dt);
	--end
--end

function AnimObject.Client:OnUpdate(dt)

	--if( CryAction.IsClient() and not CryAction.IsServer() ) then
		--self:CorrectTiming(dt);
	--end

	if (self.bStopAnimAfterQL) then
		self.bStopAnimAfterQL = false;
		self:SetTimer(self.POSTQL_TIMER, 0.2);
		if (self.Properties.Animation.bAlwaysUpdate ~= 1) then
			self:Activate(0);
		end
	end

	--local count = self:CountLinks();
	--for v = 0, count-1, 1 do
		--local link = self:GetLink(v);
		--if(link) then
			--local name = self:GetLinkName(link.id);
			--if( name ) then
				--local pos = self:GetHelperPos(name,false);
				--local angles = self:GetHelperAngles(name,false);
				--link:SetWorldAngles(angles);
				--link:SetWorldPos(pos);
			--end
		--end
	--end

end

-------------------------------------------------------
function AnimObject:OnLoad(table)  
	--self.__super.OnLoad( self,table ); -- Call parent
	
  self.bAnimPlaying = table.bAnimPlaying;
  self.bAnimLoop = table.bAnimLoop;
  self.AnimName = table.AnimName;
  self.animstarted = table.animstarted;

	self.controllingAnimHere = table.bControllingAnimHere;
  
  if (self.controllingAnimHere) then
	  if (self.animstarted == 1) then -- restart animation
	    self:StartEntityAnimation();
	    self:SetAnimationTime(0, 0, table.animTime);
	  else
	    --we have to stop the animation
	    -- either at the point stored in the file
	  	if (table.animTime > 0) then
		    self:StartEntityAnimation();
				self:SetAnimationSpeed( 0, 0, 0.0 );
		    self:SetAnimationTime(0, 0, table.animTime);
		    self.bStopAnimAfterQL = true;
		    self:Activate(1);
		  else
		    -- or just at the beginning
		    self:ResetAnimation(0, -1);
		  end
	  end
	else
		self.externalAnim_anim = table.externalAnim_anim;
		self.externalAnim_layer = table.externalAnim_layer;
		self.externalAnim_loop = table.externalAnim_loop;
		self:StartAnimation( 0, self.externalAnim_anim, self.externalAnim_layer, 0, 1, self.externalAnim_loop );			
    self:SetAnimationTime(0, self.externalAnim_layer, table.animTime);
	end
end	
	
	

-------------------------------------------------------
function AnimObject:OnSave(table)  
	--self.__super.OnSave( self,table ); -- Call parent
	
	table.bAnimPlaying = self.bAnimPlaying
	table.bAnimLoop = self.bAnimLoop
	table.AnimName = self.AnimName
	table.bControllingAnimHere = self.controllingAnimHere;
	
	if (self.controllingAnimHere) then
		if (self.animstarted == 1 and self:IsAnimationRunning(0,0)) then
			table.animTime = self:GetAnimationTime(0,0);
			table.animstarted = 1;
		else
			table.animstarted = 0;
			if (self.curAnimTime) then
			  table.animTime = self.curAnimTime;
			else
				table.animTime = 0;
			end
		end
	else
		table.externalAnim_anim = self.externalAnim_anim;
		table.externalAnim_layer = self.externalAnim_layer;
		table.externalAnim_loop = self.externalAnim_loop;
		table.animTime = self:GetAnimationTime(0,self.externalAnim_layer);
	end
	
end

------------------------------------------------------------------------------------------------------
-- Additional Flow events.
------------------------------------------------------------------------------------------------------
AnimObject.FlowEvents.Inputs.ResetAnimation = { AnimObject.Event_ResetAnimation, "bool" }
AnimObject.FlowEvents.Inputs.StartAnimation = { AnimObject.Event_StartAnimation, "bool" }
AnimObject.FlowEvents.Inputs.StopAnimation = { AnimObject.Event_StopAnimation, "bool" }


-- client functions
function AnimObject.Client:ClEvent_StartAnimation(servertime)

	--Log("ClEvent_StartAnimation recieved"..self:GetName());

	self.timeDiff = CryAction.GetServerTime()-servertime;
--	local localDiff = System.GetCurrTime()-servertime;
--	if( self.timeDiff>0.1 ) then
--			System.LogToConsole(self:GetName().." Diff="..self.timeDiff.." localDiff="..localDiff);
--	else
--		if( self.timeDiff<-0.1 ) then
--				System.LogToConsole(self:GetName().." Diff="..self.timeDiff);
--		end
--	end
	
	if( not CryAction.IsServer() ) then
		self:Event_StartAnimation();
	end
end

function AnimObject.Client:ClEvent_ResetAnimation()
	if( not CryAction.IsServer() ) then
		self:Event_ResetAnimation();
	end
end

------------------------------------------------------------------------------------------------------
function AnimObject:SavePhysicalState()
  self.initPos = self:GetPos();
  self.initRot = self:GetWorldAngles();
  self.initScale = self:GetScale();
end

------------------------------------------------------------------------------------------------------
function AnimObject:RestorePhysicalState()
  self:SetPos(self.initPos);
  self:SetWorldAngles(self.initRot);
  self:SetScale(self.initScale);


	-- restore
	self:ResetAnimation(0, -1);
	self.animstarted=0;
	local PhysProps = self.Properties.Physics;
	if( PhysProps.Mass>0 ) then
		self:OnReset();
	else
		self:StartAnimation( 0,self.Properties.Animation.Animation,0,0,0,false );	
	end;



end

function AnimObject:SendSyncToClient( channelId )
	if( self.animstarted==1 ) then
		animTime = self:GetAnimationTime(0,0);
		self.Client.ClSync( self, animTime, self.startTime, CryAction.GetServerTime() )
	end
end


function AnimObject.Server:OnPostInitClient( channelId )
	self:SendSyncToClient(channelId);
end

function AnimObject.Server:SVSync(channelId)
	self:SendSyncToClient(channelId);
end

function AnimObject.Client:ClSync( animTimeValue, startTimeValue, serverTimeValue )
--	if( self.animstarted==0 ) then
		--self:Event_ResetAnimation();
		--self.timeDiff = CryAction.GetServerTime()-serverTimeValue;
		self:StartEntityAnimation();
		self.startTime = startTimeValue;
		self:SetAnimationTime(0,0,animTimeValue);
		--Log("CLSync recieved"..self:GetName()..animTimeValue);
--	end
end

function AnimObject:UpdateFromServer()

	self.Server.SVSync(self);

end


-- Notification from trackview (animation in sequence starts/stops)
function AnimObject:OnSequenceAnimationStart( animName, layer, loop )
	self.controllingAnimHere = false;
	self.externalAnim_anim = animName;
	self.externalAnim_layer = layer;
	self.externalAnim_loop = loop;
end

function AnimObject:OnSequenceAnimationStop()
	self.controllingAnimHere = true;
end


function AnimObject:OnFlowGraphAnimationStart( animName, layer, loop )
	self.controllingAnimHere = false;
	self.externalAnim_anim = animName;
	self.externalAnim_layer = layer;
	self.externalAnim_loop = loop;
end

function AnimObject:OnFlowGraphAnimationStop()
	self.controllingAnimHere = true;
end
