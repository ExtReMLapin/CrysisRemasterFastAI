Script.ReloadScript("Scripts/Entities/Lights/Light.lua")

EnvironmentLight =
{
	Properties =
	{
		_nVersion = -1,
		bActive = 0,
		Radius = 10,
		Color = {
			clrDiffuse = { x=1,y=1,z=1 },
			fDiffuseMultiplier = 1,
			fSpecularMultiplier = 1,
			fHDRDynamic = 0,		-- -1=darker..0=normal..1=brighter
		},
		Options = {
			bAffectsThisAreaOnly = 1,
			bIgnoresVisAreas = 0,
			bDeferredLight = 1,
			bDeferredClipBounds = 0,
			_texture_deferred_cubemap = "",
			file_deferred_clip_geom = "",
		},
		OptionsAdvanced = {
		  texture_deferred_cubemap = "",
		},
	},

	Editor=
	{
		ShowBounds=0,
		AbsoluteRadius = 1,
	},

	_LightTable = {},
}

LightSlot = 1

function EnvironmentLight:OnInit()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
	self:OnReset();
	self:Activate(1);	-- Force OnUpdate to get called
	self:CacheResources("EnvironmentLight.lua");
end

function EnvironmentLight:CacheResources(requesterName)
  if ( self.Properties.OptionsAdvanced.texture_deferred_cubemap == "" ) then
	  self.Properties.OptionsAdvanced.texture_deferred_cubemap = self.Properties.Options._texture_deferred_cubemap;
  end
	Game.CacheResource(requesterName, self.Properties.OptionsAdvanced.texture_deferred_cubemap, eGameCacheResourceType_TextureDeferredCubemap, 0);
	Game.CacheResource(requesterName, self.Properties.Options.file_deferred_clip_geom, eGameCacheResourceType_StaticObject, 0);
end

function EnvironmentLight:OnShutDown()
	self:FreeSlot(LightSlot);
end

function EnvironmentLight:OnLoad(props)
	self:OnReset()
	self:ActivateLight(props.bActive)
end

function EnvironmentLight:OnSave(props)
	props.bActive = self.bActive
end

function EnvironmentLight:OnPropertyChange()
	self:OnReset();
	self:ActivateLight( self.bActive );
	if (self.Properties.Options.bDeferredClipBounds) then
		self:UpdateLightClipBounds(LightSlot);
	end
end

function EnvironmentLight:OnUpdate(dt)
	if (self.bActive and self.Properties.Options.bDeferredClipBounds) then
		self:UpdateLightClipBounds(LightSlot);
	end

	if (not System.IsEditor()) then
		self:Activate(0);
	end
end

function EnvironmentLight:OnReset()
	if (self.bActive ~= self.Properties.bActive) then
		self:ActivateLight( self.Properties.bActive );
	end
end

function EnvironmentLight:ActivateLight( enable )
    System.Log("EnvironmentLight:ActivateLight '"..self:GetName().."' "..tostring(enable));

	if (enable and enable ~= 0) then
		self.bActive = 1;
		self:LoadLightToSlot(LightSlot);
		self:ActivateOutput( "Active",true );
	else
		self.bActive = 0;
		self:FreeSlot(LightSlot);
		self:ActivateOutput( "Active",false );
	end

	self.Properties.bActive = self.bActive
end

function EnvironmentLight:LoadLightToSlot( nSlot )
	local props = self.Properties;
	local Color = props.Color;
	local Options = props.Options;
	local OptionsAdvanced = props.OptionsAdvanced;

	local diffuse_mul = Color.fDiffuseMultiplier;
	local specular_mul = Color.fSpecularMultiplier;

	local lt = self._LightTable;
	lt.radius = props.Radius;
	lt.diffuse_color = { x=Color.clrDiffuse.x*diffuse_mul, y=Color.clrDiffuse.y*diffuse_mul, z=Color.clrDiffuse.z*diffuse_mul };

	if (diffuse_mul ~= 0) then
		lt.specular_multiplier = specular_mul / diffuse_mul;
	else
		lt.specular_multiplier = 1;
	end

	if ( OptionsAdvanced.texture_deferred_cubemap == "" ) then
	  OptionsAdvanced.texture_deferred_cubemap = Options._texture_deferred_cubemap;
  end
  lt.deferred_cubemap = OptionsAdvanced.texture_deferred_cubemap;
	lt.deferred_geom = Options.file_deferred_clip_geom;
	lt.hasclipbound = Options.bDeferredClipBounds;
	lt.deferred_light = Options.bDeferredLight;
	lt.hdrdyn = Color.fHDRDynamic;
	lt.this_area_only = Options.bAffectsThisAreaOnly;
	lt.ignore_visareas = Options.bIgnoresVisAreas;
	
	lt.lightmap_linear_attenuation = 1;
	lt.is_rectangle_light = 0;
	lt.is_sphere_light = 0;
	lt.area_sample_number = 1;
	
	lt.RAE_AmbientColor = { x = 0, y = 0, z = 0 };
	lt.RAE_MaxShadow = 1;
	lt.RAE_DistMul = 1;
	lt.RAE_DivShadow = 1;
	lt.RAE_ShadowHeight = 1;
	lt.RAE_FallOff = 2;
	lt.RAE_VisareaNumber = 0;

	self:LoadLight( nSlot,lt );
end

function EnvironmentLight:Event_Enable()
	if (self.bActive == 0) then
		self:ActivateLight( 1 );
	end
end

function EnvironmentLight:Event_Disable()
	if (self.bActive == 1) then
		self:ActivateLight( 0 );
	end
end

-----------------------------------------------------
function EnvironmentLight:OnNanoSuitDischarge()
	self:Event_Disable();
end

----------------------------------------------------
function EnvironmentLight:OnTouchedByNanoWeapon()
	self:Event_Enable();
end

------------------------------------------------------------------------------------------------------
-- Event Handlers
------------------------------------------------------------------------------------------------------
function EnvironmentLight:Event_Active( bActive )
	if (self.bActive == 0 and bActive == true) then
		self:ActivateLight( 1 );
	else 
		if (self.bActive == 1 and bActive == false) then
			self:ActivateLight( 0 );
		end
	end
end


------------------------------------------------------------------------------------------------------
-- Event descriptions.
------------------------------------------------------------------------------------------------------
EnvironmentLight.FlowEvents =
{
	Inputs =
	{
		Active = { EnvironmentLight.Event_Active,"bool" },
		Enable = { EnvironmentLight.Event_Enable,"bool" },
		Disable = { EnvironmentLight.Event_Disable,"bool" },
	},
	Outputs =
	{
		Active = "bool",
	},
}
