#include "macros.sqf"
#include "Macros\GearMenuMacros.sqf"

CT_DLG_GetDisplay= {
	private ["_idd"];
	disableSerialization;
	_idd= __SEL(_this,0);
	
	_dsp= finddisplay _idd;
	
	_dsp
};

CT_DLG_SetButton = {
	private ["_dsp","_b","_idc","_loc","_act","_ctrl","_text"];
	_dsp= 	__SEL(_this,0);
	_b=		__SEL(_this,1);	
	
	_idc= 		__SEL(_b,0);
	_loc= 		__SEL(_b,1);
	_act=	 	__SEL(_b,2);
	_str_cond=	__SEL(_b,3);
	
	_ctrl= _dsp displayCtrl _idc;
	
	if(_loc != "") then {
		_text= localize _loc;
		_ctrl ctrlSetText _text;
	};
	if(_act != "") then {
		buttonSetAction [_idc, _act];
	};
	if(_str_cond != "") then {
		_cond= call compile _str_cond;
		if(_cond) then {_ctrl ctrlEnable true} else { _ctrl ctrlEnable false};
	};
};
	
CT_DLG_SetText = {
	private ["_dsp","_t","_idc","_loc","_text","_strs_array","_loc_array","_strs","_lc","_i","_ret"];
	_dsp=	_this select 0;
	_t=		_this select 1;	
	_idc= 	_t select 0;
	_loc= 	_t select 1;
	
	_ctrl= _dsp displayCtrl _idc;	
	
	_text= "";

	//STRS Array
	_strs_array=[83,84,82,83];
	
	if(typename _loc == typename 0) then { _text= str(_loc)};
	if(typename _loc == typename {}) then {_text= call _loc};
	if(typename _loc == typename "") then {
		if(_loc != "") then
		{
			_loc_array= 	toarray _loc;
			_ret=			[];
			
			for "_i" from 0 to 3 do
			{
				_strs= 		_strs_array select _i;
				_lc= 		_loc_array select _i;
					
				if(_strs==_lc) then
				{
					_ret= 	_ret + [true];
				} 
				else
				{
					_ret= 	_ret + [false];
				};		
			};
			if(!(false in _ret)) then
			{
				_text= localize _loc
			} else
			{
			 _text=_loc;
			};
		};
	};
	_ctrl ctrlSetText _text;
};
//
CT_DLG_UpdateFunds = {
	private["_idc","_funds"];
	_idc= __SEL(_this,0);
	
	while{dialog} do
	{
		_funds= format ["%1 $", Tee_Konto];
		ctrlSetText [_idc,_funds];
		sleep 1;
	};
};
CT_DLG_UpdateCosts = {
	private["_idc","_costs"];
	_idc= __SEL(_this,0);
	
	_costs= format ["%1 $", CT_DLG_OverallCost];
	ctrlSetText [_idc,_costs];
};


		
		
	