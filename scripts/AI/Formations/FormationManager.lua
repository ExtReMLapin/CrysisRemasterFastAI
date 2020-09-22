-- FormationManager: defines all the formations descriptors 
-- Created by Luciano Morpurgo - 2005
-- Usage:
-- 

FormationManager = {

}

function FormationManager:OnInit()

	local UNDEFINED = UNIT_CLASS_UNDEFINED;
	local INFANTRY = UNIT_CLASS_INFANTRY;
	local ENGINEER = UNIT_CLASS_ENGINEER;
	local MEDIC = UNIT_CLASS_MEDIC;
	local LEADER = UNIT_CLASS_LEADER;
	local SCOUT = UNIT_CLASS_SCOUT;
	local CIVILIAN = UNIT_CLASS_CIVILIAN;

	AI.CreateFormation("convoy0");
	--AI.AddFormationPointFixed("convoy0",0,0,0,0,LEADER);
	AI.AddFormationPoint("convoy0",90,20,4,UNDEFINED,25,3.0);
	AI.AddFormationPoint("convoy0",-90,20,-4,ENGINEER,25,-3.0);
	AI.AddFormationPoint("convoy0",90,40,4,UNDEFINED,45,3.0);
	AI.AddFormationPoint("convoy0",-90,40,-4,UNDEFINED,45,-3.0);
	AI.AddFormationPoint("convoy0", 90,60,4,UNDEFINED,65,3.0);
	AI.AddFormationPoint("convoy0",-90,60,-4,UNDEFINED,65,-3.0);
	AI.AddFormationPoint("convoy0", 180,70,4,UNDEFINED,70,3.0);

	AI.CreateFormation("convoy1");
	AI.AddFormationPoint("convoy1",90,20,4.5,UNDEFINED);
	AI.AddFormationPoint("convoy1",-90,20,-4.5,ENGINEER);
	AI.AddFormationPoint("convoy1",90,30,4.5,UNDEFINED);
	AI.AddFormationPoint("convoy1",-90,30,-4.5,UNDEFINED);
--	AI.AddFormationPoint("convoy1",0,23,0,UNDEFINED,25,3.0);




	AI.CreateFormation("wedge_follow");
	--AI.AddFormationPointFixed("wedge_follow",0,0,0,0,LEADER);
	AI.AddFormationPoint("wedge_follow",-20,2,-2,ENGINEER+INFANTRY);
	AI.AddFormationPoint("wedge_follow",20,2,2,ENGINEER+INFANTRY);
	AI.AddFormationPoint("wedge_follow",-20,4,-4,INFANTRY);
	AI.AddFormationPoint("wedge_follow",20,4,4,INFANTRY);
	AI.AddFormationPointFixed("wedge_follow",0,-0.5,2,0,SPECIAL_FORMATION_POINT);
	AI.AddFormationPoint("wedge_follow",0,2.5,0,CIVILIAN);
	AI.AddFormationPoint("wedge_follow",0,4,0,CIVILIAN);
	AI.AddFormationPoint("wedge_follow",0,5.5,0,CIVILIAN);

	AI.CreateFormation("line_follow3");
	--AI.AddFormationPointFixed("line_follow",0,0,0,0,LEADER);
	AI.AddFormationPoint("line_follow3",-45,3,0);
	AI.AddFormationPoint("line_follow3",45,6,0);
	AI.AddFormationPoint("line_follow3",0,9,0);

	AI.CreateFormation("line_follow3_extended");
	AI.AddFormationPoint("line_follow3_extended",-45,4,1);
	AI.AddFormationPoint("line_follow3_extended",45,8,-1);
	AI.AddFormationPoint("line_follow3_extended",0,12,1);

	AI.CreateFormation("line_follow5");
	--AI.AddFormationPointFixed("line_follow",0,0,0,0,LEADER);
	AI.AddFormationPoint("line_follow5",-45,3,0);
	AI.AddFormationPoint("line_follow5",45,6,0);
	AI.AddFormationPoint("line_follow5",45,9,0);
	AI.AddFormationPoint("line_follow5",45,12,0);
	AI.AddFormationPoint("line_follow5",0,15,0);
	AI.AddFormationPointFixed("line_follow5",170,-0.5,2,0,SPECIAL_FORMATION_POINT);

	AI.CreateFormation("line_follow5_extended");
	AI.AddFormationPoint("line_follow5_extended",-45,4,1);
	AI.AddFormationPoint("line_follow5_extended",45,8,-1);
	AI.AddFormationPoint("line_follow5_extended",45,12,1);
	AI.AddFormationPoint("line_follow5_extended",45,16,-1);
	AI.AddFormationPoint("line_follow5_extended",0,20,1);
	AI.AddFormationPointFixed("line_follow5_extended",170,-0.5,2,0,SPECIAL_FORMATION_POINT);

	AI.CreateFormation("line_follow8");
	--AI.AddFormationPointFixed("line_follow",0,0,0,0,LEADER);
	AI.AddFormationPoint("line_follow8",-45,3,0);
	AI.AddFormationPoint("line_follow8",45,6,0);
	AI.AddFormationPoint("line_follow8",45,9,0);
	AI.AddFormationPoint("line_follow8",45,12,0);
	AI.AddFormationPoint("line_follow8",45,15,0);
	AI.AddFormationPoint("line_follow8",45,18,0);
	AI.AddFormationPoint("line_follow8",45,21,0);
	AI.AddFormationPoint("line_follow8",0,24,0);

	AI.CreateFormation("line_follow8_extended");
	AI.AddFormationPoint("line_follow8_extended",-45,4,1);
	AI.AddFormationPoint("line_follow8_extended",45,8,-1);
	AI.AddFormationPoint("line_follow8_extended",45,12,1);
	AI.AddFormationPoint("line_follow8_extended",45,16,-1);
	AI.AddFormationPoint("line_follow8_extended",45,20,1);
	AI.AddFormationPoint("line_follow8_extended",45,24,-1);
	AI.AddFormationPoint("line_follow8_extended",45,28,1);
	AI.AddFormationPoint("line_follow8_extended",0,32,-1);

--	AI.CreateFormation("line_follow2");
--	AI.AddFormationPoint("line_follow2",0,2.5,0,CIVILIAN);
--	AI.AddFormationPoint("line_follow2",45,4,0,CIVILIAN);
--	AI.AddFormationPoint("line_follow2",-45,5.5,0,CIVILIAN);
--	AI.AddFormationPointFixed("line_follow2",170,-0.5,2,0,SPECIAL_FORMATION_POINT);

	AI.CreateFormation("jungle_wedge");
	AI.AddFormationPoint("jungle_wedge",0,3,-3);
	AI.AddFormationPoint("jungle_wedge",0,3,3);
	AI.AddFormationPoint("jungle_wedge",0,6,-6);
	AI.AddFormationPoint("jungle_wedge",0,6,6);
	AI.AddFormationPoint("jungle_wedge",-45,9,-12);
	AI.AddFormationPoint("jungle_wedge",45,9,12);

	AI.CreateFormation("wedge");
	AI.AddFormationPointFixed("wedge",0,3,-3,0,UNDEFINED);
	AI.AddFormationPointFixed("wedge",0,-3,-3,0,UNDEFINED);
	AI.AddFormationPointFixed("wedge",0,5,-5,0,UNDEFINED);
	AI.AddFormationPointFixed("wedge",0,-5,-5,0,UNDEFINED);


	AI.CreateFormation("wedge_rev");
	AI.AddFormationPointFixed("wedge_rev",0,3,3,0,INFANTRY);
	AI.AddFormationPointFixed("wedge_rev",0,-3,3,0,INFANTRY);
	AI.AddFormationPointFixed("wedge_rev",0,5,5,0,UNDEFINED);
	AI.AddFormationPointFixed("wedge_rev",0,-5,5,0,UNDEFINED);
	AI.AddFormationPointFixed("wedge_rev",0,0,-5,0,CIVILIAN);
	AI.AddFormationPointFixed("wedge_rev",0,1,2,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,-1,2,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,2,0,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,-2,0,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,3.5,0,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,-3.5,0,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,5,1.5,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,-5,1.5,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("wedge_rev",0,0,2,0,SPECIAL_FORMATION_POINT);

	AI.CreateFormation("squad_indoor_combat");
	AI.AddFormationPointFixed("squad_indoor_combat",0,2,0,0,INFANTRY);
	AI.AddFormationPointFixed("squad_indoor_combat",0,-2,0,0,INFANTRY);
	AI.AddFormationPointFixed("squad_indoor_combat",0,1,2,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("squad_indoor_combat",0,-1,2,0,SHOOTING_SPOT_POINT);
	AI.AddFormationPointFixed("squad_indoor_combat",0,3,0,CIVILIAN);
	AI.AddFormationPointFixed("squad_indoor_combat",0,5,0,CIVILIAN);
	AI.AddFormationPointFixed("squad_indoor_combat",0,0,2,0,SPECIAL_FORMATION_POINT);

	AI.CreateFormation("squad_indoor_follow");
	AI.AddFormationPoint("squad_indoor_follow",0,2,0,INFANTRY);
	AI.AddFormationPoint("squad_indoor_follow",0,6,0,INFANTRY);
	AI.AddFormationPoint("squad_indoor_follow",0,4,0,CIVILIAN);
	AI.AddFormationPointFixed("squad_indoor_follow",0,0,2,0,SPECIAL_FORMATION_POINT);


		
	AI.CreateFormation("row2");
	AI.AddFormationPointFixed("row2",0,1.2,1,0,UNDEFINED);
	AI.AddFormationPointFixed("row2",0,-1.2,1,0,UNDEFINED);
	
	AI.CreateFormation("rowTest");
	AI.AddFormationPointFixed("rowTest",-45,-3,1,0,UNDEFINED);
	AI.AddFormationPointFixed("rowTest",-45,-6,1,0,UNDEFINED);	
	AI.AddFormationPointFixed("rowTest",-45,-9,1,0,UNDEFINED);	
	AI.AddFormationPointFixed("rowTest",-45,-12,1,0,UNDEFINED);	
	AI.AddFormationPointFixed("rowTest",-45,-15,1,0,UNDEFINED);	
	AI.AddFormationPointFixed("rowTest",-45,3,1,0,UNDEFINED);

	AI.CreateFormation("boxTest");
	AI.AddFormationPointFixed("boxTest",-45,-3,3,0,UNDEFINED);
	AI.AddFormationPointFixed("boxTest",-45,-4,-2,0,UNDEFINED);	
	AI.AddFormationPointFixed("boxTest",-45,3,3,0,UNDEFINED);	
	AI.AddFormationPointFixed("boxTest",-45,4,-2,0,UNDEFINED);	
	
	AI.CreateFormation("trooper_patrol");
	--AI.AddFormationPointFixed("convoy0",0,0,0,0,LEADER);
	AI.AddFormationPoint("trooper_patrol",90,3,4,UNDEFINED,25,3.0);
	AI.AddFormationPoint("trooper_patrol",-90,3,-4,UNDEFINED,25,-3.0);
	AI.AddFormationPoint("trooper_patrol",90,6,4,UNDEFINED,45,3.0);
	AI.AddFormationPoint("trooper_patrol",-90,6,-4,UNDEFINED,45,-3.0);
	AI.AddFormationPoint("trooper_patrol", 90,9,4,UNDEFINED,65,3.0);
	AI.AddFormationPoint("trooper_patrol",-90,9,-4,UNDEFINED,65,-3.0);
	AI.AddFormationPoint("trooper_patrol", 180,10,0,LEADER,70,3.0);

	AI.CreateFormation("alien_escort");
	AI.AddFormationPoint("alien_escort",0,0.1,-4);
	AI.AddFormationPoint("alien_escort",0,0.1, 4);
	AI.AddFormationPoint("alien_escort",0,9,-4);
	AI.AddFormationPoint("alien_escort",0,9, 4);

	AI.CreateFormation("alien_escort2");
	AI.AddFormationPointFixed("alien_escort2",-45,-5, 5,0,UNDEFINED);
	AI.AddFormationPointFixed("alien_escort2",-45,-5,-5,0,UNDEFINED);	
	AI.AddFormationPointFixed("alien_escort2",-45, 5, 5,0,UNDEFINED);	
	AI.AddFormationPointFixed("alien_escort2",-45, 5,-5,0,UNDEFINED);	

	AI.CreateFormation("attack_surround1");
	AI.AddFormationPointFixed("attack_surround1",0,0,2,0,SPECIAL_FORMATION_POINT);
	AI.AddFormationPointFixed("attack_surround1",0,-8, 3,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0, 8, 3,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0,-6, 6,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0, 6, 6,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0,-2, 7,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0, 2, 7,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0,-5, 9,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, 5, 9,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0,-7, 5,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0, 7, 5,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0,-8, 0,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0, 8, 0,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0,-5, 12,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, 5, 12,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, 8, 14,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, -8, 14,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, -1.5, 18,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, 1.5, 18,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, -7, 15,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, 7, 15,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0,-4,-6,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround1",0, 4,-6,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0,-1,-8,0,UNDEFINED);
--	AI.AddFormationPointFixed("attack_surround1",0, 1,-8,0,UNDEFINED);

	AI.CreateFormation("attack_surround_chase");
	AI.AddFormationPointFixed("attack_surround_chase",0,-8, 3,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0, 8, 3,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0,-6, 6,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0, 6, 6,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0,-5, 9,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0, 5, 9,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0,-7, 5,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0, 7, 5,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0,-8, 0,0,UNDEFINED);
	AI.AddFormationPointFixed("attack_surround_chase",0, 8, 0,0,UNDEFINED);
	
	
	AI.LogEvent("FORMATIONS LOADED");
end