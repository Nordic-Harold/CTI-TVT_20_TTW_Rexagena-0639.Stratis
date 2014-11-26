//Script by Cthulhu

//Überwacht Variable VAR_PH und löst Stadtverteidigung aus
//Script wird einmal Server/HC seitig aufgerufen, läuft dann ständig
//Aufruf: execVM/spawn

//VAR_PH -> Platzhalter für die Liste der Städte, die angegriffen werden

#include "macros.sqf"

private ["_sleep","_cnt","_max","_Town","_TownSide","_TownAttacked"];
_sleep= 		10;

while {true} do
{
	_cnt= 		__cnt;
	_max= 		__maxArray(VAR_PH);
	
	if(_cnt <0) then
	{
		for "_i" from 0 to _max do
		{
			_Town= 				__sel(VAR_PH,_i);
			
			_TownSide=			__GVAR(_town,TownSide);
			_TownAttacked= 		__GVAR(_town,TownAttacked);
			
			player sidechat format ["Town:%1, Attacked:%2",_Town,_TownSide,_TownAttacked];
			/*
			if(!_TownAttacked) then
			{
				// KI und Überwachungsscript aufrufen
				__SVAR(_Town,TownAttacked,true);
			};
			*/
			
			sleep 0.5;
		};
	};

	sleep _sleep;
};