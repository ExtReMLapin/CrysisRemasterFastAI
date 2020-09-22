----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: User interface file. Loads all user interface scripts and defines utility functions.
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 17:8:2004   11:26 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------


UIM_INIT			= "Init";
UIM_UPDATE		= "Update";
UIM_DRAW			= "Draw";
UIM_RELEASE		= "Release";
UIM_KEYDOWN		= "KeyDown";
UIM_KEYUP			= "KeyUp";
UIM_MOUSEDOWN	= "MouseDown";
UIM_MOUSEUP		= "MouseUp";
UIM_MOUSEMOVE	= "MouseMove";

UIM_MOUSEENTER=	"MouseEnter";
UIM_MOUSELEAVE=	"MouseLeave";
UIM_COMMAND		= "Command";


----------------------------------------------------------------------------------------------------
function UI:LoadScript(script)
	Script.ReloadScript("scripts/ui/"..script);
end


----------------------------------------------------------------------------------------------------
function UI:LogError(fmt, ...)
	System:Log(string.format("$5[$4UI Error$5]$1: "..fmt, ...));
end


----------------------------------------------------------------------------------------------------
function UI:LogWarning(fmt, ...)
	System:Log(string.format("$5[$7UI Warning$5]$1: "..fmt, ...));
end


----------------------------------------------------------------------------------------------------
function UI:Log(fmt, ...)
	System:Log(string.format("UI: "..fmt, ...));
end


----------------------------------------------------------------------------------------------------
function UI:IsWidget(widget)
	if (type(widget.class) == "string") then
		return true;
	end
	
	return false;
end


----------------------------------------------------------------------------------------------------
function UI:InitWidget(widget)
	local initt = function(src, dst, tbl)
		if (dst[tbl] ~= src[tbl]) then
			for k,v in pairs(src[tbl]) do
				if (type(dst[tbl][k]) ~= type(v)) then
					dst[tbl][k] = v;
				end
			end
		else
			dst[tbl] = new(src[tbl]);
		end
	end
	
	initt(widget, UIWidget, "font");
	initt(widget, UIWidget, "skin");
	initt(widget, UIWidget, "border");
	
	if (type(widget.zorder) 	== "nil") then widget.zorder = 0; end
	if (type(widget.visible) 	== "nil") then widget.visible = true; end
	if (type(widget.disabled)	== "nil") then widget.disabled = false; end

	widget:Message(UIM_INIT);
end


----------------------------------------------------------------------------------------------------
function UI:MakeWidget(widget, widgetName, parentScreen, parentWidget)
	if (not self:IsWidget(widget)) then
		self:LogError("attempt to create a widget from a non-compatible table: '%s'", widgetName);
	end

	local className = widget.class;

	if (self.classes[className]) then
		setmetatable(widget, self.classes[className]);

		-- recurse to children
		for childName, childWidget in pairs(widget) do
			if ((type(childWidget) == "table") and (UI:IsWidget(childWidget))) then
				UI:MakeWidget(childWidget, childName, parentScreen, widget);
				widget:AddChild(childWidget);
			end
		end

		widget.ui = parentScreen.ui;
		widget.screen = parentScreen;
		widget.parent = parentWidget;
		widget.name = widgetName;

		UI:InitWidget(widget);
	else
		self:LogError("unknown class for widget '%s'", widgetName);
	end
end


----------------------------------------------------------------------------------------------------
function UI:MakeScreen(screen, screenName)
	local ui = self.describingUI;
	
	if (not ui) then
		UI:LogError("creating screen outside ui description!");

		return;
	end

	screen.name = screenName;
	screen.ui 	= ui;
	setmetatable(screen, self.classes["screen"]);
	
	ui.screens[screenName] = screen;

	screen:Message(UIM_INIT);
	
	return screen;
end


----------------------------------------------------------------------------------------------------
function UI:RegisterClass(className, classTable, parentClassTable)
	classTable.__index = classTable;
	
	if (parentClassTable) then
		setmetatable(classTable, parentClassTable);
	end

	if (self.classes[className]) then
		return self:LogWarning("attempt to re-register class name '%s'.", className);
	end

	self.classes[className] = classTable;
end


----------------------------------------------------------------------------------------------------
function UI:BeginUI(name, width, height)
	local ui = {};
	ui.screens = {};
	ui.mouse = {};
	ui.name = name;
	ui.active = false;
	ui.zorder = 0;

	self.describingUI = ui;
	self.describingUIName = name;
	
	if (width and height) then
		ui.width = width;
		ui.height = height;
	else
		ui.use_screen_size = true;
		ui.width = UI.GetScreenWidth();
		ui.height = UI.GetScreenHeight();
	end

	setmetatable(ui, self.classes["ui"]);
	
	return ui;
end


----------------------------------------------------------------------------------------------------
function UI:EndUI()
	self.describingUI:Message(UIM_INIT);
	
	self.uis[self.describingUIName] = self.describingUI;
	
	table.insert(self.sorted_uis, self.describingUI);
	
	self.describingUI = nil;	
end


----------------------------------------------------------------------------------------------------
function UI:ActivateAll(activate)
	for name,ui in pairs(self.uis) do
		ui:Activate(activate);
	end
end

----------------------------------------------------------------------------------------------------
function UI:GetUI(name)
	return self.uis[name];
end

----------------------------------------------------------------------------------------------------
function UI:DestroyUI(name)
	local ui = self.uis[name];
	
	if (ui) then
		for i,sui in pairs(self.sorted_uis) do
			if (ui == sui) then
				table.remove(self.sorted_uis, i);
				break;
			end
		end

		self.uis[name]:Message(UIM_RELEASE);
		self.uis[name] = nil;
	end
end


----------------------------------------------------------------------------------------------------
function UI:Sort()
	table.sort(self.sorted_uis, function(a, b)
		if (a.zorder < b.zorder) then
			return true;
		end
	end);
end

----------------------------------------------------------------------------------------------------
function UI:GetEventFromMsg(msg)
	if (not self.eventNames) then
		self.eventNames = {};
	end
	
	local event = self.eventNames[msg];
	
	if (not event) then
		event = "On"..msg;
		self.eventNames[msg] = event;
	end
	
	return event;
end



----------------------------------------------------------------------------------------------------
-- load all ui scripts
UI:LoadScript("uievents.lua");
UI:LoadScript("uidrawing.lua");
UI:LoadScript("uiutils.lua");