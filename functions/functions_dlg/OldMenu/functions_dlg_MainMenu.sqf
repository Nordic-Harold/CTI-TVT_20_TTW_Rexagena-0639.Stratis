#include "macros.sqf"

CT_dlg_MainMenu_StartUp=
{
	//private ["_name","_dlg","_text"];
	//_name= _this select 0;
	disableSerialization;
	waituntil {!dialog};
	_dlg= 		createdialog "TTW_dlg_MainMenu";
	
	_idd=			1100;
	_button_idc= 	[
						[1700,"STRS_MainMenu_BUnits","_erg=[] spawn CT_dlg_UnitMenu_StartUp; closedialog 0","((player distance hq_west <= CT_DLG_DistanceToBase and side player == WEST) or (player distance hq_east <= CT_DLG_DistanceToBase and side player == EAST)) and TW_ai"],
						[1701,"STRS_MainMenu_BGear","_erg=[] spawn CT_dlg_GearMenu_StartUp; closedialog 0","(player distance hq_west <= CT_DLG_DistanceToBase and side player == WEST) or (player distance hq_east <= CT_DLG_DistanceToBase and side player == EAST)"],
						[1702,"STRS_MainMenu_BVehicles","_erg= [] spawn CT_dlg_VehMenu_StartUp; closedialog 0","((player distance hq_west <= CT_DLG_DistanceToBase and side player == WEST) or (player distance hq_east <= CT_DLG_DistanceToBase and side player == EAST)) and TW_vehicles"],
						[1703,"STRS_Vote","_erg= [] spawn CT_Vote_Dialog; closedialog 0","!TW_VotePlayerRequested and TW_Voting"],
//						[1704,"STRS_MainMenu_BCommander","closedialog 0","false"],
						[1705,"STRS_MainMenu_BReturn","closedialog 0",""]
					];
					
	_text_idc=		[
						[1000,"STRS_MainMenu_TTitle"],
						[1001,{name player}]
					];
	
	waituntil {dialog};
	waituntil {!IsNull (finddisplay _idd)}; //wartet, bis Display existiert

	_dsp= finddisplay _idd;
	//text
	{
		[_dsp,_x] call CT_DLG_SetText;
	} foreach _text_idc;
	
	//button
	{
		[_dsp,_x] call CT_DLG_SetButton;
	} foreach _button_idc;	
};


