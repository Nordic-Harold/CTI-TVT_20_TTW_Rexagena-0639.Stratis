//Neue Variable:	TownAttacked		boolean 		serverseitig
//					TW_HC_TownAttacked	Array			HC seitig
//
//Neue Addvariableeventhandler in Tee_HC_Init
//Neue Funktionen: 	HC_CityDefence		Tee_HC_Init
//					
//
//
//
//
//
//
//
// Ablauf:
//
// Spieler nähert sich Stadt an, bei bestimmter Entfernung sendet dieser an den Server eine Nachricht mit Array [_object,_name]. Der Server Empfängt diese Nachricht und in "fnc_AIDef_TownSurvey.sqf" wird diese verwertet. Die Stadt wird auf angriff gestellt und an den HC (falls existiert) wird eine Nachricht geschickt, mit Inhalt der Stadt, dessen Name und der Seite. Diese wird vom HC empfangen (durch Variable TW_HC_TownAttacked) und dieser erstellt die Einheiten. Wenn HC nicht existiert, übernimmt Server diese Aufgabe.
// Die Instanz, die die Einheiten erstellt überprüft in einem bestimmten intervall, ob noch feindkräfte im Bereich der Stadt sind bzw. ob die Stadt eingenommen wurde. 
// 1. Wenn keine feindeinheiten (relativ zur Seite der Stadt) mehr in der Umgebung sind, werden alle Einheiten und deren Gruppen gelöscht.
// 2. Wenn die Stadt eingenommen wurde, werden alle Einheiten der ursprünglichen Seite und deren Gruppen gelöscht.



_object= 		_this select 0;									//Stadt	
_name=			_this select 1;									//Name der Stadt
_TownSide= 		_object getvariable "TownSide";					//Seite der Stadt
_TownAttacked= 	_object getvariable "TownAttacked";				//Wird Stadt bereits angegriffen

if(TW_playerside != _TownSide and _TownAttacked) exitwith {};	 //Nochmalige überprüfung der Seiten kann gelöscht werden

//Variable setzen, dass Stadt angegriffen wird
_object setvariable ["TownAttacked",true];						//Ziele sollten vorher alle false gesetzt werden	

//HC soll nun Einheiten erstellen, wenn vorhanden, sonst server
f(!TW_HC_Activ) then 
{
	[_object,_TownSide] spawn Tee_Server_Town_CreateAIDef;
} 
else 
{
	TW_HC_TownAttacked = [_object,_name,_TownSide];					
	publicvariable "HC_TownAttacked";
};

