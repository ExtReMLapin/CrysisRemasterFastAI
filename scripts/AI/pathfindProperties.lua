function AssignPFPropertiesToPathType(...)
	AI.AssignPFPropertiesToPathType(...);
	if (System.IsEditor() and EditorAI) then
		EditorAI.AssignPFPropertiesToPathType(...);
	end
end

--- character that travels on the surface but has no preferences - except it prefers to walk around
--- hills rather than over them
AssignPFPropertiesToPathType(
	"AIPATH_DEFAULT",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0, 
	5.0, 0.5, -10000.0, 0.0, 20.0, 7.0,
	0, 0.4, 2, 45, 7, true);

-- Default properties for humans
AssignPFPropertiesToPathType(
	"AIPATH_HUMAN",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0,
	5.0, 0.5, -10000.0, 0.0, 20.0, 7.0,
	0, 0.4, 2, 45, 1, true);

AssignPFPropertiesToPathType(
	"AIPATH_HUMAN_COVER",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0,
	5.0, 0.5, -10000.0, 10.0, 20.0, 7.0,
	0, 0.4, 2, 45, 1, true);

-- Default properties for car/vehicle agents
AssignPFPropertiesToPathType(
	"AIPATH_CAR",
	NAV_TRIANGULAR + NAV_ROAD, 
	18.0, 18.0, 0.0, 0.0, 0.0, 
	0.0, 1.5, -10000.0, 0.0, 0.0, 7.0,
	0, 0.3, 2.0, 0.0, 5, true);

AssignPFPropertiesToPathType(
	"AIPATH_TANK",
	NAV_TRIANGULAR + NAV_ROAD, 
	18.0, 18.0, 0.0, 0.0, 0.0, 
	0.0, 1.5, -10000.0, 0.0, 0.0, 7.0,
	0, 0.3, 2.0, 0.0, 6, true);

AssignPFPropertiesToPathType(
	"AIPATH_BOAT",
	NAV_TRIANGULAR + NAV_ROAD, 
	0.0, 0.0, 0.0, 0.0, 0.0, 
	0.0, 10000, 1.5, 0.0, 0.0, 0.0,
	0, 0.3, 2.0, 0.0, 5, true);

AssignPFPropertiesToPathType(
	"AIPATH_HELI",
	NAV_FLIGHT + NAV_SMARTOBJECT, 
	0.0, 0.0, 0.0, 0.0, 0.0, 
	0.0, 0.0, 0.0, 0.0, 0.0, 1.0,
	0, 0.3, 2.0, 0.0, 5, true);

-- Properties for aliens
AssignPFPropertiesToPathType(
	"AIPATH_3D",
	NAV_VOLUME + NAV_SMARTOBJECT + NAV_ROAD,
	0.0, 0.0, 0.0, 0.0, 0.0,
	0.0, 0.0, 0.0, 0.0, 0.0, 1.0,
	0, 0.4, 2, 45, 1, true);

AssignPFPropertiesToPathType(
	"AIPATH_SCOUT",
	NAV_FLIGHT + NAV_VOLUME + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0,
	0.0, 0.0, 0.0, 0.0, 0.0, 1.0,
	0, 0.4, 2, 45, 1, true);

AssignPFPropertiesToPathType(
	"AIPATH_TROOPER",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 5.0, 0.0,
	5.0, 10000.0, -10000.0, 10.0, 20.0, 7.0,
	0, 0.4, 2, 45, 1, true);

AssignPFPropertiesToPathType(
	"AIPATH_HUNTER",
	NAV_FREE_2D,
	0.0, 0.0, 0.0, 0.0, 0.0,
	0.0, 0.0, 0.0, 0.0, 0.0, 1.0,
	0, 0.4, 2, 45, 1, true);
