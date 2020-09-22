----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: User Interface UI
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 12:1:2005   16:33 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
UIUI = {};


----------------------------------------------------------------------------------------------------
function UIUI:DrawMouse()
	if (self.mouseCursor and (not self.hideMouse)) then
		local rw = self.width/800;
		local rh = self.height/600;

		UI.DrawQuad(self.mouseX*rw, self.mouseY*rh, self.mouseSize*rw, self.mouseSize*rh, UI:GetImage(self.mouseCursor), UIWhite);
	end
end


----------------------------------------------------------------------------------------------------
function UIUI:Init()
	self:Reset();
end


----------------------------------------------------------------------------------------------------
function UIUI:Reset()
	self.mouseX = 0;
	self.mouseY = 0;
	self.mouseZ = 0;
end


----------------------------------------------------------------------------------------------------
function UIUI:Release()
end


----------------------------------------------------------------------------------------------------
function UIUI:MouseUp(btn, x, y)
	if (not self.active) then return end;
	
	local mouseOver = self.mouseOver;
	if (mouseOver) then
		mouseOver:Message(UIM_MOUSEUP, btn, x, y);
	end
	self.mouse[btn] = false;
end


----------------------------------------------------------------------------------------------------
function UIUI:MouseDown(btn, x, y)
	if (not self.active) then return end;
	
	local mouseOver = self.mouseOver;
	if (mouseOver) then
		mouseOver:Message(UIM_MOUSEDOWN, btn, x, y);
	end
	self.mouse[btn] = true;	
end


----------------------------------------------------------------------------------------------------
function UIUI:MouseMove(dx, dy, dz)
	if (not self.active) then return end;

	self.mouseX = self.mouseX + dx;
	self.mouseY = self.mouseY + dy;
	self.mouseZ = self.mouseZ + dz;
	
	if (self.mouseX < 0) then self.mouseX = 0; end
	if (self.mouseX > self.width) then self.mouseX = self.width; end
	if (self.mouseY < 0) then self.mouseY = 0; end
	if (self.mouseY > self.height) then self.mouseY = self.height; end
	
	local mouseOver = UI:FindWidgetAt(self, self.mouseX, self.mouseY);
	
	if (mouseOver ~= self.mouseOver) then
		-- OnMouseLeave
		if (self.mouseOver) then
			self.mouseOver:Message(UIM_MOUSELEAVE);
		end
		-- OnMouseEnter
		if (mouseOver) then
			mouseOver:Message(UIM_MOUSEENTER);
		end
	end
	self.mouseOver = mouseOver;

	if (mouseOver) then
		mouseOver:Message(UIM_MOUSEMOVE, self.mouseX, self.mouseY, self.mouseZ);
	end
end


----------------------------------------------------------------------------------------------------
function UIUI:Update(frameTime, frameId)
	-- update screen size, renderer reports incorrect size when UI is initialized
	if (self.use_screen_size) then
		self.width = UI.GetScreenWidth();
		self.height = UI.GetScreenHeight();
	end

	local screens = self.screens;

	for name,screen in pairs(screens) do
		if (screen.active) then
			screen:Message(UIM_UPDATE, frameTime, frameId);
		end
	end

	if (self.renderTargetId) then
		UI.SetRenderTarget(self.renderTargetId);
	end

	UI.Begin2D(self.width, self.height);
	
	if (self.backgroundColor) then
		UI.Clear(self.backgroundColor);
	end

	for pass=1,1 do
		for name,screen in pairs(screens) do
			if (screen.active) then
				screen:Message(UIM_DRAW, frameTime, frameId, pass);
			end
		end
	end

	--if (self.mouseOver) then
		--UI.DrawText(0,0,"widget: "..self.mouseOver.name, 24, UIWhite);
	--end

	self:DrawMouse();

	UI.End2D();
	
	if (self.renderTargetId) then
		UI.SetRenderTarget(nil);
	end
end


----------------------------------------------------------------------------------------------------
function UIUI:Message(msg, ...)
	if (msg == UIM_INIT) then
		self:Init();		
		self:DispatchEvent(msg);
	elseif (msg == UIM_RELEASE) then
		self:Release();		
		self:DispatchEvent(msg);
	elseif (msg == UIM_MOUSEUP) then
		local arg = { ... };
		self:MouseUp(arg[1], self.mouseX, self.mouseY);
		self:DispatchEvent(msg, arg[1], self.mouseX, self.mouseY);
	elseif (msg	== UIM_MOUSEDOWN) then
		local arg = { ... };
		self:MouseDown(arg[1], self.mouseX, self.mouseY);
		self:DispatchEvent(msg, arg[1], self.mouseX, self.mouseY);
	elseif (msg == UIM_MOUSEMOVE) then
		local arg = { ... };
		self:MouseMove(arg[1], arg[2], arg[3]);
		self:DispatchEvent(msg, self.mouseX, self.mouseY, self.mouseZ);
	elseif (msg == UIM_UPDATE) then
		self:Update(...);
		self:DispatchEvent(msg, ...);
	else
		self:DispatchEvent(msg, ...);
	end
end


----------------------------------------------------------------------------------------------------
function UIUI:Activate(activate)
	if (self.active ~= activate) then
		if (self.OnActivate) then
			self:OnActivate(activate);
		end
	end
	self.active = activate;
end


----------------------------------------------------------------------------------------------------
function UIUI:Focus(focus)
	self.focused = focus;
end


----------------------------------------------------------------------------------------------------
function UIUI:ActivateAll(activate)
	for name,screen in pairs(self.screens) do
		screen:Activate(activate);
	end
end


----------------------------------------------------------------------------------------------------
function UIUI:DispatchEvent(msg, ...)
	local event = self[UI:GetEventFromMsg(msg)];
	
	if (type(event) == "function") then
		event(self, ...);
	end
end


----------------------------------------------------------------------------------------------------
function UIUI:CreateRenderTarget()
	if (not self.renderTargetId) then
		self.renderTargetId = UI.CreateRenderTarget(self.width, self.height);
	end
	
	return self.renderTargetId;
end


----------------------------------------------------------------------------------------------------
function UIUI:DestroyRenderTarget()
	UI.DestroyRenderTarget(self.renderTargetId);
	self.renderTargetId = nil;
end


----------------------------------------------------------------------------------------------------
function UIUI:GetRenderTargetId()
	return self.renderTargetId;
end

----------------------------------------------------------------------------------------------------
function UIUI:EnablePreUpdate(enable)
	self.preUpdate = enable;
end


----------------------------------------------------------------------------------------------------
function UIUI:GetScreen(name)
	return self.screens[name];
end


----------------------------------------------------------------------------------------------------
function UIUI:GetWidth()
	return self.width;
end


----------------------------------------------------------------------------------------------------
function UIUI:GetHeight()
	return self.height;
end


----------------------------------------------------------------------------------------------------
function UIUI:GetMouseXY()
	return self.mouseX, self.mouseY;
end


----------------------------------------------------------------------------------------------------
function UIUI:SetMouseXY(x, y)
	self.mouseX = x;
	self.mouseY = y;
	
	if (self.mouseX < 0) then self.mouseX = 0; end
	if (self.mouseX > self.width) then self.mouseX = self.width; end
	if (self.mouseY < 0) then self.mouseY = 0; end
	if (self.mouseY > self.height) then self.mouseY = self.height; end
end


----------------------------------------------------------------------------------------------------
function UIUI:ShowMouse(show)
	self.hideMouse = not show;
end


----------------------------------------------------------------------------------------------------
UI:RegisterClass("ui", UIUI);