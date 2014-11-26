//TeeTimes Warfare AICityDef WPGenerator
//Autor: Cthulhu
//Version: 0.1
//Beschreibung: Erstellt eine durch eine Variable definierte Anzahl an Wegpunkten für eine Gruppe und lässt die Gruppe diese abgehen.
//
//Parameter:	Variable	Format
//				_guard		Gruppe		
//				_pos		Position
//				_areasize	Array [x,y,number,boolean], wie bei settriggerarea
//
//
//
//
//Benötigte Variablen
//	name						Format		Funktion
//	c_AIDef_WP_Radius			Zahl		Radius, der Verteidigt werden soll
//	c_AIDef_WP_Count       		Zahl		Anzahl der WP basiert auf 1 (wenn c_AIDef_WP_Count=5, werden 5 Wegpunkte erstellt)
//	c_AIDef_WP_Behaviour		String		http://community.bistudio.com/wiki/setWaypointBehaviour		
//	c_AIDef_WP_CombatMode		String		http://community.bistudio.com/wiki/setWaypointCombatMode	
//	c_AIDef_WP_Formation		String		http://community.bistudio.com/wiki/setWaypointFormation		
//	c_AIDef_WP_Speed			String		http://community.bistudio.com/wiki/setWaypointSpeed			
//	c_AIDef_WP_Type				String		http://community.bistudio.com/wiki/setWaypointType
//
//<-------------------------------------------------------------------------------------------------->

//#define __RTPos(params) [params] call Bier_fnc_RandomTriggerPos

//Funktion erstellt wegpunkt, returns: Array format [Gruppe,WegpunktID]
//_guard		Gruppe
//_pos			Position		
//_areasize		format wie triggerarea

private ["_guard","_pos","_waypoint","_wp","_wp1_pos","_wp_pos","_OnWater"];

_guard=			_this select 0;
_pos= 			_this select 1;
_areasize=		_this select 2;				//format wie bei settriggerarea
_wp=			[];
_wp_pos=		[];

//Erstellt Position
_wp_pos=  [_pos,_areasize,"Ground"] call C_RandomPos;

//player sidechat format ["%1,%2",_guard,_pos];

if(count (waypoints _guard) == c_AIDef_WP_Count && c_AIDef_WP_Count > 1 ) then  {
	_wp1		=	(waypoints _guard) select 0;		//Erster Wegpunkt der Gruppe
	_wp1_pos	=	getWPPos _wp1;
	_wp_pos		=	_wp1_pos;	
	
	_waypoint	= 	_guard addwaypoint [_wp_pos,0];	//Erstellen des Letzten wegpunktes == position des ersten (wegen cycle)
	_wp			=	[_guard,c_AIDef_WP_Count];
} else {
	_waypoint= 		_guard addwaypoint [_wp_pos,c_AIDef_WP_Radius];
	_wp=			[_guard,(count waypoints _guard)-1];
};

if((_wp select 1)== c_AIDef_WP_Count) then {
	_wp setwaypointtype "CYCLE";

} else {
	_wp setwaypointtype c_AIDef_WP_Type;
};
	
_wp setWaypointBehaviour c_AIDef_WP_Behaviour;	
_wp setWaypointCombatMode c_AIDef_WP_CombatMode;
_wp setWaypointFormation c_AIDef_WP_Formation;
_wp setWaypointSpeed c_AIDef_WP_Speed;
