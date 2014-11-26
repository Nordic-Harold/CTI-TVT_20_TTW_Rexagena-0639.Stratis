/*
	Script written by TeeTime dont remove this comment
*/
Tee_Base_Create_Marker = {
	diag_log "Tee_Base_Create_Marker starting...";
	private ["_marker","_name"];
	
	waitUntil {HQ_placed};
	waitUntil {!(isNil "PosHqWest") && !(isNil "PosHqEast")};
	
	diag_log "HQ_placed is set, PosHqEast and PosHqWest are set";
	diag_log format ["PosHqWest:%1, PosHqEast:%2",PosHqWest,PosHqEast];
	diag_log format["getPos west_shop_veh: %1",getPos west_shop_veh];
	
	//West
	if(TW_playerside == "west") then {
		//Create Respawn
		_marker = CreateMarkerLocal [TW_West_Respawn, [(PosHqWest select 0) + 5,(PosHqWest select 1), PosHqWest select 2]];		//TeeTimeTest	Marker ist Lokal
	
		//HQ
		_marker = CreateMarkerLocal [TW_West_BaseMarker, position hq_west];
		_marker setMarkerTypeLocal "flag_NATO";
		_marker setMarkerSize [2, 2];

/*		
		//Shops
		//Vehicle
		//_name = format ["sh_m_%1_%2",floor(time),floor(random(1000))];
		_marker = CreateMarkerLocal [TW_West_ShopMarker_V, getPos west_shop_veh];
		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal "Vehicle";
		
		//Weapon
		//_name = format ["sh_m_%1_%2",floor(time),floor(random(1000))];
		_marker = CreateMarkerLocal [TW_West_ShopMarker_G, getPos west_shop_weapons];
		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal "Armory";
		
		//AI
		//_name = format ["sh_m_%1_%2",floor(time),floor(random(1000))];
		_marker = CreateMarkerLocal [TW_West_ShopMarker_AI, getPos west_shop_ai];
		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal "Barracks";
*/			
	};
	
	//East
	if(TW_playerside == "east") then {
		//Create Respawn
		_marker = CreateMarkerLocal [TW_East_Respawn, [(PosHqEast select 0) + 5,(PosHqEast select 1),PosHqEast select 2]];		//TeeTimeTest	Marker ist Lokal
	
		_marker = CreateMarkerLocal [TW_East_BaseMarker, position hq_east];
		_marker setMarkerTypeLocal "flag_CSAT";
		
/*		
		//Shops
		//Vehicle
		//_name = format ["sh_m_%1_%2",floor(time),floor(random(1000))];
		_marker = CreateMarkerLocal [TW_East_ShopMarker_V, getPos east_shop_veh];
		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal "Vehicle";
		
		//Weapon
		//_name = format ["sh_m_%1_%2",floor(time),floor(random(1000))];
		_marker = CreateMarkerLocal [TW_East_ShopMarker_G, getPos east_shop_weapons];
		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal "Armory";
		
		//AI
		//_name = format ["sh_m_%1_%2",floor(time),floor(random(1000))];
		_marker = CreateMarkerLocal [TW_East_ShopMarker_AI, getPos east_shop_ai];
		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerTextLocal "Barracks";
*/
		};
	
	TW_HQ_Placed_Client = true;
};



Tee_Client_Base_Build_West = {
	diag_log "Tee_Client_Base_Build_West starting...";
	private ["_hq","_marker"];

	_hq = hq_west;
	diag_log format ["getPos _hq: %1",getPos _hq];
	diag_log format ["getPos west_shop_veh: %1",getPos west_shop_veh];
	//Set Respawn
	TW_West_Respawn setMarkerPosLocal [((getPos west_shop_veh) select 0) + 5,((getPos west_shop_veh) select 1) - 10,(getPos west_shop_veh) select 2];	//TeeTimeTest	Marker ist Lokal

	
	//Set Veh Spawn
	west_shop_veh setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 10,(getPos _hq) select 2];
	"west_vehspawn" setMarkerPos [((getPos _hq) select 0) - 10,((getPos _hq) select 1),(getPos _hq) select 2];	//Nicht genutzt	
	
	diag_log format ["After set veh pos getPos west_shop_veh: %1",getPos west_shop_veh];
	
	//Set Weapon Shop
	west_shop_weapons setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 5,(getPos _hq) select 2];
	
	//Set AI Shop
	west_shop_ai setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) - 5,(getPos _hq) select 2];
};




Tee_Client_Base_Build_East = {
	private ["_hq","_marker"];
	
	_hq = hq_east;

	//Set Respawn
	TW_East_Respawn setMarkerPosLocal [((getPos east_shop_veh) select 0) + 5,((getPos east_shop_veh) select 1) - 10,(getPos east_shop_veh) select 2];	//TeeTimeTest	Marker ist Lokal
	
	//Set Veh Spawn
	east_shop_veh setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 10,(getPos _hq) select 2];
	"east_vehspawn" setMarkerPos [((getPos _hq) select 0) - 10,((getPos _hq) select 1),(getPos _hq) select 2];	//Nicht genutzt
	
	//Set Weapon Shop
	east_shop_weapons setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) + 5,(getPos _hq) select 2];
		
	//Set AI Shop
	east_shop_ai setPosATL [(getPos _hq) select 0,((getPos _hq) select 1) - 5,(getPos _hq) select 2];
};



//Mobilze HQ
Tee_Client_Base_DeMobHQ = {
	private ["_hq"];
	
	if(TW_playerside == "west") then {
		_hq = hq_west;
	};
	if(TW_playerside == "east") then {
		_hq = hq_east;
		
	};
	
	//Start Voting
	["HQ"] spawn Tee_Vote_Start;
	sleep (TW_Vote_Time + 2);
	
	if(!TW_Vote_Result) exitWith {};	//Exit if Voting failed
	
	//Mob HQ
	player moveInDriver _hq;
	_hq setFuel 1;
	_hq lock false;
	
	
	if(TW_playerside == "west") then {
		//[] spawn Tee_Client_Base_Build_West;
	};
	if(TW_playerside == "east") then {
		//[] spawn Tee_Client_Base_Build_East;
	};	
};



//Build HQ
Tee_Client_Base_HQ_setUp = {
	private ["_hq","_exit","_text"];
	
	if(TW_playerside == "west") then {
		_hq = hq_west;
	};
	if(TW_playerside == "east") then {
		_hq = hq_east;
		
	};
	
	if(player != (driver _hq)) exitWith {};

	//Check Towns
	_exit = false;
	{
			if(_hq distance (_x select 0) < TW_Base_TownProtection) exitWith {
				_exit = true;
			};

	} forEach TW_TownArray;
	
	if(_exit) exitWith {
		_text = format [localize "STRS_hq_towntoclose",TW_Base_TownProtection];
		titleText[_text, "PLAIN DOWN"];	//Msg
	};
	
	//Set HQ
	_hq setDir 90;
	moveOut player;
	_hq setFuel 0;
	_hq lock true;

	
	if(TW_playerside == "west") then {
		[] spawn Tee_Client_Base_Build_West;
	};
	if(TW_playerside == "east") then {
		[] spawn Tee_Client_Base_Build_East;
	};	
};