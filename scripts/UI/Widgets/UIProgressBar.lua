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
UIProgressBar =
{
	progress = 0,
	max_progress = 100,
};


----------------------------------------------------------------------------------------------------
function UIProgressBar:Draw(frameTime, frameId, pass)
	if (pass ~= 1) then
		return;
	end
	
	local ui = self.ui;
	local img;
	
	if (self.skin and self.skin.normal) then
		normalimg = self.skin.normal;
		backimg = self.skin.background;		
	end
	
	local progress = self.progress;
	
	if (progress < 0) then
		progress = 0;
	elseif (progress > self.max_progress) then
		progress = self.max_progress;
	end
	
	progress = progress/self.max_progress;

	-- draw background
	local rw = ui:GetWidth()/800;
	local rh = ui:GetHeight()/600;
	
	if (backimg) then
		UI.DrawQuad(self.left*rw, self.top*rh, self.width*rw, self.height*rh, UI:GetImage(backimg), self.color, UI:FixUVRect(backimg, self.skin.rect));
	end
	
	if (normalimg) then
		-- draw progress on top
		local width = self.width*progress;
		local uv = UI:FixUVRect(normalimg, self.skin.rect);
		uv[3] = uv[3]*progress;
	
		UI.DrawQuad(self.left*rw, self.top*rh, width*rw, self.height*rh, UI:GetImage(normalimg), self.color, uv);
	end
end


----------------------------------------------------------------------------------------------------
function UIProgressBar:Message(msg, ...)
	if (msg == UIM_DRAW) then
		self:Draw(...);
		self:DispatchEvent(msg, ...);
	else
		self:DispatchEvent(msg, ...);
	end
end


UI:RegisterClass("progressbar", UIProgressBar, UIWidget);