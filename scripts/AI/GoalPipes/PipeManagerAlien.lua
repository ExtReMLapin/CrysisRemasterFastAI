--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: alein goal pipes
--  
--------------------------------------------------------------------------
--  History:
--  - 2/12/2004   : Created by Kirill Bulatsev
--  - 4/4/2005    : CXP Rush Clean up by Mikko Mononen
--  - 5/4/2005    : Added Scout pipes.
--
--------------------------------------------------------------------------

function PipeManager:OnInitAlien()

		--------------------------------------------------------------------------
		-- Scout
		--

		--------------------------------------------------------------------------
		-- for Scout Attack2.lua
	
			AI.CreateGoalPipe("scoutAttackWait");
			AI.PushGoal("scoutAttackWait","run",0,1);	
			AI.PushGoal("scoutAttackWait","locate",0,"refpoint");		
			AI.PushGoal("scoutAttackWait","approach",0,3.0,AILASTOPRES_USE,-1);
			AI.PushGoal("scoutAttackWait","timeout",1,0.5);
			AI.PushGoal("scoutAttackWait","run",0,0);	
			AI.PushGoal("scoutAttackWait","signal",0,1,"SC_SCOUT_STAY_ATTACK",SIGNALFILTER_SENDER);

			AI.CreateGoalPipe("scoutAttackStandByV4");
			AI.PushGoal("scoutAttackStandByV4","run",0,0);
			AI.PushGoal("scoutAttackStandByV4","approach",0,3.0,AILASTOPRES_USE,-1);
			AI.PushGoal("scoutAttackStandByV4","timeout",1,3);
			AI.PushGoal("scoutAttackStandByV4","run",0,0);
			AI.PushGoal("scoutAttackStandByV4","signal",0,1,"SC_SCOUT_STAY_ATTACK",SIGNALFILTER_SENDER);

			AI.CreateGoalPipe("scoutAttackStandByV3");
			AI.PushGoal("scoutAttackStandByV3","run",0,0);
			AI.PushGoal("scoutAttackStandByV3","approach",0,3.0,AILASTOPRES_USE,-1);
			AI.PushGoal("scoutAttackStandByV3","firecmd",0,FIREMODE_FORCED);
			AI.PushGoal("scoutAttackStandByV3","timeout",1,3);
			AI.PushGoal("scoutAttackStandByV3","firecmd",0,0);
			AI.PushGoal("scoutAttackStandByV3","timeout",1,0.3);
			AI.PushGoal("scoutAttackStandByV3","signal",0,1,"SC_SCOUT_STAY_ATTACK",SIGNALFILTER_SENDER);

			AI.CreateGoalPipe("scoutAttackStandByV2");
			AI.PushGoal("scoutAttackStandByV2","run",0,0);		
			AI.PushGoal("scoutAttackStandByV2","firecmd",0,FIREMODE_FORCED);
			AI.PushGoal("scoutAttackStandByV2","locate",0,"refpoint");		
			AI.PushGoal("scoutAttackStandByV2","approach",0,3.0,AILASTOPRES_USE,-1);
			AI.PushGoal("scoutAttackStandByV2","timeout",1,3);
			AI.PushGoal("scoutAttackStandByV2","firecmd",0,0);
			AI.PushGoal("scoutAttackStandByV2","timeout",1,0.3);
			AI.PushGoal("scoutAttackStandByV2","signal",0,1,"SC_SCOUT_STAY_ATTACK",SIGNALFILTER_SENDER);

			AI.CreateGoalPipe("scoutAttackStandBy");
			AI.PushGoal("scoutAttackStandBy","run",0,1);		
			AI.PushGoal("scoutAttackStandBy","locate",0,"refpoint");		
			AI.PushGoal("scoutAttackStandBy","approach",0,5.0,AILASTOPRES_USE,-1);
			AI.PushGoal("scoutAttackStandBy","signal",0,1,"SC_SCOUT_CHECK_ATTACK",SIGNALFILTER_SENDER);
			AI.PushGoal("scoutAttackStandBy","timeout",1,0.3);
			AI.PushGoal("scoutAttackStandBy","branch",1,-2);
			AI.PushGoal("scoutAttackStandBy","run",0,0);
			AI.PushGoal("scoutAttackStandBy","signal",0,1,"SC_SCOUT_STAY_ATTACK",SIGNALFILTER_SENDER);

			AI.CreateGoalPipe("scoutCheckAttack");
			AI.PushGoal("scoutCheckAttack","continuous",0,1);
			AI.PushGoal("scoutCheckAttack","run",0,1);
			AI.PushGoal("scoutCheckAttack","locate",0,"refpoint");
			AI.PushGoal("scoutCheckAttack","approach",1,5.0,AILASTOPRES_USE,-1);
			AI.PushGoal("scoutCheckAttack","signal",0,1,"SC_SCOUT_CHECK_ATTACK",SIGNALFILTER_SENDER);

			AI.CreateGoalPipe("scoutCheckAttackV2");
			AI.PushGoal("scoutCheckAttackV2","run",0,1);
			AI.PushGoal("scoutCheckAttackV2","firecmd",0,FIREMODE_FORCED);
			AI.PushGoal("scoutCheckAttackV2","locate",0,"refpoint");
			AI.PushGoal("scoutCheckAttackV2","approach",1,5.0,AILASTOPRES_USE,-1);
			AI.PushGoal("scoutCheckAttackV2","timeout",1,1.0);
			AI.PushGoal("scoutCheckAttackV2","firecmd",0,0);
			AI.PushGoal("scoutCheckAttackV2","signal",0,1,"SC_SCOUT_STAY_ATTACK",SIGNALFILTER_SENDER);
	
		--------------------------------------------------------------------------
		AI.CreateGoalPipe("sc_search");
		AI.PushGoal("sc_search","locate",0,"refpoint");		
		AI.PushGoal("sc_search","run",0,1);	
		AI.PushGoal("sc_search","approach",1,4,AILASTOPRES_USE);	
		AI.PushGoal("sc_search","signal",0,1,"SC_FIND_INTERESTING_SPOT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_move_closer");
		AI.PushGoal("sc_move_closer","approach",1,10);	
		AI.PushGoal("sc_move_closer","signal",0,1,"SC_CHOOSE_ATTACK_ACTION",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_search_enemy");
		AI.PushGoal("sc_search_enemy","locate",0,"beacon");
		AI.PushGoal("sc_search_enemy","run",0,1);	
		AI.PushGoal("sc_search_enemy","approach",1,10,AILASTOPRES_USE);	
		AI.PushGoal("sc_search_enemy","signal",0,1,"SC_FIND_INTERESTING_SPOT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_search_land");
		AI.PushGoal("sc_search_land","signal",0,1,"SC_LAND_ADJUST",SIGNALFILTER_SENDER);
		AI.PushGoal("sc_search_land","timeout",1,1 );
		AI.PushGoal("sc_search_land","signal",0,1,"SC_LAND_LANDING",SIGNALFILTER_SENDER);
		AI.PushGoal("sc_search_land","timeout",1,1.8 );
		AI.PushGoal("sc_search_land","signal",0,1,"SC_LAND_INSPECT",SIGNALFILTER_SENDER);
		AI.PushGoal("sc_search_land","timeout",1,4.5 );
		AI.PushGoal("sc_search_land","signal",0,1,"SC_LAND_TAKE_OFF",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_search_takeoff");
		AI.PushGoal("sc_search_takeoff","timeout",1,0.1 );
		AI.PushGoal("sc_search_takeoff","signal",0,1,"SC_LAND_TAKE_OFF_FINAL",SIGNALFILTER_SENDER);
		AI.PushGoal("sc_search_takeoff","timeout",1,1.0 );
		AI.PushGoal("sc_search_takeoff","signal",0,1,"SC_FIND_INTERESTING_SPOT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_search_delay");
		AI.PushGoal("sc_search_delay","timeout",1,3 );
		AI.PushGoal("sc_search_delay","signal",0,1,"SC_FIND_INTERESTING_SPOT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_search_sniff");
		AI.PushGoal("sc_search_sniff","timeout",1,2);
		AI.PushGoal("sc_search_sniff","locate",0,"refpoint");		
		AI.PushGoal("sc_search_sniff","run",0,1);	
		AI.PushGoal("sc_search_sniff","approach",1,5,AILASTOPRES_USE);	
		AI.PushGoal("sc_search_sniff","signal",0,1,"SC_AT_SNIFF_POINT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_search_sniff_delay");
		AI.PushGoal("sc_search_sniff_delay","timeout",1,2);		
		AI.PushGoal("sc_search_sniff_delay","signal",0,1,"SC_SNIFF_PLAYER",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_player_seen_delay");
		AI.PushGoal("sc_player_seen_delay","timeout",1,2 );

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("sc_recoil");
		AI.PushGoal("sc_recoil","firecmd",0,0);	
		AI.PushGoal("sc_recoil","locate",0,"refpoint");		
		AI.PushGoal("sc_recoil","run",0,1);	
		AI.PushGoal("sc_recoil","approach",1,3,AILASTOPRES_USE);	
		AI.PushGoal("sc_recoil","signal",0,1,"GO_RECOIL_DONE",SIGNALFILTER_SENDER);

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("sc_patrol");
		AI.PushGoal("sc_patrol","acqtarget",0,"");		
		AI.PushGoal("sc_patrol","run",0,1);	
		AI.PushGoal("sc_patrol","continuous",0,1);	
		AI.PushGoal("sc_patrol","approach",1,5);	
		AI.PushGoal("sc_patrol","signal",0,1,"SC_NEXT_POINT",SIGNALFILTER_SENDER);	-- get next point in path

		AI.CreateGoalPipe("sc_player_seen_delay_attack");
		AI.PushGoal("sc_player_seen_delay_attack","timeout",1,2);
		AI.PushGoal("sc_player_seen_delay_attack","signal",0,1,"GO_ATTACK",SIGNALFILTER_SENDER);	-- get next point in path

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("sc_exit_delay");
		AI.PushGoal("sc_exit_delay","timeout",1,0.1);	
		AI.PushGoal("sc_exit_delay","signal",0,1,"SC_EXIT_CHECK",SIGNALFILTER_SENDER);

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("sc_escort_approach");
		AI.PushGoal("sc_escort_approach","acqtarget",0,"");		
		AI.PushGoal("sc_escort_approach","run",0,1);	
		AI.PushGoal("sc_escort_approach","approach",1,3);	
		AI.PushGoal("sc_escort_approach","signal",0,1,"SC_NEXT_POINT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_escort_carry");
		AI.PushGoal("sc_escort_carry","acqtarget",0,"");		
		AI.PushGoal("sc_escort_carry","run",0,0);	
		AI.PushGoal("sc_escort_carry","approach",1,3);	
		AI.PushGoal("sc_escort_carry","signal",0,1,"SC_NEXT_POINT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_escort_land");
		AI.PushGoal("sc_escort_land","run",0,0);	
		AI.PushGoal("sc_escort_land","timeout",1,5);	
		AI.PushGoal("sc_escort_land","signal",0,1,"SC_PICKUP",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_escort_pickup");
		AI.PushGoal("sc_escort_pickup","timeout",1,2);	
		AI.PushGoal("sc_escort_pickup","signal",0,1,"SC_NEXT_POINT",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_escort_done");
		AI.PushGoal("sc_escort_done","timeout",1,1);	
		AI.PushGoal("sc_escort_done","signal",0,1,"SC_ESCORT_DONE",SIGNALFILTER_SENDER);

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("sc_alert");
		AI.PushGoal("sc_alert","locate",0,"beacon");		
		AI.PushGoal("sc_alert","acqtarget",0,"");
		AI.PushGoal("sc_alert","run",0,1);	
		AI.PushGoal("sc_alert","approach",1,20);	
		AI.PushGoal("sc_alert","signal",0,1,"GO_SEARCH",SIGNALFILTER_SENDER);	-- get next point in path

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("sc_attack_approach");
		AI.PushGoal("sc_attack_approach","acqtarget",0,"");
		AI.PushGoal("sc_attack_approach","firecmd",0,0);	
		AI.PushGoal("sc_attack_approach","locate",0,"refpoint");		
		AI.PushGoal("sc_attack_approach","run",0,1);	
		AI.PushGoal("sc_attack_approach","approach",1,7,AILASTOPRES_USE);	
--		AI.PushGoal("sc_attack_approach","locate",0,"player");		
--		AI.PushGoal("sc_attack_approach","acqtarget",0,"");
		AI.PushGoal("sc_attack_approach","signal",0,1,"SC_CHOOSE_ATTACK_ACTION",SIGNALFILTER_SENDER);
	
--		AI.CreateGoalPipe("sc_attack_approach");
--		AI.PushGoal("sc_attack_approach","firecmd",0,0);	
--		AI.PushGoal("sc_attack_approach","locate",0,"refpoint");		
--		AI.PushGoal("sc_attack_approach","run",0,1);	
--		AI.PushGoal("sc_attack_approach","approach",1,7,AILASTOPRES_USE);	
--		AI.PushGoal("sc_attack_approach","locate",0,"player");		
--		AI.PushGoal("sc_attack_approach","acqtarget",0,"");
--		AI.PushGoal("sc_attack_approach","signal",0,1,"SC_CHOOSE_ATTACK_ACTION",SIGNALFILTER_SENDER);
	
		-- Run towards the attentionTarget at 1m range, and do the melee.
		AI.CreateGoalPipe("sc_attack_melee");
--		AI.PushGoal("sc_attack_melee","acqtarget",0,"");
		AI.PushGoal("sc_attack_melee","firecmd",0,0);
		AI.PushGoal("sc_attack_melee","run",0,1);	
		AI.PushGoal("sc_attack_melee","locate",0,"refpoint");		
		AI.PushGoal("sc_attack_melee","acqtarget",0,"");
--		AI.PushGoal("sc_attack_melee","stick",1,5,AILASTOPRES_LOOKAT,1);
		AI.PushGoal("sc_attack_melee","stick",1,16,AILASTOPRES_LOOKAT,1);
--		AI.PushGoal("sc_attack_melee","approach",1,5,AILASTOPRES_USE);
		AI.PushGoal("sc_attack_melee","signal",0,1,"SC_MELEE",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_attack_chase");
		AI.PushGoal("sc_attack_chase","acqtarget",0,"");
		AI.PushGoal("sc_attack_chase","firecmd",0,0);
		AI.PushGoal("sc_attack_chase","signal",0,1,"SC_CHASE",SIGNALFILTER_SENDER);
		AI.PushGoal("sc_attack_chase","run",0,1);
		AI.PushGoal("sc_attack_chase","stick",1,20,AILASTOPRES_LOOKAT,1);
--		AI.PushGoal("sc_attack_chase","stick",0,20);
--		AI.PushGoal("sc_attack_chase","timeout",1,5);
		AI.PushGoal("sc_attack_chase","signal",0,1,"SC_CHASE_DONE",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_attack_melee_delay");
		AI.PushGoal("sc_attack_melee_delay","acqtarget",0,"");
		AI.PushGoal("sc_attack_melee_delay","timeout",1,1.1);
		AI.PushGoal("sc_attack_melee_delay","signal",0,1,"SC_MELEE_DONE",SIGNALFILTER_SENDER);
	
--		-- Run towards the attentionTarget at 1m range, and do the melee.
--		AI.CreateGoalPipe("sc_attack_melee");
--		AI.PushGoal("sc_attack_melee","firecmd",0,0);
--		AI.PushGoal("sc_attack_melee","locate",0,"virtual_player");
--		AI.PushGoal("sc_attack_melee","acqtarget",0,"");
--		AI.PushGoal("sc_attack_melee","run",0,1);	
--		AI.PushGoal("sc_attack_melee","stick",1,5,0,1);
--		AI.PushGoal("sc_attack_melee","locate",0,"player");
--		AI.PushGoal("sc_attack_melee","acqtarget",0,"");
--		AI.PushGoal("sc_attack_melee","signal",0,1,"SC_MELEE",SIGNALFILTER_SENDER);
--		AI.PushGoal("sc_attack_melee","timeout",1,1.1);
--		AI.PushGoal("sc_attack_melee","signal",0,1,"SC_MELEE_DONE",SIGNALFILTER_SENDER);

		-- Get steady, aim at attentionTarget and fire.
		AI.CreateGoalPipe("sc_attack_fire");
		AI.PushGoal("sc_attack_fire","acqtarget",0,"");
		AI.PushGoal("sc_attack_fire","signal",1,1,"SC_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("sc_attack_fire","timeout",1,5);	
		AI.PushGoal("sc_attack_fire","signal",0,1,"SC_FIRE_DONE",SIGNALFILTER_SENDER);

		AI.CreateGoalPipe("sc_attack_rapid_fire");
		AI.PushGoal("sc_attack_rapid_fire","acqtarget",0,"");
		AI.PushGoal("sc_attack_rapid_fire","signal",1,1,"SC_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("sc_attack_rapid_fire","timeout",1,4);	
		AI.PushGoal("sc_attack_rapid_fire","signal",0,1,"SC_FIRE_DONE",SIGNALFILTER_SENDER);
		--------------------------------------------------------------------------
		-- Hunter
		--

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_patrol");
--		AI.PushGoal("ht_patrol","acqtarget",0,"");		
--		AI.PushGoal("ht_patrol","signal",0,1,"HT_TAKEOFF",SIGNALFILTER_SENDER);
--		AI.PushGoal("ht_patrol","timeout",1,3);	
--		AI.PushGoal("ht_patrol","signal",0,1,"HT_TAKEOFF_DONE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_patrol","run",0,1);	
		AI.PushGoal("ht_patrol","approach",1,5,1);	
--		AI.PushGoal("ht_patrol","signal",0,1,"HT_LAND",SIGNALFILTER_SENDER);
--		AI.PushGoal("ht_patrol","timeout",1,3);	
--		AI.PushGoal("ht_patrol","signal",0,1,"HT_LAND_DONE",SIGNALFILTER_SENDER);
		--AI.PushGoal("ht_patrol","timeout",1,5);	
		AI.PushGoal("ht_patrol","signal",0,1,"HT_NEXT_POINT",SIGNALFILTER_SENDER);	-- get next point in path

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_patrol_land");
		AI.PushGoal("ht_patrol_land","signal",0,1,"HT_LAND",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_patrol_land","timeout",1,3);	
		AI.PushGoal("ht_patrol_land","signal",0,1,"HT_LAND_DONE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_patrol_land","signal",0,1,"GO_ENEMY_FOUND",SIGNALFILTER_SENDER);	-- get next point in path

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_defend_approach");
		AI.PushGoal("ht_defend_approach","acqtarget",0,"");
		AI.PushGoal("ht_defend_approach","firecmd",0,0);	
		AI.PushGoal("ht_defend_approach","locate",0,"refpoint");		
		AI.PushGoal("ht_defend_approach","signal",0,1,"HT_TAKEOFF",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_approach","timeout",1,3);	
		AI.PushGoal("ht_defend_approach","signal",0,1,"HT_TAKEOFF_DONE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_approach","run",0,1);
		AI.PushGoal("ht_defend_approach","approach",1,9,AILASTOPRES_USE);	
		AI.PushGoal("ht_defend_approach","signal",0,1,"HT_LAND",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_approach","timeout",1,3);	
		AI.PushGoal("ht_defend_approach","signal",0,1,"HT_LAND_DONE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_approach","signal",0,1,"HT_CHOOSE_DEFEND_ACTION",SIGNALFILTER_SENDER);
	
		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_defend_fire");
		AI.PushGoal("ht_defend_fire","acqtarget",0,"");
		AI.PushGoal("ht_defend_fire","signal",1,1,"HT_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_fire","timeout",1,3);	
		AI.PushGoal("ht_defend_fire","signal",1,1,"HT_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_fire","timeout",1,3);	
		AI.PushGoal("ht_defend_fire","signal",1,1,"HT_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_fire","timeout",1,3);	
		AI.PushGoal("ht_defend_fire","signal",0,1,"HT_FIRE_DONE",SIGNALFILTER_SENDER);

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_defend_assault");
		AI.PushGoal("ht_defend_assault","acqtarget",0,"");
		AI.PushGoal("ht_defend_assault","firecmd",0,0);	
		AI.PushGoal("ht_defend_assault","locate",0,"refpoint");		
		AI.PushGoal("ht_defend_assault","signal",1,1,"HT_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_assault","run",0,1);
		AI.PushGoal("ht_defend_assault","approach",1,22,AILASTOPRES_USE);	
		AI.PushGoal("ht_defend_assault","signal",1,1,"HT_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_assault","approach",1,9,AILASTOPRES_USE);	
		AI.PushGoal("ht_defend_assault","signal",1,1,"HT_FIRE",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_assault","signal",0,1,"HT_ASSAULT_DONE",SIGNALFILTER_SENDER);

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_defend_shoot");
		AI.PushGoal("ht_defend_shoot","signal",1,1,"HT_SHOOT",SIGNALFILTER_SENDER);
		AI.PushGoal("ht_defend_shoot","timeout",1,4);	

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_lookaround");
		AI.PushGoal("ht_lookaround","lookat",0,-150,-210);
		AI.PushGoal("ht_lookaround","timeout",1,25,30);
		AI.PushGoal("ht_lookaround","clear",1);
		AI.PushGoal("ht_lookaround","signal",0,1,"HT_END_LOOK_AROUND",0);
		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ht_takeoff_and_drop");
		AI.PushGoal("ht_takeoff_and_drop","locate",1,"refpoint");
		AI.PushGoal("ht_takeoff_and_drop","approach",1,1,AILASTOPRES_USE);
		AI.PushGoal("ht_takeoff_and_drop","signal",0,1,"DROP_OBJECT",SIGNALFILTER_SENDER);
	
		--------------------------------------------------------------------------
		-- Observer
		--

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("ob_roam_covers");
		AI.PushGoal("ob_roam_covers","locate",0,"hidepoint",50);
		AI.PushGoal("ob_roam_covers","run",0,0);
		AI.PushGoal("ob_roam_covers","acqtarget",1,"");
		AI.PushGoal("ob_roam_covers","pathfind",1,"");
		AI.PushGoal("ob_roam_covers","trace",1,1);
		AI.PushGoal("ob_roam_covers","clear",0,1);
		AI.PushGoal("ob_roam_covers","signal",1,1,"END_ROAMING",0);
	
		--------------------------------------------------------------------------
		-- Stick near the enemy, and broadcast its position every 2 secs.
		AI.CreateGoalPipe("ob_stick_to_target");
		AI.PushLabel("ob_stick_to_target","STICK_LOOP");
		AI.PushGoal("ob_stick_to_target","branch",1,"WAYPOINT",IF_NAV_WAYPOINT_HUMAN);
		AI.PushGoal("ob_stick_to_target","stick",0,10);
		AI.PushGoal("ob_stick_to_target","branch",1,"TIMEOUT",BRANCH_ALWAYS);
		AI.PushLabel("ob_stick_to_target","WAYPOINT");
		AI.PushGoal("ob_stick_to_target","stick",0,5);
		AI.PushLabel("ob_stick_to_target","TIMEOUT");
		AI.PushGoal("ob_stick_to_target","timeout",1,2);
		AI.PushGoal("ob_stick_to_target","clear",0,0); -- kill the stick
		AI.PushGoal("ob_stick_to_target","branch",1,"STICK_LOOP",IF_PATH_LONGER,10);
		AI.PushGoal("ob_stick_to_target","signal",1,1,"BROADCAST_ENEMY_POS",0);
		AI.PushLabel("ob_stick_to_target","NO_BROADCAST");
		AI.PushGoal("ob_stick_to_target","branch",1,"STICK_LOOP",BRANCH_ALWAYS);
	
		AI.CreateGoalPipe("ob_not_so_random_hide_from");
		AI.PushGoal("ob_not_so_random_hide_from","timeout",1,0.2);
		AI.PushGoal("ob_not_so_random_hide_from","acqtarget",1,"");
		AI.PushGoal("ob_not_so_random_hide_from","run",0,1);
		AI.PushGoal("ob_not_so_random_hide_from","hide",1,10,HM_NEAREST,1);
		AI.PushGoal("ob_not_so_random_hide_from","run",0,0);
		AI.PushGoal("ob_not_so_random_hide_from","signal",1,1,"HIDE_DONE",0);
		-- the hide result will be send delayed back to the caller state
		AI.PushGoal("ob_not_so_random_hide_from","branch",0,"SIGNAL_SUCCESS",IF_CAN_HIDE);
		AI.PushGoal("ob_not_so_random_hide_from","timeout",1,0.2,0.5);
		AI.PushGoal("ob_not_so_random_hide_from","signal",1,1,"HIDE_FAILED",0);
		AI.PushLabel("ob_not_so_random_hide_from","SIGNAL_SUCCESS");
		AI.PushGoal("ob_not_so_random_hide_from","timeout",1,0.3,0.5);
		AI.PushGoal("ob_not_so_random_hide_from","signal",1,1,"HIDE_SUCCEED",0);
	
		AI.CreateGoalPipe("ob_random_hide");
		AI.PushGoal("ob_random_hide","timeout",1,0.2);
		AI.PushGoal("ob_random_hide","firecmd",0,0);
		AI.PushGoal("ob_random_hide","run",0,1);
		AI.PushGoal("ob_random_hide","hide",1,10,HM_RANDOM,1);
		AI.PushGoal("ob_random_hide","run",0,0);
		AI.PushGoal("ob_random_hide","signal",1,1,"HIDE_DONE",0);
		-- the hide result will be send delayed back to the caller state
		AI.PushGoal("ob_random_hide","branch",0,"SIGNAL_SUCCESS",IF_CAN_HIDE);
		AI.PushGoal("ob_random_hide","timeout",1,0.3,0.5);
		AI.PushGoal("ob_random_hide","signal",1,1,"HIDE_FAILED",0);
		AI.PushLabel("ob_random_hide","SIGNAL_SUCCESS");
		AI.PushGoal("ob_random_hide","timeout",1,0.3,0.5);
		AI.PushGoal("ob_random_hide","signal",1,1,"HIDE_SUCCEED",0);
			
		
		AI.CreateGoalPipe("ob_backoff_from");
		AI.PushGoal("ob_backoff_from","backoff",1,7,5);
	
		AI.CreateGoalPipe("ob_backoff_hide");
		AI.PushGoal("ob_backoff_hide","backoff",1,7,5);
		AI.PushGoal("ob_backoff_hide","signal",1,1,"HIDE_DONE",0);
		-- the hide result will be send delayed back to the caller state
		AI.PushGoal("ob_backoff_hide","timeout",1,0.3,0.5);
		AI.PushGoal("ob_backoff_hide","signal",1,1,"HIDE_FAILED",0);
	
		AI.CreateGoalPipe("ob_investigate");
		AI.PushGoal("ob_investigate","timeout",1,0.5,1.5);
		AI.PushGoal("ob_investigate","approach",1,3);
		AI.PushGoal("ob_investigate","lookat",1,0,-90);
		AI.PushGoal("ob_investigate","timeout",1,0.5);
		AI.PushGoal("ob_investigate","lookat",1,0,90);
		AI.PushGoal("ob_investigate","signal",1,1,"END_INVESTIGATE",0);
	
		AI.CreateGoalPipe("ob_investigate_beacon");
		AI.PushGoal("ob_investigate_beacon","clear",0,1);	-- force to evaluate the attention target.
		AI.PushGoal("ob_investigate_beacon","bodypos",0,BODYPOS_STAND);
		AI.PushGoal("ob_investigate_beacon","locate",0,"beacon");
		AI.PushGoal("ob_investigate_beacon","pathfind",1,"");
		AI.PushGoal("ob_investigate_beacon","trace",1,1);
		AI.PushGoal("ob_investigate_beacon","timeout",1,0,1);
		AI.PushGoal("ob_investigate_beacon","lookat",1,0,-90);
		AI.PushGoal("ob_investigate_beacon","timeout",1,0.5);
		AI.PushGoal("ob_investigate_beacon","lookat",1,0,90);
		AI.PushGoal("ob_investigate_beacon","signal",1,1,"END_INVESTIGATE",0);

		AI.CreateGoalPipe("ob_order_search");
		AI.PushGoal("ob_order_search", "clear", 0, 0);
		AI.PushGoal("ob_order_search", "timeout", 1, 0.1, 0.8);
		AI.PushGoal("ob_order_search", "locate", 0, "refpoint");
		AI.PushGoal("ob_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
			AI.PushGoal("ob_order_search", "clear", 0, 0);
			AI.PushGoal("ob_order_search", "+run", 0, 1);
			AI.PushGoal("ob_order_search", "+timeout", 1, 0.25);
			AI.PushGoal("ob_order_search", "+locate", 0, "refpoint");
			AI.PushGoal("ob_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
				AI.PushGoal("ob_order_search", "+pathfind", 1, "");
				AI.PushGoal("ob_order_search", "+branch", 1, "DONE", IF_NO_PATH); -- if no path just ignore this hide point
				AI.PushGoal("ob_order_search", "+branch", 1, "DONE", IF_PATH_LONGER, 35.0); -- if no found path is longer than 35m just ignore this hide point
				AI.PushGoal("ob_order_search", "+trace", 0, 1, 0, 8);
				AI.PushLabel("ob_order_search", "LOOP1");
					AI.PushGoal("ob_order_search", "+timeout", 1, 0.2, 0.4);
					AI.PushGoal("ob_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
				AI.PushGoal("ob_order_search", "+branch", 1, "LOOP1", IF_ACTIVE_GOALS);
				AI.PushGoal("ob_order_search", "+run", 0, 0);
				AI.PushGoal("ob_order_search", "+trace", 0, 1, 0, 1);
				AI.PushLabel("ob_order_search", "LOOP2");
					AI.PushGoal("ob_order_search", "+timeout", 1, 0.1, 0.2);
					AI.PushGoal("ob_order_search", "+branch", 1, "DONE", IF_SEES_LASTOP);
				AI.PushGoal("ob_order_search", "+branch", 1, "LOOP2", IF_ACTIVE_GOALS);
		AI.PushLabel("ob_order_search", "DONE");
		AI.PushGoal("ob_order_search", "clear", 0, 0); -- stops approaching - 0 means keep att. target
		AI.PushGoal("ob_order_search", "+firecmd", 0, 1);
		AI.PushGoal("ob_order_search", "+timeout", 1, 0.2, 0.5);
--		AI.PushGoal("ob_order_search", "signal", 1, 1, "FOLLOW_ME", SIGNALID_READIBILITY);
		AI.PushGoal("ob_order_search", "signal", 1, 10, "ORD_DONE", SIGNALFILTER_LEADER)
	
		AI.CreateGoalPipe("ob_goto_target");
		AI.PushGoal("ob_goto_target","acqtarget",1,"");
		AI.PushGoal("ob_goto_target","approach",1,1);
		
	

		--------------------------------------------------------------------------
		-- Guard
		--

		local gr_settleShotTime = 0.2;

		--------------------------------------------------------------------------
		AI.CreateGoalPipe("gr_roam_covers");
		AI.PushGoal("gr_roam_covers","firecmd",0,0);
		AI.PushGoal("gr_roam_covers","run",0,0);
		AI.PushGoal("gr_roam_covers","locate",0,"hidepoint",20);
		AI.PushGoal("gr_roam_covers","+acqtarget",1,"");
		AI.PushGoal("gr_roam_covers","+pathfind",1,"");
		AI.PushGoal("gr_roam_covers","+trace",1,1);
--		AI.PushGoal("gr_roam_covers","clear",0,1);
		AI.PushGoal("gr_roam_covers","signal",1,1,"END_INVESTIGATE",0);
	
		--------------------------------------------------------------------------
		AI.CreateGoalPipe("gr_stick_to_target");
		AI.PushGoal("gr_stick_to_target","gr_setup_combat");
		AI.PushGoal("gr_stick_to_target","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_stick_to_target","+stick",0,10);
		AI.PushGoal("gr_stick_to_target","+timeout",1,2,3);
		AI.PushGoal("gr_stick_to_target","clear",0,0); -- kill the stick
		AI.PushGoal("gr_stick_to_target","firecmd",0,0);
		AI.PushGoal("gr_stick_to_target","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_stick_to_target","signal",1,1,"END_STICK",0);

		AI.CreateGoalPipe("gr_track_target");
		AI.PushGoal("gr_track_target","gr_setup_combat");
		AI.PushGoal("gr_track_target","firecmd",0,0);
		AI.PushGoal("gr_track_target","run",0,1);
		AI.PushGoal("gr_track_target","locate",0,"trackpattern");
		AI.PushGoal("gr_track_target","+stick",1,1,AILASTOPRES_USE);

		AI.CreateGoalPipe("gr_shoot_on_spot");
		AI.PushGoal("gr_shoot_on_spot","timeout",1,0.1);
		AI.PushGoal("gr_shoot_on_spot","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_shoot_on_spot","timeout",1,0.7,1.3);
		AI.PushGoal("gr_shoot_on_spot","firecmd",0,0);
		AI.PushGoal("gr_shoot_on_spot","timeout",1,gr_settleShotTime);	--allow time to finish the shot

		AI.CreateGoalPipe("gr_track_fire_on");
		AI.PushGoal("gr_track_target","firecmd",0,FIREMODE_CONTINUOUS);
	
		AI.CreateGoalPipe("gr_track_fire_off");
		AI.PushGoal("gr_track_target","firecmd",0,0);
	
		AI.CreateGoalPipe("gr_not_so_random_hide_from");
		AI.PushGoal("gr_not_so_random_hide_from","acqtarget",1,"");
		AI.PushGoal("gr_not_so_random_hide_from","firecmd",0,0);
		AI.PushGoal("gr_not_so_random_hide_from","run",0,1);
		AI.PushGoal("gr_not_so_random_hide_from","hide",1,15,HM_FARTHEST_FROM_TARGET,1);
		AI.PushGoal("gr_not_so_random_hide_from", "branch", 1, "HIDE_OK", IF_CAN_HIDE);
			AI.PushGoal("gr_not_so_random_hide_from","hide",1,40,HM_FARTHEST_FROM_TARGET,1);
			AI.PushGoal("gr_not_so_random_hide_from", "branch", 1, "HIDE_OK", IF_CAN_HIDE);
				AI.PushGoal("gr_not_so_random_hide_from","hide",1,80,HM_NEAREST,1);
				AI.PushGoal("gr_not_so_random_hide_from", "branch", 1, "HIDE_FAILED", IF_CANNOT_HIDE);
		AI.PushLabel("gr_not_so_random_hide_from", "HIDE_OK");
		AI.PushGoal("gr_not_so_random_hide_from","run",0,0);
		AI.PushGoal("gr_not_so_random_hide_from","locate",0,"atttarget");
		AI.PushGoal("gr_not_so_random_hide_from","+lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_not_so_random_hide_from","timeout",1,0.1,0.3);
		AI.PushLabel("gr_not_so_random_hide_from", "HIDE_FAILED");
		AI.PushGoal("gr_not_so_random_hide_from","signal",1,1,"HIDE_DONE",0);

		AI.CreateGoalPipe("gr_flee_trooper");
		AI.PushGoal("gr_flee_trooper","acqtarget",1,"beacon");
		AI.PushGoal("gr_flee_trooper","firecmd",0,0);
		AI.PushGoal("gr_flee_trooper","run",0,2);
		AI.PushGoal("gr_flee_trooper","hide",1,15,HM_FARTHEST_FROM_TARGET,1);
		AI.PushGoal("gr_flee_trooper", "branch", 1, "HIDE_OK", IF_CAN_HIDE);
			AI.PushGoal("gr_flee_trooper","hide",1,40,HM_FARTHEST_FROM_TARGET,1);
			AI.PushGoal("gr_flee_trooper", "branch", 1, "HIDE_OK", IF_CAN_HIDE);
				AI.PushGoal("gr_flee_trooper","hide",1,80,HM_NEAREST,1);
				AI.PushGoal("gr_flee_trooper", "branch", 1, "HIDE_FAILED", IF_CANNOT_HIDE);
		AI.PushLabel("gr_flee_trooper", "HIDE_OK");
		AI.PushGoal("gr_flee_trooper","run",0,0);
		AI.PushGoal("gr_flee_trooper","locate",0,"atttarget");
		AI.PushGoal("gr_flee_trooper","+lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_flee_trooper","timeout",1,0.1,0.3);
		AI.PushLabel("gr_flee_trooper", "HIDE_FAILED");
		AI.PushGoal("gr_flee_trooper","signal",1,1,"FLEE_TROOPER_DONE",0);

		AI.CreateGoalPipe("gr_lookat_target");
		AI.PushGoal("gr_lookat_target","locate",0,"atttarget");
		AI.PushGoal("gr_lookat_target","+lookat",0,0,0,1); --lookat lastop

		AI.CreateGoalPipe("gr_lookat_beacon");
		AI.PushGoal("gr_lookat_beacon","locate",0,"beacon");
		AI.PushGoal("gr_lookat_beacon","+lookat",0,0,0,1); --lookat lastop
	
		AI.CreateGoalPipe("gr_remove_flee");
		AI.PushGoal("gr_remove_flee","signal",1,1,"REMOVE_FLEE",0);
	
		AI.CreateGoalPipe("gr_random_hide");
--		AI.PushGoal("gr_random_hide","timeout",1,0.2);
		AI.PushGoal("gr_random_hide","firecmd",0,0);
		AI.PushGoal("gr_random_hide","run",0,1);
		AI.PushGoal("gr_random_hide","hide",1,40,HM_RANDOM,1);
		AI.PushGoal("gr_random_hide","run",0,0);
		AI.PushGoal("gr_random_hide","signal",1,1,"HIDE_DONE",0);
		
		AI.CreateGoalPipe("gr_backoff_from");
		AI.PushGoal("gr_backoff_from","backoff",1,7,5);
	
		AI.CreateGoalPipe("gr_backoff_hide");
		AI.PushGoal("gr_backoff_hide","backoff",1,7,5);
		AI.PushGoal("gr_backoff_hide","signal",1,1,"HIDE_DONE",0);

--		AI.CreateGoalPipe("gr_run_to_alarm");
--		AI.PushGoal("gr_run_to_alarm","firecmd",0,1);
--		AI.PushGoal("gr_run_to_alarm","timeout",1,0.7);
--		AI.PushGoal("gr_run_to_alarm","firecmd",0,0);
--		AI.PushGoal("gr_run_to_alarm","run",0,1);
--		AI.PushGoal("gr_run_to_alarm","stick",1,10,AILASTOPRES_USE,1);
--		AI.PushGoal("gr_run_to_alarm","signal",1,1,"ALERT_OTHERS",0);
--		AI.PushGoal("gr_run_to_alarm","timeout",1,1.0);
--		AI.PushGoal("gr_run_to_alarm","signal",1,1,"HIDE_DONE",0);
--	
--		AI.CreateGoalPipe("gr_run_to_alarm_near");
--		AI.PushGoal("gr_run_to_alarm_near","firecmd",0,1);
--		AI.PushGoal("gr_run_to_alarm_near","timeout",1,0.7);
--		AI.PushGoal("gr_run_to_alarm_near","firecmd",0,0);
--		AI.PushGoal("gr_run_to_alarm_near","run",0,1);
--		AI.PushGoal("gr_run_to_alarm_near","stick",1,2,AILASTOPRES_USE,1);
--		AI.PushGoal("gr_run_to_alarm_near","signal",1,1,"ALERT_OTHERS",0);
--		AI.PushGoal("gr_run_to_alarm_near","timeout",1,1.0);
--		AI.PushGoal("gr_run_to_alarm_near","signal",1,1,"HIDE_DONE",0);
	
		AI.CreateGoalPipe("gr_investigate");
		AI.PushGoal("gr_investigate","firecmd",0,0);
		AI.PushGoal("gr_investigate","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_investigate","timeout",1,0.3,1.0);
		AI.PushGoal("gr_investigate","approach",1,6);
		AI.PushGoal("gr_investigate","lookat",0,0,-90);
		AI.PushGoal("gr_investigate","timeout",1,0.5);
		AI.PushGoal("gr_investigate","lookat",0,0,90);
		AI.PushGoal("gr_investigate","approach",1,2);
		AI.PushGoal("gr_investigate","signal",1,1,"END_INVESTIGATE",0,1);
	
		AI.CreateGoalPipe("gr_investigate_interested");
		AI.PushGoal("gr_investigate_interested","firecmd",0,0);
		AI.PushGoal("gr_investigate_interested","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		-- first look at the attention target.
		AI.PushGoal("gr_investigate_interested","locate",0,"atttarget");
		AI.PushGoal("gr_investigate_interested","+lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_investigate_interested","timeout",1,0.5,1.5);
		-- Get closer, and look again.
		AI.PushGoal("gr_investigate_interested","approach",1,20);
		AI.PushGoal("gr_investigate_interested","lookat",0,0,-40);
		AI.PushGoal("gr_investigate_interested","timeout",1,0.3,0.5);
		AI.PushGoal("gr_investigate_interested","lookat",0,0,80);
		AI.PushGoal("gr_investigate_interested","timeout",1,0.4,0.7);
		AI.PushGoal("gr_investigate_interested","lookat",0,0,-40);
		-- Get even closer, and look again.
		AI.PushGoal("gr_investigate_interested","run",0,0);
		AI.PushGoal("gr_investigate_interested","approach",1,3);		-- approach with caution to avoid overshooting at target if running.
		AI.PushGoal("gr_investigate_interested","timeout",1,0.3);
		AI.PushGoal("gr_investigate_interested","locate",0,"atttarget");
		AI.PushGoal("gr_investigate_interested","+lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_investigate_interested","timeout",1,0.5);
		AI.PushGoal("gr_investigate_interested","lookat",0,0,-85);
		AI.PushGoal("gr_investigate_interested","timeout",1,0.5,0.7);
		AI.PushGoal("gr_investigate_interested","lookat",0,0,85);
		AI.PushGoal("gr_investigate_interested","timeout",1,0.5,0.7);
		AI.PushGoal("gr_investigate_interested","signal",1,1,"END_INVESTIGATE",0,1);
	
		AI.CreateGoalPipe("gr_investigate_beacon");
		AI.PushGoal("gr_investigate_beacon","firecmd",0,0);
		AI.PushGoal("gr_investigate_beacon","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_investigate_beacon","timeout",1,0.3,1.0);
--		AI.PushGoal("gr_investigate_beacon","gr_setup_combat" );
--		AI.PushGoal("gr_investigate_beacon","clear",0,1);	-- force to evaluate the attention target.
--		AI.PushGoal("gr_investigate_beacon","bodypos",0,BODYPOS_STAND);
		AI.PushGoal("gr_investigate_beacon","locate",0,"beacon");
		AI.PushGoal("gr_investigate_beacon","+approach",1,8);
		AI.PushGoal("gr_investigate_beacon","run",0,0);
--		AI.PushGoal("gr_investigate_beacon","approach",1,8);		-- approach with caution to avoid overshooting at target if running.
		AI.PushGoal("gr_investigate_beacon","timeout",1,0,0.5);
		AI.PushGoal("gr_investigate_beacon","lookat",0,0,-60);
		AI.PushGoal("gr_investigate_beacon","timeout",1,0.3);
		AI.PushGoal("gr_investigate_beacon","lookat",0,0,60);
		AI.PushGoal("gr_investigate_beacon","locate",0,"beacon");
		AI.PushGoal("gr_investigate_beacon", "+branch", 1, "DONE", IF_SEES_LASTOP);
			AI.PushGoal("gr_investigate_beacon","locate",0,"beacon");
			AI.PushGoal("gr_investigate_beacon","+approach",1,2);
		AI.PushLabel("gr_investigate_beacon", "DONE");
--		AI.PushGoal("gr_investigate_beacon","timeout",1,0,1);
--		AI.PushGoal("gr_investigate_beacon","lookat",1,0,-60);
--		AI.PushGoal("gr_investigate_beacon","timeout",1,0.5);
--		AI.PushGoal("gr_investigate_beacon","lookat",1,0,60);
		AI.PushGoal("gr_investigate_beacon","signal",1,1,"END_INVESTIGATE",0,2);
	
		AI.CreateGoalPipe("gr_setup_combat");	
		AI.PushGoal("gr_setup_combat","run",0,1);
	
		AI.CreateGoalPipe("gr_group_fire");
	--	AI.PushGoal("gr_group_fire","gr_setup_combat");
		AI.PushGoal("gr_group_fire","timeout",1,0.4,0.6);
		AI.PushGoal("gr_group_fire","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_group_fire","+timeout",1,2);
		AI.PushGoal("gr_group_fire","+firecmd",0,0);
		AI.PushGoal("gr_group_fire","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_group_fire","+signal",1,10,"ORD_DONE",SIGNALFILTER_LEADER);
	
		AI.CreateGoalPipe("gr_group_short_cover_fire");
--		AI.PushGoal("gr_group_short_cover_fire","gr_setup_combat");
		AI.PushGoal("gr_group_short_cover_fire","acqtarget",1,"");
		AI.PushGoal("gr_group_short_cover_fire","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_group_short_cover_fire","+timeout",1,1,2);
		AI.PushGoal("gr_group_short_cover_fire","+firecmd",0,0);
		AI.PushGoal("gr_group_short_cover_fire","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_group_short_cover_fire","signal",1,1,"END_COVER_FIRE");

		AI.CreateGoalPipe("gr_group_form");
--		AI.PushGoal("gr_group_form","gr_setup_combat");
		AI.PushGoal("gr_group_form","firecmd",0,0);
		AI.PushGoal("gr_group_form","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_group_form","timeout",1,0.5,0.7);
		AI.PushGoal("gr_group_form","signal",1,1,"ALERT_COMBAT_REPLY",SIGNALID_READIBILITY);
		AI.PushGoal("gr_group_form","run",0,1);
		AI.PushGoal("gr_group_form","signal",1,10,"ORD_DONE",SIGNALFILTER_LEADER);
		AI.PushGoal("gr_group_form","locate",0,"formation");
		AI.PushGoal("gr_group_form","+stick",1,2,AILASTOPRES_USE);
	
		AI.CreateGoalPipe("gr_group_track");
		AI.PushGoal("gr_group_track","firecmd",0,0);
		AI.PushGoal("gr_group_track","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_group_track","signal",0,1,"ALERT_COMBAT",SIGNALID_READIBILITY);
		-- approach the beacon (avg enemy position) in order to visual contact to the enemy just in
		-- case the alien which is chosen to lead the group which is chosen as leader does not have attention target.
		AI.PushGoal("gr_group_track","locate",0,"beacon");
		AI.PushGoal("gr_group_track","+approach",0,1,AILASTOPRES_USE);
		AI.PushGoal("gr_group_track","+timeout",1,0.6,0.8);
		AI.PushGoal("gr_group_track","clear",0,0); -- kill the stick
		AI.PushGoal("gr_group_track","run",0,1);
		AI.PushGoal("gr_group_track","locate",0,"trackpattern");
		AI.PushGoal("gr_group_track","+stick",1,1,AILASTOPRES_USE);

		AI.CreateGoalPipe("gr_group_stick_to_target");
--		AI.PushGoal("gr_group_stick_to_target","gr_setup_combat");
		AI.PushGoal("gr_group_stick_to_target","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_group_stick_to_target","+stick",0,10);
		AI.PushGoal("gr_group_stick_to_target","+timeout",1,2,2.6);
		AI.PushGoal("gr_group_stick_to_target","+firecmd",0,0);
		AI.PushGoal("gr_group_stick_to_target","+timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_group_stick_to_target","+stick",0,10);
		AI.PushGoal("gr_group_stick_to_target","+timeout",1,0.5,1);
		AI.PushGoal("gr_group_stick_to_target","signal",1,1,"END_STICK",0);

		AI.CreateGoalPipe("gr_group_track_wait");
		AI.PushGoal("gr_group_track_wait","timeout",1,0.8);
		AI.PushGoal("gr_group_track_wait","+signal",1,10,"ORD_DONE",SIGNALFILTER_LEADER);

		AI.CreateGoalPipe("gr_spot_enemy");
		AI.PushGoal("gr_spot_enemy", "timeout", 1, 0.5, 0.5);	-- allow time for the smart objects to kick in
		AI.PushGoal("gr_spot_enemy","signal",1,1,"END_ATTACK",0);

		AI.CreateGoalPipe("gr_goto_refpoint");
		AI.PushGoal("gr_goto_refpoint","run",0,1);
		AI.PushGoal("gr_goto_refpoint","locate",0,"refpoint");
		AI.PushGoal("gr_goto_refpoint","+approach", 1, 4, AILASTOPRES_USE);
		AI.PushGoal("gr_goto_refpoint","signal",1,1,"END_GOTO",0);

		AI.CreateGoalPipe("gr_attack_rally");
		AI.PushGoal("gr_attack_rally","run",0,1);
		AI.PushGoal("gr_attack_rally","firecmd",0,0);
		AI.PushGoal("gr_attack_rally","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_attack_rally","locate", 0, "refpoint");
		AI.PushGoal("gr_attack_rally","+approach", 1, 4, AILASTOPRES_USE);
		AI.PushGoal("gr_attack_rally","gr_attack");

		AI.CreateGoalPipe("gr_attack");
		AI.PushGoal("gr_attack","run",0,1);
		AI.PushGoal("gr_attack","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_attack","stick",0,10);
		AI.PushGoal("gr_attack","timeout",1,3,4);
		AI.PushGoal("gr_attack","firecmd",0,0);
		AI.PushGoal("gr_attack","timeout",1,gr_settleShotTime);	--allow time to finish the shot
--		AI.PushGoal("gr_attack","hide",1,30,HM_NEAREST,1);
		AI.PushGoal("gr_attack","approach", 1, 10); -- approach the attention target to get in contact again.
		AI.PushGoal("gr_attack","signal",1,1,"END_ATTACK",0);

		AI.CreateGoalPipe("gr_attack_hide");
		AI.PushGoal("gr_attack_hide","firecmd",0,0);
		AI.PushGoal("gr_attack_hide","timeout",1,gr_settleShotTime);	--allow time to finish the shot
--		AI.PushGoal("gr_attack_hide","acqtarget",1,"");
		AI.PushGoal("gr_attack_hide","run",0,1);
		AI.PushGoal("gr_attack_hide","hide",1,40,HM_NEAREST,1);
		AI.PushGoal("gr_attack_hide","branch", 1, "DONE", IF_SEES_TARGET);
		AI.PushGoal("gr_attack_hide","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_attack_hide","approach", 1, 10); -- approach the attention target to get in contact again.
		AI.PushGoal("gr_attack_hide","firecmd",0,0);
		AI.PushGoal("gr_attack_hide","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushLabel("gr_attack_hide","DONE");
		AI.PushGoal("gr_attack_hide","signal",1,1,"HIDE_DONE",0);

		AI.CreateGoalPipe("gr_ambush_switch_hide");
		AI.PushGoal("gr_ambush_switch_hide","firecmd",0,0);
--		AI.PushGoal("gr_ambush_switch_hide","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_ambush_switch_hide","run",0,1);
		AI.PushGoal("gr_ambush_switch_hide","locate", 0, "refpoint");
		AI.PushGoal("gr_ambush_switch_hide","+hide",1,50,HM_LEFTMOST_FROM_TARGET,1);
		AI.PushGoal("gr_ambush_switch_hide","run",0,0);
		AI.PushGoal("gr_ambush_switch_hide","signal",1,1,"HIDE_DONE",0);

		AI.CreateGoalPipe("gr_hide_near_refpoint");
		AI.PushGoal("gr_hide_near_refpoint","firecmd",0,0);
--		AI.PushGoal("gr_hide_near_refpoint","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_hide_near_refpoint","run",0,1);
		AI.PushGoal("gr_hide_near_refpoint","locate", 0, "refpoint");
		AI.PushGoal("gr_hide_near_refpoint","+hide",1,25,HM_NEAREST_TO_LASTOPRESULT,1);
		AI.PushGoal("gr_hide_near_refpoint","run",0,0);
		AI.PushGoal("gr_hide_near_refpoint","locate",0,"atttarget");
		AI.PushGoal("gr_hide_near_refpoint","+lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_hide_near_refpoint","timeout",1,0.1,0.3);
		AI.PushGoal("gr_hide_near_refpoint","signal",1,1,"HIDE_DONE",0);

		AI.CreateGoalPipe("gr_ambush_switch_anchor");
		AI.PushGoal("gr_ambush_switch_anchor","firecmd",0,0);
--		AI.PushGoal("gr_ambush_switch_anchor","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_ambush_switch_anchor","run",0,1);
		AI.PushGoal("gr_ambush_switch_anchor","approach",1,2,AILASTOPRES_USE);
		AI.PushGoal("gr_ambush_switch_anchor","signal",1,1,"HIDE_DONE",0);

		AI.CreateGoalPipe("gr_ambush_reveal");
		AI.PushGoal("gr_ambush_reveal","firecmd",0,0);
		AI.PushGoal("gr_ambush_reveal","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_ambush_reveal","run",0,1);
		AI.PushGoal("gr_ambush_reveal","locate",1,"refpoint");
		AI.PushGoal("gr_ambush_reveal","+approach",1,15,AILASTOPRES_USE);
		AI.PushGoal("gr_ambush_reveal","signal",1,1,"REVEAL_DONE",0);

		AI.CreateGoalPipe("gr_cover_flee_to");
		AI.PushGoal("gr_cover_flee_to","firecmd",0,0);
		AI.PushGoal("gr_cover_flee_to","lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_cover_flee_to","timeout",1,0.1,0.3);
		AI.PushGoal("gr_cover_flee_to","lookat",1,-500); --reset lookat
		AI.PushGoal("gr_cover_flee_to","run",0,1);
		AI.PushGoal("gr_cover_flee_to","approach",1,2,AILASTOPRES_USE);
		AI.PushGoal("gr_cover_flee_to","run",0,1);
		AI.PushGoal("gr_cover_flee_to","lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_cover_flee_to","timeout",1,1.0);
		AI.PushGoal("gr_cover_flee_to","lookat",1,-500); --reset lookat
		AI.PushGoal("gr_cover_flee_to","timeout",1,5.0,6.5);
		AI.PushGoal("gr_cover_flee_to","signal",1,1,"HIDE_DONE",0);


		AI.CreateGoalPipe("gr_ambush_idle");
		AI.PushGoal("gr_ambush_idle","run",0,0);
		AI.PushGoal("gr_ambush_idle","firecmd",0,0);
		AI.PushGoal("gr_ambush_idle","timeout",1,gr_settleShotTime);	--allow time to finish the shot
--		AI.PushGoal("gr_ambush_idle","timeout",1,7,17);
		AI.PushGoal("gr_ambush_idle","locate",0,"atttarget");
		AI.PushGoal("gr_ambush_idle","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_ambush_idle","timeout",1,2);
		AI.PushGoal("gr_ambush_idle","signal",1,1,"CHECK_SWITCH",0);
		AI.PushGoal("gr_ambush_idle","locate",0,"refpoint");
		AI.PushGoal("gr_ambush_idle","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_ambush_idle","timeout",1,2);
		AI.PushGoal("gr_ambush_idle","signal",1,1,"CHECK_SWITCH",0);
		AI.PushGoal("gr_ambush_idle","lookat",1,-40,40);
		AI.PushGoal("gr_ambush_idle","timeout",1,1,2);
		AI.PushGoal("gr_ambush_idle","signal",1,1,"CHECK_SWITCH",0);
		AI.PushGoal("gr_ambush_idle","lookat",1,-40,40);
		AI.PushGoal("gr_ambush_idle","timeout",1,1,2);
		AI.PushGoal("gr_ambush_idle","signal",1,1,"CHECK_SWITCH",0);
		AI.PushGoal("gr_ambush_idle","lookat",1,-40,40);
		AI.PushGoal("gr_ambush_idle","locate",0,"refpoint");
		AI.PushGoal("gr_ambush_idle","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_ambush_idle","timeout",1,1,2);
		AI.PushGoal("gr_ambush_idle","signal",1,1,"CHECK_SWITCH",0);
		AI.PushGoal("gr_ambush_idle","lookat",1,-40,40);
		AI.PushGoal("gr_ambush_idle","timeout",1,1,2);
		AI.PushGoal("gr_ambush_idle","signal",1,1,"CHECK_SWITCH",0);
		AI.PushGoal("gr_ambush_idle","locate",0,"refpoint");
		AI.PushGoal("gr_ambush_idle","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_ambush_idle","timeout",1,1,10);
		AI.PushGoal("gr_ambush_idle","signal",1,1,"MAKE_NOISE",0);

		AI.CreateGoalPipe("gr_hide_idle");
		AI.PushGoal("gr_hide_idle","run",0,1);
		AI.PushGoal("gr_hide_idle","locate", 0, "refpoint");
		AI.PushGoal("gr_hide_idle","+approach",1,2,AILASTOPRES_USE);
		AI.PushGoal("gr_hide_idle","signal",1,1,"END_HIDE",0);

		AI.CreateGoalPipe("gr_wait_to_attack");
		AI.PushGoal("gr_wait_to_attack","run",0,0);
		AI.PushGoal("gr_wait_to_attack","firecmd",0,0);
--		AI.PushGoal("gr_wait_to_attack","locate", 0, "atttarget");
--		AI.PushGoal("gr_wait_to_attack","+lookat",1,0,0,1); --lookat lastop
--		AI.PushGoal("gr_wait_to_attack","timeout",1,0.1);
--		AI.PushGoal("gr_wait_to_attack","lookat",1,-500); --reset lookat
		AI.PushGoal("gr_wait_to_attack","timeout",1,2.7);
		AI.PushGoal("gr_wait_to_attack","signal",1,1,"END_ATTACK");

		AI.CreateGoalPipe("gr_attack_defender");
		AI.PushGoal("gr_attack_defender","run",0,2);
		AI.PushGoal("gr_attack_defender","bodypos",0,BODYPOS_PRONE);
		AI.PushGoal("gr_attack_defender","firecmd",0,0);
		AI.PushGoal("gr_attack_defender","locate", 0, "refpoint");
		AI.PushGoal("gr_attack_defender","+approach",1,2,AILASTOPRES_USE);
--		AI.PushGoal("gr_attack_defender","locate",0,"atttarget");
--		AI.PushGoal("gr_attack_defender","+lookat",1,0,0,1); --lookat lastop
--			AI.PushGoal("gr_attack_defender","lookat",1,-500); --reset lookat
			AI.PushGoal("gr_attack_defender","bodypos",0,BODYPOS_STAND);
			AI.PushGoal("gr_attack_defender","firecmd",0,FIREMODE_CONTINUOUS);
			AI.PushGoal("gr_attack_defender","run",0,0);
--			AI.PushGoal("gr_attack_defender","backoff",0,5,0,AI_MOVE_LEFT);
			AI.PushGoal("gr_attack_defender","timeout",1,4);
			AI.PushGoal("gr_attack_defender","clear",0,0); -- kill the backoff
--			AI.PushGoal("gr_attack_defender","signal",1,1,"CHECK_TO_ENDATTACK",0,2);
			AI.PushGoal("gr_attack_defender","backoff",0,10,0,AI_MOVE_FORWARD);
--			AI.PushGoal("gr_attack_defender","timeout",1,2.5);
			AI.PushGoal("gr_attack_defender","firecmd",0,0);
			AI.PushGoal("gr_attack_defender","bodypos",0,BODYPOS_PRONE);
			AI.PushGoal("gr_attack_defender","run",0,2);
			AI.PushGoal("gr_attack_defender","backoff",1,25,0,AI_MOVE_FORWARD);
		AI.PushGoal("gr_attack_defender","signal",1,1,"CHECK_TO_HIDE",0);

		AI.CreateGoalPipe("gr_attack_defender_long");
		AI.PushGoal("gr_attack_defender_long","run",0,1);
		AI.PushGoal("gr_attack_defender_long","firecmd",0,0);
		AI.PushGoal("gr_attack_defender_long","locate", 0, "refpoint");
		AI.PushGoal("gr_attack_defender_long","+approach",1,2,AILASTOPRES_USE);
--		AI.PushGoal("gr_attack_defender_long","locate",0,"atttarget");
--		AI.PushGoal("gr_attack_defender_long","+lookat",1,0,0,1); --lookat lastop
			AI.PushGoal("gr_attack_defender_long","timeout",1,gr_settleShotTime);	--allow time to finish the shot
			AI.PushGoal("gr_attack_defender_long","firecmd",0,FIREMODE_CONTINUOUS);
			AI.PushGoal("gr_attack_defender_long","timeout",1,10.0);
--			AI.PushGoal("gr_attack_defender_long","lookat",1,-500); --reset lookat
--			AI.PushGoal("gr_attack_defender_long","run",0,0);
--			AI.PushGoal("gr_attack_defender_long","timeout",1,5.0);
--			AI.PushGoal("gr_attack_defender_long","signal",1,1,"CHECK_TO_ENDATTACK",0,2);
--			AI.PushGoal("gr_attack_defender_long","timeout",1,2.5);
			AI.PushGoal("gr_attack_defender_long","firecmd",0,0);
--			AI.PushGoal("gr_attack_defender_long","timeout",1,gr_settleShotTime);	--allow time to finish the shot
			AI.PushGoal("gr_attack_defender_long","run",0,1);
		AI.PushGoal("gr_attack_defender_long","signal",1,1,"CHECK_TO_HIDE",0);


		AI.CreateGoalPipe("gr_attack_ambient_noshoot");
		AI.PushGoal("gr_attack_ambient_noshoot","run",0,1);
		AI.PushGoal("gr_attack_ambient_noshoot","firecmd",0,0);
		AI.PushGoal("gr_attack_ambient_noshoot","locate", 0, "refpoint");
		AI.PushGoal("gr_attack_ambient_noshoot","+approach",1,2,AILASTOPRES_USE);
			AI.PushGoal("gr_attack_ambient_noshoot","timeout",1,1.0);
		AI.PushGoal("gr_attack_ambient_noshoot","signal",1,1,"CHECK_TO_HIDE",0);



		AI.CreateGoalPipe("gr_attack_defender_still");
		AI.PushGoal("gr_attack_defender_still","run",0,1);
		AI.PushGoal("gr_attack_defender_still","locate", 0, "refpoint");
		AI.PushGoal("gr_attack_defender_still","+approach",1,2,AILASTOPRES_USE);
--		AI.PushGoal("gr_attack_defender_still", "branch", 1, "DONE", IF_NO_ENEMY_TARGET);
			AI.PushGoal("gr_attack_defender_still","+signal",1,1,"CHECK_TO_ENDATTACK",0,1);
			AI.PushGoal("gr_attack_defender_still","+firecmd",0,FIREMODE_CONTINUOUS);
--			AI.PushGoal("gr_attack_defender_still","+run",0,0);
			AI.PushGoal("gr_attack_defender_still","+timeout",1,1,1.5);
			AI.PushGoal("gr_attack_defender_still","+signal",1,1,"CHECK_TO_ENDATTACK",0,2);
			AI.PushGoal("gr_attack_defender_still","+timeout",1,0.7,1.5);
			AI.PushGoal("gr_attack_defender_still","+firecmd",0,0);
			AI.PushGoal("gr_attack_defender_still","timeout",1,gr_settleShotTime);	--allow time to finish the shot
			AI.PushGoal("gr_attack_defender_still","run",0,1);
--		AI.PushLabel("gr_attack_defender_still","DONE");
		AI.PushGoal("gr_attack_defender_still","signal",1,1,"CHECK_TO_HIDE",0);

		AI.CreateGoalPipe("gr_attack_defender_melee");
		AI.PushGoal("gr_attack_defender_melee","run",0,2);
		AI.PushGoal("gr_attack_defender_melee","firecmd",0,0);
		AI.PushGoal("gr_attack_defender_melee","timeout",1,gr_settleShotTime);	-- allow time to finish the shot
		AI.PushGoal("gr_attack_defender_melee","locate", 0, "refpoint");
		AI.PushGoal("gr_attack_defender_melee","+stick",1,3,AILASTOPRES_USE,STICK_BREAK+STICK_SHORTCUTNAV); -- stick will not slow down at the end of the path
		AI.PushGoal("gr_attack_defender_melee","locate", 0, "atttarget");
		AI.PushGoal("gr_attack_defender_melee","stick",1,8,AILASTOPRES_USE,STICK_BREAK+STICK_SHORTCUTNAV);
		AI.PushGoal("gr_attack_defender_melee","signal",1,1,"DO_MELEE",0);
		AI.PushGoal("gr_attack_defender_melee","locate", 0, "atttarget");
		AI.PushGoal("gr_attack_defender_melee","+charge", 1, 6.0, 8.0, AILASTOPRES_USE);
--		AI.PushGoal("gr_attack_defender_melee","move",0,7.0,3.5,AILASTOPRES_USE);
--		AI.PushGoal("gr_attack_defender_melee","stick",0,5,AILASTOPRES_USE);
--		AI.PushGoal("gr_attack_defender_melee","signal",1,1,"DO_MELEE_ADVERTISE",0);
--		AI.PushGoal("gr_attack_defender_melee","timeout",1,0.7);
--		AI.PushGoal("gr_attack_defender_melee","clear",0,0); -- kill the stick
--		AI.PushGoal("gr_attack_defender_melee","timeout",1,0.5);
--		AI.PushGoal("gr_attack_defender_melee","signal",1,1,"DO_MELEE",0);
--		AI.PushGoal("gr_attack_defender_melee","timeout",1,0.4);
--		AI.PushGoal("gr_attack_defender_melee","timeout",1,0.5);
--		AI.PushGoal("gr_attack_defender_melee","signal",1,1,"SET_MELEE_TARGET",0);
--		AI.PushGoal("gr_attack_defender_melee","clear",1,0); -- kill the stick
--		AI.PushGoal("gr_attack_defender_melee","locate", 1, "refpoint");
--		AI.PushGoal("gr_attack_defender_melee","move",0,0.5,0.5,AILASTOPRES_USE);
--		AI.PushGoal("gr_attack_defender_melee","timeout",1,1.5);
--		AI.PushGoal("gr_attack_defender_melee","clear",0,0); -- kill the move
		AI.PushGoal("gr_attack_defender_melee","signal",1,1,"CHARGE_DONE",0);
		AI.PushGoal("gr_attack_defender_melee","signal",1,1,"END_ATTACK",0);

		AI.BeginGoalPipe("gr_attack_defender_melee2");
			AI.PushGoal("run",0,2);
			AI.PushGoal("firecmd",0,0);
	--		AI.PushGoal("gr_attack_defender_melee2","timeout",1,gr_settleShotTime);	--allow time to finish the shot
			AI.PushGoal("locate",0,"atttarget");
			AI.PushGoal("stick",1,8,AILASTOPRES_USE,STICK_BREAK+STICK_SHORTCUTNAV);
			AI.PushGoal("signal",1,1,"DO_MELEE",0);
			AI.PushGoal("locate", 0, "atttarget");
			AI.PushGoal("+charge", 1, 6.0, 8.0, AILASTOPRES_USE);
	
	--		AI.PushGoal("gr_attack_defender_melee2","move",0,2.5,1.0,AILASTOPRES_LOOKAT);
	--		AI.PushGoal("gr_attack_defender_melee2","timeout",1,0.2);
	--		AI.PushGoal("gr_attack_defender_melee2","signal",1,1,"DO_MELEE_ADVERTISE",0);
	--		AI.PushGoal("gr_attack_defender_melee2","timeout",1,0.7);
	--		AI.PushGoal("gr_attack_defender_melee2","signal",1,1,"DO_MELEE",0);
	--		AI.PushGoal("gr_attack_defender_melee2","timeout",1,3.0);
	--		AI.PushGoal("gr_attack_defender_melee2","clear",0,0); -- kill the move
	--		AI.PushGoal("gr_attack_defender_melee2","timeout",1,0.3);
			AI.PushGoal("signal",1,1,"END_ATTACK",0);
		AI.EndGoalPipe();

		AI.CreateGoalPipe("gr_scare_stick");
		AI.PushGoal("gr_scare_stick","firecmd",0,0);
		AI.PushGoal("gr_scare_stick","bodypos",0,BODYPOS_PRONE);
		AI.PushGoal("gr_scare_stick","run",0,2);
		AI.PushGoal("gr_scare_stick","locate",0,"trackpattern");
		AI.PushGoal("gr_scare_stick","+stick",1,0.5,AILASTOPRES_USE,STICK_SHORTCUTNAV);	--cont
--		AI.PushGoal("gr_scare_stick","+move",1,1,0.7,AILASTOPRES_USE);

		AI.CreateGoalPipe("gr_defender_melee_timeout");
		AI.PushGoal("gr_defender_melee_timeout","firecmd",0,0);
		AI.PushGoal("gr_defender_melee_timeout","locate",0,"atttarget");
		AI.PushGoal("gr_defender_melee_timeout","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_defender_melee_timeout","timeout",1,0.3);
		AI.PushGoal("gr_defender_melee_timeout","lookat",1,-500); --reset lookat
		AI.PushGoal("gr_defender_melee_timeout","timeout",1,0.3,0.6);
		AI.PushGoal("gr_defender_melee_timeout","signal",1,1,"END_ATTACK",0);

		AI.CreateGoalPipe("gr_scare_attack");
		AI.PushGoal("gr_scare_attack","firecmd",0,0);
		AI.PushGoal("gr_scare_attack","bodypos",0,BODYPOS_PRONE);
		AI.PushGoal("gr_scare_attack","run",0,2);
		AI.PushGoal("gr_scare_attack","locate",0,"trackpattern");
		AI.PushGoal("gr_scare_attack","+stick",1,2,AILASTOPRES_USE,STICK_SHORTCUTNAV);	--cont
--		AI.PushGoal("gr_scare_attack","+move",1,1,0.7,AILASTOPRES_USE);

		AI.CreateGoalPipe("gr_defender_hide");
		AI.PushGoal("gr_defender_hide","firecmd",0,0);
		AI.PushGoal("gr_defender_hide","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_defender_hide","run",0,1);
		AI.PushGoal("gr_defender_hide","hide",1,15,HM_FARTHEST_FROM_TARGET,1);
		AI.PushGoal("gr_defender_hide","locate",0,"atttarget");
		AI.PushGoal("gr_defender_hide","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_defender_hide","signal",1,1,"END_ATTACK",0);

		AI.CreateGoalPipe("gr_goto_defend_spot");
--		AI.PushGoal("gr_goto_defend_spot","locate",0,"refpoint");
		AI.PushGoal("gr_goto_defend_spot","+approach",1,1,AILASTOPRES_USE);
		AI.PushGoal("gr_goto_defend_spot","signal",1,1,"END_GOTO",0);

		AI.CreateGoalPipe("gr_repos_defender_melee");
		AI.PushGoal("gr_repos_defender_melee","run",0,1);
		AI.PushGoal("gr_repos_defender_melee","locate",0,"refpoint");
		AI.PushGoal("gr_repos_defender_melee","+approach",1,3,AILASTOPRES_USE);
		AI.PushGoal("gr_repos_defender_melee","locate",0,"atttarget");
		AI.PushGoal("gr_repos_defender_melee","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_repos_defender_melee","signal",1,1,"DO_DEFENDER_MELEE",0);

		AI.CreateGoalPipe("gr_goto_reinf");
		AI.PushGoal("gr_goto_reinf","run",0,1);
		AI.PushGoal("gr_goto_reinf","locate",0,"refpoint");
		AI.PushGoal("gr_goto_reinf","+approach",1,1,AILASTOPRES_USE);
		AI.PushGoal("gr_goto_reinf","signal",1,1,"END_GOTO",0);

		AI.CreateGoalPipe("gr_investigate_defend_spot");
--		AI.PushGoal("gr_investigate_defend_spot","locate",0,"refpoint");
		AI.PushGoal("gr_investigate_defend_spot","+approach",1,10,AILASTOPRES_USE);
		AI.PushGoal("gr_investigate_defend_spot","locate",0,"atttarget");
		AI.PushGoal("gr_investigate_defend_spot","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_investigate_defend_spot","locate",0,"refpoint");
		AI.PushGoal("gr_investigate_defend_spot","+approach",1,3,AILASTOPRES_USE);
		AI.PushGoal("gr_investigate_defend_spot","signal",1,1,"END_INVESTIGATE",0,2);

		AI.CreateGoalPipe("gr_protect_defend_spot");
--		AI.PushGoal("gr_protect_defend_spot","run",0,0);
		AI.PushGoal("gr_protect_defend_spot","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_protect_defend_spot","timeout",1,2,3);
		AI.PushGoal("gr_protect_defend_spot","firecmd",0,0);
		AI.PushGoal("gr_protect_defend_spot","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_protect_defend_spot","locate",0,"refpoint");
		AI.PushGoal("gr_protect_defend_spot","+approach",1,10,AILASTOPRES_USE);
		AI.PushGoal("gr_protect_defend_spot","locate",0,"atttarget");
		AI.PushGoal("gr_protect_defend_spot","+lookat",1,0,0,1); --lookat lastop
		AI.PushGoal("gr_protect_defend_spot","firecmd",0,FIREMODE_CONTINUOUS);
		AI.PushGoal("gr_protect_defend_spot","timeout",1,3,4);
		AI.PushGoal("gr_protect_defend_spot","firecmd",0,0);
		AI.PushGoal("gr_protect_defend_spot","timeout",1,gr_settleShotTime);	--allow time to finish the shot
		AI.PushGoal("gr_protect_defend_spot","signal",1,1,"END_ATTACK",0);

		AI.CreateGoalPipe("gr_paralyze");
		AI.PushGoal("gr_paralyze", "+ignoreall", 0,1);
		AI.PushGoal("gr_paralyze", "+firecmd", 0,0);
		AI.PushGoal("gr_paralyze", "+timeout", 1,10);
		AI.PushGoal("gr_paralyze", "+lookat",1,-170,170);
		AI.PushGoal("gr_paralyze", "+timeout", 1, 2);
		AI.PushGoal("gr_paralyze", "+lookat",1,-170,170);
		AI.PushGoal("gr_paralyze", "+timeout", 1, 2);
		AI.PushGoal("gr_paralyze", "+lookat",1,-30,30);
		AI.PushGoal("gr_paralyze", "+timeout", 1, 1);
		AI.PushGoal("gr_paralyze", "+lookat",1,-170,170);
		AI.PushGoal("gr_paralyze", "+timeout", 1, 0.5);
		AI.PushGoal("gr_paralyze", "+lookat",1,-70,70);
		AI.PushGoal("gr_paralyze", "+ignoreall", 0,0);
		AI.PushGoal("gr_paralyze", "+clear", 1);

		AI.CreateGoalPipe("gr_lookat_interested");
		AI.PushGoal("gr_lookat_interested","lookat",0,0,0,1); --lookat lastop
		AI.PushGoal("gr_lookat_interested","timeout",1,0.4,0.5);
		AI.PushGoal("gr_lookat_interested","lookat",1,-17,17);
		AI.PushGoal("gr_lookat_interested","timeout",1,0.3,0.5);
		AI.PushGoal("gr_lookat_interested","lookat",1,-17,17);
		AI.PushGoal("gr_lookat_interested","timeout",1,0.7,1.5);
		AI.PushGoal("gr_lookat_interested","lookat",0,0,0,1); --lookat lastop

		AI.CreateGoalPipe("gr_make_alerted");
		AI.PushGoal("gr_make_alerted","bodypos",0,BODYPOS_STEALTH);

		AI.CreateGoalPipe("gr_make_relaxed");
		AI.PushGoal("gr_make_relaxed","bodypos",0,BODYPOS_STAND);

		---------------------------------------------
		AI.CreateGoalPipe("gr_pursue_beacon");
		AI.PushGoal("gr_pursue_beacon","locate",0,"beacon");
		AI.PushGoal("gr_pursue_beacon","approach",1,1,AILASTOPRES_USE);
		AI.PushGoal("gr_pursue_beacon","signal",0,1,"PURSUE_DONE",0);

		---------------------------------------------
		AI.CreateGoalPipe("gr_pursue_target");
		AI.PushGoal("gr_pursue_target","approach",1,1);
		AI.PushGoal("gr_pursue_target","signal",0,1,"PURSUE_DONE",0);

		---------------------------------------------
		AI.CreateGoalPipe("gr_ambient_follow_path");
		AI.PushGoal("gr_ambient_follow_path","run",0,2);
		AI.PushGoal("gr_ambient_follow_path","firecmd",0,0);
		AI.PushGoal("gr_ambient_follow_path","bodypos",0,BODYPOS_PRONE);
		AI.PushGoal("gr_ambient_follow_path","followpath",1,1,0,1,-1);
		AI.PushGoal("gr_ambient_follow_path","signal",0,1,"SETUP_AMBIENT",0);

		---------------------------------------------
		AI.CreateGoalPipe("gr_ambient_wait");
		AI.PushGoal("gr_ambient_wait","timeout",1,0.1,0.2);
		AI.PushGoal("gr_ambient_wait","signal",0,1,"SETUP_AMBIENT",0);

		---------------------------------------------
		AI.CreateGoalPipe("coord_hide_from");
		AI.PushGoal("coord_hide_from","acqtarget",1,"");
		AI.PushGoal("coord_hide_from","run",0,0);
		AI.PushGoal("coord_hide_from","ignoreall",0,1);--don't lose/reaquire the target
		AI.PushGoal("coord_hide_from","hide",1,40,HM_NEAREST,1);
		AI.PushGoal("coord_hide_from","ignoreall",0,0);

		---------------------------------------------
		AI.CreateGoalPipe("coord_stick_refpoint");
		AI.PushGoal("coord_stick_refpoint","run",0,1);
		AI.PushGoal("coord_stick_refpoint","locate",1,"refpoint");
		AI.PushGoal("coord_stick_refpoint","+acqtarget",1,"");
		AI.PushGoal("coord_stick_refpoint","+ignoreall",0,1);--don't lose/reaquire the target
		AI.PushGoal("coord_stick_refpoint","+stick",0,1.5);
		AI.PushGoal("coord_stick_refpoint","+timeout",1,3);
		AI.PushGoal("coord_stick_refpoint","+clear",1);

		---------------------------------------------
		AI.CreateGoalPipe("coord_approach_attack_point");
		AI.PushGoal("coord_approach_attack_point", "locate",1,"refpoint");
		AI.PushGoal("coord_approach_attack_point", "approach",1,1,AILASTOPRES_USE);
		AI.PushGoal("coord_approach_attack_point", "signal",1,1,"APPROACH_POINT_REACHED",0);

		---------------------------------------------
		AI.CreateGoalPipe("coord_fire_timeout");
		AI.PushGoal("coord_fire_timeout", "timeout",1,2);
		AI.PushGoal("coord_fire_timeout", "signal",1,1,"END_FIRE_TIMEOUT",0);

		---------------------------------------------
		AI.CreateGoalPipe("coord_grenade_seen");
		AI.PushGoal("coord_grenade_seen", "backoff", 1, 7); 
		AI.PushGoal("coord_grenade_seen", "run", 1, 2); 

		---------------------------------------------
		AI.CreateGoalPipe("alien_paralyze");
		AI.PushGoal("alien_paralyze", "+ignoreall", 0,1);
		AI.PushGoal("alien_paralyze", "+clear", 1);
		AI.PushGoal("alien_paralyze", "+firecmd", 1,0);
		AI.PushGoal("alien_paralyze", "+timeout", 1,7);
		AI.PushGoal("alien_paralyze", "+ignoreall", 0,0);


		---------------------------------------------
		AI.BeginGoalPipe("grn_AlienHide");
			AI.PushGoal("signal",1,1,"ACC_READABILITY",0);
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("run", 0, 2);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("locate", 0, "refpoint");
			AI.PushGoal("approach",1,3,AILASTOPRES_USE,1,"MARK_HIDESPOT_UNREACHABLE");
			AI.PushGoal("signal",0,1,"UNBLOCK",0);
			AI.PushGoal("timeout", 1, 3,5);
			AI.PushGoal("signal",0,1,"TRACK_TARGET",0);	
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_MoveToAttTarget");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("run", 0, 0);

			AI.PushGoal("locate",0,"self");
			AI.PushGoal("proximity",0,20.0,"TARGET_CLOSE", AIPROX_VISIBLE_TARGET_ONLY);

			AI.PushGoal("locate", 0, "beacon");
			AI.PushGoal("approach",1,3,AILASTOPRES_USE);
			AI.PushGoal("timeout", 1,2);
			AI.PushGoal("signal",0,1,"SEEK_TARGET",0);
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_SeekHide");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("run", 0, 0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("locate", 0, "refpoint");
			AI.PushGoal("approach",1,3,AILASTOPRES_USE,1,"MARK_HIDESPOT_UNREACHABLE");
			AI.PushGoal("timeout", 1, 1,3);
			AI.PushGoal("signal",0,1,"SEEK_TARGET",0);	
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_MeleePause");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("run", 0, 0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE,1);
--			AI.PushGoal("approach",1,18);
--			AI.PushGoal("signal",0,1,"BLOCK_DODGE",0);
--			AI.PushGoal("signal",0,1,"THREATEN_READ",0);
--			AI.PushGoal("locate",0,"atttarget");
--			AI.PushGoal("lookat", 0, 0, 0, 1);
--			AI.PushGoal("animation",0,AIANIM_SIGNAL,"threaten");
--			AI.PushGoal("timeout", 1,2.7);
--			AI.PushGoal("signal",0,1,"UNBLOCK_DODGE",0);

			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("run",0,1);
			AI.PushGoal("locate",0,"atttarget");
			AI.PushGoal("stick",1,10,AILASTOPRES_USE,STICK_BREAK);

			AI.PushGoal("run",0,2);
			AI.PushGoal("locate", 0, "atttarget");
			AI.PushGoal("+charge", 1, 12.0, 6.0, AILASTOPRES_USE);
			AI.PushGoal("signal",1,1,"END_ATTACK",0);

--			AI.PushGoal("signal",0,1,"START_MELEE",0); 
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_Melee");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("run",0,2);
			AI.PushGoal("locate",0,"atttarget");
			AI.PushGoal("+stick",1,10,AILASTOPRES_USE,STICK_BREAK);
--			AI.PushGoal("run",0,2);
			AI.PushGoal("locate", 0, "atttarget");
			AI.PushGoal("+charge", 1, 12.0, 6.0, AILASTOPRES_USE);
			AI.PushGoal("signal",1,1,"END_ATTACK",0);
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_MeleeShort");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("run",0,1);
			AI.PushGoal("locate",0,"atttarget");
			AI.PushGoal("stick",1,8,AILASTOPRES_USE,STICK_BREAK+STICK_SHORTCUTNAV);
--			AI.PushGoal("run",0,2);
			AI.PushGoal("signal",1,1,"BLOCK_DODGE",0);
			AI.PushGoal("locate", 0, "atttarget");
			AI.PushGoal("+charge", 1, 4.0, 6.0, AILASTOPRES_USE);
			AI.PushGoal("signal",1,1,"END_ATTACK",0);
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_MeleeShortPause");

			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("run",0,1);

			AI.PushGoal("signal",0,1,"BLOCK_DODGE",0);
			AI.PushGoal("signal",0,1,"THREATEN_READ",0);
			AI.PushGoal("locate",0,"atttarget");
			AI.PushGoal("lookat", 0, 0, 0, 1);
			AI.PushGoal("animation",0,AIANIM_SIGNAL,"threaten");
			AI.PushGoal("timeout", 1,2.7);
			AI.PushGoal("signal",0,1,"UNBLOCK_DODGE",0);

			AI.PushGoal("locate",0,"atttarget");
			AI.PushGoal("stick",1,8,AILASTOPRES_USE,STICK_BREAK+STICK_SHORTCUTNAV);
--			AI.PushGoal("run",0,2);
			AI.PushGoal("signal",1,1,"BLOCK_DODGE",0);
			AI.PushGoal("locate", 0, "atttarget");
			AI.PushGoal("+charge", 1, 4.0, 6.0, AILASTOPRES_USE);
			AI.PushGoal("signal",1,1,"END_ATTACK",0);
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_MeleeDodge");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("run",0,2);
			
			AI.PushGoal("locate", 0, "beacon");
			AI.PushGoal("+dodge",1,4.0,1);
			AI.PushGoal("timeout",1,0.2);
			
			AI.PushGoal("signal",1,1,"CONTINUE_MELEE",0);
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_HideDodge");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("run",0,1);
			
			AI.PushGoal("locate", 0, "beacon");
			AI.PushGoal("+dodge",1,4.0,1);
			
			AI.PushGoal("signal",1,1,"CONTINUE_HIDE",0);
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_RangeAttack");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("bodypos", 0, BODYPOS_PRONE);
			AI.PushGoal("run",0,2,1,30);
			AI.PushGoal("firecmd",0,1);
			AI.PushGoal("strafe",0,100,100);
			AI.PushGoal("locate",0,"atttarget");
			AI.PushGoal("+stick",1,6,AILASTOPRES_USE,STICK_BREAK);
--			AI.PushGoal("timeout",1,3,5);
			AI.PushGoal("signal",1,1,"END_ATTACK",0);
		AI.EndGoalPipe();

		---------------------------------------------
		AI.BeginGoalPipe("grn_RangeAttackLong");
			AI.PushGoal("firecmd",0,0);
			AI.PushGoal("bodypos", 0, BODYPOS_STEALTH);
			AI.PushGoal("run",0,0);
			AI.PushGoal("firecmd",0,1);
			AI.PushGoal("timeout",1,4,6);
			
			AI.PushGoal("signal",1,1,"END_ATTACK",0);
		AI.EndGoalPipe();

		
	AI.LogEvent("ALIEN PIPES LOADED");
end
