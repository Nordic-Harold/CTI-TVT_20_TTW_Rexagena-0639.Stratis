/*
	Script written by TeeTime dont remove this comment
*/

Tee_HC_Init = {
	diag_log "Report: HC Init Started";
	
	//Swicht HC Into HC Object
	//selectPlayer twhc_1;
	
	//Variablen
	TW_HC_ClientSlot = player;
	publicVariable "TW_HC_ClientSlot";
	
	//Stellt den HC kalt
	//player setVehicleInit "this allowDamage false;";
	player attachTo [base,[0,0,-10]];

	//Eventhandler
	"TW_Town_Taken_Server" addPublicVariableEventHandler {
		TW_Town_Taken_Server spawn Tee_Server_Town_CreateAIDef;
		TW_Town_Taken_Server spawn Tee_Server_Town_Repair;
	};

	"TW_Mission_End" addPublicVariableEventHandler {
		if(TW_restart) then {
			[] call Tee_HC_Restart;
		} else {
			endMission "END1";
		};
	};
	
	diag_log "Report: HC Init Finished";
};



/*
	Init Variables and Values for choosen gamemode
*/
Tee_HC_Init_Values = {
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
	
	
	
	//End
	diag_log "Report: HC Values updated";
};
