Tee_HC_Init = {
	diag_log Report HC Init Started;										//Befehl diag_log erwartet String
	
	Variables																//Auskommentieren
	TW_HC_ClientSlot = player;
	publicVariable TW_HC_ClientSlot;										//Befehl publicvariable erwartet String
	
	Stellt den HC kalt														//Auskommentieren
	player setVehicleInit this allowDamage false;;
	player attachTo [base,[0,0,-10]];

	Eventhandler															//Auskommentieren
	TW_Town_Taken_Server addPublicVariableEventHandler {					//Fällt bei Auslösung von aus Server weg;Variablennamen müssen String sein
		TW_Town_Taken_Server spawn Tee_Server_Town_CreateAIDef;
	};

	TW_Mission_End addPublicVariableEventHandler {							//Variablennamen müssen String sein
		if(TW_restart) then {
			[] call Tee_HC_Restart;
		} else {
			endMission END1;
		};
	};
	
	//Erstellen der Stadtverteidigung
	"TW_HC_TownAttacked" addPublicVariableEventHandler {
		_params= _this select 1;
		_params call HC_Town;
		};
	
	diag_log Report HC Init Finished;										//Befehl diag_log erwartet String
};

HC_TownDefence = {
private ["_object","_Townside","_name"];

	_object= 		_this select 0;
	_name=			_this select 1;
	_TownSide= 		_this select 2;
	
	[_object,_TownSide] spawn Tee_Server_Town_CreateAIDef;
	
	if(debug) then {player groupChat "AI Def HC Spawn";};
	if(debug) then {diag_log format ["Report: HC Defense created for %1, side: ",_name,_TownSide];}; //Townside wurde ebenso in die Debugnachricht mit aufgenommen//Hinzugefügt zu den Debug Nachrichten
};
