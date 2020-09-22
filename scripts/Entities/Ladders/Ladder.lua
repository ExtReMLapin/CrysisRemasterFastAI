--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2005.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Ladder implementation
--  
--------------------------------------------------------------------------
--  History:
--  - 6:6:2005 : Created by Filippo De Luca
--
--------------------------------------------------------------------------

Ladder = 
{
	Properties = 
	{
		soclasses_SmartObjectClass = "Ladder",

		--fileModel = "objects/library/props/ladders/ladder_wood_7m.cgf",
		fileModel = "objects/Prototype/Measurement/ladder.cgf",
		fUseDistance = 2,
		sDirectionAxis = "x",
  },
  	
  Editor={
		Icon="Ladder.bmp",
	},
  	
  	PhysParams = 
  	{ 
  		mass = 0,
  		density = 0,
  	},
  	
  	bottom_pos = {x=0,y=0,z=0},
  	top_pos = {x=0,y=0,z=0},
  	  	
  Server = {},
	Client = {},
}


-------------------------------------------------------
function Ladder:OnLoad(table)
  self.bottom_pos = table.bottom_pos
  self.top_pos = table.top_pos
  self.direction = table.direction
end

-------------------------------------------------------
function Ladder:OnSave(table)
	table.bottom_pos = self.bottom_pos
	table.top_pos = self.top_pos
	table.direction = self.direction
end

function Ladder:OnPropertyChange()
	self:Reset();
end

function Ladder:OnReset()
	self:Reset();
end

function Ladder:OnSpawn()	
	self:Reset(1);
end

function Ladder:OnDestroy()
end

function Ladder.Server:OnUpdate(frameTime)
end

function Ladder:DoPhysicalize()
	if (self.currModel ~= self.Properties.fileModel) then
		self:LoadObject( 0,self.Properties.fileModel );
		self:Physicalize(0,PE_RIGID,self.PhysParams);
		
		local bbmin,bbmax = self:GetLocalBBox();
		bbmax.z = bbmax.z + 1.5;
		self:SetLocalBBox(bbmin,bbmax);
	end
	self.currModel = self.Properties.fileModel;
end

function Ladder:Reset(onSpawn)
	
	self:Activate(1);
	self:DoPhysicalize();		
	self:AwakePhysics(1);
	
	local axis = self.Properties.sDirectionAxis;
	if (axis == "X" or axis == "x") then
		self.direction = self:GetDirectionVector(0);
	elseif (axis == "Y" or axis == "y") then
		self.direction = self:GetDirectionVector(1);
	else
		self.direction = self:GetDirectionVector(2);
	end
	
	local bottomTag = System.GetEntityByName(self:GetName().."_bottom");
	local topTag = System.GetEntityByName(self:GetName().."_top");
	
	if (bottomTag and topTag) then
		bottomTag:GetWorldPos(self.bottom_pos);
		topTag:GetWorldPos(self.top_pos);
	else
		--no helpers found: set some defaults		
		local zAxis = self:GetDirectionVector(2);
		local bbmin,bbmax = self:GetLocalBBox();
		
		self:GetWorldPos(self.bottom_pos);
		self.bottom_pos.x = self.bottom_pos.x + zAxis.x * (bbmin.z + 1);
		self.bottom_pos.y = self.bottom_pos.y + zAxis.y * (bbmin.z + 1);
		self.bottom_pos.z = self.bottom_pos.z + zAxis.z * (bbmin.z + 1);
		
		self:GetWorldPos(self.top_pos);
		self.top_pos.x = self.top_pos.x + zAxis.x * (bbmax.z - 0.25);
		self.top_pos.y = self.top_pos.y + zAxis.y * (bbmax.z - 0.25);
		self.top_pos.z = self.top_pos.z + zAxis.z * (bbmax.z - 0.25);
						
		CopyVector(g_Vectors.temp_v1,self.direction);
		FastScaleVector(g_Vectors.temp_v1,g_Vectors.temp_v1,-0.5);
		
		FastSumVectors(self.top_pos,self.top_pos,g_Vectors.temp_v1);
		FastSumVectors(self.bottom_pos,self.bottom_pos,g_Vectors.temp_v1);		
	end
end

function ProjectPointToLine(result,point,lineStart,lineEnd)
	local line = g_Vectors.temp_v4;
	SubVectors(line,lineEnd,lineStart);
	NormalizeVector(line);

	result.x = point.x - lineStart.x;
	result.y = point.y - lineStart.y;
	result.z = point.z - lineStart.z;
	
	local dot1 = dotproduct3d(result,line)
	local dot2 = dotproduct3d(line,line);
	local dot = dot1/dot2;

	result.x = lineStart.x + line.x * dot;
	result.y = lineStart.y + line.y * dot;
	result.z = lineStart.z + line.z * dot;
end

function Ladder:IsUsable(user)

	if (not user) then
		return 0;
	end

	local delta = g_Vectors.temp_v1;
	local userPos = g_Vectors.temp_v2;
	
	user:GetWorldPos(userPos);
	ProjectPointToLine(delta,userPos,self.bottom_pos,self.top_pos);
		
	SubVectors(delta,delta,userPos);
	local dist = LengthSqVector(delta);

	local useDistance = self.Properties.fUseDistance;
			
	--first: check the distance
	if (dist<useDistance*useDistance) then
		
		do return 1; end
		
		local distVec =  g_Vectors.temp_v3;
		SubVectors(distVec,self.bottom_pos,userPos);
		local distBottom = LengthSqVector(distVec);
		SubVectors(distVec,self.top_pos,userPos);
		local distTop = LengthSqVector(distVec);
		
		--now, if the player is close to the bottom check the facing direction, otherwise ignore it.
		if (distBottom>distTop) then
			return 1;
		else
			--TODO:make more precise, plus this is good for upstraight ladders.
			NormalizeVector(delta);
			local dot = dotproduct3d(delta,self.direction);
			
			if (dot<0.25) then
				return 0;
			else		
				return 1;
			end
		end
	else
		return 0;
	end
end

function Ladder:GetUsableMessage(idx)
	return "@use_ladder"
end

function Ladder:OnUsed(user)	
	--user wants to detach?
	--if (user.ladderId == self.id) then
		--user.actor:CreateCodeEvent({event = "ladder",ladderTop = g_Vectors.v000,ladderBottom = g_Vectors.v000});
		--user.actor:SetExtensionParams("Interactor",{locker = self.id, lockId = NULL_ENTITY, lockIdx = 0});
		--user.ladderId = nil;
		--
		--user:HolsterItem(false);
		--
		--return nil;
	--end
	--
	--if (self:IsUsable(user) ~= 1) then
		--return nil;
	--end
	--		
	--user.actor:CreateCodeEvent({event = "ladder",ladderTop = self.top_pos,ladderBottom = self.bottom_pos});
	--user.actor:SetExtensionParams("Interactor",{locker = self.id, lockId = self.id, lockIdx = 1});
	--user.ladderId = self.id;
	--
	--HUD:SetInstructionObsolete(g_gameRules.UsableMessage);
	--g_gameRules.UsableMessage = nil;
	
	--user:HolsterItem(true);
end