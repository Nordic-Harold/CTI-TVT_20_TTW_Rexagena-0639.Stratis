
/*
	Script written by TeeTime dont remove this comment
*/
Tee_Init_Client = {

	//Variables
	if(playerside == west) 	then { TW_playerside = "west"; TW_playerside_colour = "ColorBlue";};
	if(playerside == east) 	then { TW_playerside = "east"; TW_playerside_colour = "ColorRed";};

	//if(player in TW_westplayer_array) then { TW_playerside = "west"; TW_playerside_colour = "ColorBlue";};		//For Later
	//if(player in TW_eastplayer_array) then { TW_playerside = "east"; TW_playerside_colour = "ColorRed";};			//For Later

	
	//Eventhandler
	player addEventHandler ["killed", "_this call Tee_Player_Killed;"];
	
	"TW_Vote_Start" addPublicVariableEventHandler {TW_Vote_Start spawn Tee_Vote_Started;};
	
	"TW_Player_Killed" addPublicVariableEventHandler {TW_Player_Killed call Tee_Player_Killed_Pub;};
	
	"TW_AI_Killed" addPublicVariableEventHandler {TW_AI_Killed call Tee_AI_Killed_Pub;};
	
	"TW_Town_Taken" addPublicVariableEventHandler {TW_Town_Taken call Tee_Town_Captured_2;};
	
	"TW_Mission_End" addPublicVariableEventHandler {
		if(TW_restart) then {
			[] spawn Tee_Client_Restart;
		} else {
			endMission "END1";
		};
	};
	
	
	//Functions
	[] call Tee_Grp_Init;
};



/*
	Init Variables and Values for choosen gamemode
*/
Tee_Player_Init_Values = {
	private ["_i","_value","_array"];
	
	//Towns
	_array = [];
	TW_Para_Towns = TW_Para_Towns min (count TW_TownArray);	//Catch wrong input
	for [{_i=0},{_i<TW_Para_Towns},{_i=_i+1}] do {
		_array = _array + [TW_TownArray select _i];
	};
	TW_TownArray = _array;
	
	//Mehr
	_array = [];
};



Tee_Client_Restart = {
	titleText[localize "STRS_restart", "PLAIN DOWN"];	//Msg
	
	sleep 15;
	Tee_Konto = 1000;
	[] spawn Tee_Client_Base_Build_West;	//TeeTimeTest
	[] spawn Tee_Client_Base_Build_East;	//TeeTimeTest
	
	titleText[localize "STRS_restart2", "PLAIN DOWN"];	//Msg
	
	TW_Mission_End = false;
};

