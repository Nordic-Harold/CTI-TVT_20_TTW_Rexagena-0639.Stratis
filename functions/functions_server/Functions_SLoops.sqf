/*
	Script written by TeeTime dont remove this comment
*/

/*
	For a Restart without a Restart
*/
Tee_Server_Restart = {

	if(TW_Server_Restart) exitWith {};
	TW_Server_Restart = true;

	//Repair Everything
	{
		_x setDamage 0;
	} forEach ((getPos hq_west) nearObjects 5000);
	
	sleep 8;
	
	//Kill all Units
	{
		_x setDamage 1;
	} forEach allUnits;
	
	//Kill all Player
	{
		_x setDamage 1;
	} forEach playableUnits;

	//Vehicles
	{
		if(!(_x in _basicvehicles)) then {deleteVehicle _x;};
	} forEach vehicles;
	
	//Bodies
	{
		deleteVehicle _x;
	} forEach allDead;
	
	//Towns
	[] spawn Tee_Server_CreateTownMarker;

	//Base
	[] call Tee_Server_Base_Set_Base;
	[] call Tee_Server_Base_Build_West;
	[] call Tee_Server_Base_Build_East;
	
	TW_Server_Restart 	= false;
	TW_Mission_End 		= false;
	publicVariable "TW_Mission_End";
};



//Server Loops
Tee_Server_CleanUp = {
	private ["_i","_w","_basicvehicles","_shops","_shoploc","_wspawn_loc","_espawn_loc","_vehiclearray","_vehiclearraynew","_found"];
	if(isDedicated) then {diag_log "Report: CleanUp Started";};
	if(TW_HC_Client) then {diag_log "Report: HC Server Loop Started";};
	
	_i = 0;
	_basicvehicles 		= vehicles;	//List of all Vehicles at Missionstart
	_shops 				= [hq_west,west_shop_veh,west_shop_weapons,west_shop_ai,hq_east,east_shop_veh,east_shop_weapons,east_shop_ai];
	_shoploc 			= [];
	_vehiclearray		= [];
	_vehiclearraynew 	= [];
	TW_Server_HQPos		= [getPos hq_west,getPos hq_east];	//Save HQ Pos for Noob Protection
	
	waitUntil {HQ_placed};
	//Save Shop Locations
	{
		_shoploc = _shoploc + [[_x,getPos _x]];
	} forEach _shops;

	
	while {true} do {
	
			//Check Shops
		//	{
		//		if((_x select 0) distance (_x select 1) > 2) then {
		//			(_x select 0) setPos (_x select 1);
		//		};
		//	} forEach _shoploc;	
	
	
		//Check for Missionend
		if(time > (3600 * TW_roundtime)) then {
			TW_Mission_End = true;
			publicVariable "TW_Mission_End";
			if(TW_restart) then {
				TW_roundtime = TW_roundtime + TW_roundtime;
				[] spawn Tee_Server_Restart;
			} else {
				endMission "END1";
			};
		};
	

		//Check for HC
		if(time > 120) then {
			if(isPlayer TW_HC_ClientSlot) then {
				//TW_HC_Activ	= true;		//TeeTimeTest	mal deaktiviert
			} else {
				//TW_HC_Activ	= false;	//TeeTimeTest	mal deaktiviert
			};
		};
		
		
		//Check HQ Pos Anti Water Protection
		if(surfaceIsWater (getPos hq_west)) then {
			hq_west setPos (TW_Server_HQPos select 0);
			hq_west setDir 90;
			hq_west setFuel 0;
			hq_west lock true;
			
			if(alive (driver hq_west)) then {
				(driver hq_west) setDamage 1;
			};
		};
		if(surfaceIsWater (getPos hq_east)) then {
			hq_east setPos (TW_Server_HQPos select 1);
			hq_east setDir 90;
			hq_east setFuel 0;
			hq_east lock true;
			if(alive (driver hq_east)) then {
				(driver hq_east) setDamage 1;
			};
		};
	
	
		//Clean
		if(_i >= 10) then {
			_i = 0;
			
			//Bodies
			{
				deleteVehicle _x;
			} forEach allDead;
	
			//Groups
			{
				if(count units _x == 0) then {
					deleteGroup _x;
				};
			} forEach allGroups;
	
			//Vehicles
			{
				if(! alive _x && !(_x in _basicvehicles)) then {deleteVehicle _x;};
			} forEach vehicles;
			
			//Inaktiv Vehicles
			_vehiclearray 		= _vehiclearraynew;
			_vehiclearraynew 	= [];
			{
				if(alive _x && count (crew _x) == 0 && !(_x in _basicvehicles)) then {
					_found = false;
					for [{_w=0},{_w<= count _vehiclearray},{_w=_w+1}] do {
						if(_x == ((_vehiclearray select _w) select 0)) then {
							if((getPos _x) distance ((_vehiclearray select _w) select 1) < 1) then {
								deleteVehicle _x;
							} else {
									_vehiclearraynew = _vehiclearraynew + [[_x,getPos _x]];
							};
							_found = true;	
						};
					};
					if(!_found) then {
						_vehiclearraynew = _vehiclearraynew + [[_x,getPos _x]];
					};
				};
			} forEach vehicles;
		};
		
		
		//Report
		if(isDedicated) then {diag_log format ["Report: Server FPS %1",diag_fps];};
		if(TW_HC_Client) then {diag_log format ["Report: HC FPS %1",diag_fps];};
		
		
		//End
		_i = _i + 1;
		sleep 60;
	};
};