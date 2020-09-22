Light =
{
	Properties =
	{
		_nVersion = -1,
		bActive = 1,
		Radius = 10,
		Style =
		{
			nLightStyle = 0,
			Rotation = {x=0.0,y=0.0,z=0.0},
			fAnimationSpeed = 1,
			nAnimationPhase = 0,
			fCoronaScale = 1,
			fCoronaDistSizeFactor = 1,
			fCoronaDistIntensityFactor = 1,
			texture_AttenuationMap = "",
		},
		Projector =
		{
			texture_Texture = "",
			bProjectInAllDirs = 0,
			fProjectorFov = 90,
			fProjectorNearPlane = 0,
			nBeamSlicesCount = 0,
		},
		Color = {
			clrDiffuse = { x=1,y=1,z=1 },
			fDiffuseMultiplier = 1,
			fSpecularMultiplier = 1,
			fHDRDynamic = 0,		-- -1=darker..0=normal..1=brighter
		},
		Options = {
			bCastShadow = 0,
			nCastShadows = 0,
			fShadowBias = 1, --[0,1000,1,"Moves the shadow cascade toward or away from the shadow-casting object."]
			fShadowSlopeBias = 1, --[0,1000,1,"Allows you to adjust the gradient (slope-based) bias used to compute the shadow bias."]
			bAffectsThisAreaOnly = 1,
			bIgnoresVisAreas = 0,
			--bUsedInRealTime = 1,
			bDeferredLight = 1,
			bAmbientLight = 0,
			bNegativeLight=0,
			bFakeLight=0,
			bDeferredClipBounds = 0,
			bIrradianceVolumes = 0,
			texture_deferred_cubemap = "",
			file_deferred_clip_geom = "",
			nPostEffect=0, -- 0=none, 1= screen space light shaft, 2= flare, 3= volume desaturation ?			
		},
	},

	Editor=
	{
		Model="Editor/Objects/Light_Omni.cgf",
		--Icon="Light.tif",
		Icon="Light.bmp",
		ShowBounds=0,
		AbsoluteRadius = 1,
		IsScalable = false;
	},

	_LightTable = {},
}

LightSlot = 1

function Light:OnInit()
	--self:NetPresent(0);
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
	self:OnReset();
	self:CacheResources("Light.lua");
end

function Light:CacheResources(requesterName)
	local textureFlags = 0;
	if (self.Properties.Projector.bProjectInAllDirs ~= 0 and self.Properties.Options.bDeferredLight ~= 0) then
		textureFlags = eGameCacheResourceFlag_TextureReplicateAllSides;
	end
	Game.CacheResource(requesterName, self.Properties.Projector.texture_Texture, eGameCacheResourceType_Texture, textureFlags);
	
	textureFlags = eGameCacheResourceFlag_TextureNoStream;
	Game.CacheResource(requesterName, self.Properties.Style.texture_AttenuationMap, eGameCacheResourceType_Texture, textureFlags);
	
	Game.CacheResource(requesterName, self.Properties.Options.texture_deferred_cubemap, eGameCacheResourceType_TextureDeferredCubemap, 0);
	Game.CacheResource(requesterName, self.Properties.Options.file_deferred_clip_geom, eGameCacheResourceType_StaticObject, 0);
end

function Light:OnShutDown()
	self:FreeSlot(LightSlot);
end

function Light:OnLoad(props)
	self:OnReset()
	self:ActivateLight(props.bActive)
end

function Light:OnSave(props)
	props.bActive = self.bActive
end

function Light:OnPropertyChange()
	self:OnReset();
	self:ActivateLight( self.bActive );
	if (self.Properties.Options.bDeferredClipBounds) then
		self:UpdateLightClipBounds(LightSlot);
	end
end

function Light:OnLevelLoaded()
	if (self.Properties.Options.bDeferredClipBounds) then
		self:UpdateLightClipBounds(LightSlot);
	end
end

function Light:OnReset()
	if (self.bActive ~= self.Properties.bActive) then
		self:ActivateLight( self.Properties.bActive );
	end
end

function Light:ActivateLight( enable )
	if (enable and enable ~= 0) then
		self.bActive = 1;
		self:LoadLightToSlot(LightSlot);
		self:ActivateOutput( "Active",true );
	else
		self.bActive = 0;
		self:FreeSlot(LightSlot);
		self:ActivateOutput( "Active",false );
	end
end

function Light:LoadLightToSlot( nSlot )
	local props = self.Properties;
	local Style = props.Style;
	local Projector = props.Projector;
	local Color = props.Color;
	local Options = props.Options;

	local diffuse_mul = Color.fDiffuseMultiplier;
	local specular_mul = Color.fSpecularMultiplier;
	
	local lt = self._LightTable;
	lt.style = Style.nLightStyle;
	lt.corona_scale = Style.fCoronaScale;
	lt.corona_dist_size_factor = Style.fCoronaDistSizeFactor;
	lt.corona_dist_intensity_factor = Style.fCoronaDistIntensityFactor;
	lt.rotation = Style.Rotation;
	lt.anim_speed = Style.fAnimationSpeed;
	lt.anim_phase = Style.nAnimationPhase;
	lt.attenuation_map = Style.texture_AttenuationMap;
	
	lt.beamslices = Projector.nBeamSlicesCount;
	
	lt.radius = props.Radius;
	lt.diffuse_color = { x=Color.clrDiffuse.x*diffuse_mul, y=Color.clrDiffuse.y*diffuse_mul, z=Color.clrDiffuse.z*diffuse_mul };
	if (diffuse_mul ~= 0) then
		lt.specular_multiplier = specular_mul / diffuse_mul;
	else
		lt.specular_multiplier = 1;
	end

	lt.hdrdyn = Color.fHDRDynamic;
	lt.projector_texture = Projector.texture_Texture;
	lt.proj_fov = Projector.fProjectorFov;
	lt.proj_nearplane = Projector.fProjectorNearPlane;
	lt.cubemap = Projector.bProjectInAllDirs;
	lt.this_area_only = Options.bAffectsThisAreaOnly;
	lt.hasclipbound = Options.bDeferredClipBounds;
	lt.ignore_visareas = Options.bIgnoresVisAreas;
	lt.realtime = Options.bUsedInRealTime;
	lt.fake = Options.bFakeLight;
	lt.deferred_light = Options.bDeferredLight;
	lt.post_effect = Options.nPostEffect;
	lt.irradiance_volumes = Options.bIrradianceVolumes;
	lt.ambient_light = props.Options.bAmbientLight;		
	lt.negative_light = props.Options.bNegativeLight;
	lt.indoor_only = 0;
	lt.has_cbuffer = 0;
	lt.cast_shadow = Options.nCastShadows;
	lt.shadow_bias = Options.fShadowBias;
	lt.shadow_slope_bias = Options.fShadowSlopeBias;
	lt.deferred_cubemap = Options.texture_deferred_cubemap;
	lt.deferred_geom = Options.file_deferred_clip_geom;
		
	lt.lightmap_linear_attenuation = 1;
	lt.is_rectangle_light = 0;
	lt.is_sphere_light = 0;
	lt.area_sample_number = 1;

	self:LoadLight( nSlot,lt );
end

function Light:Event_Enable()
	if (self.bActive == 0) then
		self:ActivateLight( 1 );
	end
end

function Light:Event_Disable()
	if (self.bActive == 1) then
		self:ActivateLight( 0 );
	end
end

-----------------------------------------------------
function Light:OnNanoSuitDischarge()
	self:Event_Disable();
end

----------------------------------------------------
function Light:OnTouchedByNanoWeapon()
	self:Event_Enable();
end

------------------------------------------------------------------------------------------------------
-- Event Handlers
------------------------------------------------------------------------------------------------------
function Light:Event_Active( bActive )
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
Light.FlowEvents =
{
	Inputs =
	{
		Active = { Light.Event_Active,"bool" },
		Enable = { Light.Event_Enable,"bool" },
		Disable = { Light.Event_Disable,"bool" },
	},
	Outputs =
	{
		Active = "bool",
	},
}
