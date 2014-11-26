//TeeTimes Warfare AICityDef WPGenerator
//Autor: Cthulhu
//Version: 0.1
//Beschreibung: Erstellt eine durch eine Variable definierte Anzahl an Wegpunkten für eine Gruppe und lässt die Gruppe diese abgehen.
//
//Parameter:	Variable	Format
//				_guard		Gruppe		
//				_pos		Position
//
//Bsp:			[group player,position player] call fnc_AIDef_CreateWaypoints;
//
//
//x steht für beliebigen präfix
//Benötigte Variablen
//	name					Format		Funktion
//	x_AIDef_WP_Radius		Zahl		Radius, der Verteidigt werden soll
//	x_AIDef_WP_Count        Zahl		Anzahl der WP basiert auf 1 (wenn x_AIDef_WP_Count=5, werden 5 Wegpunkte erstellt)
//	x_AIDef_WP_Behaviour	String		http://community.bistudio.com/wiki/setWaypointBehaviour		
//	x_AIDef_WP_CombatMode	String		http://community.bistudio.com/wiki/setWaypointCombatMode	
//	x_AIDef_WP_Formation	String		http://community.bistudio.com/wiki/setWaypointFormation		
//	x_AIDef_WP_Speed		String		http://community.bistudio.com/wiki/setWaypointSpeed			
//	x_AIDef_WP_Type			String		http://community.bistudio.com/wiki/setWaypointType
//
//<-------------------------------------------------------------------------------------------------->

/*
x_AIDef_WP_Radius=50; x_AIDef_WP_Count=5; x_AIDef_WP_Behaviour="SAFE"; x_AIDef_WP_CombatMode= "Green"; x_AIDef_WP_Formation="LINE"; x_AIDef_WP_Speed= "Limited"; x_AIDef_WP_Type= "MOVE"
*/
private ["_guard","_pos","_CreateWaypoints"];

_guard=			_this select 0;
_pos= 			_this select 1;

_CreateWaypoints=
{
	//Funktion erstellt wegpunkt, returns: Array format [Gruppe,WegpunktID]
	//_guard		Gruppe
	//_pos			Position		
	//
	private ["_guard","_pos","_waypoint","_wp1","_wp1_pos"];
	
	_guard=			_this select 0;
	_pos= 			_this select 1;
	_wp=			[];
	
	if(count (waypoints _guard)==x_AIDef_WP_Count && x_AIDef_WP_Count>1 ) then 
	{
		_wp1= 			(waypoints _guard) select 0;		//Erster Wegpunkt der Gruppe
		_wp1_pos=		getWPPos _wp1;	
		
		_waypoint= 		_guard addwaypoint [_wp1_pos,0];	//Erstellen des letzten wegpunktes == position des ersten (wegen cycle)
		_wp=			[_guard,x_AIDef_WP_Count];
	}else
	{
		_waypoint= 		_guard addwaypoint [_pos,x_AIDef_WP_Radius];
		_wp=			[_guard,(count waypoints _guard)-1];
	};
	
	if((_wp select 1)== x_AIDef_WP_Count) then
	{
		_wp setwaypointtype "CYCLE";

	} else
	{
		_wp setwaypointtype x_AIDef_WP_Type;
	};
		
	_wp setWaypointBehaviour x_AIDef_WP_Behaviour;	
	_wp setWaypointCombatMode x_AIDef_WP_CombatMode;
	_wp setWaypointFormation x_AIDef_WP_Formation;
	_wp setWaypointSpeed x_AIDef_WP_Speed;
};

for [{_x=0},{_x<=x_AIDef_WP_Count},{_x=_x+1}] do
{
	[_guard,_pos] call _CreateWaypoints;
};		
