----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: ECG (Electrocardiogram)
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 13:2:2005   13:58 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------
HUDECG =
{
	ecg_color 			= {0, 200, 0, 192},
	cursor_color 		= UIBlack,
	axis_color 			= UIBlack,
	scroll					= false,

	historigram_size= 256,
	update_rate			= 128,	-- per second

	----------------------------------------------------------------------------------------------------
	SampleCount = 128,
	Sample =
	{
		1.090699,0.927671,0.547002,0.125660, -0.196292, -0.365192, -0.392830, -0.329632, -0.238713,
		-0.165084,-0.121436,-0.099282,-0.086572,-0.075866,-0.064047,-0.050018,-0.033330,-0.013724,
		0.008948,0.034713,0.063448,0.094851,0.128428,0.163485,0.199143,0.234359,0.267979,0.298788,
		0.325589,0.347272,0.362894,0.371743,0.373396,0.367743,0.355006,0.335718,0.310688,0.280945,
		0.247666,0.212098,0.175484,0.138993,0.103659,0.070341,0.039700,0.012189,-0.011939,-0.032612,
		-0.049906,-0.064017,-0.075224,-0.083856,-0.090266,-0.094802,-0.097798,-0.099552,-0.100329,
		-0.100353,-0.099806,-0.098838,-0.097563,-0.096072,-0.094430,-0.092685,-0.090874,-0.088953,
		-0.087021,-0.085096,-0.083177,-0.081265,-0.079360,-0.077462,-0.075571,-0.073686,-0.071809,
		-0.069939,-0.068076,-0.066220,-0.064371,-0.062530,-0.060696,-0.058869,-0.057049,-0.055234,
		-0.053421,-0.051605,-0.049772,-0.047898,-0.045935,-0.043800,-0.041353,-0.038372,-0.034522,
		-0.029330,-0.022174,-0.012302,0.001109,0.018835,0.041433,0.069033,0.101139,0.136482,0.172997,
		0.207962,0.238300,0.261028,0.273738,0.275028,0.264769,0.244130,0.215372,0.181449,0.145518,
		0.110473,0.078576,0.051201,0.028499,0.008603,-0.013685,-0.046817,-0.096758,-0.154828,-0.189135,
		-0.151499,0.004022,0.297986,0.688807,1.042229,
	},
	
	Historigram = {},
	writeCursor = 1,
}


----------------------------------------------------------------------------------------------------
function HUDECG:SetTarget(targetId)
	self.targetId = targetId;
end


----------------------------------------------------------------------------------------------------
function HUDECG:Draw(frameTime, frameId, pass)
	if (pass ~= 1) then
		return;
	end

	local ui = self.ui;
	local img;
	
	if (self.skin and self.skin.normal) then
		img = self.skin.normal;
	end

	local rw = UI.GetScreenWidth()/800;
	local rh = UI.GetScreenHeight()/600;
	
	local x = self.left*rw;
	local y = self.top*rh;

	UI.DrawQuad(x, y, self.width*rw, self.height*rh, UI:GetImage(img), self.color, UI:FixUVRect(img, self.skin.rect));
	HUD:DrawLineFrame(self.left, self.top, self.width, self.height, UIBlack[1], UIBlack[2], UIBlack[3], UIBlack[4]);

	if (self.scroll) then
		self:DrawECGScroll();
	else
		self:DrawECG();
	end
end


----------------------------------------------------------------------------------------------------
function HUDECG:Update(frameTime, frameId)
	local amplitude = 0;
	local sps = self.SampleCount;

	if (self.targetId) then
		local target = System.GetEntity(self.targetId);
		
		if (target and target.actor) then
			if (target:IsDead()) then
				amplitude = 0;
				self.readCursor = 1;
			else
				amplitude = 0.05+(target.actor:GetHealth()/100)*0.85;
			end

			local bpm = 74+(100-target.actor:GetHealth())*0.5;
			sps = self.SampleCount*bpm/60;
		end
	end

	if (not self.readCursor) then
		self.readCursor = 1;
	end
	
	local step = 1.0/self.update_rate;
	while ((not self.last_update) or (_time-self.last_update > step)) do
		if (not self.last_update) then
			self.last_update = _time;
		end

		local t = self.readCursor;
		local a = math.floor(t);
		local b = math.ceil(t);
		
		if (a <= 0) then
			a = 1;
		end
		if (a > self.SampleCount) then
			a = 1;
		end
		
		if (b > self.SampleCount) then
			b = 1;
		end

		local u = t-a;

		a = self.Sample[a];
		b = self.Sample[b];

		local mv = u*a+(1-u)*b;

		self.Historigram[self.writeCursor] = mv*amplitude;
		self.writeCursor = self.writeCursor+1;
		
		if (self.writeCursor > self.historigram_size) then
			self.writeCursor = 1;
		end

		self.readCursor = self.readCursor+step*sps;
		
		if (self.readCursor > self.SampleCount) then
			self.readCursor = self.readCursor - self.SampleCount;
		end
				
		if (not self.last_update) then
			self.last_update = _time;
		end
		
		self.last_update = self.last_update+step;
	end
end


----------------------------------------------------------------------------------------------------
function HUDECG:Message(msg, ...)
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
function HUDECG:DrawECGScroll()
	local drawSamples = math.min(table.getn(self.Historigram), self.historigram_size);
	if (table.getn(self.Historigram)> self.historigram_size) then
	Log("BUG");
	end
	
	local dx = (self.width-2)/self.historigram_size;
	
	local x0 = self.left+1;
	local y0 = self.top+self.height*0.5;
	
	local wcx = self.left+2+drawSamples*dx;

	System.Draw2DLine(wcx, self.top, wcx, self.top+self.height, self.cursor_color[1]/255, self.cursor_color[2]/255, self.cursor_color[3]/255, self.cursor_color[4]/255);
	System.Draw2DLine(self.left, self.top+self.height*0.5, self.left+self.width, self.top+self.height*0.5, self.axis_color[1]/255, self.axis_color[2]/255, self.axis_color[3]/255, self.axis_color[4]/255);
	
	local wc = self.writeCursor;
	
	if (wc > 1) then
		for i=wc,drawSamples do
			local x1 = x0+(i-wc-1)*dx;
			local x2 = x0+(i-wc)*dx;
			local y1 = y0-self.Historigram[i-1]*self.height*0.45;
			local y2 = y0-self.Historigram[i]*self.height*0.45;
			
			System.Draw2DLine(x1, y1, x2, y2, self.ecg_color[1]/255, self.ecg_color[2]/255, self.ecg_color[3]/255, self.ecg_color[4]/255);
		end
	end
	
	x0 = x0+(drawSamples-wc)*dx;
	
	for i=2,wc-1 do
		local x1 = x0+(i-1)*dx;
		local x2 = x0+(i)*dx;
		local y1 = y0-self.Historigram[i-1]*self.height*0.45;
		local y2 = y0-self.Historigram[i]*self.height*0.45;
			
		System.Draw2DLine(x1, y1, x2, y2, self.ecg_color[1]/255, self.ecg_color[2]/255, self.ecg_color[3]/255, self.ecg_color[4]/255);
	end
end


----------------------------------------------------------------------------------------------------
function HUDECG:DrawECG()
	local drawSamples = table.getn(self.Historigram);
	local dx = (self.width-2)/self.historigram_size;
	
	local x0 = self.left+1;
	local y0 = self.top+self.height*0.5;
	
	local wcx = self.left+self.writeCursor*dx;

	System.Draw2DLine(wcx, self.top, wcx, self.top+self.height, self.cursor_color[1]/255, self.cursor_color[2]/255, self.cursor_color[3]/255, self.cursor_color[4]/255);
	System.Draw2DLine(self.left, self.top+self.height*0.5, self.left+self.width, self.top+self.height*0.5, self.axis_color[1]/255, self.axis_color[2]/255, self.axis_color[3]/255, self.axis_color[4]/255);

	if (drawSamples >= 1) then
		for i=2,drawSamples do
			local x1 = x0+(i-1)*dx;
			local x2 = x0+i*dx;
			local y1 = y0-self.Historigram[i-1]*self.height*0.45;
			local y2 = y0-self.Historigram[i]*self.height*0.45;
			
			System.Draw2DLine(x1, y1, x2, y2, self.ecg_color[1]/255, self.ecg_color[2]/255, self.ecg_color[3]/255, self.ecg_color[4]/255);
		end
	end
end

----------------------------------------------------------------------------------------------------
UI:RegisterClass("ecg", HUDECG, UIWidget);
