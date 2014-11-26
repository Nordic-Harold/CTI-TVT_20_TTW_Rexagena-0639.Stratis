/*
	Script written by TeeTime dont remove this comment
*/

/*
	Can the given Town be captured?
*/
Tee_Stra_TowncanCap = {
	private ["_object","_side","_array"];	

	_object = _this select 0;	//Town
	_side	= _this select 1;	//TW_playerside

	_array	= [];
	_return	= false;
	
	//Get Street Array
	{
		if(_x select 0 == _object) exitWith {_array = _x select 1;};
	} forEach TW_Town_StreetArray;
	
	//Check
	{
		if(_x getVariable "TownSide" == _side) exitWith { _return = true };
	} forEach _array;
	
	_return
};



/*
	Can the given Town be captured contains basic checks too
*/
Tee_Stra_TowncanCap_Basic = {
	private ["_object","_side","_town","_return"];
	
	_object = _this select 0;	//Town
	_side	= _this select 1;	//TW_playerside

	_return	= false;
	
	
	//Check if First Town
	_return	= true;
	{
		_town = _x select 0;
		if(_side == _town getVariable "TownSide") then {
			_return	= false;
		};
	} forEach TW_TownArray;
	
	
	//Normal Check
	if(!_return) then {
		{
			_return = [_object,_side] call Tee_Stra_TowncanCap;
		} forEach TW_TownArray;
	};
	
	
	//Place for more Checks
	
	_return
};