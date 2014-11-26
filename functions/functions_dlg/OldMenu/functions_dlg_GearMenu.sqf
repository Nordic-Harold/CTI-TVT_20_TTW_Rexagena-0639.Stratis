#include "macros.sqf"
#include "Macros\GearMenuMacros.sqf"

CT_dlg_GearMenu_StartUp= {
	private ["_text_idc","_frames_idc","_button_idc","_dsp","_idd"];

	//Erstellung des Dialogs

	
	//IDCs zur erstellung des Dialogs
	_text_idc= 				TW_dlg_GearMenu_text_idc;
	_frames_idc=			TW_dlg_GearMenu_frames_idc;
	_button_idc=			TW_dlg_GearMenu_button_idc;

	//Variablen
	CT_DLG_OverallCost=		0;						//Setzt Kostenzähler auf 0
	CT_DLG_CartList=		[];						//Setzt Einkaufswagen auf 0

	//Dialogspezifische Variablen
	CT_DLG_DialogIDD=		IDD_GEARMENU;			//IDD des Dialogs
	
	//Display des Dialogs (kann nicht global gespeichert werden
	waituntil {!dialog};
	disableSerialization;
	_dlg= createdialog "TTW_dlg_GearMenu";
	waituntil {dialog};
	waituntil {!IsNull (finddisplay CT_DLG_DialogIDD)}; //wartet, bis Display existiert
	_dsp= finddisplay CT_DLG_DialogIDD;
	
	//Creates Listbox Array
	[_side] call CT_DLG_GearMenu_CreatIDArray;
	
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
	//Funds/Costs Update
	_erg= [IDC_GEARMENU_TEXT_GEARMENU_MONEYCOUNT] spawn CT_DLG_UpdateFunds;
	[IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE] call CT_DLG_GearMenu_UpdateCost;			//Updated Kosten für Start
	//ComboBox SetUp
	_combo_array=[IDC_GEARMENU_COMBO_GEARMENU_SELTYPE,TW_dlg_TypeArray_Gear];				//Einträge
	[_dsp,_combo_array] call CT_DLG_GearMenu_ComboSetUp;
	
	//LB Select Gear Setup
	[_dsp,IDC_GEARMENU_LB_GEARMENU_SELGEAR] call CT_DLG_GearMenu_LBSelGearSetUp;
	
	//LB für Anzeige ausgewählte gegenstände
	[_dsp] call CT_DLG_GearMenu_CartSetUp;
/*
	//**********************
	//Combo Button IDC_GEARMENU_COMBO_GEARMENU_SELTYPE für Select Gear LB IDC_GEARMENU_LB_GEARMENU_SELGEAR
	_combo_array=[IDC_GEARMENU_COMBO_GEARMENU_SELTYPE,TW_dlg_TypeArray_Gear];
	[_dsp,_combo_array] call CT_DLG_GearMenu_ComboSetUp;
	
	//**********************
	//LB IDC_GEARMENU_LB_GEARMENU_SELGEAR für auswahl LB 1501 (Magazines)
	[_dsp] call CT_DLG_GearMenu_LBSelGearSetUp;				//Erstellt Magazine
	
	//**********************

	
	//**********************
	//Button deaktivierten
	ctrlEnable [IDC_GEARMENU_BUTTON_GEARMENU_BUYTOINVENTORY, false] 
	*/
};
//Erstellung des ID Arrays
CT_DLG_GearMenu_CreatIDArray = {
	private ["_side","_ID_Lists","_Type_Array","_LB_Array","_ID_Array","_max_IDs","_max_Types","_ObjType","_type","_LB_Entry","_ID","_Var_Type","_x","_i"];
	
	_type=		__SEL(_this,0);
	_side= 		0;
	if(side player == WEST) then {_side = 0};
	if(side player == EAST) then {_side = 1};
	if(side player == Resistance) then {_side = 2};
	
	_ID_Lists= 		CT_DLG_AllGear;	//0=east, 1=west,2=town/resistance
	_LB_Array=		[];	
	_ID_Array=		[];
	
	_ID_Array=		__SEL(_ID_Lists,_side);
	_max_IDs= 		__MAX(_ID_Array);

	for "_x" from 0 to _max_IDs do {
	
		_ID= 		__SEL(_ID_Array,_x);
		_Var_Type= 	_ID call Tee_GetWeap_Typ;
	
		if(_Var_Type == _type) then { _LB_Array= __ARRAY_ADD(_LB_Array,[_ID])};
	};
	
	_return= _LB_Array;										//wird benötigt um LB für Auswahl des gear herzustellen
	_return													//Variable im Format [[typ1 IDs],[typ2 IDs],[typ3 IDs],...]
};
//Combo Control Funktionen
CT_DLG_GearMenu_ComboSetUp ={

	private ["_dsp","_idc","_types","_max_types","_ctrl","_type","_entry","_i","_ctrl","_lbsize"];
	_dsp=		__SEL(_this,0);
	_idc=		__SSEL(_this,1,0);
	_types=		__SSEL(_this,1,1);

	_max_types=	(count _types) - 1;	
	
	_ctrl= 		_dsp displayCtrl _idc;
	//Clear Listbox
	[_ctrl] call CT_DLG_LBClear;
	
	for "_i" from 0 to _max_types do {
	
		_type=		_types select _i;
		_entry=		[_type] call CT_DLG_LBGetTypeName;

		[_ctrl,_entry] call CT_DLG_LBAdd;
		
		//Originalbezeichnung Hinterlegen
		[_ctrl,_i,(_types select _i)] call CT_DLG_LBSetData;
	};
	
	//Eventhandler
	_ctrl ctrladdeventhandler["LBSelChanged","_this call CT_DLG_GearMenu_CreateLBEntries"];
	
	_lbsize= [_ctrl] call CT_DLG_LBSize;
	if(_lbsize >=1) then {lbSetCurSel [_idc,0]};
};
CT_DLG_GearMenu_CreateLBEntries={
	private ["_ctrl","_idc","_idd","_idx","_dsp","_ID_Array","_max_IDs","_ID","_Name","_price","_i"];
	_ctrl= 		__SEL(_this,0);
	_idx= 		__SEL(_this,1);
	
	_idd= 		CT_DLG_DialogIDD;
	_idc= 		IDC_GEARMENU_LB_GEARMENU_SELGEAR;	

	_dsp= 		[_idd] call CT_DLG_GetDisplay;
	_ctrl= 		_dsp displayctrl _idc;
	
	
	_typ=		__SEL(TW_dlg_TypeArray_Gear, _idx);
	_ID_Array= 	[_typ] call CT_DLG_GearMenu_CreatIDArray;
	_max_IDs=	__MAX(_ID_Array);
	
	//Clear Listbox;
	[_ctrl] call CT_DLG_LBClear;	
	
	for "_i" from 0 to _max_IDs do {
		_ID= 		__SEL(_ID_Array,_i);
		
		if(_ID != 0) then
		{
			_Name=		_ID call Tee_GetWeap_Name;
			_Price=		_ID call Tee_GetWeap_Price;
			
			_entry= [_Name,_Price] call CT_DLG_LBSetEntryNamePrice;
			
			[_ctrl,_entry] call CT_DLG_LBAdd;					//Eintrag in Listbox
			[_ctrl,_i,_ID] call CT_DLG_LBSetData;				//ID hinterlegen
		};
	};
};
//ListBox Funktionen für LB Select Gear und selected gear
CT_DLG_GearMenu_LBSelGearSetUp= {
	private ["_dsp","_idc","_ctrl"];
	_dsp= 		__SEL(_this,0);
	_idc=		__SEL(_this,1);
	_ctrl= 		_dsp displayCtrl _idc;
	
	//Anzeige Magazine
//	_ctrl ctrladdeventhandler["LBSelChanged","_this call CT_DLG_GearMenu_GetMagazines"]; zZ nicht benötigt

	//Zu Kaufliste hinzufügen
	_erg=_ctrl ctrladdeventhandler["LBDblClick","call CT_DLG_GearMenu_Add1ToCart"];
};
CT_DLG_GearMenu_CartSetUp= {
private ["_dsp","_idc","_ctrl"];
	_dsp= 		__SEL(_this,0);
	_idc=		IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
	_ctrl= 		_dsp displayCtrl _idc;
	
	//von Kaufliste entfernen
	_erg=_ctrl ctrladdeventhandler["LBDblClick","call CT_DLG_GearMenu_Remove1FromCart"];
};

//Cart Functions
CT_DLG_GearMenu_Add1ToCart = {
	private ["_idd","_idc","_dsp","_ctrl","_idx","_ID"];
	_idd=			CT_DLG_DialogIDD;
	_idc=			IDC_GEARMENU_LB_GEARMENU_SELGEAR;
	_dsp= 			[_idd] call CT_DLG_GetDisplay;
	_ctrl=			_dsp displayCtrl _idc;
	
	_idx=			[_ctrl] call CT_DLG_LBGetSelected;
	_ID=			[_ctrl,_idx] call CT_DLG_LBGetData;
	
	[_ID] call CT_DLG_CartAddItem;
	
	//Einkaufswagen updaten
	_idc= 	IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
	[_idd,_idc] call CT_DLG_GearMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE;
	[_idc, _ID] call CT_DLG_GearMenu_UpdateCost;
};
CT_DLG_GearMenu_Remove1FromCart = {
	private ["_idd","_idc","_dsp","_ctrl","_idx"];
	_idd=		CT_DLG_DialogIDD;
	_idc=		IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
	_dsp= 		[_idd] call CT_DLG_GetDisplay;
	_ctrl=		_dsp displayCtrl _idc;	

	_idx= 		[_ctrl] call CT_DLG_LBGetSelected;		//Index selected item
	[_idx] call CT_DLG_CartSetIDCountMinus;				//Abzug oder entfernen des eintrages
	
	//Einkaufswagen updaten
	_idc= 	IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
	[_idd,_idc] call CT_DLG_GearMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE;
	[_idc] call CT_DLG_GearMenu_UpdateCost;
};
CT_DLG_GearMenu_AddAllToCart= {
	private ["_idd","_dsp","_idc","_ctrl","_idx","_type","_ID_List"];
	//Dialog Info
	_idd=		CT_DLG_DialogIDD;
	_dsp= 		[_idd] call CT_DLG_GetDisplay;
	
	//Combo Box
	_idc=		IDC_GEARMENU_COMBO_GEARMENU_SELTYPE;
	_ctrl=		_dsp displayCtrl _idc;
	_idx=		[_ctrl] call CT_DLG_LBGetSelected;
	_type=		[_ctrl,_idx] call CT_DLG_LBGetData;
	
	_ID_List= 	[_type] call CT_DLG_GearMenu_CreatIDArray;					//Liste mit IDs
	
	{
		[_x] call CT_DLG_CartAddItem
	} foreach _ID_List;
	
	//Einkaufswagen updaten
	_idc= 	IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
	[_idd,_idc] call CT_DLG_GearMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE;
	[_idc] call CT_DLG_GearMenu_UpdateCost;

};
CT_DLG_GearMenu_RemoveAllFromCart={
	call CT_DLG_ResetCart;
	
	//Einkaufswagen updaten
	_idd= 	CT_DLG_DialogIDD;
	_idc= 	IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
	[_idd,_idc] call CT_DLG_GearMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE;
	[_idc, _ID] call CT_DLG_GearMenu_UpdateCost;
};

//General Functions
CT_DLG_GearMenu_UpdateCart= {
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
		_id= __SEL(_x,0);
		_cnt= __SEL(_x,1);
		
		_name=		_ID call Tee_GetWeap_Name;
		_entry= format ["%1 x %2",_name, _cnt];
		
		[_ctrl,_entry] call CT_DLG_LBAdd;
	} foreach _CL;
};	
CT_DLG_GearMenu_UpdateCost = {
	private ["_idc","_CL","_ID","_price"];
	_idc= 		__SEL(_this,0);
	_CL= 		CT_DLG_CartList;
	
	CT_DLG_OverallCost= 0;
	
	{
		_ID= 		__SEL(_x,0);
		_cnt= 		__SEL(_x,1);
		_price=		_ID call Tee_GetWeap_Price;
		
		CT_DLG_OverallCost= CT_DLG_OverallCost + (_price * _cnt);
	} foreach _CL;
	
	[_idc] call CT_DLG_UpdateCosts;
};

//Kauffunktionen Buy to Inventory
CT_DLG_GearMenu_BuyToInventory = {
	private ["_buytype","_ID"];
	_buytype= 	0;					//0=to inventory, 1= to crate
	
	{
		_ID= 	__SEL(_x,0);
		_cnt=	__SEL(_x,1);
		
		for "_i" from 1 to _cnt do
		{
			[_ID,_buytype] call CT_DLG_GearMenu_Buy;
		};
	} foreach  		CT_DLG_CartList;
	
	CT_DLG_CartList = [];
	
	//Einkaufswagen updaten
	_idd=	CT_DLG_DialogIDD;
	_idc= 	IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
	[_idd,_idc] call CT_DLG_GearMenu_UpdateCart;
	
	//Kosten Updaten
	_idc= IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE;
	[_idc] call CT_DLG_GearMenu_UpdateCost;
};
CT_DLG_GearMenu_Buy= {
	private ["_ID","_buytype","_type"];
	_ID=		__SEL(_this,0);
	_buytype= 	__SEL(_this,1);
	
	_type=	_ID call Tee_GetWeap_Typ;
	
	//"wep","mag","item","wear","bp"
	switch (_type) do
	{
		case "wep": {[_ID] call Tee_AddWeapon};
		case "mag": {[_ID] call Tee_AddMag};
		case "item": {[_ID] call Tee_AddItem};
		case "wear": {};
		case "bp":	{};
	};
};