#include "macros.sqf"
#include "Macros\GearMenuMacros.sqf"

CT_DLG_LBGetObjType= {
	private ["_types","_str_types"];
	_types= 		__SEL(_this,0);
	_str_types= 	str(_types);
	_return= 0;
	
	if(_str_types == str(TW_dlg_TypeArray_Gear)) then {_return= 0};
	if(_str_types == str(TW_dlg_TypeArray_Vehicle)) then {_return=1};
	if(_str_types == str([])) then {_return=2};
	
	_return
};
CT_DLG_LBGetTypeName = {
	private ["_type","_prefix","_loc"];
	_type= 		__SEL(_this,0);
	_prefix= 	TW_dlg_Menu_LocPrefix;
	_loc= 		format ["%1_%2",_prefix,_type];
	
	_return= 	localize _loc;
	_return
};
CT_DLG_LBClear={
	private ["_ctrl"];
	_ctrl= 		__SEL(_this,0);
	lbclear _ctrl;
};
CT_DLG_LBAdd = {
	private ["_ctrl","_idc","_entry"];
	_ctrl= 		__SEL(_this,0);
	_entry=		__SEL(_this,1);
	
	_ctrl lbAdd _entry
};
CT_DLG_LBGetSelected= {
	private ["_ctrl"];
	_ctrl= __SEL(_this,0);
	_return= lbcursel _ctrl;
	
	_return
};
CT_DLG_LBSetData= {
	private ["_ctrl","_idx","_data"];
	_ctrl= 	__SEL(_this,0);
	_idx=	__SEL(_this,1);
	_data= 	__SEL(_this,2);
	
	_ctrl lbsetdata [_idx,str(_data)];
};

CT_DLG_LBGetData={
	private ["_ctrl","_idx","_data"];
	
	_ctrl= 	__SEL(_this,0);
	_idx=	__SEL(_this,1);
	
	_str_data= _ctrl lbData _idx;
	_return=call compile _str_data;
	
	_return
};
CT_DLG_LBSize = {
	private ["_ctrl"];
	_ctrl= __SEL(_this,0);
	
	_return= lbsize _ctrl;
	_return
};
CT_DLG_LBSetEntryNamePrice={
	private ["_name","_price","_cnt_price"];

	_name= 		__SEL(_this,0);
	_price=		__SEL(_this,1);
	
	_return= format ["%1$- %2",_price,_name];
	_return
};	
				

//********************
//List Box Allocations
//********************
//Creates the Array for the Listbox Entries
//Saves into CT_DLG_CurrentLB
CT_DLG_CreatIDArray={
	private ["_side","_ID_Lists","_Type_Array","_LB_Array","_ID_Array","_max_IDs","_max_Types","_ObjType","_type","_LB_Entry","_ID","_Var_Type","_x","_i"];
	_side= 			__SEL(_this,0);
	_ID_Lists= 		__SEL(_this,1);	
	_Type_Array=	if(count _this >=2) then {__SEL(_this,2)} else {[]};
	_LB_Array=		[];	
	_ID_Array=		[];
	
	_ID_Array=		__SEL(_ID_Lists,_side);
	_max_IDs= 		__MAX(_ID_Array);
	_max_Types= 	if(count _Type_Array != 0) then {__MAX(_Type_Array)} else {1};
	
	_ObjType=[_Type_Array] call CT_DLG_LBGetObjType;	
	
	for "_i" from 0 to _max_Types do {
		_type= 			__SEL(_Type_Array,_i);
		_LB_Entry=		[];
		
		for "_x" from 0 to _max_IDs do {
		
			_ID= 		__SEL(_ID_Array,_x);
			_Var_Type =="";
			
			if(_ObjType == 0) then { _Var_Type= _ID call Tee_GetWeap_Typ};		//Gear Type
			if(_ObjType == 1) then { _Var_Type= _ID call Tee_GetVeh_Typ};		//Vehicle Type
			if(_ObjType == 2) then { _Var_Type= _ID call Tee_GetUnit_Typ};		//Unit Type
			
			if(_Var_Type == _type) then { _LB_Entry= __ARRAY_ADD(_LB_Entry,[_ID])};
		};
		
		if(count _LB_Entry == 0) then { _LB_Entry= [0]};			//Wenn 0, kein eintrag!!

		_LB_Array = _LB_Array + [_LB_Entry];
	};
	
	CT_DLG_CurrentLB= _LB_Array
};
