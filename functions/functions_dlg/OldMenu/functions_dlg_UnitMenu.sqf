#include "macros.sqf"
#include "Macros\UnitMenuMacros.sqf"


CT_dlg_UnitMenu_StartUp= {
	private ["_text_idc","_frames_idc","_button_idc","_idd","_dlg","_dsp"];
	disableSerialization;	
	
	_text_idc= 		TW_dlg_UnitMenu_text_idc;
	_frames_idc=	TW_dlg_UnitMenu_frames_idc;
	_button_idc=	TW_dlg_UnitMenu_button_idc;
	_idd=			IDD_UNITMENU;
	
	CT_DLG_CartList=			[];						//Einkaufswagen 0 setzen
	CT_DLG_OverallCost=			0;						//Setzt Kosten auf 0
	
	waituntil {!dialog};
	_dlg= createdialog "TTW_dlg_UnitMenu";
	waituntil {dialog};
	waituntil {!IsNull (finddisplay _idd)}; //wartet, bis Display existiert
	
	_dsp= finddisplay _idd;	

	//DLG Setup
	//TEXTE
	if(!IsNil "_text_idc") then {
		{
			[_dsp,_x] call CT_DLG_SetText;
		} foreach _text_idc;
	};
	//Frames
	if(!IsNil "_frames_idc") then {
		{
			[_dsp,_x] call CT_DLG_SetText;
		} foreach _frames_idc;
	};
	//BUTTONS
	if(!IsNil "_button_idc") then {
		{
			[_dsp,_x] call CT_DLG_SetButton;
		} foreach _button_idc;
	};

	//SPECIAL FUNCTIONS
	//**********************
	//Funds update 1003
	_erg= [IDC_UNITMENU_TEXT_UNITMENU_FUNDSVALUE] spawn CT_DLG_UpdateFunds;						//Updated die Kontoinformationen
	
	[_dsp,IDC_UNITMENU_LB_UNITMENU_SELECTUNIT] call CT_DLG_UnitMenu_LBSelectUnitsSetUp;			//Setzt Select Unit LB
	[_dsp,IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS] call CT_DLG_UnitMenu_LBSelectedUnitsSetUp;	//Setzt Selected Units LB
	[IDC_UNITMENU_TEXT_UNITMENU_COSTSVALUE] spawn CT_DLG_UnitMenu_UpdateCost;					//Setzt Kosten
	
	/*	//CostUpdate
	_erg= 
	//**********************
	//Combo Button IDC_GEARMENU_COMBO_GEARMENU_SELTYPE für Select Gear LB IDC_GEARMENU_LB_GEARMENU_SELGEAR
	_combo_array=[IDC_GEARMENU_COMBO_GEARMENU_SELTYPE,TW_dlg_TypeArray_Gear];
	[_dsp,_combo_array] call CT_DLG_GearMenu_ComboSetUp;
	
	//**********************
	//LB IDC_GEARMENU_LB_GEARMENU_SELGEAR für auswahl LB 1501 (Magazines)
	[_dsp] call CT_DLG_GearMenu_LBSelGearSetUp;				//Erstellt Magazine
	
	//**********************
	//LB für Anzeige ausgewählte gegenstände

	
	//**********************
	//Button deaktivierten
	ctrlEnable [IDC_GEARMENU_BUTTON_GEARMENU_BUYTOINVENTORY, false] 
	*/
};

CT_DLG_UnitMenu_CreatIDArray = {
	private ["_side","_ID_Lists"];
	//Feststellen der Seite
	_side= 		0;
	if(side player == WEST) then {_side = 0};
	if(side player == EAST) then {_side = 1};
	if(side player == Resistance) then {_side = 2};
	
	//Erstellt Liste
	_ID_Lists= 	CT_DLG_AllUnits;				//0=east, 1=west,2=town/resistance
	_return=	__SEL(_ID_Lists,_side);			//Liste mit allen Einheiten
	
	_return
};
CT_DLG_UnitMenu_CreateLBEntries={
	private ["_ctrl","_idc","_idx","_dsp","_ID_Array","_max_IDs","_ID","_Name","_price","_i"];
	_dsp=	__SEL(_this,0);
	_idc=	__SEL(_this,1);
	_ctrl= 	_dsp displayctrl _idc;
	
	_ID_Array= 	call CT_DLG_UnitMenu_CreatIDArray;
	_max_IDs=	__MAX(_ID_Array);
	
	//Clear Listbox;
	[_ctrl] call CT_DLG_LBClear;	
	
	for "_i" from 0 to _max_IDs do {
		_ID= 		__SEL(_ID_Array,_i);
		
		if(_ID != 0) then
		{
			_Name=		_ID call Tee_GetUnit_Name;
			_Price=		_ID call Tee_GetUnit_Price;
			
			_entry= [_Name,_Price] call CT_DLG_LBSetEntryNamePrice;
			
			[_ctrl,_entry] call CT_DLG_LBAdd;					//Eintrag in Listbox
			[_ctrl,_i,_ID] call CT_DLG_LBSetData;				//ID hinterlegen
		};
	};
};
//DLG Setup
CT_DLG_UnitMenu_LBSelectUnitsSetUp = {
	private ["_dsp","_idc","_ctrl","_eh"];
		_dsp=	__SEL(_this,0);
		_idc=	__SEL(_this,1);
		_ctrl=	_dsp displayCtrl _idc;
		
		[_dsp,_idc] call CT_DLG_UnitMenu_CreateLBEntries;					//Füllt liste mit kaufbaren Einheiten
		
		//Eventhandler
		_eh=_ctrl ctrladdeventhandler["LBDblClick","call CT_DLG_UnitMenu_Add1ToCart"];
		
};
CT_DLG_UnitMenu_LBSelectedUnitsSetUp = {
		private ["_dsp","_idc","_ctrl","_eh"];
		_dsp=	__SEL(_this,0);
		_idc=	__SEL(_this,1);
		_ctrl=	_dsp displayCtrl _idc;
		
		//Eventhandler
		_eh=_ctrl ctrladdeventhandler["LBDblClick","call CT_DLG_UnitMenu_Remove1FromCart"];	
};
//--- Cart Functions
CT_DLG_UnitMenu_Add1ToCart = {
	private ["_idd","_dsp","_ctrl","_ID","_ID_idx","_idc"];
	//Display
	_idd=		IDD_UNITMENU;
	_dsp= 		[_idd] call CT_DLG_GetDisplay;
	
	//LB Select Units
	_idc=		IDC_UNITMENU_LB_UNITMENU_SELECTUNIT;
	_ctrl=		_dsp displayCtrl _idc;
	_idx=		[_ctrl] call CT_DLG_LBGetSelected;
	
	
	//Prüft anzahl der AI, die gekauft werden kann
	_cnt_AllItems= 		call CT_DLG_CartCountAllItems;
	_ai_used=			count (units (group player)) - 1;
	_ai_allowed= 		TW_AI_max;									
	_AllUnits=			_cnt_AllItems + _ai_used;
	
	if(_AllUnits < _ai_allowed) then
	{
		_ID=	[_ctrl,_idx] call CT_DLG_LBGetData;		
		[_ID] call CT_DLG_CartAddItem;								//Fügt Item in den Einkaufswagen
		
		//Einkaufswagen updaten
		_idc= 	IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS;
		[_idd,_idc] call CT_DLG_UnitMenu_UpdateCart;
		
		//Kosten Updaten
		_idc= IDC_UNITMENU_TEXT_UNITMENU_COSTSVALUE;
		[_idc] call CT_DLG_UnitMenu_UpdateCost;
	} else {
		hint (localize "STRS_buy_ai_limit")
	};
};
CT_DLG_UnitMenu_Remove1FromCart = {
	private ["_idd","_dsp","_idc","_ctrl","_idx"];
	//Display
	_idd=		IDD_UNITMENU;
	_dsp= 		[_idd] call CT_DLG_GetDisplay;
	
	//LB Select Units
	_idc=		IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS;
	_ctrl=		_dsp displayCtrl _idc;
	_idx=		[_ctrl] call CT_DLG_LBGetSelected;
	
	[_idx] call CT_DLG_CartSetIDCountMinus;				//Abzug oder entfernen des eintrages
	
	//Einkaufswagen updaten
	_idc= 	IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS;
	[_idd,_idc] call CT_DLG_UnitMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_UNITMENU_TEXT_UNITMENU_COSTSVALUE;
	[_idc] call CT_DLG_UnitMenu_UpdateCost;
};
CT_DLG_UnitMenu_AddAllToCart = {
	private ["_idd","_dsp","_ctrl","_ID","_ID_idx","_idc","_cnt"];
	//Display
	_idd=		IDD_UNITMENU;
	_dsp= 		[_idd] call CT_DLG_GetDisplay;
	
	//LB Select Units
	_idc=		IDC_UNITMENU_LB_UNITMENU_SELECTUNIT;
	_ctrl=		_dsp displayCtrl _idc;
	_idx=		[_ctrl] call CT_DLG_LBGetSelected;
	
	_size=		[_ctrl] call CT_DLG_LBSize;	
	_cnt= if(_size <= TW_AI_max) then {_size} else {TW_AI_Max};
	_ID_Array=	[];	
	
	for "_i" from 0 to (_cnt - 1) do {
		_ID= [_ctrl,_i] call CT_DLG_LBGetData;
		[_ID] call CT_DLG_CartAddItem;
	};
	
	//Einkaufswagen updaten
	_idc= 	IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS;
	[_idd,_idc] call CT_DLG_UnitMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_UNITMENU_TEXT_UNITMENU_COSTSVALUE;
	[_idc] call CT_DLG_UnitMenu_UpdateCost;
};
CT_DLG_UnitMenu_RemoveAllFromCart = {
	//Display
	_idd=		IDD_UNITMENU;
	CT_DLG_CartList=			[];	
	
	//Einkaufswagen updaten
	_idc= 	IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS;
	[_idd,_idc] call CT_DLG_UnitMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_UNITMENU_TEXT_UNITMENU_COSTSVALUE;
	[_idc] call CT_DLG_UnitMenu_UpdateCost;
};
//Update Functions
CT_DLG_UnitMenu_UpdateCart= {
	private ["_idd","_idc","_CL","_ctrl","_max_Entries","_id","_cnt","_name","_entry"];
	_idd= 		__SEL(_this, 0);
	_idc=		__SEL(_this,1);
	_CL=		CT_DLG_CartList;
	
	//Display Information
	_dsp= 		[_idd] call CT_DLG_GetDisplay;
	_ctrl=		_dsp displayCtrl _idc;
	
	//Säubern Listbox
	[_ctrl] call CT_DLG_LBClear;
	
	{
		_id= 		__SEL(_x,0);
		_cnt= 		__SEL(_x,1);
		
		_name=		_ID call Tee_GetUnit_Name;
		_entry= 	format ["%1 x %2",_name, _cnt];
		
		[_ctrl,_entry] call CT_DLG_LBAdd;
	} foreach _CL;
};	
CT_DLG_UnitMenu_UpdateCost = {
	private ["_idc","_CL","_ID","_price"];
	_idc= 		__SEL(_this,0);
	_CL= 		CT_DLG_CartList;
	
	CT_DLG_OverallCost= 0;
	
	{
		_ID= 		__SEL(_x,0);
		_cnt= 		__SEL(_x,1);
		_price=		_ID call Tee_GetUnit_Price;
		
		CT_DLG_OverallCost= CT_DLG_OverallCost + (_price * _cnt);
	} foreach _CL;
	
	[_idc] call CT_DLG_UpdateCosts;
};
//Buy Function
CT_DLG_UnitMenu_BuySelected= {
	private ["_ID","_cnt","_idd","_idc"];
	{
		_ID= 	__SEL(_x,0);
		_cnt=	__SEL(_x,1);
		
		for "_i" from 1 to _cnt do
		{
			[_ID] call Tee_BuyUnit;
		};
	} foreach CT_DLG_CartList;
	
	CT_DLG_CartList= [];
	
		//Einkaufswagen updaten
	_idd=	IDD_UNITMENU;
	_idc= 	IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS;
	[_idd,_idc] call CT_DLG_UnitMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_UNITMENU_TEXT_UNITMENU_COSTSVALUE;
	[_idc] call CT_DLG_UnitMenu_UpdateCost;
};