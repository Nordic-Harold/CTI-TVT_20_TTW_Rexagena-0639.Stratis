/*
	Script written by TeeTime dont remove this comment
*/
Tee_Client_CreateTownMarker = {
	private ["_object","_markername","_text","_marker"];	
	{
		_object 	= _x select 0;
		_markername = _x select 1;
		_text		= _x select 2;
		
		//Create Marker
		_marker = CreateMarkerLocal [_markername, position _object];
		_marker setMarkerShapeLocal "Icon"; 
		_marker setMarkerTypeLocal "mil_circle";
		_marker setMarkerTextLocal format["%1 100/100",_text];
		_marker setMarkerColorLocal "ColorBlack";
		
	} forEach TW_TownArray;
};



/*
	Called on all Client who took the last points
*/
Tee_Town_Captured = {
	private ["_object","_side"];	

	_object = _this select 0;
	_marker	= _this select 1;
	
	_side	= TW_playerside;
	
	//Colouring of town marker
	_marker setMarkerColorLocal TW_playerside_colour;
	_marker setMarkerTextLocal format["%1 100/100",_name];
		
	TW_Town_Taken = [_object,_side];
	publicVariable "TW_Town_Taken";
	TW_Town_Taken_Server = [_object,_side];
	publicVariable "TW_Town_Taken_Server";
	
	if(isServer && !isDedicated) then {
		TW_Town_Taken_Server spawn Tee_Server_Town_CreateAIDef;
		TW_Town_Taken_Server spawn Tee_Server_Town_Repair;
	};
};



/*
	Called on all Clients when a Town got captured
*/
Tee_Town_Captured_2 = {
	private ["_object","_side","_detected"];	

	_object = _this select 0;
	_side	= _this select 1;
	_name   = [_object] call CT_FindTownName;
		
	if(player distance _object <= TW_Town_CapDis && _side == TW_playerside) then {
		Tee_Konto = Tee_Konto + Tee_Money_TownCap;
						
		_text = format [localize "STRS_town_takenbonus",Tee_Money_TownCap];
		titleText[_text, "PLAIN DOWN"];	//Msg
	};
	
	// If a side has detected that town and if the player belongs to side opposite of one that captured the town - show message
	diag_log "Tee_Town_Captured_2";
	_detected = _object getVariable "TownDetected";
	diag_log format ["_detected: %1, _object: %2",_detected,_object];
	diag_log format ["TW_playerside: %1",TW_playerside];
	
	if (TW_playerside != _side && !(isNil "_detected") && (TW_playerside in _detected)) then {
		diag_log "message will be dispatched";
		_text = format [localize "STRS_town_captured",_name,[_side] call CT_GetSideName];
		diag_log _text;
		hintSilent _text;		
	};
};



Tee_AttackTown = {
	private ["_object","_unitcount","_name","_points","_marker","_text","_detected"];
	while{true} do {
	
		waitUntil{alive player};
		
		{
			_object = _x select 0;
			_marker = _x select 1;
			_name 	= _x select 2;
			
			if(player distance _object <= TW_Town_CapDis) then {
				_points = _object getVariable "TownPoints";
			
				if(TW_playerside != _object getVariable "TownSide") then {
					
					//Check if town can be caped in strategic mode
					if(!([_object,TW_playerside] call Tee_Stra_TowncanCap_Basic) && TW_Strategic_Street) exitWith {
						_text = format [localize "STRS_town_cantcapstrat"];
						titleText[_text, "PLAIN DOWN"];	//Msg
					};
					
					//Count near AI units
					_unitcount = 0;
					{
						if(_x distance _object <= TW_Town_CapDis) then {
							_unitcount = _unitcount + 1;
						};
					} forEach (units (group player));
					
					_points = _points - (5 * _unitcount);
					
					if(debug) then {
						_points = _points - 20;
					};
					
					if(_points <= 0) then {
						_object setVariable ["TownSide",TW_playerside , true];
						_object setVariable ["TownPoints", 100, true];
						
						// #9 bug fix
						hint format ["Objective %1 has been captured by %2.",_name,[TW_playerside] call CT_GetSideName];
						
						//_marker = _object getVariable "TownMarker";
						
						//TeeTimeTest	gedoppelt
						//_marker setMarkerColorLocal TW_playerside_colour;
						//_marker setMarkerTextLocal format["%1 100/100",_name];
					
						Tee_Konto = Tee_Konto + Tee_Money_TownCap;
						
						_text = format [localize "STRS_town_takenbonus",Tee_Money_TownCap];
						titleText[_text, "PLAIN DOWN"];	//Msg

						//Create AI Def
						//[_object] call Tee_Town_Captured;
						[_object,_marker,TW_playerside_colour] call Tee_Town_Captured;
						
					} else {
						_object setVariable ["TownPoints", _points, true];
						_marker setMarkerTextLocal format["%1 %2/100",_name,_points];
					
						_text = format [localize "STRS_town_points",_points];
						titleText[_text, "PLAIN DOWN"];	//Msg
					};
				} else {
					if(_points < 100) then {
						_points = _points + 5;
						_object setVariable ["TownPoints", _points, true];
					};
				};
			} else {
				//Scout Town
				_detected = _object getVariable "TownDetected";
				
				if (isNil "_detected") then {
					_detected = [];
				};
					
				if( !(TW_playerside in _detected) && (player distance _object <= TW_Town_DecDis) && !TW_Para_satintel) then {
					
					Tee_Konto = Tee_Konto + Tee_Money_TownScout;
					_text = format [localize "STRS_town_scoutbonus",Tee_Money_TownScout];
					titleText[_text, "PLAIN DOWN"];	//Msg
	
					_detected = _detected + [TW_playerside];
					_object setVariable ["TownDetected", _detected , true];
				};
			};	
		} forEach TW_TownArray;
		
		sleep 30;
	};
};

CT_GetSideName = {
	private ["_side","_result"];
	
	_side = _this select 0;
	
	if (_side=="west") then {
		_result = "NATO forces";
	}
	else{
		_result = "CSAT forces";
	};
	
	_result
};

CT_FindTownMarker= {
	private ["_obj"];
	_obj= _this select 0;
	_return= "";
	{
		if(_x select 0 == _obj) then {_return = _x select 1};
	} foreach TW_TownArray;
	
	_return
};
CT_FindTownName= {
	private ["_obj"];
	_obj= _this select 0;
	_return= "";
	{
		if(_x select 0 == _obj) then {_return = _x select 2};
	} foreach TW_TownArray;
	
	_return
};