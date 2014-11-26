/*
	Script written by TeeTime dont remove this comment
*/

Tee_HC_CreateTownDefense = {
	private ["_object","_markername","_text","_marker"];
	{
		_object 	= _x select 0;
		_text		= _x select 2;
		
		//Init Def
		[_object] spawn Tee_Server_Town_InitAIDef;
		
		if(debug) then {player groupChat "AI Def HC Spawn";};
		diag_log format ["Report: HC Defense created for %1",_text];
		sleep 1;
	} forEach TW_TownArray;
};
