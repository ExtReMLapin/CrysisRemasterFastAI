----------------------------------------------------------------------------------------------------
--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.
----------------------------------------------------------------------------------------------------
--  $Id$
--  $DateTime$
--  Description: Implements the HUD Events!
--
----------------------------------------------------------------------------------------------------
--  History:
--  - 25:4:2005   12:15 : Created by Márcio Martins
--
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
function HUD:OnSound(pos, radius, soundId)
	local radar = HUD:GetScreen("default").radar;
	
	if (soundId) then
		local sounder = System.GetEntity(soundId);
		
		if (sounder == g_localActor) then
			return;
		end
	end
	
	if (radar) then
		radar:PushSound(pos, radius);
	end
end


----------------------------------------------------------------------------------------------------
function HUD:OnContact(entity, name)
	local radar = HUD:GetScreen("default").radar;
	
	if (radar) then
		radar:PushContact(entity, name);
	end	
end