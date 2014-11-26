/*
	Script written by TeeTime dont remove this comment
*/
Tee_GetWeap_Name = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 1;};
	} forEach Tee_Weapon_Array;
	_return
};



Tee_GetWeap_Class = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 2;};
	} forEach Tee_Weapon_Array;
	_return
};



Tee_GetWeap_Price = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 3;};
	} forEach Tee_Weapon_Array;
	_return
};



Tee_GetWeap_Typ = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 5;};
	} forEach Tee_Weapon_Array;
	_return
};



Tee_AddWeapon = {
	private ["_id","_class","_price","_text"];
	
	_id		= 	_this select 0;
	_class	=	_id call Tee_GetWeap_Class;
	_price	= 	_id call Tee_GetWeap_Price;
	
	if(debug) then {
		player groupChat "Wep";
		player groupChat _class; 
	};
	
	if(Tee_Konto < _price) exitWith {
		titleText[localize "STRS_buy_nomoney", "PLAIN DOWN"];	//Msg
	};
	Tee_Konto = Tee_Konto - _price;
	
	player addWeapon _class;
	
	_text = format [localize "STRS_Konto2", Tee_Konto];
	titleText[_text, "PLAIN DOWN"];	//Msg
	
	//Save Gear
	[] call Tee_SS_Gear_Save;
};



Tee_AddMag  = {
	private ["_id","_class","_price"];
	
	_id		= 	_this select 0;
	_class	=	_id call Tee_GetWeap_Class;
	_price	= 	_id call Tee_GetWeap_Price;
	
	if(debug) then {
		player groupChat "Mag";
		player groupChat _class;
	};
	
	if(Tee_Konto < _price) exitWith {
		titleText[localize "STRS_buy_nomoney", "PLAIN DOWN"];	//Msg
	};
	Tee_Konto = Tee_Konto - _price;
	
	player addMagazine _class;
	
	_text = format [localize "STRS_Konto2", Tee_Konto];
	titleText[_text, "PLAIN DOWN"];	//Msg
	
	//Save Gear
	[] call Tee_SS_Gear_Save;
};



Tee_AddItem = {
	private ["_id","_class","_price"];
	
	_id		= 	_this select 0;
	_class	=	_id call Tee_GetWeap_Class;
	_price	= 	_id call Tee_GetWeap_Price;
	
	if(debug) then {
		player groupChat "Item";
		player groupChat _class;
	};
	
	if(Tee_Konto < _price) exitWith {
		titleText[localize "STRS_buy_nomoney", "PLAIN DOWN"];	//Msg
	};
	Tee_Konto = Tee_Konto - _price;
	
	player addItem _class;
	
	_text = format [localize "STRS_Konto2", Tee_Konto];
	titleText[_text, "PLAIN DOWN"];	//Msg
	
	//Save Gear
	[] call Tee_SS_Gear_Save;
};