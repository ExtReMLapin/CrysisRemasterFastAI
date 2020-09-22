----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Stealth-o-Meter
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 25:4:2005   11:36 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
HUDStealthOMeter =
{
	stealthMeter = 1;
}


----------------------------------------------------------------------------------------------------
function HUDStealthOMeter:SetTarget(targetId)
	self.targetId = targetId;
end


----------------------------------------------------------------------------------------------------
function HUDStealthOMeter:Draw(frameTime, frameId, pass)
	if (pass ~= 1) then
		return;
	end

	local ui = self.ui;
	local img;

	local rw = self.ui.width/800;
	local rh = self.ui.height/600;

	local x = self.left*rw;
	local y = self.top*rh;

	local barrierGreen = 0;
	local barrierYellow = 0.45;
	local barrierRed = 1;
	local color;

	local stealth = self.stealthMeter;
	if (stealth < barrierYellow) then
		local t = clamp(((stealth-barrierGreen)/(barrierYellow-barrierGreen)), 0, 1);
		color = UI:InterpolateColor(self.stealth_green, self.stealth_yellow, t);
	else
		local t = clamp(((stealth-barrierYellow)/(barrierRed-barrierYellow)), 0, 1);
		color = UI:InterpolateColor(self.stealth_yellow, self.stealth_red, t);
	end

	UI.DrawQuad(x, y, self.width*rw, self.height*rh, nil, self.color);
	UI.DrawQuad(x, y, self.width*rw*self.stealthMeter, self.height*rh, nil, color);
end


----------------------------------------------------------------------------------------------------
function HUDStealthOMeter:Update(frameTime, frameId)
	local stealthAmount = AI.GetDetectionValue();
	self.stealthMeter = math.max(Interpolate(self.stealthMeter, stealthAmount, frameTime*self.speed), 0.075);
end


----------------------------------------------------------------------------------------------------
function HUDStealthOMeter:Message(msg, ...)
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
UI:RegisterClass("stealthometer", HUDStealthOMeter, UIWidget);