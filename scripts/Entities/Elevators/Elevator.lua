--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2007.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Elevator
--  
--------------------------------------------------------------------------
--  History:
--  - 28:1:2007 : Created by Marcio Martins
--
--------------------------------------------------------------------------

Elevator = 
{
	Properties = 
	{
		soclasses_SmartObjectClass = "Elevator",

		objModel = "",
		
		Sounds = 
		{
			soundSoundOnStart = "",
			soundSoundOnMove 	= "sounds/doors/wooddooropen.wav",
			soundSoundOnStop 	= "",
		},
		
		bAutomatic				= 0,
		nFloorCount				= 2,
		fFloorHeight			= 5,
		nInitialFloor			= 0,
		nDestinationFloor = 1,
		
		Slide = 
		{
			fSpeed 				= 1.0,
			fAcceleration = 1.0,
			sAxis 				= "z",
			fStopTime 		= 0.75
		},
	},

	Editor={
		Icon = "elevator.bmp",
		IconOnTop=1,
	},

	Server = {},
	Client = {},
}


----------------------------------------------------------------------------------------------------
function Elevator:OnPreFreeze(freeze, vapor)
	if (freeze) then
		return false; -- don't allow freezing
	end
end


function Elevator:OnPropertyChange()
	self:Reset();
end


function Elevator:OnReset()
	self:Reset();
end


function Elevator:OnSpawn()	
	CryAction.CreateGameObjectForEntity(self.id);
	CryAction.BindGameObjectToNetwork(self.id);
	CryAction.ForceGameObjectUpdate(self.id, true);	
	
	
	self.isServer=CryAction.IsServer();
	self.isClient=CryAction.IsClient();
	
	self.originalpos=self:GetWorldPos();
	

	self:Reset();
end


function Elevator:OnDestroy()
end


function Elevator:DoPhysicalize()
	if (self.currModel ~= self.Properties.objModel) then
		CryAction.ActivateExtensionForGameObject(self.id, "ScriptControlledPhysics", false);
		self:LoadObject( 0,self.Properties.objModel );
		self:Physicalize(0,PE_RIGID,{mass=0});
		CryAction.ActivateExtensionForGameObject(self.id, "ScriptControlledPhysics", true);
	end
	self.currModel = self.Properties.objModel;
end


function Elevator:Reset()
	self:Activate(0);
	self:DoPhysicalize();
	
	local initial=self.Properties.nInitialFloor;

	self.floorpos={};
	self.floorpos[initial]=self.originalpos;
	
	if (self.Properties.nFloorCount>0) then
		
		for i=0,self.Properties.nFloorCount-1 do
			local pos=vecNew(self.originalpos);
			local axis=self.Properties.Slide.sAxis;
			local height=self.Properties.fFloorHeight;
			local range=(i*height-initial*height);
			local dir=g_Vectors.temp_v1;
			
			if (axis=="X" or axis=="x") then
				dir=self:GetDirectionVector(0, dir);
			elseif (axis=="Y" or axis=="y") then
				dir=self:GetDirectionVector(1, dir);
			else
				dir=self:GetDirectionVector(2, dir);
			end
			
			pos.x=pos.x+dir.x*range;
			pos.y=pos.y+dir.y*range;
			pos.z=pos.z+dir.z*range;
			self.floorpos[i]=pos;
		end
	end
	
	self.currFloor=initial;
	self.goalFloor=initial;
	self.nextFloor=nil;

	self.automatic=self.Properties.bAutomatic~=0;
	if (self.automatic) then
		local min,max=self:GetLocalBBox();
		self:SetTriggerBBox(min, max);
	end

	self:UpdateSlide(0);
	self:AwakePhysics(1);
end


function Elevator.Server:OnTimer(timerId, msec)
	if (timerId==1) then
		if (self.automatic and (not self.resting)) then
			self:Slide(self.Properties.nInitialFloor);
		elseif (self.nextFloor and self.nextFloor~=self.currFloor) then
			self:Slide(self.nextFloor);
			self.nextFloor=nil;
		end
	else
		if (self.automatic) then
			self:Slide(self.Properties.nDestinationFloor);
		end
	end
end


function Elevator.Server:OnEnterArea(entity, areaId)
	if (entity and entity.actor) then
		self:SetTimer(0, 2000);
	end
end


function Elevator:UpdateSlide(frameTime)
	if (self.currFloor==self.goalFloor) then
		return;
	end
	
	local currPos=self:GetWorldPos(g_Vectors.temp_v1);
	local goalPos=self.floorpos[self.goalFloor];

	if (vecLenSq(vecSub(goalPos, currPos))<0.001) then
		self.currFloor=self.goalFloor;
		
		self:SoundOff(self.Properties.Sounds.soundSoundOnMove);
		self:Sound(self.Properties.Sounds.soundSoundOnStop);
		
		if (self.isServer) then
			if (self.automatic) then
				if (self.currFloor==self.Properties.nInitialFloor) then
					self.resting=true;
				end
			end
			self:SetTimer(1, 3000);
		end
		
		self:Activate(0);
	else
		self.resting=false;
	end
end


function Elevator.Server:OnCollision(collision)
end


function Elevator.Server:OnUpdate(frameTime)
	self:UpdateSlide(frameTime);
end


function Elevator.Client:OnUpdate(fameTime)
	if (not self.isServer) then
		self:UpdateSlide(frameTime);
	end
end


function Elevator.Server:OnInitClient(channelId)
	if (self.currFloor==self.goalFloor) then
		self.Client.ClSlide(self, self.goalFloor, true);
	else
		self.Client.ClInitMoving(self, self.currFloor, self.goalFloor, self.scp:GetSpeed(), self.scp:GetAcceleration());
	end
end


function Elevator.Server:SvRequestSlide(userId, floor)
	self:Slide(user, floor);
end


function Elevator.Client:ClSlide(floor)
	if (not self.isServer) then
		self:Slide(floor);
	end
end


function Elevator:OnPostStep()
	
end


function Elevator:Slide(floor)
	if (floor>=self.Properties.nFloorCount) then
		floor=self.Properties.nFloorCount-1;
	elseif (floor<0) then
		floor=0;
	end
	
	local speed=self.scp:GetSpeed();

	if (self.currFloor==floor and speed==0) then
		return;
	elseif (self.goalFloor==floor) then
		return;
	end
	
	if (speed<=0) then
		self:Sound(self.Properties.Sounds.soundSoundOnStart);
		self:Sound(self.Properties.Sounds.soundSoundOnMove, true);

		self.goalFloor=floor;
		self.currFloor=-1;
		
		self:Activate(1);	
		
		self.Client.ClSlide(self, floor, false);
		
		self.scp:MoveTo(self.floorpos[self.goalFloor], self:GetSpeed(), self.Properties.Slide.fSpeed, self.Properties.Slide.fAcceleration, self.Properties.Slide.fStopTime);
	else
		self.nextFloor=floor;
	end
end


function Elevator:Sound(snd, loop)
	if (not snd or snd=="") then
		return;
	end
	
	if (loop and not self.soundIds) then
		self.soundIds={};
	end

	local id=self:PlaySoundEvent(snd, g_Vectors.v000, g_Vectors.v010, SOUND_DEFAULT_3D, SOUND_SEMANTIC_MECHANIC_ENTITY);
	--local id=self:PlaySoundEventEx(snd, SOUND_DEFAULT_3D, 1, g_Vectors.v000, 0, 0, SOUND_SEMANTIC_MECHANIC_ENTITY);	
	
	if (loop) then
		self.soundIds[snd] = id;
	end
end


function Elevator:SoundOff(snd)
	if (self.soundIds and self.soundIds[snd]) then
		self:StopSound(self.soundIds[snd]);
		self.soundIds[snd]=nil;
	end
end


function Elevator:Up(callFloor)
	if (self.currFloor==callFloor) then
		self:Slide(self.goalFloor+1);
	else
		self:Slide(callFloor);
	end
end


function Elevator:Down(callFloor)
	if (self.currFloor==callFloor) then
		self:Slide(self.goalFloor-1);
	else
		self:Slide(callFloor);
	end
end


function Elevator.Client:ClSlide(floor, instant)
	if (not self.isServer) then
		if (not instant) then
			self:Slide(floor);
		else
			self.goalFloor=floor;
			self.currFloor=floor;
			self:SetWorldPos(self.floorpos[self.goalFloor]);
		end
	end
end


function Elevator.Client:ClInitMoving(currFloor, goalFloor, speed, acceleration)
	self.currFloor=currFloor;
	self.goalFloor=goalFloor;

	self.scp:MoveTo(self.floorpos[self.goalFloor], speed, self.Properties.Slide.fSpeed, acceleration, self.Properties.Slide.fStopTime);
	
	self:Activate(1);
end


Elevator.FlowEvents =
{
	Inputs =
	{
		Up = { Elevator.Up, "bool" },
		Down = { Elevator.Down, "bool" },
	},
	Outputs =
	{
		Up = { Elevator.Up, "bool" },
		Down = { Elevator.Down, "bool" },
	},
}
