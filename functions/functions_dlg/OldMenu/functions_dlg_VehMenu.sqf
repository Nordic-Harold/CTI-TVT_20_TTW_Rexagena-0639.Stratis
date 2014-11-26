#include "macros.sqf"
#include "Macros\VehMenuMacros.sqf"


CT_dlg_VehMenu_StartUp= {
	private ["_text_idc","_frames_idc","_button_idc","_idd","_dlg","_dsp"];
	disableSerialization;	
	
	_text_idc= 		TW_dlg_VehMenu_text_idc;
	_frames_idc=	TW_dlg_VehMenu_frames_idc;
	_button_idc=	TW_dlg_VehMenu_button_idc;
	_idd=			IDD_VEHMENU;
	
	waituntil {!dialog};
	_dlg= createdialog "TTW_dlg_VehMenu";
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
	_erg= [IDC_VEHICE_TEXT_VEHMENU_FUNDSVALUE] spawn CT_DLG_UpdateFunds;							//Updated die Kontoinformationen
	
	[_dsp,IDC_VEHICE_LB_VEHMENU_SELECTVEHICLE] call CT_DLG_VehMenu_LBSelectVehiclesSetUp;			//Setzt Select Unit LB
};

CT_DLG_VehMenu_CreatIDArray = {
	private ["_side","_ID_Lists"];
	//Feststellen der Seite
	_side= 		0;
	if(side player == WEST) then {_side = 0};
	if(side player == EAST) then {_side = 1};
	if(side player == Resistance) then {_side = 2};
	
	//Erstellt Liste
	_ID_Lists= 	__SEL(CT_DLG_AllVehicles,_side);				//0=east, 1=west,2=town/resistance
	_return=	[];			//Liste mit allen Einheiten
	{
		
		_typ= _x call Tee_GetVeh_Typ;
		
		if(TW_vehicles and _typ in ["Bike","Boat","Car","Truck","Tank","Box"]) then {
			_return= _return + [_x];
		};
		if(TW_air and _typ == "Air") then {
			_return= _return + [_x];
		};
	} foreach _ID_Lists;
	
	_return
};
CT_DLG_VehMenu_CreateLBEntries={
	private ["_ctrl","_idc","_idx","_dsp","_ID_Array","_max_IDs","_ID","_Name","_price","_i"];
	_dsp=	__SEL(_this,0);
	_idc=	__SEL(_this,1);
	_ctrl= 	_dsp displayctrl _idc;
	
	_ID_Array= 	call CT_DLG_VehMenu_CreatIDArray;
	_max_IDs=	__MAX(_ID_Array);
	
	//Clear Listbox;
	[_ctrl] call CT_DLG_LBClear;	
	
	for "_i" from 0 to _max_IDs do {
		_ID= 		__SEL(_ID_Array,_i);
		
		if(_ID != 0) then
		{
			_Name=		_ID call Tee_GetVeh_Name;
			_Price=		_ID call Tee_GetVeh_Price;
			_entry= 	[_Name,_Price] call CT_DLG_LBSetEntryNamePrice;
			
			[_ctrl,_entry] call CT_DLG_LBAdd;					//Eintrag in Listbox
			[_ctrl,_i,_ID] call CT_DLG_LBSetData;				//ID hinterlegen
		};
	};
};
//DLG Setup
CT_DLG_VehMenu_LBSelectVehiclesSetUp = {
		_dsp=	__SEL(_this,0);
		_idc=	__SEL(_this,1);
		_ctrl=	_dsp displayCtrl _idc;
		
		[_dsp,_idc] call CT_DLG_VehMenu_CreateLBEntries;					//Füllt liste mit kaufbaren Einheiten		
};
//Buy Function
CT_DLG_VehMenu_BuySelected= {
	private ["_idd","_idc","_dsp","_ctrl","_idx","_ID"];
	_idd= 	IDD_VEHMENU;
	_idc= 	IDC_VEHICE_LB_VEHMENU_SELECTVEHICLE;
	_dsp= 	[_idd] call CT_DLG_GetDisplay;
	_ctrl= 	_dsp displayCtrl _idc;
	_idx=	[_ctrl] call CT_DLG_LBGetSelected;

	_ID= 	[_ctrl,_idx] call CT_DLG_LBGetData;
	
	[_ID] call Tee_CreateVehicle;
};