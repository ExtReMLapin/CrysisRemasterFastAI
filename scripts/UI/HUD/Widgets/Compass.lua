----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: ECG (Electrocardiogram)
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 13:2:2005   13:58 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
HUDCompass =
{
	north	=	{ x=-1, y=0, z=0 },
	south	= { x=1, y=0, z=0 },
	west	=	{ x=0, y=-1, z=0 },
	east	=	{ x=0, y=1, z=0 },
}

----------------------------------------------------------------------------------------------------
function HUDCompass:SetTarget(targetId)
	self.targetId = targetId;
end


----------------------------------------------------------------------------------------------------
function HUDCompass:Draw(frameTime, frameId, pass)
	if (pass ~= 1) then
		return;
	end

	local ui = self.ui;
	local img;
	
	if (self.skin and self.skin.normal) then
		img = self.skin.normal;
	end

	if (self.compass_rect) then
		local rw = self.ui.width/800;
		local rh = self.ui.height/600;

		local x = self.left*rw;
		local y = self.top*rh;

		UI.DrawQuad(x, y, self.width*rw, self.height*rh, UI:GetImage(img), self.color, UI:FixUVRect(img, self.compass_rect));
		
		x = (self.left+(self.width-self.needle_width)*0.5)*rw;
		y = (self.top+self.height+self.needle_offset)*rw;
		UI.DrawQuad(x, y, self.needle_width*rw, self.needle_height*rw, UI:GetImage(img), self.color, UI:FixUVRect(img, self.needle.rect));
		HUD:DrawLine(self.left, self.top-1, self.left, self.top+self.height+1, self.border_color);
		HUD:DrawLine(self.left+self.width, self.top-1, self.left+self.width, self.top+self.height+1, self.border_color);
	end
end


----------------------------------------------------------------------------------------------------
function HUDCompass:Update(frameTime, frameId)
	if (self.targetId) then
		local target = System.GetEntity(self.targetId);
		if (target and target.actor) then
			self.viewDir = target.actor:GetHeadDir(self.viewDir);
			local dir = self.viewDir;
			dir.z = 0;
			vecCopy(dir, vecNormalize(dir));
			
			local north = vecDot(dir, self.north);
			local east = vecDot(dir, self.east);
			
			local ang = math.acos(north);
			local perimeter = self.north_span[2]-self.north_span[1];
			local radius = perimeter/(2.0*math.pi);

			local texx;
			
			if (east > 0) then
				texx = self.north_span[2]-radius*(math.pi*2-ang);
			else
				texx = self.north_span[1]+radius*(math.pi*2-ang);
			end
			
			if (not self.compass_rect) then
				self.compass_rect = {};
			end

			self.compass_rect[1] = texx-self.skin.rect[3]*0.5;
			self.compass_rect[2] = self.skin.rect[2];
			self.compass_rect[3] = self.skin.rect[3];
			self.compass_rect[4] = self.skin.rect[4];
		end
	else
		self.compass_rect = nil;
	end
end


----------------------------------------------------------------------------------------------------
function HUDCompass:Message(msg, ...)
	if (msg == UIM_UPDATE) then
		self:Update(...);
		self:DispatchEvent(msg, ...);
	elseif (msg == UIM_DRAW) then
		self:Draw(...);
		self:DispatchEvent(msg, ...);
	else
		self:DispatchEvent(msg, ...);
	end
end


----------------------------------------------------------------------------------------------------
UI:RegisterClass("compass", HUDCompass, UIWidget);
