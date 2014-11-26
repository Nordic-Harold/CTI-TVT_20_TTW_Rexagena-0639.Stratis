//Funktion löst tote Einheit aus gruppe
//Typ: Funktion
//Bsp: this addeventhandler ["killed",{ _this call fnc_AIDef_AIKilled}];
private ["_killed","_killer","_grp","_units","_alive_units","_CheckDone"];

_killed=			_this select 0;									//getötete Einheit
_killer=			_this select 1;									//Killer

_grp= 				group _killed;									//Gruppe der getöteten Einheit
_units= 			units _grp;										//Einheiten der Gruppe

_killed spawn fnc_AIDef_AIKilled_HideBody;

[_killed] join grpNull;												//Getötete KI wird aus Gruppe gelöscht

//Wenn keine Einheiten mehr in Gruppe vorhanden, löscht die Engine die Gruppe automatisch, folgendes zur absicherung
if(!IsNull _grp and count units _grp== 0) then
{
	deleteGroup _grp;
	_grp= grpNull;
};