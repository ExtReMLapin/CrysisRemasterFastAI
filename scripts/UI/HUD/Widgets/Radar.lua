----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the HUD radar
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 11:4:2005  : Created by Filippo De Luca
--
----------------------------------------------------------------------------------------------------
HUDRadar =
{
	motionTrackRadius = 50,--meters
	radarRadius = 0,
	
	contacts = {},
	effects = {},
	scanners = {};

	color_temp = {0,0,0,0},
	radarCenter = {x=0, y=0, z=0},
	cacheVec_angles = {},
}

----------------------------------------------------------------------------------------------------
function HUDRadar:SetTarget(targetId)
	self.targetId = targetId;
end


----------------------------------------------------------------------------------------------------
function HUDRadar:Reset()
	self.contacts = {};
	self.scanners = {};
	self.effects = {};
end


----------------------------------------------------------------------------------------------------
function HUDRadar:PushSound(pos, radius)	
	local effect = self:CreateEffect();
	
	effect.fade = 0.5;
	effect.color[1] = 112;
	effect.color[2] = 112;
	effect.color[3] = 128;
	effect.img = "textures/gui/hud/radar/wave.dds";
	effect.radius = 0;
	effect.scaleSpeed = radius/effect.fade;
	CopyVector(effect.pos, pos);
			
	return effect;
end

----------------------------------------------------------------------------------------------------
function HUDRadar:PushScanner(entity)
	local newIndex = -1;
	
	if (entity.Properties.bSquadMate and (tonumber(entity.Properties.bSquadMate) ~= 0)) then
		self:PushContact(entity);

		return;
	end
	
	if (entity.vehicle and type(entity:GetDriverId()) == "userdata") then
		local driver = System.GetEntity(entity:GetDriverId());

		if (driver and driver.actor) then				
			if (driver.actor:IsPlayer()) then
				return false;
			end
		end
	end
	
	-- check if already scanned
	for i,contact in ipairs(self.contacts) do
		if (contact.active and contact.entityId and (contact.entityId == entity.id)) then
			return;
		end
	end
	
	-- check if out of screen
	local min, max = entity:GetProjectedWorldBBox();
	
	if ((max.x <= 0) or (min.x >= 800) or
			(max.y <= 0) or (min.y >= 600) or
			(min.z >= 1)) then
		return;
	end;
	

	-- try to find an inactive scanner that we could use
	for i,scanner in ipairs(self.scanners) do
		--check for doubles, if any return it
		if (scanner.active or scanner.scheduled) then
			if (scanner.entityId and scanner.entityId == entity.id) then
				return;
			end
		elseif (newIndex < 0) then
			newIndex = i;
		end
	end

	-- none found, create a new one
	if (newIndex < 0) then
		newIndex = table.getn(self.scanners) + 1;
		self.scanners[newIndex] = {};
		self.scanners[newIndex].color = {};
	end

	local scanner = self.scanners[newIndex];

	scanner.scheduled = true;
	scanner.active = false;
	scanner.entityId = entity.id;
	
	scanner.down = false;
	scanner.positioned = false;
	
	scanner.sound_done = false;
	scanner.blink_start = nil;
	scanner.blink_alpha = 1;
	scanner.blink_stay = false;
	scanner.current_left_barx = nil;
	scanner.current_right_barx = nil;
	scanner.current_barh = nil;
	scanner.current_bary = nil;
	scanner.current_height = nil;

	return scanner;
end


----------------------------------------------------------------------------------------------------
function HUDRadar:IsTargetVisible(entity)
	local pos = System.GetViewCameraPos(g_Vectors.temp_v3);
	local epos = entity:GetWorldPos(g_Vectors.temp_v4);
	local dir = vecScale(vecSub(epos, pos), 1.05);
	--local hits = ItemSystem.TraceRay(pos, dir, 1, g_localActor.id, true, false);
	--if (hits and hits[1].target and hits[1].target==entity) then
--		return true;
--	end

	return false;
end


----------------------------------------------------------------------------------------------------
function HUDRadar:UpdateScanners(frameTime)
	local doSchedule = false;
	
	for i,scanner in ipairs(self.scanners) do
		if (scanner.active) then
			local entity = System.GetEntity(scanner.entityId);

			if ((not entity) or (entity.MotionTrackable and (not entity:MotionTrackable()))) then
				scanner.active = false;
				break;
			end

			-- draw side bars
			local ox = 105;
			local oy = 10;
			local rx = (800-2*ox)/800;
			local ry = (600-2*oy)/600;
			
			-- check if out of screen
			local min, max = entity:GetProjectedWorldBBox();
			
			if ((max.x <= 0) or (min.x >= 800) or
					(max.y <= 0) or (min.y >= 600) or
					(min.z >= 1)) then
				scanner.active = false;
				break;
			end
			
			if (not self:IsTargetVisible(entity)) then
				scanner.active = false;
				break;
			end
			
			min.x = ox+min.x*rx;
			min.y = oy+min.y*ry;
			max.x = ox+max.x*rx;
			max.y = oy+max.y*ry;

			if (not scanner.positioned) then
				if (not scanner.current_barh) then
					scanner.goal_left_barx = min.x-6;
					scanner.goal_right_barx = max.x+6;
					scanner.goal_bary	= min.y;
					scanner.goal_barh	= max.y-min.y+22;
	
					scanner.current_left_barx = 0;
					scanner.current_right_barx = 800;
					scanner.current_barh = 600;
					scanner.current_bary = 0;
				else			
					scanner.goal_left_barx = min.x-6;
					scanner.goal_right_barx = max.x+6;
					scanner.goal_bary	= min.y-2;
					scanner.goal_barh	= max.y-min.y+22;
		
					scanner.current_left_barx = Interpolate(scanner.current_left_barx, scanner.goal_left_barx, frameTime * self.scanner_blend_speed);
					scanner.current_right_barx = Interpolate(scanner.current_right_barx, scanner.goal_right_barx, frameTime * self.scanner_blend_speed);
					scanner.current_barh = Interpolate(scanner.current_barh, scanner.goal_barh, frameTime * self.scanner_blend_speed);
					scanner.current_bary = Interpolate(scanner.current_bary, scanner.goal_bary, frameTime * self.scanner_blend_speed);
				end
			else
				scanner.current_left_barx = min.x-6;
				scanner.current_right_barx = max.x+6;
				scanner.current_bary	= min.y;
				scanner.current_barh	= max.y-min.y+22;
			end

			rx = self.ui.rx;
			ry = self.ui.ry;
			
			local color = UI:GetColor(self.scanner_color1[1], self.scanner_color1[2], self.scanner_color1[3], self.scanner_color1[4]*scanner.blink_alpha);

			UI.DrawQuad(scanner.current_left_barx*rx-self.scanner_bar_width, scanner.current_bary*ry, self.scanner_bar_width, scanner.current_barh*ry, nil, color);
			UI.DrawQuad(scanner.current_right_barx*rx, scanner.current_bary*ry, self.scanner_bar_width, scanner.current_barh*ry, nil, color);

			UI.DrawQuad(scanner.current_left_barx*rx-self.scanner_bar_width, scanner.current_bary*ry, self.scanner_bar_width+6, self.scanner_bar_width, nil, color);
			UI.DrawQuad(scanner.current_right_barx*rx-6, scanner.current_bary*ry, self.scanner_bar_width+6, self.scanner_bar_width, nil, color);

			UI.DrawQuad(scanner.current_left_barx*rx-self.scanner_bar_width, (scanner.current_bary+scanner.current_barh)*ry, self.scanner_bar_width+6, self.scanner_bar_width, nil, color);
			UI.DrawQuad(scanner.current_right_barx*rx-6, (scanner.current_bary+scanner.current_barh)*ry, self.scanner_bar_width+6, self.scanner_bar_width, nil, color);

			
			if ((math.abs(scanner.current_left_barx-scanner.goal_left_barx) <= 1) and (math.abs(scanner.current_right_barx-scanner.goal_right_barx) <= 1)) then
				scanner.positioned = true;
				
				if (not scanner.sound_done) then
					if (self.scanner_sound) then
						Sound.Play(self.scanner_sound, {0,0,0}, 2, SOUND_SEMANTIC_HUD);
					end
					scanner.sound_done = true;
				end				
			end

			if (scanner.positioned) then
				local done = false;
				
				-- blink the brackets
				if (not scanner.blink_stay) then
					if (not scanner.blink_start) then
						scanner.blink_start = _time;
					end
					
					local dt = (_time-scanner.blink_start)/self.scanner_blink_duration;
					scanner.blink_alpha = math.abs(math.cos(math.pi*self.scanner_blinks*dt));
					
					if (dt >= 1) then
						scanner.blink_end = _time;
						scanner.blink_alpha = 1;
						scanner.blink_stay = true;
					end
				else
					if (_time-scanner.blink_end > self.scanner_stay_duration) then
						done = true;
					end
				end
			
				--[[
				-- draw scanning anim
				if (not scanner.down) then
					if (not scanner.current_height) then
						scanner.current_height = 0;
						scanner.current_top = 2;
					end
	
					scanner.current_height = scanner.current_height+frameTime*self.scanner_speed;
				
					if (scanner.current_height >= scanner.current_barh-2) then
						scanner.current_height = scanner.current_barh-2;
						scanner.down = true;
					end
				else
					local dt = frameTime*self.scanner_speed;
	
					scanner.current_top = scanner.current_top+dt;
					scanner.current_height = scanner.current_barh-2-scanner.current_top;
					
					if (scanner.current_height <= 2) then
						done = true;
					end
				end

				local alpha = 0.05+0.95*math.random();
				local c = self.scanner_color2;
				
				HUD:DrawImage(min.x-3, scanner.current_bary+scanner.current_top, max.x-min.x+6, scanner.current_height, UI:GetColor(c[1], c[2], c[3], c[4]*alpha), "");
				--]];
								
				if (done) then
					
					self:PushContact(entity);
					scanner.active = false;
					break;
				end
			end

			break;
		end

		doSchedule = true;
	end
	
	if (doSchedule) then
		if (not self.schedule_delay_start) then
			self.schedule_delay_start = _time;
		end

		if (_time - self.schedule_delay_start > self.schedule_delay) then
			for i,scanner in ipairs(self.scanners) do
				if (scanner.scheduled) then
					self.schedule_delay_start = nil;
					
					scanner.scheduled = false;
					scanner.active = true;
					break;
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUDRadar:CreateEffect()
	local newIndex = -1;
		
	-- try to find an inactive effect that we could use
	for i,effect in ipairs(self.effects) do
		if (not effect.active) then
			newIndex = i;
			break;
		end
	end
	
	-- none found, create a new one
	if (newIndex < 0) then
		newIndex = table.getn(self.effects) + 1;
		self.effects[newIndex] = {};
		self.effects[newIndex].color = {0,0,0,0};
		self.effects[newIndex].pos = {x=0, y=0, z=0};
	end
	
	local effect = self.effects[newIndex];
		
	effect.active = true;	
	effect.fade = 1.0;
	effect.color[1] = 255;
	effect.color[2] = 255;
	effect.color[3] = 255;
	effect.color[4] = 255;
	effect.img = "textures/gui/hud/radar/wave.dds";
	effect.radius = 5;
	effect.scaleSpeed = 0;
	effect.followContactID = -1;
	
	return effect;
end

----------------------------------------------------------------------------------------------------
function HUDRadar:PushContact(entity, name)
	if (not entity) then
		return;
	end

	local newIndex = -1;

	-- try to find an inactive contact
	for i,contact in ipairs(self.contacts) do
		--check for doubles, if any return it
		if (contact.active) then
			if (contact.entityId and contact.entityId == entity.id) then
				return;
			end
		elseif (newIndex < 0) then
			newIndex = i;
		end
	end

	-- found none, create a new one
	if (newIndex < 0) then
		newIndex = table.getn(self.contacts) + 1;
		self.contacts[newIndex] = {};
		self.contacts[newIndex].color = {};
		self.contacts[newIndex].blinkColor = {};
		self.contacts[newIndex].pos = {x=0,y=0,z=0};
	end
	
	local contact = self.contacts[newIndex];
	
	contact.active = true;	
	contact.fade = 1.0;	
	contact.color[1] = 255;
	contact.color[2] = 255;
	contact.color[3] = 255;
	contact.color[4] = 255;
	contact.blinkColor[1] = 255;
	contact.blinkColor[2] = 255;
	contact.blinkColor[3] = 255;
	contact.img = "textures/gui/hud/radar/enemy_grey.dds";
	contact.radius = 4.5;
	contact.blinking = 0;
	
	if (entity) then 
		contact.entityId = entity.id;
	else
		contact.entityId = nil;
	end
	
	if (name) then
		contact.name = name;
	else
		contact.name = "";
	end
	
	--put a small effect when a new contact is pushed
	local effect = self:CreateEffect();	
	effect.fade = 1.0;
	effect.img = "textures/gui/hud/radar/highlight.dds";
	effect.radius = 0;
	effect.scaleSpeed = 10/effect.fade;
	effect.followContactID = newIndex;
	
	return contact;
end

----------------------------------------------------------------------------------------------------
function HUDRadar:RemoveContactByName(name)
	for i,contact in ipairs(self.contacts) do
		if (contact.active and contact.name and contact.name == name) then
			self:RemoveContactById(i);
		end
	end
end

----------------------------------------------------------------------------------------------------
function HUDRadar:RemoveContactById(id)
	local contact = self.contacts[id];
	
	if (contact) then
		contact.active = false;		
	end
end

----------------------------------------------------------------------------------------------------
function HUDRadar:GetContactById(id)
	local contact = self.contacts[id];
	
	return contact;
end

----------------------------------------------------------------------------------------------------
function HUDRadar:UpdateMotionTracker(target, frameTime)
	do return end;
	if (not self.nextMotionCheck) then
		self.nextMotionCheck = math.max(self.tracker_interval, 1); -- 1 second for initial scanning
	end
	
	self.nextMotionCheck = self.nextMotionCheck - frameTime;
	
	if (self.nextMotionCheck <=0) then
		--check for new motion each 0.65 seconds
		self.nextMotionCheck = self.tracker_interval;
	
		local ppos = System.GetViewCameraPos();

		local entities = System.GetPhysicalEntitiesInBox(ppos, self.motionTrackRadius);
		
		if (entities) then
			for i,entity in ipairs(entities) do
				if (entity.MotionTrackable and entity:MotionTrackable() and (not entity:IsHidden())) then
					if (entity:GetSpeed() > 1) then
						self:PushScanner(entity);
					end
				end
			end	
		end
	end

	-- get the target on the screen
	local target = self:GetViewTarget(self.motionTrackRadius);
	
	if (target) then
		if (target ~= self.last_view_target) then
			self.last_view_target = target;
			self.last_view_target_start = _time;
		elseif (_time-self.last_view_target_start > self.scanner_view_target_delay) then
			if (target and target.MotionTrackable and target:MotionTrackable() and (not target:IsHidden())) then
				self:PushScanner(target);
			end
		end
	end

	self:UpdateScanners(frameTime);
end


----------------------------------------------------------------------------------------------------
function HUDRadar:GetViewTarget(range, offset)
	local target;
	if (self.targetId) then
		target = System.GetEntity(self.targetId);
	end
	
	if (not target) then
		return;
	end

	local dir, pos;
	
	if (target and target.actor) then
		self.viewDir = System.GetViewCameraDir(self.viewDir);
		self.viewPos = System.GetViewCameraPos(self.viewPos);
		dir = self.viewDir;
		pos = self.viewPos;
	end

	if (offset) then
		pos.x = pos.x+dir.x*offset.x;
		pos.y = pos.y+dir.y*offset.y;
		pos.z = pos.z+dir.z*offset.z;
	end
	
	if dir then
		dir.x = dir.x*range;
		dir.y = dir.y*range;
		dir.z = dir.z*range;
	
		--hits = ItemSystem.TraceRay(pos, dir, 1, target.id);
	end
		
	if (hits) then
		return hits[1].target;
	end
end


----------------------------------------------------------------------------------------------------
function HUDRadar:UpdateObjectives()
	local objectives = System.GetEntitiesByClass("MissionObjective");	
	
	for i,entity in pairs(objectives) do
		if (entity.objectiveEnabled) then
			self:PushContact(entity, entity.Properties.radarMessage);
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUDRadar:Update(frameTime, frameId)
end


----------------------------------------------------------------------------------------------------
function HUDRadar:Draw(frameTime, frameId, pass)
	do return end;
	if (pass ~= 1) then
		return;
	end
	
	local target;
	if (self.targetId) then
		target = System.GetEntity(self.targetId);
	end
	
	if (not target) then	
		return;
	end
	
	self:UpdateMotionTracker(target, frameTime);
	
	local goalCenter = g_Vectors.temp_v1;
	local goalRadius = self.radarRadius;
	local gridImg = "textures/gui/hud/radar/grid_256b.dds";
	local iconMult = 1.25;
	
	if (false) then
		goalCenter.x = 400;
		goalCenter.y = 325;
		goalRadius = self.radius_zoomed;
		self.radarRangeScale = self.range_zoomed;
		
		gridImg = "textures/gui/hud/radar/grid_512b.dds";
		iconMult = 2.25;
	else
		goalCenter.x = self.left;
		goalCenter.y = self.top;
		goalRadius = self.radius;
		self.radarRangeScale = self.range;
	end
	
	local center = self.radarCenter;
	local blendSpeed = math.min(frameTime*13.0, 1.0);

	center.x = Interpolate(center.x, goalCenter.x, blendSpeed);
	center.y = Interpolate(center.y, goalCenter.y, blendSpeed);
	self.radarRadius = Interpolate(self.radarRadius,goalRadius,blendSpeed);
		
	local radius = self.radarRadius;

	--draw the grid
	local angle = target.actor:GetAngles(g_Vectors.temp_v1).z;					
	HUD:DrawImageCentered(center.x, center.y, radius*2, radius*2, self.color, gridImg, nil, angle);
	
	if (not self.__dummy_contact) then
		self.__dummy_contact = { color = {}, pos = {}};
	end
	
	-- update/draw contacts	
	self:UpdateContacts(target, frameTime, angle, iconMult);
	
	-- update objectives
	self:UpdateObjectives();

	--draw the player				
	local iconSize = 4 * iconMult;
	HUD:DrawImageCentered(center.x, center.y, iconSize, iconSize, UI:GetColor(64, 64, 255, 255), "textures/gui/hud/radar/player_white.dds");
	HUD:DrawLine(center.x, center.y, center.x, center.y - iconSize, UI:GetColor(64, 64, 255, 255));

	self:UpdateEffects(target, frameTime, angle, iconMult);
end


----------------------------------------------------------------------------------------------------
function HUDRadar:UpdateContacts(target, frameTime, radarAngle, iconMult)
	for i,contact in ipairs(self.contacts) do
		if (contact.active) then
			self:UpdateContact(target, contact, frameTime, radarAngle, iconMult);
		end
	end	
end


----------------------------------------------------------------------------------------------------
function HUDRadar:UpdateContact(target, contact, frameTime, radarAngle, iconMult)
	local entity = System.GetEntity(contact.entityId);

	--in case the entity got lost, remove the contact
	if ((not entity) or (contact.fade < 0)) then
		contact.active = false;
	else
		local center = self.radarCenter;		
		local radius = self.radarRadius;

		contact.pos = entity:GetWorldPos(contact.pos);

		--if the update radar function return nil this contact is supposed to be removed
		if ((entity.UpdateRadar) and (not entity:UpdateRadar(contact))) then
			contact.fade = contact.fade-frameTime;
		end

		--move the contact position to player's space
		local delta = target.actor:VectorToLocal(contact.pos, g_Vectors.temp_v1);
							
		--cap the conctact in the radar radius
		delta = vecScale(delta, radius/self.radarRangeScale);
		local len = vecLen(delta);
					
		if (len > radius) then
			delta = vecScale(delta,1/len*radius);
		end
	
		--draw contact
		local fade = clamp(contact.fade,0.0,1.0);
					
		local entAngle = 0;
		if (entity.actor) then
			entAngle = radarAngle - entity.actor:GetAngles(g_Vectors.temp_v1).z + math.pi;
		else
			entAngle = radarAngle - entity:GetAngles(g_Vectors.temp_v1).z + math.pi;
		end
		
		local color = self.color_temp;
		
		color[1] = contact.color[1];
		color[2] = contact.color[2];
		color[3] = contact.color[3];
		color[4] = contact.color[4];
		
		if (contact.blinking and contact.blinking > 0) then
			contact.blinking = contact.blinking - frameTime;
						
			if (contact.nextblink and contact.nextblink > 0) then
				contact.nextblink = contact.nextblink - frameTime;
			else
				contact.nextblink = 0.1;
				color[1] = contact.blinkColor[1];
				color[2] = contact.blinkColor[2];
				color[3] = contact.blinkColor[3];
			end
		end
		

		local heightAlpha = 1;
		local heightZoom = 1;

		local a=[[		
		if (target:GetWorldPos().z-contact.pos.z < -3.5) then
			heightZoom = 1.85;
			heightAlpha = 0.3;
		elseif (target:GetWorldPos().z-contact.pos.z > 3.5) then
			heightZoom = 0.65;
		end
		]];

		iconRadius = contact.radius * iconMult * heightZoom;
		HUD:DrawImageCentered(center.x+delta.x, center.y-delta.y, iconRadius*2, iconRadius*2, UI:GetColor(color[1], color[2], color[3], color[4]*fade*heightAlpha), contact.img, nil, entAngle);

		if (contact.name ~= "") then
			--HUD:DrawTextCentered(center.x+delta.x, center.y-delta.y-iconRadius*2, contact.name, 10*iconMult, UI:GetColor(255,255,255,255*fade));
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUDRadar:UpdateEffects(target, frameTime, radarAngle, iconMult)
	for i,effect in ipairs(self.effects) do
		if (effect.active) then
			self:UpdateEffect(target, effect, frameTime, radarAngle, iconMult);
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUDRadar:UpdateEffect(target, effect, frameTime, radarAngle, iconMult)
	local center = self.radarCenter;		
	local radius = self.radarRadius;

	if (effect.followContactID > 0) then
		local contact = self.contacts[effect.followContactID];
		if (contact) then
			CopyVector(effect.pos, contact.pos);
			effect.color[1] = contact.color[1];
			effect.color[2] = contact.color[2];
			effect.color[3] = contact.color[3];
		else
			effect.followContactID = -1;
		end
	end
						
	--move the effect position to player's space
	local delta = target.actor:VectorToLocal(effect.pos, g_Vectors.temp_v3);
						
	local radarScale = radius/self.radarRangeScale;
	FastScaleVector(delta,delta,radarScale);
	
	local len = LengthVector(delta);
	if (len>radius) then
		effect.active = false;
		return;
	end
					
	--draw effect
	effect.fade = effect.fade - frameTime;
	if (effect.scaleSpeed) then
		effect.radius = effect.radius + effect.scaleSpeed * frameTime;
	end
	
	local fade = clamp(effect.fade,0.0,1.0);
								
	iconRadius = effect.radius * radarScale * iconMult;	
	HUD:DrawImageCentered(center.x + delta.x , center.y - delta.y, iconRadius, iconRadius, UI:GetColor(effect.color[1],effect.color[2],effect.color[3],effect.color[4]*fade), effect.img);
	
	if (iconRadius > radius*2 or effect.fade < 0) then
		effect.active = false;
	end
end


----------------------------------------------------------------------------------------------------
function HUDRadar:DrawMotionTracked(projmin, projmax, offset, scale, r, g, b, a)
	local ox = 105;
	local oy = 20;
	local rx = (800-210)/800;
	local ry = (600-20)/600;
	
	local min = g_Vectors.temp_v1;
	local max = g_Vectors.temp_v2;

	min.x = ox+projmin.x*rx;
	min.y = oy+projmin.y*ry;
	max.x = ox+projmax.x*rx;
	max.y = oy+projmax.y*ry;
	
	local dx = (max.x-min.x);
	local w = math.min(math.max((max.x-min.x)/5, 4), 16)*scale;
	local h = math.min(math.max((max.y-min.y)/5, 4), 16)*scale;
	local ow = offset+8*(math.max(0.25, dx/200));
	local oh = offset+12*(math.max(0.25, dx/200));

	local color = UI:GetColor(r, g, b, a);
	HUD:DrawImage(min.x-ow, min.y-oh, w, h, color, "textures/gui/hud/radar/target.dds", {12, 0, 14, 18});
	HUD:DrawImage(min.x-ow, max.y-h+oh, w, h, color, "textures/gui/hud/radar/target.dds", {12, 46, 14, 18});
	HUD:DrawImage(max.x-w+ow, min.y-oh, w, h, color, "textures/gui/hud/radar/target.dds", {38, 0, 14, 18});
	HUD:DrawImage(max.x-w+ow, max.y-h+oh, w, h, color, "textures/gui/hud/radar/target.dds", {38, 46, 14, 18});
end


----------------------------------------------------------------------------------------------------
function HUDRadar:Message(msg, ...)
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
UI:RegisterClass("radar", HUDRadar, UIWidget);
