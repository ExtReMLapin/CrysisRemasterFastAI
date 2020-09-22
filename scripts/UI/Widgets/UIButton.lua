----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements a basic button
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 12:1:2005   19:11 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
UIButton =
{
};


----------------------------------------------------------------------------------------------------
function UIButton:Draw(frameTime, frameId, pass)
	local ui = self.ui;
	local skin 	= self.skin;
	local img = UI:SelectImage(skin, self.disabled, ui.mouse[1] and self.mouseOver, self.mouseOver);

	local rw = ui:GetWidth()/800;
	local rh = ui:GetHeight()/600;
	
	local x = self.left*rw;
	local y = self.top*rh;

	--Disabled for the new menu.
	--UI.DrawQuad(x, y, self.width*rw, self.height*rh, UI:GetImage(img), self.color, UI:FixUVRect(img, self.skin.rect));
	
	if (not EmptyString(self.text)) then
		-- offset the text if button pressed
		local offset = 0;
		if (ui.mouse[1] and self.mouseOver) then
			offset = 1;
		end
	
		local color = UIWhite;
		
		if (self.text_color) then
			color = self.text_color;
			
			if (self.text_over_color and self.mouseOver) then
				color = self.text_over_color;
			end
			if (self.text_down_color and self.mouseOver and ui.mouse[1]) then
				color = self.text_down_color;
			end
		end
	
		UI.DrawText(x+4+offset*rw, y+(self.height*0.5)*rh+offset*rh, self.text, self.height*rh, color, eUIA_Left, eUIA_Middle);
	end
end


----------------------------------------------------------------------------------------------------
function UIButton:Message(msg, ...)
	if (msg == 			UIM_MOUSEENTER) then
		self.mouseOver = true;
		self:DispatchEvent(msg, ...);
	elseif (msg == 	UIM_MOUSELEAVE) then
		self.mouseOver = false;
		self:DispatchEvent(msg, ...);
	elseif (msg == 	UIM_MOUSEUP) then
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


UI:RegisterClass("button", UIButton, UIWidget);