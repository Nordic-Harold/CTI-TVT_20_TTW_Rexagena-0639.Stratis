#include "macros.sqf"
#include "setup.sqf"

CT_DLG_GearMenu_SetUp= {

private [];

	_button_idcs= 	[];
	_frames_idcs= 	[];
	_pict_idcs=		[];
	
	CT_DLG_GearMenu_IDD=	IDD_GearMenu;
	
	disableSerialization;
	waituntil {!dialog};
	_dlg= createdialog "CT_DLG_GearMenu";
	waituntil {dialog};
	waituntil {!IsNull (finddisplay CT_DLG_GearMenu_IDD)};
	
	_dsp= findDisplay CT_DLG_GearMenu_IDD;
	
	[_dsp] call CT_DLG_GearMenu_UtilizationBarInit; 				//Updated die Ausnutzungsbalken
	[_dsp] call CT_DLG_GearMenu_UpdatePictureInit;
};