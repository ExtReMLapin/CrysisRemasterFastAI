----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: User Interface utility functions!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 12:1:2005   12:26 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
function UI:PointInRect(x, y, rl, rt, rw, rh)
	if ((x < rl) or (x > rl+rw)) then
		return false;
	end

	if ((y < rt) or (y > rt+rh)) then
		return false;
	end
	
	return true;
end


----------------------------------------------------------------------------------------------------
function UI:PointInWidget(x, y, widget)
	return UI:PointInRect(x, y, widget.left, widget.top, widget.width, widget.height);
end


----------------------------------------------------------------------------------------------------
function UI:GetAbsoluteXY(x, y, widget)
	if (widget) then
		parent = widget;

		while (parent) do
			x = x+parent.left;
			y = y+parent.top;
			
			parent = parent.parent;
		end
	end
	
	return x, y;
end


----------------------------------------------------------------------------------------------------
function UI:GetRelaviveXY(x, y, widget)
	local ax,ay = UI:GetAbsoluteXY(0,0, widget);
	
	return x-ax,y-ay;
end


----------------------------------------------------------------------------------------------------
function UI:FindWidgetAt(ui, x, y)
	if (ui) then
		-- go through all active screens and find the topmost widget
		local widget;
		for name,screen in pairs(ui.screens) do
			if (screen.active) then
				widget = screen:FindWidgetAt(x, y);
			end
		end

		-- TODO: check for topmost screen
		return widget;
	end
end


----------------------------------------------------------------------------------------------------
function UI:AdjustRect(rl, rt, rw, rh, b, grow)
	if (grow) then
		return rl-b, rt-b, rw+b, rh+b;
	end
	
	return rl+b, rt+b, rw-b, rh-b;
end


----------------------------------------------------------------------------------------------------
function UI:IntersectRects(rl0, rt0, rw0, rh0, rl1, rt1, rw1, rh1)
	if ((rl1 > rl0 + rw0) or (rl0 > rl1+rw1) or (rt1 > rt0+rh0) or (rt0 > rt1+rh1)) then
		return rl0, rt0, 0, 0;
	end
	
	local nl, nt, nw, nh;
	
	if (rl1 > rl0) then
		nl = rl1;
	else
		nl = rl0;
	end
	
	if (rl1 + rw1 > rl0 + rw0) then
		nw = rl0 + rw0 - nl;
	else
		nw = rl1 + rw1 - nl;
	end


	if (rt1 > rt0) then
		nt = rt1;
	else
		nt = rt0;
	end

	if (rt1 + rh1 > rt0 + rh0) then
		nh = rt0 + rh0 - nt;
	else
		nh = rt1 + rh1 - nt;
	end
end


----------------------------------------------------------------------------------------------------
function UI:GetWidgetCanvas(widget)
	if (widget.parent) then
		local l,t,w,h;
		local cl,ct,cw,ch = widget.left, widget.top, widget.width, widget.height;
		local parent = widget.parent;
		
		cl,ct = UI:GetAbsoluteXY(cl, ct, parent);

		while (parent) do
			local pl,pt,pw,ph = parent.left, parent.top, parent.width, parent.height;

			if (parent.parent) then
				pl,pt = UI:GetAbsoluteXY(pl, pt, parent.parent);
			end

			l,t,w,h = UI:IntersectRects(cl,ct,cw,ch, pl,pt,pw,ph);
			cl,ct,cw,ch = l,t,w,h;
			
			parent = parent.parent;
		end
		
		return l,t,w,h;
	else
		return widget.left, widget.top, widget.width, widget.height;
	end
end

----------------------------------------------------------------------------------------------------
function UI:FixUV(texName, u, v)
	local lowerName = string.lower(texName);
	local img = self.images[lowerName];
	
	if (not img) then
		return 0, 0;
	end

	return u/img.width, v/img.height;
end


----------------------------------------------------------------------------------------------------
function UI:FixUVRect(texName, r)
	local tmp = UI.__uv_tmp;
	if (not tmp) then
		tmp = {};
		UI.__uv_tmp = tmp;
	end

	local lowerName = string.lower(texName);
	local img = self.images[lowerName];
	if (not img) then
		tmp[1] = 0;
		tmp[2] = 0;
		tmp[3] = 0;
		tmp[4] = 0;
	elseif (not r) then
		if (not r) then
			tmp[1], tmp[2] = UI:FixUV(lowerName, 0.5, 0.5);
			tmp[3], tmp[4] = UI:FixUV(lowerName, img.width-1, img.height-1);
		end
	else
		local u, v = r[1]+0.5, r[2]+0.5;

		tmp[1], tmp[2] = UI:FixUV(lowerName, u, v);
		tmp[3], tmp[4] = UI:FixUV(lowerName, u+r[3]-1, v+r[4]-1);
	end

	return tmp;
end


----------------------------------------------------------------------------------------------------
function UI:GetImage(name)
	if (name and (string.len(name) > 0)) then
		local lowerName = string.lower(name);
		local img = self.images[lowerName];
		
		if (img) then
			return img.id;
		end

		id = UI.LoadImage(lowerName, false);

		if (id) then
			img = {};
			img.id = id;
			img.width, img.height = UI.GetImageSize(id);

			self.images[lowerName] = img;
		end

		return id;
	end
end


----------------------------------------------------------------------------------------------------
function UI:GetImageInfo(name)
	UI:GetImage(name);
	
	if (name and (string.len(name) > 0)) then
		local lowerName = string.lower(name);
		local img = self.images[lowerName];
		
		return img;
	end
end


----------------------------------------------------------------------------------------------------
function UI:SelectImage(skin, disabled, down, over)
	if (disabled) then
		return skin.disabled;
	elseif (down) then
		return skin.down;
	elseif (over) then
		return skin.over;
	else
		return skin.normal;
	end
end

----------------------------------------------------------------------------------------------------
function UI:GetColorF(r, g, b, a)
	if (not self.__color) then
		self.__color = {};
	end

	self.__color[1] = r*255;
	self.__color[2] = g*255;
	self.__color[3] = b*255;
	self.__color[4] = a*255;
	
	return self.__color;
end


----------------------------------------------------------------------------------------------------
function UI:GetColor(r, g, b, a)
	if (not self.__color) then
		self.__color = {};
	end
	self.__color[1] = r;
	self.__color[2] = g;
	self.__color[3] = b;
	self.__color[4] = a;
	
	return self.__color;
end


----------------------------------------------------------------------------------------------------
function UI:InterpolateColorF(left, right, t)
	if (not self.__color) then
		self.__color = {};
	end

	self.__color[1] = 255*(left[1]*(1-t)+right[1]*t);
	self.__color[2] = 255*(left[2]*(1-t)+right[2]*t);
	self.__color[3] = 255*(left[3]*(1-t)+right[3]*t);
	self.__color[4] = 255*(left[4]*(1-t)+right[4]*t);
	
	return self.__color;
end


----------------------------------------------------------------------------------------------------
function UI:InterpolateColor(left, right, t)
	if (not self.__color) then
		self.__color = {};
	end

	self.__color[1] = left[1]*(1-t)+right[1]*t;
	self.__color[2] = left[2]*(1-t)+right[2]*t;
	self.__color[3] = left[3]*(1-t)+right[3]*t;
	self.__color[4] = left[4]*(1-t)+right[4]*t;
	
	return self.__color;
end