/*
	Script written by TeeTime dont remove this comment
*/

Tee_GetVeh_Name = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 1;};
	} forEach Tee_Veh_Array;
	_return
};



Tee_GetVeh_Class = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 2;};
	} forEach Tee_Veh_Array;
	_return
};



Tee_GetVeh_Price = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 3;};
	} forEach Tee_Veh_Array;
	_return
};



Tee_GetVeh_Typ = {
	private ["_return"];
	_return = 0;
	{
		if(_this == _x select 0) exitWith {_return = _x select 5;};
	} forEach Tee_Veh_Array;
	_return
};



Tee_CreateVehicle = {
	private ["_id","_class","_price","_typ","_text","_veh", "_box"];
	
	_id		= 	_this select 0;
	_class	=	_id call Tee_GetVeh_Class;
	_price	= 	_id call Tee_GetVeh_Price;
	_typ	= 	_id call Tee_GetVeh_Typ;
	
	if(!TW_vehicles && _typ != "Box") exitWith {
		titleText[localize "STRS_buy_vehicle_noserver", "PLAIN DOWN"];	//Msg
	};
	
	if(!TW_air && _typ == "Air") exitWith {
		titleText[localize "STRS_buy_vehicle_noserver", "PLAIN DOWN"];	//Msg
	};
	
	if(Tee_Konto < _price) exitWith {
		titleText[localize "STRS_buy_nomoney", "PLAIN DOWN"];	//Msg
	};
	
	Tee_Konto = Tee_Konto - _price;
	
	_text = format [localize "STRS_Konto2", Tee_Konto];
	titleText[_text, "PLAIN DOWN"];	//Msg

	//Create
//	_veh = _class createVehicle (position player);
//	_veh setVehicleVarName format["veh_%1_%2",floor(time),floor(random(10))];

		_box = createVehicle [_class, ((position player) findEmptyPosition[ 2 , 100 , _class ]),[], 0, "CAN_COLLIDE"];
		_box addaction ["<t color = '#D00808'>Open crate</t>","scripts\ammobox.sqf",[], 6, true, true, "", "(_this distance (_target))<3 and !(player in _target)"];  


/*
	//Lock/Unlock Action
	if(_typ != "Box") then {
		_veh lock true;
		TW_Vehicle_Client = TW_Vehicle_Client + [_veh];
	
		//Action
		_text		= "Lock/Unlock";
		_actioncode	= format ["[%1] call Tee_Vehicle_Lock;",_veh];
		//_action 	= _veh addAction [_text, AddActionCode,_actioncode];
	} else {
		//Action
		//_text		= "Open Box";
		//_actioncode	= format ['createGearDialog [player, "RscDisplayGear"];',_veh];
		//_action 	= _veh addAction [_text, AddActionCode,_actioncode];
	
		//player groupchat str weaponCargo _veh;	//Debug
	};
*/	
/*

	//Box Lock/Unlock Action
	if(_typ != "Box") then {
		_veh lock true;
		TW_Vehicle_Client = TW_Vehicle_Client + [_veh];
		//Action
		//_text		= "Lock/Unlock";
		//_actioncode	= format ["[%1] call Tee_Vehicle_Lock;",_veh];
		//_action 	= _veh addAction [_text, AddActionCode,_actioncode];
	} else {
		//Action
		_text		= "Open Box";
		_actioncode	= format ["createGearDialog [player, "RscDisplayGear"];", _veh];
		_action 	= _veh addAction [_text, AddActionCode,_actioncode];
		
		//player groupchat str weaponCargo _veh;	//Debug
	};
*/

};



/*
//	Lock Unlock given Vehicle

Tee_Vehicle_Lock = {
	private ["_veh","_locked","_dis","_dis2"];
	
	_veh 	= _this select 0;
	
	//Work Arround
	_dis2 	= 999;
	{
		_dis = player distance _x;
		if(alive _x && _dis < _dis2) then {
			_dis2 = _dis;
			_veh = _x;
		};
	} forEach TW_Vehicle_Client;
	//Work Arround

	_locked	= locked _veh;

	if(_locked == 2) then {
		_veh lock false;
		titleText[localize "STRS_lock_open", "PLAIN DOWN"];	//Msg
	} else {
		_veh lock true;
		titleText[localize "STRS_lock_closed", "PLAIN DOWN"];	//Msg
	};	
};
*/