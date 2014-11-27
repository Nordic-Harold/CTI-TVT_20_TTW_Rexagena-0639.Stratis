/*
	Script written by TeeTime dont remove this comment
	
	To Do
	
		AI Level mit parameter anpassen
		Code:
			{_x setSkill ["aimingaccuracy", 0.3];} forEach units groupname;

		Parameter für Town Rebuilt
		Parameter Clean Up
		
		Fahrzeug Spawn
		Lock/Unlock Elite Fixen

		AI spawn überarbeiten
		Shop System
		
		HC
			Slot Protection einfügen
		
		Squad System
			-Was tun mit KI die man vor Wechsel gekauft hat? Töten oder in Reserve halten?
			-Namen von Squad Mitgliedern anziegen
			-Sondermarker für Teamleader
			-Auf Karte eigene Farbe für Squadmitglieder
			-Leader Möglichkeit geben Leute abzulehnen

		High Command
			-West/Ost Fahrer aus feindlichem HQ schmeißen
			-Var angelegt
	
		MobileHQ bis 650
		Respawn bis 700
	
	Added:

	
		
	Fixed:
		possibily to join enemy groups
	
	Changed:

	
	Prüfen:
		-Fahrzeug lock
		- Kick Player nach TK testen
		Wird AI nach Disc gekillt?
		Werden Repairstation Actiosn bagebroche nwenn man sich bewegt
		-Wenn man die Mission mit Veteran Schwierigkeit startet, können weder blufor noch opfor ihre Fahrzeuge aufsperren.
		
		
	Idee:
		-UPSON?
		- Zweitbase (FOB) kann mit einem Speziellen Fahrzeug (hoher Preis) gebaut werden. Mainbase dafür weiter auseinander und wie gesagt, der feindlichen Base auf der Map gegenüber liegend.
	
	Bugs:
		-KI Soldaten und Resistance (Civis) bekämpfen sich nicht.	KeinFix
		-Ab und zu verliert man ohne etwas zu tun, die Kontrolle über seine KI Kollegen.
		-Ab und zu kann man den Basemarker der feindlichen Fraktion auf der Map sehen, dafür aber nicht seinen eigenen.
		
	Parameter:
		-Wetter

		-Kaufen von KI an "Towncenter"
		-Kaufen von Munition an "Towncenter"
		-Respawn an "Towncenter": enabled, disabled
		-3D Sicht blockieren
		-Respawnzeit

		-Armed Cars: enabled, disabled
		-AI Spieler statt Spieler
		-Startresourcen (500, 1000, 2000, 5000, 10000, 20000, 50000)
*/

[] spawn {
	waitUntil {time > 21};
	["<img size= '10' shadow='false' image='images\ArmA3PRO.paa'/><br/><br/><t size='.7' color='#FFFFFF'>ArmA 3 Pro TeeTimes Warfare</t>",0,0,3,12] spawn BIS_fnc_dynamicText;
};

// Task Force Radio Client Settings ----------------------------------------------------	
tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = true;
tf_give_microdagr_to_soldier = true;
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;
tf_same_dd_frequencies_for_side = false;

// Loadout by LEA ---------------------------------------------------------------------	
leaFunction =  compile preprocessFileLineNumbers "scripts\lea\loadout-init.sqf"; 
call leaFunction;

finishMissionInit;
enableSaving [false,false];

diag_log "=================TEETIMES WARFARE=================";

west setFriend [resistance, 0];
west setFriend [civilian, 0];

east setFriend [resistance, 0];
east setFriend [civilian, 0];

resistance setFriend [WEST, 0];
resistance setFriend [EAST, 0];

civilian setFriend [WEST, 0];
civilian setFriend [EAST, 0];

skipTime ((paramsArray select 0) - daytime + 24 ) % 24;
setViewDistance (paramsArray select 1);
setTerrainGrid (paramsArray select 2);


waitUntil { (( (time > 1) && (alive player)) || isServer ) };

//Mission Variables
diag_log format["Player name is %1",name player];

debug 				= if(isServer && !isDedicated && name player in ["TeeTime","GunnyTomHighway","Gentoo"]) then {true} else {false};
//debug				=true;
TW_restart			= if((paramsArray select 3) == 1) then {true} else {false};	//Restarts Mission without a Restart
TW_roundtime		= (paramsArray select 9);									//Time Limit for each round
TW_Addons_Active	= false;

TW_Para_Towns		= (paramsArray select 10);	//How many Towns can be caped
TW_Para_MobilBase	= if((paramsArray select 11) == 1) then {true} else {false};	//Static or Mobil Bases true = mobil false = static
TW_Para_satintel	= if((paramsArray select 12) == 1) then {true} else {false};	//Satelite intelligence on/Off with "On" towns must not be scouted


TW_BoxShop			= false;	//Shop menu will be replaced with the ability to create weapon Boxes
TW_vehicles			= if((paramsArray select 17) == 1) then {true} else {false};		//Can Vehicles be bought
TW_air				= if((paramsArray select 6) == 1) then {true} else {false};		//Can Air be bought
TW_ai				= if((paramsArray select 7) == 1) then {true} else {false};		//Can AI be bought

TW_Income			= (paramsArray select 8);		//0.5= 50% 1 = 100% 2= 200%		Effect Startmoney and all Income
weapon_price		= 1;		//
vehicle_price		= 1;		//
airvehicle_price	= 1;		//
ai_price			= 1;		//

TW_AI_Def_lvl		= (paramsArray select 4);	//AI Guards level normal is 1 -> 6 men
TW_AI_max			= (paramsArray select 5);	//Max AI ammount per player
TW_AI_Patrols		= if((paramsArray select 16) == 1) then {true} else {false};	//Will the AI Def stay static or will they randome patrol?


TW_Strategic_Street	= if((paramsArray select 18) == 1) then {true} else {false};


//Headless Client Variables HC Functions are defined in the Serverfunctions	
//HC must be on the Server at mission Start!!
TW_HC_Array		= ["Off","TWHC","BierAIG_HC","TeeTime"];
TW_HC_Activ		= if((paramsArray select 13) == 0) then {false} else {true};		//Set to true if you want to use HC
TW_HC_ID		= TW_HC_Array select (paramsArray select 13);	//PlayerID OR Playername of the Headless Client
TW_HC_Client	= if((((getPlayerUID player) == TW_HC_ID) || (name player == TW_HC_ID)) && TW_HC_Activ) then {true} else {false};	//Will be set to true if the Client is the HC
TW_HC_ClientSlot = objNull;	//Will be the playerobject who is the HC

//Unused
TW_HC_Def_AI		= if((paramsArray select 14) == 0) then {false} else {true};		//Set to true if you want to use HC
TW_HC_Def_AI		= if((paramsArray select 15) == 0) then {false} else {true};		//Set to true if you want to use HC

//Functions and Variables
_h = [] execVM "variablen.sqf";
waitUntil{(scriptDone _h)};

diag_log format ["After variablen.sqf => HQ_placed : %1", HQ_placed];

_h= [] execVM "functions\FunctionsInit.sqf";
waituntil {scriptdone _h};

if((isServer && !TW_ServerStarted) || (TW_HC_Client && TW_HC_Activ)) then {	//Nur zum Test !TW_Server ... kann eigentlich raus
	_h = [] execVM "functions\FunctionsInitServer.sqf";
	waitUntil{(scriptDone _h)};
	_h = [] execVM "functions\FunctionsInitHC.sqf";
	waitUntil{(scriptDone _h)};	
	_h = [] execVM "functions\FunctionsInitAIDef.sqf";
	waitUntil{(scriptDone _h)};
};

//Init
//Server
if(isServer && !TW_ServerStarted) then {
	TW_ServerStarted = true;
	publicVariable "TW_ServerStarted";
	if(isDedicated || debug) then {diag_log "Report: ServerInit Started";};
	
	//Basic
	[] call Tee_Server_Init;
	[] call Tee_Server_Init_Values;
	if(!TW_HC_Activ) then {
		[] spawn Tee_Server_CleanUp;
	};

	//Towns
	[] spawn Tee_Server_CreateTownMarker;

	//Base
	[] call Tee_Server_Base_Set_Base;
	[] call Tee_Server_Base_Build_West;
	[] call Tee_Server_Base_Build_East;
	
	HQ_placed = true;
	publicVariable "PosHqWest";
	publicVariable "PosHqEast";
	publicVariable "HQ_placed";
	
	if(isDedicated || debug) then {diag_log "Report: ServerInit Done";};
};

//Repetitive Cleanup Script
[
    60, // seconds to delete dead bodies (0 means don't delete) 
    5*60, // seconds to delete dead vehicles (0 means don't delete)
    3*60, // seconds to delete immobile vehicles (0 means don't delete)
    2*60, // seconds to delete dropped weapons (0 means don't delete)
    10*60, // seconds to deleted planted explosives (0 means don't delete)
    5*60 // seconds to delete dropped smokes/chemlights (0 means don't delete)
] execVM 'scripts\repetitive_cleanup.sqf';  

//HC
if(TW_HC_Client) then {
	//Basic
	[] call Tee_HC_Init;
	[] call Tee_HC_Init_Values;
	[] spawn Tee_Server_CleanUp;
	
	//Towns
	[] spawn Tee_HC_CreateTownDefense;
};

//Clients
if(! isDedicated) then {
	//Init Dialoge, darf nur am client initialisiert werden!
	_h= [] execVM "functions\FunctionsInitDLG.sqf";
	waituntil {scriptdone _h};
	
	[] call Tee_Init_Client;
	[] call Tee_Player_Init_Values;

	//Base
	[] spawn Tee_Base_Create_Marker;
	
	//Town
	[] call Tee_Client_CreateTownMarker;
	[] call CT_Marker_CreateConnections;				//Erstellt Verbindungen
	
	//Loops
	[] spawn Tee_MoneyLoop;
	[] spawn Tee_AttackTown;
	[] spawn Tee_ActionLoop;
	[] spawn Tee_PlayerMarker_Loop;	
	
	//Player specific
	[] spawn Tee_SetPlayer;
	
	diag_log str([IsNil "Tee_Init_Client",IsNil "Tee_Player_Init_Values",IsNil "Tee_Base_Create_Marker",IsNil "Tee_Client_CreateTownMarker",IsNil "CT_Marker_CreateConnections", IsNil "Tee_MoneyLoop",IsNil "Tee_AttackTown",IsNil "Tee_ActionLoop",IsNil "Tee_PlayerMarker_Loop",IsNil "Tee_SetPlayer"]);
	if (debug) then {
		diag_log "If Gentoo and GunnyTomHighway are testing on personal server, screw you AI!";
		player allowDamage false;
	};
};

if(isDedicated || debug) then {diag_log "Report: Init Done";};

// TcB AIS Wounding System ----------------------------------------------------------	
// by psycho
enableTeamswitch false;
TCB_AIS_PATH = "scripts\ais_injury\";
{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit

// No FLIR on any weapon/vehicle
0 = [] execVM 'scripts\shutDownAllFLIR.sqf';

// No Shift+Click markers ingame
0 = [] execVM 'scripts\removeShiftClickMarkers.sqf';