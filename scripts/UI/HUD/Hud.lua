----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the HUD!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 13:2:2005   13:58 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
-- load specific hud widgets
UI:LoadScript("hud/widgets/ecg.lua");
UI:LoadScript("hud/widgets/compass.lua");
UI:LoadScript("hud/widgets/radar.lua");
UI:LoadScript("hud/widgets/stealthometer.lua");


HUDSettings =
{
	--backgroundColor = UIBlack,
	textColor				= { 255, 255, 255, 255 };

	digitTexture		= "textures/gui/hud/hud_artset.dds",
	digitColor			= { 255, 255, 255, 255 };
	digitUV					= {
		["0"] = { 12+0*50,  0, 28, 50, 1 },
		["1"] = { 12+1*50,  0, 28, 50, 0.8 },
		["2"] = { 12+2*50,  0, 28, 50, 1 },
		["3"] = { 12+3*50,  0, 28, 50, 1 },
		["4"] = { 12+4*50,  0, 28, 50, 1 },
		["5"] = { 12+5*50,  0, 28, 50, 1 },
		["6"] = { 12+6*50,  0, 28, 50, 1 },
		["7"] = { 12+7*50,  0, 28, 50, 1 },
		["8"] = { 12+8*50,  0, 28, 50, 1 },
		["9"] = { 12+9*50,  0, 28, 50, 1 },
		["/"] = { 12,      50, 28, 50, 0.8 },
		["-"] = { 448, 		 62, 28, 50, 0.8 },
	},
	
	infoColor								= { 175, 218, 154, 255 };
	infoX										= 32,
	infoY										= 420,
	infoMinY								= 130,
	infoSize								= 12,
	infoSpacing							= 3,
	
	instructionColor				= { 107, 140, 107, 255 };
	instructionX						= 400,
	instructionY						= 300,
	instructionMinY					= 200,
	instructionSize					= 24,
	instructionSpacing			= 3,
	instructionFadeOut			= 0.5,
	
	objectivesX							= 234,
	objectivesY							= 80,
	objectivesW							= 360,
	objectivesH							= 360,
	objectivesSpacing				= 3,
	objectivesFrameColor		= { 107, 140, 107, 128 };
	objectivesBorder				= 5,
	objectivesColor					= { 255, 255, 255, 255 };
	objectivesCompleteColor	= { 255, 255, 255, 128 };
	objectivesSize					= 22,
	
	mapX										= 400-180,
	mapY										= 150,
	mapWidth								= 360,
	mapHeight								= 360,
	mapIconSize							= 16,
	
	mapWindowX							= 0;
	mapWindowY							= 0;
	mapWindowW							= 0;
	mapWindowH							= 0;

	chatColor								= { 107, 140, 107, 255 };

	info_messages = {};
	inst_messages = {};
	chat_messages = {};
	obj_messages = {};
};


HUD = UI:BeginUI("hud", 1024, 1024);
	UI:LoadScript("hud/screens/default.lua");
UI:EndUI();


merge(HUD, HUDSettings);


UI:LoadScript("hud/hudevents.lua");


----------------------------------------------------------------------------------------------------
function HUD:DrawNumber(left, top, number, size, color, kerning)
	local nstr = tostring(number);
	local len = string.len(nstr);
	local width = size/1.77;
	local texture = self.digitTexture;
	local x = left;
	kerning = retDef(kerning, 0);

	for i=1,len do
		local coords = self.digitUV[string.sub(nstr, i, i)];
		
		if (coords) then
			UI.DrawQuad(x*self.rx, top*self.ry, width*self.rx, size*self.ry, UI:GetImage(texture), color,
				UI:FixUVRect(texture, coords));
			x = x+width*coords[5]+kerning;
		else
			x = x+width+kerning;
		end
	end
end

----------------------------------------------------------------------------------------------------
function HUD:DrawImageCentered(x, y, width, height, color, img, coords, angleZ)
	self:DrawImage(x-width*0.5,y-height*0.5,width,height,color,img,coords,angleZ);
end

----------------------------------------------------------------------------------------------------
function HUD:DrawImage(left, top, width, height, color, img, coords, angleZ)

	if (angleZ and (angleZ>0.001 or angleZ<-0.001)) then		
		UI.DrawQuad(left*self.rx, top*self.ry, width*self.rx, height*self.ry, UI:GetImage(img), color,
		UI:FixUVRect(img, coords), angleZ, self.rx, self.ry);
	else
		UI.DrawQuad(left*self.rx, top*self.ry, width*self.rx, height*self.ry, UI:GetImage(img), color,
		UI:FixUVRect(img, coords));
	end
end


----------------------------------------------------------------------------------------------------
function HUD:DrawCrosshair(cx, cy, frameTime)
	if (self.hide) then
		return;
	end
	if (g_localActor and g_localActor.inventory:GetCurrentItemId()) then
		local item = g_localActor.inventory:GetCurrentItem();
				
		if (item and item.weapon) then
			if ((not g_gameRules.fading) and item.weapon:GetCrosshair()) then
				local name = item.weapon:GetCrosshair();
				local crosshair = WeaponCrosshairs[name];

				if (crosshair and item.weapon:GetCrosshairVisibility()) then
					local width = 5;
					local minw = 4;
					local spread = item.weapon:GetSpread();
					local opacity = item.weapon:GetCrosshairOpacity();
					crosshair:Draw(cx, cy, item, minw+spread, minw+spread+width, opacity, frameTime);
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUD:Reset()
	for name,screen in pairs(self.screens) do
		if (screen.Reset) then
			screen:Reset();
		end
		for name,widget in pairs(screen.widgets) do
			if (widget.Reset) then
				widget:Reset();
			end
		end
	end
	
	self.info_messages = {};
	self.inst_messages = {};
	self.chat_messages = {};
	self.obj_messages = {};	
end

----------------------------------------------------------------------------------------------------
function HUD:DrawNumberRA(left, top, number, size, color, kerning)
	local nstr = tostring(number);
	local len = string.len(nstr);
	local width = size/1.77;
	local texture = self.digitTexture;
	local x = left-width;
	kerning = retDef(kerning, 0);

	for i=1,len do
		UI.DrawQuad(x*self.rx, top*self.ry, width*self.rx, size*self.ry, UI:GetImage(texture), color,
			UI:FixUVRect(texture, self.digitUV[string.sub(nstr, len-i+1, len-i+1)]));
		x = x-(width+kerning);
	end
end


----------------------------------------------------------------------------------------------------
function HUD:DrawLineFrame(x, y, w, h,color)
	self:DrawLine(x, y, x, y+h, color);
	self:DrawLine(x+w, y, x+w, y+h, color);

	self:DrawLine(x, y, x+w, y, color);
	self:DrawLine(x, y+h, x+w, y+h, color);
end


----------------------------------------------------------------------------------------------------
function HUD:DrawLine(x, y, x2, y2, color)
	UI.DrawLine(x*self.rx, y*self.ry, x2*self.rx, y2*self.ry, color);
end


----------------------------------------------------------------------------------------------------
function HUD:DrawTextRA(x, y, text, size, color)
	size = (size*self.rx+size*self.ry)*0.5;
	
	UI.DrawText(x*self.rx, y*self.ry, text, size, color, eUIA_Right, eUIA_Top);
end


----------------------------------------------------------------------------------------------------
function HUD:DrawTextCentered(x, y, text, size, color)
	size = (size*self.rx+size*self.ry)*0.5;
	
	UI.DrawText(x*self.rx, y*self.ry, text, size, color, eUIA_Center, eUIA_Middle);
end


---------------------------------------------------------------------------------------------------
function HUD:DrawText(x, y, text, size, color)
	size = (size*self.rx+size*self.ry)*0.5;

	UI.DrawText(x*self.rx, y*self.ry, text, size, color);
end


----------------------------------------------------------------------------------------------------
function HUD:AddInfoMessage(_text, _lifetime)
	HUD.DrawStatusText(_text); -- intercepts status messages
	do return end;
	_lifetime = retDef(_lifetime, 4);
	local msg =
	{
		text 			= _text,
		life			= _lifetime,
		alpha			= 1;
		alphaspeed= 1/_lifetime;
	};

	local top = self.infoY;
	local idx = 0;
	local noroom = false;

	for i,v in pairs(self.info_messages) do
		if ((v.life <= 0) and (idx == 0)) then
			idx = i;
			b= true;
			break;
		end
		
		if (v.life > 0) then
			if (math.abs(top-v.top) < self.infoSize) then
				top = v.top-(self.infoSize*0.5)-self.infoSpacing;
			end
		end
		
		if (top < self.infoMinY) then
			noroom = true;
		end
	end
	
	if (noroom) then
		local mint = 10000;
		local mini = 0;
		for i,v in pairs(self.info_messages) do
			if (v.life < mint) then
				mint = v.life;
				mini = i;
			end
		end

		idx = mini;
		msg.top = self.info_messages[mini].top;
	else
		msg.top = top;
	end


	if (idx <= 0) then
		table.insert(self.info_messages, msg);
	else
		self.info_messages[idx] = msg;
	end
end


----------------------------------------------------------------------------------------------------
function HUD:AddInstructionMessage(_text, _lifetime)
	local msg =
	{
		text 			= _text,
		life			= self.instructionFadeOut,
		obsolete	= false,
		alpha			= 1;
		alphaspeed= 1/self.instructionFadeOut;
	};

	local top = self.instructionY;
	local idx = 0;
	local noroom = false;

	for i,v in pairs(self.inst_messages) do
		if ((v.life <= 0) and (idx == 0)) then
			idx = i;
			b= true;
			break;
		end
		
		if (v.life > 0) then
			if (math.abs(top-v.top) < self.instructionSize) then
				top = v.top-(self.instructionSize*0.5)-self.instructionSpacing;
			end
		end
		
		if (top < self.instructionMinY) then
			noroom = true;
		end
	end
	
	if (noroom) then
		local mint = 10000;
		local mini = -1;
		for i,v in pairs(self.inst_messages) do
			if (v.obsolete and (v.life < mint)) then
				mint = v.life;
				mini = i;
			end
		end
		
		if (mini > -1) then
			noroom = false;
			idx = mini;
			msg.top = self.inst_messages[mini].top;
		end
	else
		msg.top = top;
	end

	if (not noroom) then
		if (idx <= 0) then
			table.insert(self.inst_messages, msg);
			idx = table.getn(self.inst_messages);
		else
			self.inst_messages[idx] = msg;
		end
		
		if (_lifetime) then
			Script.SetTimer(_lifetime*1000, function() HUD:SetInstructionObsolete(idx); end);
		end
		return idx;
	end
end


----------------------------------------------------------------------------------------------------
function HUD:SetInstructionObsolete(instruction)
	if (self.inst_messages and instruction and self.inst_messages[instruction]) then
		self.inst_messages[instruction].obsolete = true;
	end
end


----------------------------------------------------------------------------------------------------
function HUD:AddChatMessage(_text, _lifetime)
	local msg =
	{
		text 			= _text,
		life			= _lifetime,
		alpha			= 1;
		alphaspeed= 1/_lifetime;
		top				= 0,
	};

	table.insert(self.chat_messages, msg);
	table.sort(self.chat_messages, function(a, b)
		if (a.life < b.life) then
			return true;
		end
	end);
end


----------------------------------------------------------------------------------------------------
function HUD:ShowObjectives(show)
	self.drawObjectives = show;
end


----------------------------------------------------------------------------------------------------
function HUD:AddObjective(_name, _text)
	local msg =
	{
		text 			= _text,
		name			= _name,
		complete	= false,
	};

	for i,v in pairs(self.obj_messages) do
		if (v.name == _name) then
			v.text 			= _text;
			v.complete 	= false;
			
			return;
		end
	end

	table.insert(self.obj_messages, msg);
end


----------------------------------------------------------------------------------------------------
function HUD:SetObjectiveComplete(_name)
	for i,v in pairs(self.obj_messages) do
		if (v.name == _name) then
			if (not v.complete) then
				v.text = v.text.." (completed)";
			end
			v.complete = true;
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUD:UpdateInfoMessages(frameTime, frameId)
	do return end;
	UI.SetFont("new_hud", "default");
	local count = table.getn(self.info_messages);
	for i,v in pairs(self.info_messages) do
		if (v.life > 0) then
			HUD:DrawText(self.infoX, v.top, v.text, self.infoSize, UI:GetColor(self.infoColor[1], self.infoColor[2], self.infoColor[3], self.infoColor[4]*v.alpha));
			v.life = v.life-frameTime;
			v.alpha = v.alpha-v.alphaspeed*frameTime;
		end
	end
	UI.SetFont("hud", "default");
end


----------------------------------------------------------------------------------------------------
function HUD:UpdateInstructionMessages(frameTime, frameId)
	local count = table.getn(self.info_messages);

	for i,v in pairs(self.inst_messages) do
		if (v.life > 0) then
			HUD:DrawTextCentered(self.instructionX, v.top, v.text, self.instructionSize, UI:GetColor(self.instructionColor[1], self.instructionColor[2], self.instructionColor[3], self.instructionColor[4]*v.alpha));

			if (v.obsolete) then
				v.life = v.life-frameTime;
				v.alpha = v.alpha-v.alphaspeed*frameTime;
			end
		end
	end	
end

----------------------------------------------------------------------------------------------------
function HUD:DrawMapElement(entity, pos, texture, color, zoom, levelInfo, left, top, uvs, img)
	local rx = UI.GetScreenWidth()/800;
	local ry = UI.GetScreenHeight()/600;
	
	local w = self.mapIconSize;
	local h = self.mapIconSize;
	local x, y = self:WorldToMap(pos, levelInfo, uvs, img);
	
	local angle = 0;

	if (entity.actor) then
		angle = math.pi-entity.actor:GetAngles(g_Vectors.temp_v1).z+math.pi*0.5;
	else
		angle = entity:GetAngles(g_Vectors.temp_v1).z+math.pi*0.5;
	end

	UI.DrawQuad((left+x-w*0.5)*rx, (top+y-h*0.5)*ry, w*rx, h*ry, UI:GetImage(texture), color, UI:FixUVRect(texture, coords), angle, rx, ry);
end

----------------------------------------------------------------------------------------------------
function HUD:GetMapUV(texture, cx, cy, zoom, img)
	local uv = UI:FixUVRect(texture);
	
	if (img) then	
		local rcpw = 1/img.width;
		local rcph = 1/img.height;
		
		local izoom = 1/math.min(math.max(1, zoom), 8);

		local u = math.min(math.max(0.5*rcpw, ((cx+0.5)*rcpw)-(izoom*0.5)), (1-izoom));
		local v = math.min(math.max(0.5*rcph, ((cy+0.5)*rcph)-(izoom*0.5)), (1-izoom));
		uv[1] = u;
		uv[2] = v;
		uv[3] = u+izoom;
		uv[4] = v+izoom;
	end

	return uv;
end

----------------------------------------------------------------------------------------------------
function HUD:WorldToMap(world, levelInfo, uvs, img)
	local heightmapSize = levelInfo.heightmapSize;
	local terrainSize = levelInfo.terrainSize;
	
	local winx = math.floor(uvs[1]*img.width);
	local winy = math.floor(uvs[2]*img.height);
	local winw = math.floor(uvs[3]*img.width)-winx;
	local winh = math.floor(uvs[4]*img.height)-winy;
	
	winx = winx+self.mapWindowX;
	winy = winy+self.mapWindowY;

	local x = self.mapWidth*((world.y*heightmapSize/terrainSize)-winx)/winw;
	local y = self.mapHeight*((world.x*heightmapSize/terrainSize)-winy)/winh;

	return x, y;
end

----------------------------------------------------------------------------------------------------
function HUD:WorldToMapTexel(world, levelInfo, uvs, img)
	local heightmapSize = levelInfo.heightmapSize;
	local terrainSize = levelInfo.terrainSize;
	
	local winx = math.floor(uvs[1]*img.width);
	local winy = math.floor(uvs[2]*img.height);
	local winw = math.floor(uvs[3]*img.width)-winx;
	local winh = math.floor(uvs[4]*img.height)-winy;
	
	winx = winx+self.mapWindowX;
	winy = winy+self.mapWindowY;

	local x = (world.y*heightmapSize/terrainSize)-winx;
	local y = (world.x*heightmapSize/terrainSize)-winy;

	return x, y;
end

----------------------------------------------------------------------------------------------------
function HUD:DrawMap(frameTime)
	local levelInfo = UI.GetCurrentLevelInfo();
	
	if ((not levelInfo) or (not Mission) or (not Mission.mapTexture)) then
		return;
	end
	
	if (Mission.mapWindowX) then
		self.mapWindowX = Mission.mapWindowX;
		self.mapWindowY = Mission.mapWindowY;
	else
		self.mapWindowX = 0;
		self.mapWindowY = 0;
	end
	
	local texture = levelInfo.path.."/"..Mission.mapTexture;
	local img = UI:GetImageInfo(texture);
	
	if (not img) then
		return;
	end

	local w = self.mapWidth;
	local h = self.mapHeight;
	local x = self.mapX;
	local y = self.mapY;
	local zoom = 1;

	local rx = UI.GetScreenWidth()/800;
	local ry = UI.GetScreenHeight()/600;

	UI.DrawLine(x*rx-1, y*ry, x*rx-1, (y+h)*ry, UIBlack);
	UI.DrawLine((x+w)*rx+1, y*ry, (x+w)*rx+1, (y+h)*ry, UIBlack);

	UI.DrawLine(x*rx-1, y*ry-1, (x+w)*rx+1, y*ry-1, UIBlack);
	UI.DrawLine(x*rx-1, (y+h)*ry+1, (x+w)*rx+1, (y+h)*ry+1, UIBlack);
	
	local unzoomeduvs = HUD:GetMapUV(texture, img.width*0.5, img.height*0.5, 1, img);
	local centerx, centery = HUD:WorldToMapTexel(g_localActor:GetWorldPos(), levelInfo, unzoomeduvs, img);
	local uvs = HUD:GetMapUV(texture, centerx, centery, zoom, img);

	UI.DrawQuad(x*rx, y*ry, w*rx, h*ry, UI:GetImage(texture), UIWhite, uvs, img);
	
	if (not self.__dummy_contact) then
		self.__dummy_contact = { color = {}, pos = {}};
	end

	local contact = self.__dummy_contact;
	local objectives = System.GetEntitiesByClass("MissionObjective");	
	
	for i,entity in pairs(objectives) do
		if (entity:UpdateRadar(contact)) then
			self:DrawMapElement(entity, contact.pos, contact.img, contact.color, zoom, levelInfo, x, y, uvs, img);
		end
	end
	
	local radar = HUD:GetScreen("default").radar;
	
	for i,contact in pairs(radar.contacts) do
		if (contact.active) then
			local entity = System.GetEntity(contact.entityId);

			if (entity) then
				self:DrawMapElement(entity, contact.pos, contact.img, contact.color, zoom, levelInfo, x, y, uvs, img);
			end
		end
	end

	
	self:DrawMapElement(g_localActor, g_localActor:GetWorldPos(g_Vectors.temp_v1), "textures/gui/hud/radar/enemy_grey.dds", UIWhite, zoom, levelInfo, x, y, uvs, img);
end

----------------------------------------------------------------------------------------------------
function HUD:UpdateObjectiveMessages(frameTime)
	if (not self.drawObjectives) then
		return;
	end
	
	self:DrawMap(frameTime);
	
	if (table.getn(self.obj_messages) < 1) then
		return;
	end
	
	local alpha = 1;
	
	--HUD:DrawLineFrame(self.objectivesX, self.objectivesY, self.objectivesW, self.objectivesH, self.objectivesFrameColor);
	
	local left 	= self.objectivesX+self.objectivesBorder;
	local top 	= self.objectivesY+self.objectivesBorder-30;
	
	local rx = UI.GetScreenWidth()/800;
	local ry = UI.GetScreenHeight()/600;


	for i,v in pairs(self.obj_messages) do
		local color = self.objectivesColor;
		if (v.complete) then
			color = self.objectivesCompleteColor;
		end

		size = self.objectivesSize*(self.rx+self.ry)*0.5;
		UI.DrawText(left*self.rx, top*self.ry, v.text, size, color);

		local w, h = UI.GetTextSize(v.text, self.objectivesSize);
		top = top+(h/self.ry)+self.objectivesSpacing;
	end
end


----------------------------------------------------------------------------------------------------
function HUD:UpdateChatMessages(frameTime)
end


----------------------------------------------------------------------------------------------------
function HUD:OnUpdate(frameTime, frameId)
	if (g_gameRules) then
		self:Activate(not UI:GetUI("main").active);
	else
		self:Activate(false);
	end
	
	if (g_localActor and (not UI:IsLoading())) then	
		local hudEntity = g_localActor.hud;
		if hudEntity then
			--hudEntity:DrawSlot(0, 1);
			--UI.Render3DEntity(hudEntity.id, math.rad(45), 0.1, 10, 0, 0.00001);
			--hudEntity:DrawSlot(0, 0);
		end
	end

	--UI.Begin2D(UI.GetScreenWidth(), UI.GetScreenHeight());
	--self:UpdateObjectiveMessages(frameTime);
	--if (g_gameRules and g_gameRules.DrawScores) then
--		g_gameRules:DrawScores(frameTime, frameId);
--	end
--	self:DrawCrosshair(400, 300, frameTime);
	--UI.End2D();
end


----------------------------------------------------------------------------------------------------
function HUD:OnActivate(activate)
	self.rx = self.width/800;
	self.ry = self.height/600;
	self.screens.default:Activate(true);
	
	UI.SetFont("hud", "default");
end


----------------------------------------------------------------------------------------------------
function HUD:Spawn(actor)
	--[[
	--if (actor.hud) then
		--HUD:Destroy(actor);
	--end
	
	local params = 
	{
		class = "GUI",
		name 	= actor:GetName().."'s HUD",
		flags = ENTITY_FLAG_CLIENT_ONLY+ENTITY_FLAG_NO_SAVE,

		properties =
		{
			bRigidBody					= 0,
			bResting 						= 0,
			bUsable							= 0,
			bPhysicalized				= 0,
			GUIMaterial					= "",
			GUIWidth						= 1024,
			GUIHeight						= 1024,
			GUIDefaultScreen		= "default",
			GUIMouseCursor			= "",
			GUIPreUpdate				= 0,
			GUIHasFocus					= 1,
			color_GUIBackgroundColor = {0,0,0},
		}
	};
	
	local current_aspect = UI.GetScreenWidth()/UI.GetScreenHeight();
	local fbt = math.abs(4/3-current_aspect);
	local sbn = math.abs(16/9-current_aspect);

	--if (fbt > sbn) then
		--params.properties.objModel = "objects/hud/hud_16_9.cgf";
	--else
		params.properties.objModel = "objects/hud/hud_4_3.cgf";
	--end

	local hud = System.SpawnEntity(params);

	hud:DrawSlot(0, 0);
	hud:SetUI("hud");

	actor.hud = hud;
	
	local hudparams =
	{
		hudOffset = { x=0.0, y=3.65, z=1.45 };
		hudAngleOffset = { x=0, y=0, z=0 };
	};

	actor.actor:SetParams(hudparams);
	--]]--
	self:Reset();
end


----------------------------------------------------------------------------------------------------
function HUD:Slide(up, speed, delay)
	if (up) then
		self.sliding_speed = speed;
		self.sliding_target = 4;
	else
		self.sliding_speed = -speed;
		self.sliding_target = 0;
		--self:Hide(false);
	end
	
	if (delay and (delay > 0)) then
		self.slide_time = _time + delay;
	else
		self.sliding = true;
		self.slide_time = nil;
	end

	if (not self.sliding_offset) then
		self.sliding_offset = 0;
	end
end


----------------------------------------------------------------------------------------------------
function HUD:IsSliding()
	return self.sliding;
end


----------------------------------------------------------------------------------------------------
function HUD:UpdateHUD(actor, frameTime, show)
	local hud = actor.hud;

	if (hud) then
		local stats = actor.actor:GetStats();
		
		if (self.sliding) then
			self.sliding_offset = self.sliding_offset + frameTime*self.sliding_speed;
			if ((self.sliding_speed > 0) and (self.sliding_offset >= self.sliding_target)) then
				self.sliding_offset = self.sliding_target;
				self.sliding = false;

				self:Hide(true);
			elseif ((self.sliding_speed < 0) and (self.sliding_offset <= self.sliding_target)) then
				self.sliding_offset = self.sliding_target;
				self.sliding = false;
			end
		elseif (self.slide_time) then
			if (_time >= self.slide_time) then
				self.slide_time = nil;
				self.sliding = true;
			end
		end
		
		if (self.sliding_offset) then
			local up = vecFrontToUp(System.GetViewCameraDir());
			local pos = stats.HUDPos;

			pos.x = pos.x+up.x*self.sliding_offset;
			pos.y = pos.y+up.y*self.sliding_offset;
			pos.z = pos.z+up.z*self.sliding_offset;
		end
		
		if (stats.thirdPerson or (not show) or self.hide) then
			hud:Hide(1);			
		else
			hud:Hide(0);
			hud:SetWorldPos(stats.HUDPos);	
			hud:SetWorldAngles(stats.HUDAngles);
		end
	end
end


----------------------------------------------------------------------------------------------------
function HUD:Destroy(actor)	
	if (actor.hud) then
		System.RemoveEntity(actor.hud.id);
		actor.hud = nil;
	end
end


----------------------------------------------------------------------------------------------------
function HUD:Hide(hide)
	if (hide and (tonumber(hide) ~= 0)) then
		self.hide = true;
	else
		self.hide = false;
	end
end


----------------------------------------------------------------------------------------------------
function HUD:IsHidden()
	return g_localActor.hud:IsHidden();
end


----------------------------------------------------------------------------------------------------
System.LoadFont("hud"); -- load specific hud font
HUD:Activate(true);

--if (g_localActor and g_localActor.hud) then
	--g_localActor.hud:SetUI("hud");
--end

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------




-- CXP BEGIN HACK	
THEEND = UI:BeginUI("theend");
	local theend =
	{	
		active = true,
		cxp1 =
		{
			class = "static",
			
			left 	= 0,
			top 	= 0,
			width = 800,
			height= 600,
			
			color	= {0, 0, 0, 0},
			
			skin 	=
			{
				normal	= "textures/gui/CXP_endscreen.dds",
			},
		},
		
		ftb = true,

		OnUpdate = function(self, frameTime, frameId)
			local spd1 = 5; --fadeout time in seconds
			local spd2 = 2;
			if (self.ftb) then
				if (not self.ftb_start) then
					self.ftb_start = _time;
					System.ExecuteCommand("hud 0");
				end
				local dt = _time-self.ftb_start;
				self.cxp1.color[4] = math.min(255, 255*dt/spd1);
							
				Sound.SetMasterVolumeScale(math.max(0, (1-dt/spd1)));

				if (dt >= spd1) then
					UI.PauseGame(true);
					dt = 2;
					self.ftb =false;
					self.fpic = true;
				end
				do return end
			elseif (self.fpic) then
				Sound.Silence();
				if (not self.fpic_start) then
					self.fpic_start = _time;
				end
	
				local dt = _time-self.fpic_start;
				
				self.cxp1.color[1] = math.min(255, 255*dt/spd2);
				self.cxp1.color[2] = math.min(255, 255*dt/spd2);
				self.cxp1.color[3] = math.min(255, 255*dt/spd2);
			end
		end,
	};
	
	UI:MakeScreen(theend, "theend");
UI:EndUI();


THEEND:Focus(false);

THEEND.OnActivate = function (self, activate)
	if (activate) then
		HUD:Hide(true);
	end
	self:GetScreen("theend"):Activate(true);
	self:Focus(activate);
end

THEEND.OnKeyDown = function(self, keyCode, keyName, keyChar)
	if (keyName == "esc") then
		if (not System.IsEditor()) then
			System.Quit();
		end
		self:Activate(false);
	end	
end
-- CXP END HACK
