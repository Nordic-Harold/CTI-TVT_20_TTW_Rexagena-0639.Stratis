/*
	Script written by TeeTime dont remove this comment
*/
//Player Marker and Marker Uodate
Tee_PlayerMarker_Loop = {
	private ["_i","_markerarray","_name","_type","_marker","_object","_text","_detected","_points","_side","_colour","_text","_actioncode","_action"];
	
	waitUntil {HQ_placed};
	
	_markerarray = [];
	
	while {true} do {
		_i = 0;
		
		//Delete PlayerMarker
		{
			deleteMarkerLocal _x;
		} forEach _markerarray;
		
		
		//Create PlayerMarker
		{
			_i = _i + 1;
			_name = format ["PlMa_%1",_i];
			if(alive _x && isPlayer _x && playerSide == side _x) then {
			
				if(vehicle _x == _x) then {
					_type = "n_inf";
				} else {
					_type = "b_motor_inf";
				};
			
				_marker = CreateMarkerLocal [_name, position _x];
				_marker setMarkerShapeLocal "Icon";
				_marker setMarkerTypeLocal _type;
				_marker setMarkerTextLocal name _x;
				
				_markerarray = _markerarray + [_marker];
			};
		} forEach playableUnits;
		
		
		//Update HQ
		if(TW_playerside == "west") then {
			TW_West_BaseMarker setMarkerPosLocal (getPos hq_west);
			TW_West_ShopMarker_V setMarkerPosLocal (getPos west_shop_veh);
			TW_West_ShopMarker_G  setMarkerPosLocal (getPos west_shop_weapons);
			TW_West_ShopMarker_AI setMarkerPosLocal (getPos west_shop_ai);
		};
		if(TW_playerside == "east") then {
			TW_East_BaseMarker setMarkerPosLocal (getPos hq_east);
			TW_East_ShopMarker_V setMarkerPosLocal (getPos east_shop_veh);
			TW_East_ShopMarker_G  setMarkerPosLocal (getPos east_shop_weapons);
			TW_East_ShopMarker_AI setMarkerPosLocal (getPos east_shop_ai);
		};
		
		
		//Update Town
		{
			_object 	= _x select 0;
			_name 		= _x select 1;
			_text		= _x select 2;
			
			_detected 	= _object getVariable "TownDetected";
			_points 	= _object getVariable "TownPoints";
			_side 		= _object getVariable "TownSide";
			
			if (isNil "_side") then {
				_side = "civ";
			};

			if (isNil "_detected") then {
				_detected = [];
			};
			
			_colour		= "";
			

			//Mark Captureable Towns
			if([_object,TW_playerside] call Tee_Stra_TowncanCap && TW_Strategic_Street && _side!= TW_playerside) then {
				_colour = "ColorOrange";
				_name setMarkerColorLocal _colour;	//TeeTimeTest unschön weil gedoppelt siehe Unten
			};
			
			//Set Town Colors
			if(TW_playerside in _detected || TW_Para_satintel) then {
				_name setMarkerTextLocal format["%1 %2/100",_text,_points];
			
				if(_side == "civ") then {_colour = "ColorBlack";};
					//Mark Captureable Towns
					if([_object,TW_playerside] call Tee_Stra_TowncanCap && TW_Strategic_Street && _side!= TW_playerside) then {
						_colour = "ColorOrange";
					};
				if(_side == "west") then {_colour = "ColorBlue";};
				if(_side == "east") then {_colour = "ColorRed";};
				
				_name setMarkerColorLocal _colour;
			};
		} forEach TW_TownArray;
		
		
		//Update Respawn
		TW_West_Respawn setMarkerPosLocal [((getPos west_shop_veh) select 0) + 5,((getPos west_shop_veh) select 1) - 10,(getPos west_shop_veh) select 2];	//TeeTimeTest	Marker ist Lokal
		TW_East_Respawn setMarkerPosLocal [((getPos east_shop_veh) select 0) + 5,((getPos east_shop_veh) select 1) - 10,(getPos east_shop_veh) select 2];	//TeeTimeTest	Marker ist Lokal
	
		//Basic Values
		if(playerside == west) 	then { TW_playerside = "west"; TW_playerside_colour = "ColorBlue";};
		if(playerside == east) 	then { TW_playerside = "east"; TW_playerside_colour = "ColorRed";};
		
		sleep 10;
	};
};



Tee_Marker_ConnectMarker = {
	private ["_base1","_base2","_xdif","_ydif","_xpos","_ypos","_pos","_marker"];
	
	_base1 = getPos (_this select 0);
	_base2 = getPos (_this select 1);
	
	_xdif = (_base1 select 0) - (_base2 select 0);
	_ydif = (_base1 select 1) - (_base2 select 1);
	
	_xpos = (_base1 select 0) - _xdif / 2;
	_ypos = (_base1 select 1) - _ydif / 2;
	
	_pos	= [_xpos,_ypos,0];
	_dir	= atan ( _xdif / _ydif );
	
	//player globalChat str _pos;
	
	_name 	= format ["CM_%1_%2",floor(time),floor(random(1000))];
	_type	= "RECTANGLE";
	
	_marker = CreateMarkerLocal [_name, _pos];
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerBrushLocal "Solid";
	_marker setMarkerDirLocal _dir;
	_marker setMarkerSizeLocal [3, ((_base1 distance _base2) / 2) -25 ];	//Auf 95% runter wegen Optik
	_marker setMarkerColorLocal "ColorBlack";
	_marker setMarkerAlphaLocal 0.3;
};

//By Cthulhu
//Function CT_Marker_CreateConnections
CT_Marker_CreateConnections=
{
	private ["_cnt_Towns","_max_Towns","_TownArray","_Town","_Connections"];	

	_cnt_Towns= count TW_Town_StreetArray;
	_max_Towns= _cnt_Towns - 1;

	for "_i" from 0 to _max_Towns do
	{
		_TownArray= TW_Town_StreetArray select _i;
		
		_Town= _TownArray select 0;
		_Connections= _TownArray select 1;
		
		{
			[_Town,_x] call Tee_Marker_ConnectMarker;
		} foreach _Connections;
	};
};