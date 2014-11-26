/*
	Script written by TeeTime dont remove this comment
*/
/*
	Repair Function
	Must be spawned
*/
Tee_Sup_Repair = {
	private ["_i","_vehicle","_pos","_damage","_text"];	

	_vehicle = vehicle player;
	_pos	= getPos _vehicle;
	_damage = getDammage _vehicle;
	
	if(_damage == 0) exitWith {
		titleText[localize "STRS_repair_cant", "PLAIN DOWN"];	//Msg
	};
	
	if(Tee_Konto < TW_Repair_Cost) exitWith {
		titleText[localize "STRS_repair_nomoney", "PLAIN DOWN"];	//Msg
	};
	
	Tee_Konto = Tee_Konto - TW_Repair_Cost;
	_vehicle engineOn false;
	
	_text = format [localize "STRS_repair_started", TW_Repair_Time];
	titleText[_text, "PLAIN DOWN"];	//Msg
	
	for [{_i=0},{_i< TW_Repair_Time},{_i=_i+5}] do {
		sleep 5;

		if(getPos _vehicle distance _pos > 1) exitWith {
			titleText[localize "STRS_repair_aborted", "PLAIN DOWN"];	//Msg
		};
		
		_vehicle setDammage (getDammage _vehicle - (_damage / (TW_Repair_Time / 5))); 
		titleText[localize "STRS_repair_msg", "PLAIN DOWN"];	//Msg
	};
	
	_vehicle setDammage 0;
	titleText[localize "STRS_repair_end", "PLAIN DOWN"];	//Msg
};



/*
	Refuel Function
	Must be spawned
*/
Tee_Sup_Refuel = {
	private ["_i","_vehicle","_pos"];	

	_vehicle = vehicle player;
	_pos	= getPos _vehicle;
	
	if(fuel _vehicle == 1) exitWith {
		titleText[localize "STRS_refuel_full", "PLAIN DOWN"];	//Msg
	};
	
	if(Tee_Konto < TW_Sup_Fuel_Cost) exitWith {
		titleText[localize "STRS_refuel_nomoney", "PLAIN DOWN"];	//Msg
	};
	
	Tee_Konto = Tee_Konto - TW_Sup_Fuel_Cost;
	_vehicle engineOn false;
	
	titleText[localize "STRS_refuel_started", "PLAIN DOWN"];	//Msg
	
	while {fuel _vehicle < 1} do {
		sleep TW_Sup_Fuel_Time;

		if(getPos _vehicle distance _pos > 1) exitWith {
			titleText[localize "STRS_refuel_aborted", "PLAIN DOWN"];	//Msg
		};
		
		_vehicle setFuel ((fuel _vehicle + 0.1) min 1);
		titleText[localize "STRS_refuel_status", "PLAIN DOWN"];	//Msg
	};

	titleText[localize "STRS_refuel_end", "PLAIN DOWN"];	//Msg	
};



/*
	Reammo Function
	Must be spawned
	
	
*/
Tee_Sup_Reammo = {
	private ["_i","_vehicle","_pos","_text"];	

	_vehicle = vehicle player;
	_pos	= getPos _vehicle;
	
	if(Tee_Konto < TW_Sup_Reammo_Cost) exitWith {
		titleText[localize "STRS_ammo_nomoney", "PLAIN DOWN"];	//Msg
	};
	
	Tee_Konto = Tee_Konto - TW_Sup_Reammo_Cost;
	_vehicle engineOn false;
	
	_text = format [localize "STRS_ammo_started", TW_Sup_Reammo_Time];
	titleText[_text, "PLAIN DOWN"];	//Msg
	
	sleep TW_Sup_Reammo_Time;

	if(getPos _vehicle distance _pos > 1) exitWith {
		titleText[localize "STRS_ammo_aborted", "PLAIN DOWN"];	//Msg
	};
		
	_vehicle setVehicleAmmo 1;
	titleText[localize "STRS_ammo_end", "PLAIN DOWN"];	//Msg
};

