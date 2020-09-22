----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements a static control.
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 17:8:2004   11:26 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
UIStatic =
{
};


----------------------------------------------------------------------------------------------------
function UIStatic:Draw(frameTime, frameId, pass)
	if (pass ~= 1) then
		return;
	end

	local ui = self.ui;
	local img;
	
	if (self.skin and self.skin.normal) then
		img = self.skin.normal;
	end

	local rw = ui:GetWidth()/800;
	local rh = ui:GetHeight()/600;
	
	local x = self.left*rw;
	local y = self.top*rh;
	
	UI.DrawQuad(x, y, self.width*rw, self.height*rh, UI:GetImage(img), self.color, UI:FixUVRect(img, self.skin.rect));
end


----------------------------------------------------------------------------------------------------
function UIStatic:Message(msg, ...)
	if (msg == UIM_MOUSEENTER) then
		self.mouseOver = true;
		self:DispatchEvent(msg, ...);
	elseif (msg == UIM_MOUSELEAVE) then
		self.mouseOver = false;
		self:DispatchEvent(msg, ...);
	elseif (msg == UIM_MOUSEUP) then
		self:DispatchEvent(msg, ...);
		self:DispatchEvent(UIM_COMMAND);
		return;
	elseif (msg == UIM_DRAW) then
		self:Draw(...);
		self:DispatchEvent(msg, ...);
	else
		self:DispatchEvent(msg, ...);
	end
end


UI:RegisterClass("static", UIStatic, UIWidget);