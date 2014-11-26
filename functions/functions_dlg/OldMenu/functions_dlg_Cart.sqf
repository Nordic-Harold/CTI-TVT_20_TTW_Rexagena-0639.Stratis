#include "macros.sqf"
#include "Macros\GearMenuMacros.sqf"
//************************
//Einkaufswagen Funktionen
//************************
//DATA Functions
CT_DLG_CartGetIDEntries = {
	private["_Cart","_id"];
	_Cart= 		CT_DLG_CartList;
	_return= 	[];
	{
		_id=		__SEL(_x,0);
		_return=	__ARRAY_ADD(_return,[_id])
	} foreach _Cart;
	
	_return
};
CT_DLG_CartGetID= {
	private["_idx"];
	_idx= __SEL(_this,0);
	_return= __SSEL(CT_DLG_CartList,_idx, 0);
	
	_return
};
CT_DLG_CartGetCount= {
	private["_idx"];
	_idx= __SEL(_this,0);
	_return= __SSEL(CT_DLG_CartList,_idx, 1);
	
	_return
};
CT_DLG_CartFindIDEntry= {
	private ["_ID","_CartListID"];
	_ID= 	__SEL(_this,0);
	_CartListID= call CT_DLG_CartGetIDEntries;
	_return= _CartListID find _ID;
	
	_return
};
CT_DLG_CartGetSize= {
	_return= count CT_DLG_CartList;
	_return
};
CT_DLG_CartCountAllItems= {
	private ["_size","_cnt","_ID_cnt"];
	_size= call CT_DLG_CartGetSize;
	_cnt= 0;
	
	for "_i" from 0 to (_size -1) do {
		_ID_cnt= [_i] call CT_DLG_CartGetCount;
		_cnt= _cnt + _ID_cnt;	
	};
	_return= _cnt;
	
	_return
};

//Manipulation Functions
CT_DLG_CartAddEntry= {
	private ["_ID"];
	
	_ID=	__SEL(_this,0);
	_cnt= 	__CNT(CT_DLG_CartList);
	_idx= 0;
	if(_cnt >=1) then
	{	
		_idx= _cnt;
	};
	
	CT_DLG_CartList set [_idx,[_ID,1]];
};
CT_DLG_CartAddItem= {
	private ["_ID","_ID_idx"];
	
	_ID= __SEL(_this,0);
	_ID_idx=	[_ID] call CT_DLG_CartFindIDEntry;

	if(_ID_idx != -1) then
	{
		[_ID_idx] call CT_DLG_CartSetIDCountPlus;
	} else
	{
		[_ID] call CT_DLG_CartAddEntry;
	};
};
CT_DLG_CartSetIDCountPlus= {
	private ["_idx","_ID","_ID_Cnt"];
	_idx= 		__SEL(_this,0);
	
	try {
		if(_idx != -1) then {throw _idx} else {hint (localize "STRS_dlg_CART_ErrorNoSelection")};
		}
	catch {
		_ID=		[_idx] call CT_DLG_CartGetID;
		_ID_Cnt=	[_idx] call CT_DLG_CartGetCount;
		_ID_Cnt=	_ID_Cnt + 1;
		
		CT_DLG_CartList set [_idx,[_ID,_ID_Cnt]];
	};
};
CT_DLG_CartSetIDCountMinus= {
	private ["_idx","_ID","_ID_Cnt"];
	_idx= 		__SEL(_this,0);	
	
	try {
		if(_idx != -1) then {throw _idx} else {hint (localize "STRS_dlg_CART_ErrorNoSelection")};
		}
	catch {
		if(_idx == -1) exitwith {hint "No Item Selected"};
		
		_ID=		if(count _this >=2) then {__SEL(_this,1)} else {__SSEL(CT_DLG_CartList,_idx,0)};
		_ID_Cnt=	if(count _this >=2) then {1} else {__SSEL(CT_DLG_CartList,_idx,1)};
		
		if(_ID_cnt == 1) then
		{
			[_ID] call CT_DLG_DeleteEntryFromCart;	
		} else
		{
			_ID_Cnt=	_ID_Cnt - 1;
			CT_DLG_CartList set [_idx,[_ID,_ID_Cnt]];
		};
	};
};
CT_DLG_DeleteEntryFromCart= {
	private ["_ID","_CL_New","_Entry","_cnt"];
	_ID=		__SEL(_this,0);
	_CL_New=	[];
	
	{
		_Entry= 		_x;
		_Entry_ID=		__SEL(_Entry,0);
			
		
		if(_Entry_ID!=_ID) then
		{
			_cnt=	__CNT(_CL_New);
			__ARRAY_SET(_CL_New,_cnt,_Entry);	
		};
	} foreach CT_DLG_CartList;
	
	CT_DLG_CartList = _CL_New;
};
CT_DLG_ResetCart= {
	CT_DLG_CartList = [];
};

