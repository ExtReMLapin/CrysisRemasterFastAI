-- register explosion and crack shapes
Log("registering explosion and shapes with physics system...");

local folder = "objects/prototype/breakable/";


-- for now only have one material id, later, we should make a list of materialIds
-- and register the shapes accordingle, ex:
-- 0 -- concrete
-- 1 -- wood
--Physics.RegisterExplosionShape(folder.."explosionb.cgf", 1, 0, 1, "",0,"");
--Physics.RegisterExplosionShape(folder.."explosion_shipdoor.cgf", 13, 1, 1);
Physics.RegisterExplosionShape("Objects/Natural/Trees/Explosion_shape/tree_broken_shape.cgf", 7, 2, 1, "",0,"");
Physics.RegisterExplosionShape("Objects/Natural/Trees/Explosion_shape/tree_broken_shape2.cgf", 1.3, 3, 1, 
	"",0,"");
Physics.RegisterExplosionShape("Objects/Library/Alien/Generic_Elements/Spikes/alien_breakable_spikes_explosionshape.cgf", 1.3, 4, 1, "",0,"");
Physics.RegisterExplosionShape("Objects/Natural/Trees/Explosion_shape/tree_broken_shape3.cgf", 1.3, 5, 1, 
	--"",0,"");
  "objects/natural/trees/explosion_shape/trunk_slpinters_a.cgf",1.6,"breakable_objects.tree_break.small");
--Physics.RegisterExplosionShape("Objects/_Prototype/Breakable_Building/procedural_brekable_building/concrete_explosionshape.cgf", 1.3, 6, 1, "",0,"");
