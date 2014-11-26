/*
	Script written by TeeTime dont remove this comment
*/

Tee_GetUnit_Name = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 1;};
	} forEach Tee_AI_Array;
	_return
};



Tee_GetUnit_Class = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 2;};
	} forEach Tee_AI_Array;
	_return
};



Tee_GetUnit_Price = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 3;};
	} forEach Tee_AI_Array;
	_return
};



Tee_GetUnit_Side = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 5;};
	} forEach Tee_AI_Array;
	_return
};



Tee_CreateUnit = {
	private ["_group","_class","_pos","_unit"];
	
	_group		= 	_this select 0;
	_class		=	_this select 1;
	_pos		=	_this select 2;

	_unit = _group createUnit [_class, _pos, [], 0, "FORM"];
	
	_unit addEventHandler ["killed", "_this call Tee_AI_Killed;"];
	
	_unit
};



Tee_BuyUnit = {
	private ["_id","_class","_price","_group","_unit","_text"];
	
	_id		= 	_this select 0;
	_class	=	_id call Tee_GetUnit_Class;
	_price	= 	_id call Tee_GetUnit_Price;
	
	_group = group player;
	
	if(debug) then {
		player groupChat "AI";
		player groupChat _class; 
	};
	
	if(!TW_ai) exitWith {
		titleText[localize "STRS_buy_ai_noserver", "PLAIN DOWN"];	//Msg
	};
	
	if(player != leader group player) exitWith {
		titleText[localize "STRS_buy_ai_notleader", "PLAIN DOWN"];	//Msg
	};
	
	if(Tee_Konto < _price) exitWith {
		titleText[localize "STRS_buy_nomoney", "PLAIN DOWN"];	//Msg
	};
	if(count (units _group) >= (TW_AI_max + 1)) exitWith {
		titleText[localize "STRS_buy_ai_limit", "PLAIN DOWN"];	//Msg
	};
	
	Tee_Konto = Tee_Konto - _price;
	
	_unit = [_group,_class,position player] call Tee_CreateUnit;

	_text = format [localize "STRS_Konto2", Tee_Konto];
	titleText[_text, "PLAIN DOWN"];	//Msg
};
