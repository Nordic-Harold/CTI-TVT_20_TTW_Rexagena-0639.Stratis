/*
	Script written by TeeTime dont remove this comment
*/
Tee_Server_Init = {
	"TW_Town_Taken_Server" addPublicVariableEventHandler {
		TW_Town_Taken_Server spawn Tee_Server_Town_CreateAIDef;
		TW_Town_Taken_Server spawn Tee_Server_Town_Repair;
	};
	"TW_Player_Kick" addPublicVariableEventHandler {TW_Player_Kick call Tee_Server_KickPlayer;};
	"TW_Mission_End" addPublicVariableEventHandler {
		if(TW_restart) then {
			[] spawn Tee_Server_Restart;
		} else {
			endMission "END1";
		};
	};
};


/*
	Init Variables and Values for choosen gamemode
*/
Tee_Server_Init_Values = {
	private ["_i","_value","_array"];
	
	//Towns
	_array = [];
	TW_Para_Towns = TW_Para_Towns min (count TW_TownArray);	//Catch wrong input
	for [{_i=0},{_i<TW_Para_Towns},{_i=_i+1}] do {
		_array = _array + [TW_TownArray select _i];
	};
	TW_TownArray = _array;
	
	//Mehr
	_array = [];
};



//Kick Player
Tee_Server_KickPlayer = {
	serverCommand format["#kick %1",call compile _this];
};



//Base
Tee_Server_Base_Set_Base = {
	private ["_pos","_sel_1","_sel_2"];
	
	_pos = TW_BasePos_Array select (round(random (count TW_BasePos_Array - 1)));
	
	if((random 2) < 1) then {
		_sel_1 = 0;
		_sel_2 = 1;
	} else {
		_sel_1 = 1;
		_sel_2 = 0;
	};
	
	hq_west setPos (getMarkerPos (_pos select _sel_1));
	hq_west setDir 90;
	hq_west lock true;
	hq_west lockCargo true;
	if(isDedicated) then {diag_log format["Report: WestMarker %1 - WestHQPos %2",(getMarkerPos (_pos select _sel_1)),(getPos hq_west)];};
	PosHqWest = getPos hq_west;
	
	hq_east setPos (getMarkerPos (_pos select _sel_2));
	hq_east setDir 90;
	hq_east lock true;
	hq_east lockCargo true;
	PosHqEast = getPos hq_east;
	
	if(isDedicated) then {diag_log format["Report: EastMarker %1 - EastHQPos %2",(getMarkerPos (_pos select _sel_2)),(getPos hq_east)];};
	
	if(isDedicated) then {diag_log "Report: HQ Placed";};
};



Tee_Server_Base_Build_West = {
	diag_log "Tee_Server_Base_Build_West starting...";
	private ["_hq","_marker","_text","_actioncode"];

	_hq = hq_west;
	
	//Set Veh Spawn
	west_shop_veh setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 10,(getPos _hq) select 2];
	"west_vehspawn" setMarkerPos [((getPos _hq) select 0) - 10,((getPos _hq) select 1),(getPos _hq) select 2];	//Nicht genutzt	
	
	//Create Respawn. milivojm => I've put this AFTER setting vehicle position.
	_marker = CreateMarkerLocal [TW_West_Respawn, [((getPos west_shop_veh) select 0) + 5,((getPos west_shop_veh) select 1) -10,(getPos west_shop_veh) select 2]];		//TeeTimeTest	Marker ist Lokal
	//"respawn_west" setMarkerPos [((getPos _hq) select 0) + 5,(getPos _hq) select 1,(getPos _hq) select 2];
	
	if(isDedicated) then {diag_log format["Report: Respawn West Placed %1",getMarkerPos TW_West_Respawn];};	
		
	diag_log format["Report: west_shop_veh position placed %1",getPos west_shop_veh];
	
	//Set Weapon Shop
	west_shop_weapons setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 5,(getPos _hq) select 2];
	
	//Set AI Shop
	west_shop_ai setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) - 5,(getPos _hq) select 2];
	
	if(isDedicated) then {diag_log "Report: Westbase Build";};
};



Tee_Server_Base_Build_East = {
	private ["_hq","_marker","_text","_actioncode"];
	
	_hq = hq_east;	
	
	//Set Veh Spawn
	east_shop_veh setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 10,(getPos _hq) select 2];
	"east_vehspawn" setMarkerPos [((getPos _hq) select 0) - 10,((getPos _hq) select 1),(getPos _hq) select 2];	//Nicht genutzt
	
	//Create Respawn. milivojm => I've put this AFTER setting vehicle position.
	_marker = CreateMarkerLocal [TW_East_Respawn, [((getPos east_shop_veh) select 0) + 5,((getPos east_shop_veh) select 1) -10,(getPos east_shop_veh) select 2]];		//TeeTimeTest	Marker ist Lokal
	//"respawn_east" setMarkerPos [((getPos _hq) select 0) + 5,(getPos _hq) select 1,(getPos _hq) select 2];
	
	if(isDedicated) then {diag_log format["Report: Respawn East Placed %1",getMarkerPos TW_East_Respawn];};
	
	//Set Weapon Shop
	east_shop_weapons setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 5,(getPos _hq) select 2];
		
	//Set AI Shop
	east_shop_ai setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) - 5,(getPos _hq) select 2];
	
	if(isDedicated) then {diag_log "Report: Eastbase Build";};
};

// Stop units callouts and shouting
client_code = {

    if (isDedicated) exitWith {};

    [] spawn {
        waitUntil {!(isNull player) && (time > 0)};
        enableSentences false;
        showSubtitles false;
        player addMPEventHandler ["MPRespawn", { enableSentences false; showSubtitles false; }];
    };

};

publicVariable "client_code";

// Execute everywhere incl. JIP
[[], "client_code", nil, true, true] call BIS_fnc_MP;  