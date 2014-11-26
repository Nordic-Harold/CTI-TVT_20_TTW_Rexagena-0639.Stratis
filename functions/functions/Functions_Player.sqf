/*
	Script written by TeeTime dont remove this comment
*/

//--- Hide first to prevent spoils
if (isMultiplayer) then {
		2 cutText ["Receiving mission intel, wait 20 seconds...","BLACK FADED",2];
//	12452 cutText ["Receiving mission intel...", "BLACK FADED", 50000];
};	
	
Tee_SetPlayer = {
	diag_log "Tee_SetPlayer starting";
	diag_log format ["HQ_Placed: %1",HQ_placed];
	waitUntil {HQ_placed};
	diag_log format ["TW_HQ_Placed_Client: %1",TW_HQ_Placed_Client];
	waitUntil {TW_HQ_Placed_Client};
	waitUntil {alive player};
	
	//if(TW_playerside == "west") then {player setPos (getMarkerPos TW_West_Respawn);};
	//if(TW_playerside == "east") then {player setPos (getMarkerPos TW_East_Respawn);};
	//diag_log format["TW_West_Respawn : %1 , TW_East_Respawn : %2 ",getMarkerPos TW_West_Respawn,getMarkerPos TW_East_Respawn];
	//check after 20 secs
	//titleText["Please wait 20 seconds for client to initialize.", "PLAIN DOWN"];	//Msg
	sleep 20;
	diag_log format["player distance hq_west: %1",player distance hq_west];
	diag_log format["player distance hq_east: %1",player distance hq_east];
	diag_log format["TW_playerside: %1", TW_playerside];
	if(TW_playerside == "west" && player distance hq_west > 10) then {player setPos (getMarkerPos TW_West_Respawn); diag_log "player repositioned"; };
	if(TW_playerside == "east" && player distance hq_east > 10) then {player setPos (getMarkerPos TW_East_Respawn); diag_log "player repositioned"; };
	diag_log format["After sleep 20 seconds => TW_West_Respawn : %1 , TW_East_Respawn : %2 ",getMarkerPos TW_West_Respawn,getMarkerPos TW_East_Respawn];


	//Make sure that leader is a player		muss für player squads angepasst werden	TeeTimeTest
	if(! isPlayer(leader (group (vehicle player)))) then {
		group player selectLeader player;
	};

	
	//Welcome Msg
	sleep 5;
	titleText[localize "STRS_welcome_1", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_4", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_6", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_InfoText_1", "PLAIN DOWN"];	//Msg
	sleep 5;	
	titleText[localize "STRS_welcome_end", "PLAIN DOWN"];	//Msg
	
};
/*	
	[] spawn CT_Info_Dialog;
	
	//Welcome Msg
	sleep 10;
	titleText[localize "STRS_welcome_1", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_2", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_3", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_4", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_5", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_6", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_7", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_8", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_9", "PLAIN DOWN"];	//Msg
	sleep 5;
	titleText[localize "STRS_welcome_end", "PLAIN DOWN"];	//Msg
};
*/

//Called on killed Client
Tee_Player_Killed = {
	private ["_victim","_killer","_side","_pos"];
	
	_victim = _this select 0;
	_killer = _this select 1;
	
	_side	= playerSide;		//TeeTimeTest kann im Moment nur auf Clients ausgeführt werden!
	_pos	= getPos _victim;
	
	if(isPlayer _killer) then {
		TW_Player_Killed = [_victim,_killer,_side,_pos];
		publicVariable "TW_Player_Killed";
	};
	
	//For selfhosted Missions
	if(isServer && isPlayer _killer) then {
		TW_Player_Killed call Tee_Player_Killed_Pub;
	};
};



//Called on all Clients
Tee_Player_Killed_Pub = {
	private ["_victim","_killer","_side","_text"];
	
	_victim = _this select 0;
	_killer = _this select 1;
	_side	= _this select 2;
	
	//Bonus
	if(player == _killer && playerside != _side) then {
		Tee_Konto = Tee_Konto + Tee_Money_Kill_Bonus;
		player groupchat format [localize "STRS_kill_bonus",Tee_Money_Kill_Bonus,(name _victim)]; 	//Msg
	};
	
	//Punish
	if(player == _killer && playerside == _side && _killer != _victim) then {
		//Punish
		Tee_Money_TK_Punish call Tee_Money_Substract;
		_text = format [localize "STRS_kill_TK_punish",Tee_Money_TK_Punish];
		titleText[_text, "PLAIN DOWN"];	//Msg
		
		//HQ
		if((player distance hq_west < 50 && TW_playerside == "west") or (player distance hq_east < 50 && TW_playerside == "east")) then {
			TW_TK_Counter = TW_TK_Counter + 1;	//Double Punish for Base TK
			player setDamage 1;
			titleText[localize "STRS_kill_TK_punishbase", "PLAIN DOWN"];	//Msg
		};
		
		//Kick
		TW_TK_Counter = TW_TK_Counter + 1;
		if(TW_TK_Counter >= 3) then {
			[] spawn Tee_Player_TK_Punish;
			TW_TK_Counter = 0;
			TW_Player_Kick = getPlayerUID player;
			publicVariable "TW_Player_Kick";		
		};
	};
};



//Punish Player for TK
Tee_Player_TK_Punish = {
	private ["_i","_pos"];
	
	_pos = getPos player;
	
	titleText[localize "STRS_kill_TK_punish_ultiamte", "PLAIN DOWN"];	//Msg
	
	for [{_i=0},{_i<300},{_i=_i+30}] do {
		player setPos [0,0,5];
		titleText[localize "STRS_kill_TK_punish_ultiamte2", "PLAIN DOWN"];	//Msg
		sleep 30;
	};
	
	player setPos _pos;
};



/*
	Respawn
*/
Tee_Player_Respawn = {
	private ["_i"];
	
	openMap [true, true];
	onMapSingleClick "_pos call Tee_Player_Respawn_Choose;";
	
	player groupchat localize "STRS_spawn_choosemsg";	//Msg
	player groupchat localize "STRS_spawn_choosemsg2";	//Msg
	
	//Group
	if(! isPlayer(leader (group (vehicle player)))) then {
		group player selectLeader player;
	};
	
	//Add Rank
	player addRating 40000;
	
	//Space for Weapon Loadign etc
	[] call Tee_SS_Gear_Load;
};



/*
	Respawn Choose
*/
Tee_Player_Respawn_Choose = {
	private ["_pos","_found","_base","_object","_text"];
	
	_pos 	= _this;
	_found	= false;	//Will be set to true if a valid respawn has been choosed
	
	if(TW_playerside == "west") then {_base = (getMarkerPos TW_West_Respawn);};
	if(TW_playerside == "east") then {_base = (getMarkerPos TW_East_Respawn);};
	
	//Base
	if(_pos distance _base <= 250) exitWith {
			onMapSingleClick "";
			player setPos _base;
			openMap [false, false];
			_found	= true;
	};
	
	//Towns
	{
		_object 	= _x select 0;
		//_markername = _x select 1;
		_text		= _x select 2;
		
		if(_pos distance _object <= 250 && ((_object getVariable "TownSide") == TW_playerside) && ((_object getVariable "TownPoints") >= 100)) exitWith {
			onMapSingleClick "";
			player setPos (getPos _object);
			openMap [false, false];
			_found	= true;
		};		
	} forEach TW_TownArray;
	
	//Message
	if(!_found) then {
		player groupchat localize "STRS_spawn_choosemsg2";	//Msg
	};
};

CT_Info_Dialog={

	private ["_name","_dlg","_text"];
	_name= _this select 0;

	disableSerialization;
	//idd			1001
	//idcbuttons 	1200,1201
	//idctext		1300	
	
	_idd=			1001;
	_button_idc= 	[
//						[1700,"STRS_VotingMenu_VoteYes","[true] call Tee_Vote_Vote; closedialog 0"],
						[1701,"STRS_InfoDlg_Close","closedialog 0"]
					];		
	_StrText_idd=	1300;
	
	waituntil {!dialog};
	_dlg= 			createdialog "TTW_dlg_MobHQ";	
	waituntil {dialog};
	
	waituntil {!IsNull (finddisplay _idd)}; //wartet, bis Display existiert
	_dsp= 			finddisplay _idd;
	
	//Set Structured Text
	_ctrl= 			_dsp displayCtrl _StrText_idd;
	_text= 			parsetext format ["<t align='center'>%1</t>",localize "STRS_InfoText1"];
	
	_ctrl ctrlSetStructuredText  _text;
	
	//Set buttonAction
	{
		_idc= _x select 0;
		_loc= _x select 1;
		_act= _x select 2;
		
		_text= localize _loc;
		
		_ctrl= _dsp displayCtrl _idc;
		
		_ctrl ctrlSetText _text;
		buttonSetAction [_idc, _act];
	} foreach _button_idc;	
};

