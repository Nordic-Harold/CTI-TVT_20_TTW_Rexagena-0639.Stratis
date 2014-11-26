/*
	Script written by TeeTime dont remove this comment
*/

Tee_Server_CreateTownMarker = {
	private ["_object","_markername","_text","_marker"];
	{
		_object 	= _x select 0;
		_markername = _x select 1;
		_text		= _x select 2;
	
/*	
		//Make Object undestroyable
		_object setVehicleInit "this allowDamage false;";
		processInitCommands;
*/
		
		//SetVariable
		_object setVariable ["TownSide", "civ", true];	//Owning side
		_object setVariable ["TownPoints", 100, true];	//Town Points
		_object setVariable ["TownDetected", [], true];	//Side who deteced the town
		//_object setVariable ["TownMarker", _marker, true];
		
		//Init Def
		if(!TW_HC_Activ) then {
			[_object] spawn Tee_Server_Town_InitAIDef;
			sleep 1;
			
			if(debug) then {player groupChat "AI Def Server Spawn";};	
		};
	} forEach TW_TownArray;
};



Tee_Server_Town_InitAIDef = {
	private ["_i","_object","_group","_unitarray","_unit"];	

	_object = _this select 0;
	
	_pos 	= getPos _object;
	
	//All Units in this array will be in the same group!
	_unitarray	= [
		9008,9006,9004,9002,9003
	];
	
	//Create Unit
	for [{_i=0},{_i<TW_AI_Def_lvl},{_i=_i+1}] do {
	
		_group	= createGroup resistance;
		
		{
			_unit = [_group,_x call Tee_GetUnit_Class,_pos] call Tee_CreateUnit;
				//removeallWeapons _unit;
				_unit addMagazines ["30Rnd_556x45_Stanag", 12];
				_unit addMagazine "HandGrenade";
				_unit addWeapon "arifle_TRG20_ACO_pointer_F";
				
			sleep 0.25;
		} forEach _unitarray;
		
		//Patrols
		if(TW_AI_Patrols) then {
			[_group,_pos] call CT_AI_Addwaypoints;
		};
		
		sleep 4;
	};
	
	// remember that resistance AI has been created
	_object setVariable ["AIDefSide","resistance"];
};



/*
	Creates AI Defense for the owning side west/east
*/
Tee_Server_Town_CreateAIDef = {
	private ["_object","_side","_groupside","_group","_unitarray","_unit","_lastAIside"];	

	//Messages
	if(TW_HC_Activ && isDedicated) exitWith {};
	if(isServer && isDedicated) then {diag_log "Report: Server Defense created for Captured Town";};
	if(TW_HC_Client) then {diag_log "Report: HC Defense created for Captured Town";};	
	
	_object = _this select 0;
	_side 	= _this select 1;

	_lastAIside = _object getVariable "AIDefSide";
	diag_log format ["_lastAIside: %1",_lastAIside];
	_pos 	= getPos _object;
	
	// if the function has been called multiple times by several capping players, ignore the subsequent calls
	if (_lastAIside == _side) exitWith {};
	
	if(_side == "west") then {
		_groupside	= west;
		//All Units in this array will be in the same group!
		_unitarray	= [
			7001,7002,7003
		];
	};
	
	if(_side == "east") then {
		_groupside	= east;
		//All Units in this array will be in the same group!
		_unitarray	= [
			6001,6002,6003
		];
	};
	
	//Create Unit
	for [{_i=0},{_i<TW_AI_Def_lvl},{_i=_i+1}] do {
		//Create new Group
		_group		= createGroup _groupside;
		
		//Create Units
		{
			_unit = [_group,_x call Tee_GetUnit_Class,_pos] call Tee_CreateUnit;
			
			sleep 0.25;
		} forEach _unitarray;
		
		//Patrols
		if(TW_AI_Patrols) then {
			[_group,_pos] call CT_AI_Addwaypoints;
		};
		
	//	CT_AIDefMonitor_Groups= CT_AIDefMonitor_Groups	+ [_group];
		
		sleep 4;
	};	
	
	_object setVariable ["AIDefSide",_side];
	diag_log format ["AIDefSide variable set to: %1 for object: %2", _side, _object];
};



/*
	Repairs a town after it has been taken by a side to reduce Lag
	Must be spawned
*/
Tee_Server_Town_Repair = {
	private ["_town","_objects"];	

	if(TW_HC_Activ && isDedicated) exitWith {};
	if(isDedicated) then {diag_log "Report: Server Town Repairing started";};
	if(TW_HC_Client) then {diag_log "Report: Town Repairing started";};
	
	_town = _this select 0;
	
	sleep 120;	//Wait 2 Minutes to let player leave the area
	
	_objects = (getPos _town) nearObjects ["Building",150];
	
	//Repair Towns
	{
		if(damage _x > 0) then {
			_x setDamage 0;
			sleep 5;
		};
	} forEach _objects;
};
