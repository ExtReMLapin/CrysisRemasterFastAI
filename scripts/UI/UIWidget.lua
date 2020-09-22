----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the base functionality of a user interface widget.
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 17:8:2004   11:45 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
UIWidget =
{
	left 		= 0,
	top 		= 0,
	width 	= 128,
	height 	= 128,
	
	color		= UIWhite,

	font 		= new(UIFontDefault);
	skin		= new(UISkinDefault);
	border	= new(UIBorderDefault);
};


----------------------------------------------------------------------------------------------------
function UIWidget:AddChild(child)
	if (not self.children) then
		self.children = {};
	end
	
	self.children[child.name] = child;
end


----------------------------------------------------------------------------------------------------
function UIWidget:DelChild(child)
	self.children[child.name] = nil;
end


----------------------------------------------------------------------------------------------------
function UIWidget:FindChildAt(x, y)
	if (self.children) then
		local n = table.getn(self.children);
		for i=1,n do
			local widget = self.children[n-i+1];
			if (widget.visible) then
				local l,t,w,h = UI:GetWidgetCanvas(widget);
				local ax,ay = UI:GetAbsoluteXY(x, y, self);
				
				if (UI:PointInRect(ax, ay, l,t,w,h)) then
					return widget;
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------
function UIWidget:Message(msg, ...)
	self:DispatchEvent(msg, ...);
end


----------------------------------------------------------------------------------------------------
function UIWidget:DispatchEvent(msg, ...)
	local event = self[UI:GetEventFromMsg(msg)];
	
	if (type(event) == "function") then
		event(self, ...);
	end
end


----------------------------------------------------------------------------------------------------
UI:RegisterClass("widget", UIWidget);