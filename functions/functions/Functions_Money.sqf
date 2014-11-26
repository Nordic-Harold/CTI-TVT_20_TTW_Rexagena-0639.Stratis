/*
	Script written by TeeTime dont remove this comment
*/
Tee_ShowMoney = {
	hintSilent format [localize "STRS_Konto",Tee_Konto];	//Msg
};



Tee_Money_Substract = {
	if(Tee_Konto > _this) then {
		Tee_Konto = Tee_Konto - _this;
	} else {
		Tee_Konto = 0;
	};
};



Tee_MoneyLoop = {
	private ["_i","_count","_enemycount"];
	while{true} do {
		sleep 60;
		_i			= 0; // I hope he meant to init this var to 0, otherwise there are undefined errors below (GunnyTomHighway)
		_count 		= 0;
		_enemycount	= 0;
		
		//Basic
		Tee_Konto = Tee_Konto + Tee_Money_Min;
		//Towns
		{
			_object = _x select 0;
			if(TW_playerside == _object getVariable "TownSide") then {
				Tee_Konto = Tee_Konto + Tee_Money_Town;
				_count = _count + 1;
			} else {
				if("civ" != _object getVariable "TownSide") then {
					_enemycount = _enemycount + 1;
				};
			};	
		} forEach TW_TownArray;
		
		//TK Counter Reduce
		if(_i >= 10) then {
			TW_TK_Counter = TW_TK_Counter - 1;
			_i = 0;
		};
		
		//End Mission Loser
		if(_enemycount == count TW_TownArray && !TW_Mission_End) exitWith {
			TW_Mission_End = true;
			publicVariable "TW_Mission_End";
		};
		
		//End Mission Winner
		if(_count == count TW_TownArray && !TW_Mission_End) exitWith {
			TW_Mission_End = true;
			publicVariable "TW_Mission_End";
		};
		
		_i = _i + 1;
	};
};
