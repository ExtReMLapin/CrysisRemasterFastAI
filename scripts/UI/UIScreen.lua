----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the screen metatable. Manages lists of widgets.
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 17:8:2004   11:25 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
UIScreen = {};


----------------------------------------------------------------------------------------------------
function UIScreen:Init()
	self.widgets = {};

	for name,widget in pairs(self) do
		if ((type(widget) == "table") and (UI:IsWidget(widget))) then
			UI:MakeWidget(widget, name, self);
			self:AddWidget(widget);
		end
	end
	
	self.active = false;
	
	self:Sort();
end


----------------------------------------------------------------------------------------------------
function UIScreen:Update(frameTime, frameId)
	for i,widget in pairs(self.widgets) do
		widget:Message(UIM_UPDATE, frameTime, frameId);
	end
end


----------------------------------------------------------------------------------------------------
function UIScreen:Release()
end


----------------------------------------------------------------------------------------------------
-- draw the screen
function UIScreen:Draw(frameTime, frameId, pass)
	for i,widget in pairs(self.widgets) do
		if (widget.visible) then
			widget:Message(UIM_DRAW, frameTime, frameId, pass);
		end
	end
end


----------------------------------------------------------------------------------------------------
-- add a widget to this screen
function UIScreen:AddWidget(widget)
	table.insert(self.widgets, widget);
end


----------------------------------------------------------------------------------------------------
-- remove a widget from this screen
function UIScreen:DelWidget(widget)
	for i,w in pairs(self.widgets) do
		if (w == widget) then
			table.remove(self.widgets, i);
			break;
		end
	end
end


----------------------------------------------------------------------------------------------------
function UIScreen:Message(msg, ...)
	if (msg == UIM_INIT) then
		self:Init();
		self:DispatchEvent(msg);
	elseif (msg == UIM_UPDATE) then
		self:Update(...);
		self:DispatchEvent(msg, ...);
	elseif (msg == UIM_RELEASE) then
		self:Release();
		self:DispatchEvent(msg);
	elseif (msg == UIM_DRAW) then
		self:Draw(...);
		self:DispatchEvent(msg, ...);
	else
		self:DispatchEvent(msg, ...);
	end
end


----------------------------------------------------------------------------------------------------
function UIScreen:DispatchEvent(msg, ...)
	local event = self[UI:GetEventFromMsg(msg)];
	
	if (type(event) == "function") then
		event(self, ...);
	end
end


----------------------------------------------------------------------------------------------------
function UIScreen:FindWidgetAt(x, y)
	local n = table.getn(self.widgets);
	for i=1,n do
		local widget = self.widgets[n-i+1];
		if (widget.visible) then
			local l,t,w,h = UI:GetWidgetCanvas(widget);
			
			if (UI:PointInRect(x, y, l,t,w,h)) then
				return widget;
			end
		end
	end
end

----------------------------------------------------------------------------------------------------
function UIScreen.LessZOrder(a,b)
	if (a.zorder < b.zorder) then
		return true;
	end
end

----------------------------------------------------------------------------------------------------
function UIScreen:Sort()
	table.sort(self.widgets, UIScreen.LessZOrder );
end


----------------------------------------------------------------------------------------------------
-- activate the screen
function UIScreen:Activate(activate)
	if (self.active ~= activate) then
		if (self.OnActivate) then
			self:OnActivate(activate);
		end
	end
	self.active = activate;
end


----------------------------------------------------------------------------------------------------
-- prepare and register class in ui system
UI:RegisterClass("screen", UIScreen);