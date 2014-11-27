/*
	Script written by TeeTime dont remove this comment
*/

Tee_Vote_Start = {
	private ["_kind","_text","_result","_return"];

	_kind 	= _this select 0;	//What kind of Vote is it	can be "HQ",
	
	//Check and activate Vote
	if(TW_Voting) exitWith {titleText [ localize "STRS_Vote_Running", "PLAIN DOWN"];};	//Msg
	TW_Voting					= true;
	TW_VotePlayerRequested		= true;						//Für CT Dialoge
	
	//Reset
	_return			= false;
	TW_Vote_Result 	= _return;
	
	//Own Vote
	TW_Vote_Votes = [1,0];
	publicVariable "TW_Vote_Votes";
	TW_Vote_Start = [TW_playerside,_kind,name player];
	publicVariable "TW_Vote_Start";
	
	_text = format [localize "STRS_Vote_Started",TW_Vote_Time];
	titleText [_text, "PLAIN DOWN"];	//Msg
	
	if(debug) then {TW_Vote_Start spawn Tee_Vote_Started;};
	
	sleep TW_Vote_Time;
	
	_text = format [localize "STRS_Vote_Result",TW_Vote_Votes select 0,TW_Vote_Votes select 1];
	titleText[_text, "PLAIN DOWN"];	//Msg
	
	
	_return = if((TW_Vote_Votes select 0) > (TW_Vote_Votes select 1)) then {true} else {false};
	
	TW_Vote_Result 	= _return;
	TW_Voting		= false;
	TW_VotePlayerRequested		= false;				//Für CT Dialoge
};



/*
	Called on all players
*/
Tee_Vote_Started = {
	private ["_side","_kind","_name","_text","_actioncode","_action","_actionarray","_parsedtext"];

	_side	= _this select 0;	//Side who is allowed to vote
	_kind 	= _this select 1;	//What kind of Vote is it
	_name	= _this select 2;
	
	if(_side != TW_playerside) exitWith {};
	
	// fix for issue #17
	// only team and squad leaders can vote.
	if (!(isFormationLeader player)) exitWith {};
	
	if(TW_Voting) exitWith {};
	
	TW_Voting = true;
	
	if(_kind == "HQ") then {
		_text = format [localize "STRS_Vote_StartInformation",_name];
	};
	
	hintSilent _text; //Msg
	player sidechat _text;
	
/*	
	_text			= localize "STRS_Vote";
	_actioncode		= format ["%1 spawn CT_Vote_Dialog;",[_name]];
	_action 		= player addAction [_text, AddActionCode,_actioncode];
	TW_Vote_Actions = TW_Vote_Actions + [_action];
	
	_text			= localize "STRS_Vote_Yes";
	_actioncode		= format ["[%1] call Tee_Vote_Vote;",true];
	_action 		= player addAction [_text, AddActionCode,_actioncode];
	TW_Vote_Actions = TW_Vote_Actions + [_action];
	
	_text			= localize "STRS_Vote_No";
	_actioncode		= format ["[%1] call Tee_Vote_Vote;",false];
	_action 		= player addAction [_text, AddActionCode,_actioncode];
	TW_Vote_Actions = TW_Vote_Actions + [_action];
	*/
};

/*
	Vote
*/
Tee_Vote_Vote = {
	if(_this select 0) then {
		TW_Vote_Votes = [(TW_Vote_Votes select 0) + 1,(TW_Vote_Votes select 1)];
	} else {
		TW_Vote_Votes = [(TW_Vote_Votes select 0),(TW_Vote_Votes select 1) + 1];	
	};
	publicVariable "TW_Vote_Votes";
	
	{
		diag_log "TW_Vote_Actions";
		diag_log format["removeAction %1",_x];
		player removeAction _x;
	} forEach TW_Vote_Actions;
	
	TW_Voting		= false;
	TW_Vote_Actions = [];
};

//Vote Dialog
CT_Vote_Dialog={

	private ["_name","_dlg","_text"];
	_name= TW_Vote_Start select 2;

	disableSerialization;
	//idd			1001
	//idcbuttons 	1200,1201
	//idctext		1300	
	
	_idd=			1001;
	_button_idc= 	[
						[1700,"STRS_VotingMenu_VoteYes","[true] call Tee_Vote_Vote; closedialog 0"],
						[1701,"STRS_VotingMenu_VoteNo","[false] call Tee_Vote_Vote; closedialog 0"]
					];		
	_StrText_idd=	1300;
	
	waituntil {!dialog};
	_dlg= 			createdialog "TTW_dlg_MobHQ";	
	waituntil {dialog};
	
	waituntil {!IsNull (finddisplay _idd)}; //wartet, bis Display existiert
	_dsp= 			finddisplay _idd;
	
	//Set Structured Text
	_ctrl= 			_dsp displayCtrl _StrText_idd;
	_text= 			parsetext format ["<t align='center'>Player <t color='#ff0000'>%1</t> wants to mobilize the MHQ</t>",_name];
	
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
	
	