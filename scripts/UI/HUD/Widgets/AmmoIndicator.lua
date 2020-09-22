----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Ammo Indicator!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 16:2:2005   21:22 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
HUDAmmoIndicator =
{
	north	=	{ x=0, y=1, z=0 },
	south	= { x=0, y=-1, z=0 },
	west	=	{ x=1, y=0, z=0 },
	east	=	{ x=-1, y=0, z=0 },
}

----------------------------------------------------------------------------------------------------
function HUDAmmoIndicator:SetTarget(targetId)
	self.targetId = targetId;
end


----------------------------------------------------------------------------------------------------
function HUDAmmoIndicator:Draw(frameTime, frameId, pass)
	if (pass ~= 1) then
		return;
	end

	local ui = self.ui;
	local img;

	if (self.skin and self.skin.normal) then
		img = self.skin.normal;
	end

	if (self.compass_rect) then
		local rw = UI.GetScreenWidth()/800;
		local rh = UI.GetScreenHeight()/600;

		local x = self.left*rw;
		local y = self.top*rh;

		UI.DrawQuad(x, y, self.width*rw, self.height*rh, UI:GetImage(img), self.color, UI:FixUVRect(img, self.compass_rect));
		
		x = (self.left+(self.width-self.needle_width)*0.5)*rw;
		y = (self.top+self.height+self.needle_offset)*rw;
		UI.DrawQuad(x, y, self.needle_width*rw, self.needle_height*rw, UI:GetImage(img), self.color, UI:FixUVRect(img, self.needle.rect));
	end
end


----------------------------------------------------------------------------------------------------
function HUDAmmoIndicator:Update(frameTime, frameId)
	if (self.targetId) then
		local target = System.GetEntity(self.targetId);
		if (target) then
			
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUDAmmoIndicator:Message(msg, ...)
	if (msg == UIM_UPDATE) then
		self:Update();
		self:DispatchEvent(msg, ...);
	elseif (msg == UIM_DRAW) then
		self:Draw(...);
		self:DispatchEvent(msg, ...);
	else
		self:DispatchEvent(msg, ...);
	end
end


----------------------------------------------------------------------------------------------------
UI:RegisterClass("ammoindicator", HUDAmmoIndicator, UIWidget);