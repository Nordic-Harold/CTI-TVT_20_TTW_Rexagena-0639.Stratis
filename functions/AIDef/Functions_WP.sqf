CT_AI_AddWaypoints={
	private ["_x","_guard","_pos","_areasize"];

	_guard=			_this select 0;
	_pos= 			_this select 1;
	_areasize=		c_AIDef_WP_Radius;
	
	//(c_AIDef_WP_Count + 1) da letzte=erste WP
	
	for [{_x=1},{_x<=(c_AIDef_WP_Count + 1)},{_x=_x+1}] do
	{
		[_guard,_pos,_areasize] spawn CT_AI_CreateWaypoints;
	};
};

CT_AI_CreateWaypoints=
{
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
	
	_SurfaceIsWater= true;

	if(count (waypoints _guard) == (c_AIDef_WP_Count + 1) && c_AIDef_WP_Count > 1 ) then  {
		_wp_pos		=	_pos;	
		
		_waypoint	= 	_guard addwaypoint [_wp_pos,0];	//Erstellen des Letzten wegpunktes == position des ersten (wegen cycle)
		_wp			=	[_guard,c_AIDef_WP_Count];
	} else {
		
		//Erstellt Position
		while{_SurfaceIsWater} do {
			_wp_pos=  [_pos,_areasize] call CT_AI_RandomPos;

			_SurfaceIsWater= surfaceIsWater[_wp_pos select 0,_wp_pos select 1];
		};
		
		_waypoint= 		_guard addwaypoint [_wp_pos,0];
		_wp=			[_guard,(count waypoints _guard)-1];
	};

	if((_wp select 1)== (c_AIDef_WP_Count + 1)) then {
		_wp setwaypointtype "CYCLE";

	} else {
		_wp setwaypointtype c_AIDef_WP_Type;
	};
	
	_wp setWaypointBehaviour c_AIDef_WP_Behaviour;	
	_wp setWaypointCombatMode c_AIDef_WP_CombatMode;
	_wp setWaypointFormation c_AIDef_WP_Formation;
	_wp setWaypointSpeed c_AIDef_WP_Speed;
};

CT_AI_RandomPos= {
	private ["_pos","_r","_dir","_x","_y","_z","_dx","_dy"];
	
	_pos= 		_this select 0;
	_r=			_this select 1;
	
	_dir= 		random (360);
	_x=			_pos select 0;
	_y=			_pos select 1;
	_z=			0;
	_dx=		_r*sin(_dir);
	_dy=		_r*cos(_dir);
	
	_return= [_x+_dx,_y+_dy,_z];
	
	_return
};