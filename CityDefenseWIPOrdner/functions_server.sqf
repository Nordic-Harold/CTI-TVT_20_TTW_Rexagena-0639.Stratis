
Tee_Server_Town_CreateAIDef = {
	private ["_object","_side","_groupside","_group","_unitarray","_unit"];	

	_object = _this select 0;
	_side 	= _this select 1;
	
	_pos 	= getPos _object;
	
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
	
	if(_side == "resistance") then {									//Neu, beinhaltet resistance gruppen, muss bei Ausrüstung beachtet werden! (unten)
		_groupside	= resistance;
		//All Units in this array will be in the same group!
		_unitarray	= [
			9001,9002,9003
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
		
		if(_side== "resistance") then														//Neu, rüstet Einheiten der Resitanceseite mit Waffen aus
		{
			{
				_unit = [_group,_x call Tee_GetUnit_Class,_pos] call Tee_CreateUnit;
				_unit addMagazine ["30Rnd_65x39_caseless_green", 12];
				_unit addWeapon "arifle_Katiba_C_ACO_pointer_F";
				
				sleep 0.25;
			} forEach _unitarray;
		};
		sleep 2;
																							//Wegpunkte hier einfügen
		sleep 2;
	};	
};