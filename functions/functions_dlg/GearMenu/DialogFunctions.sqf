#include "macros.sqf"
#include "setup.sqf"
//Update der Ausnutzungsbalken
CT_DLG_GearMenu_UtilizationBarInit= {
	_dsp= __SEL(_this,0);
	
	_UpdateStaminaBar= {
		private ["_dsp","_idc","_width","_add","_ctrl","_l","_w","_pos","_x","_y","_h","_w"];
		_dsp= 	__SEL(_this,0);
		_idc= 	__SEL(_this,1);
		_width= __SEL(_this,2);
		_add=	if(count _this >=3) then {__SEL(_this,3)} else {0};			//zusätzliches Gewicht muss noch eingearbeitet werden
		
		_ctrl=	_dsp displayCtrl _idc;
		_l=		load player;
		
		_w= 	_l*_width;
		_pos= 	ctrlposition _ctrl;
		_x=		__SEL(_pos,0);
		_y=		__SEL(_pos,1);
		_h=		__SEL(_pos,3);
		_w= 	_l*_width;
		
		_ctrl ctrlSetPosition [_x,_y,_w,_h];
		_ctrl ctrlCommit 0; 
	};	
	_UpdateUniformBar= {
		private ["_dsp","_idc","_width","_add","_ctrl","_l","_w","_pos","_x","_y","_h","_w"];
		_dsp= 	__SEL(_this,0);
		_idc= 	__SEL(_this,1);
		_width= __SEL(_this,2);
		_add=	if(count _this >=3) then {__SEL(_this,3)} else {0};				//zusätzliches Gewicht muss noch eingearbeitet werden

		_ctrl=	_dsp displayCtrl _idc;	
		_l=		loaduniform player;

		_w= 	_l*_width;
		_pos= 	ctrlposition _ctrl;
		_x=		__SEL(_pos,0);
		_y=		__SEL(_pos,1);
		_h=		__SEL(_pos,3);
		_w= 	_l*_width;
		
		_ctrl ctrlSetPosition [_x,_y,_w,_h];
		_ctrl ctrlCommit 0; 
	};
	_UpdateVestBar= {
		private ["_dsp","_idc","_width","_add","_ctrl","_l","_w","_pos","_x","_y","_h","_w"];
		_dsp= 	__SEL(_this,0);
		_idc= 	__SEL(_this,1);
		_width= __SEL(_this,2);
		_add=	if(count _this >=3) then {__SEL(_this,3)} else {0};				//zusätzliches Gewicht muss noch eingearbeitet werden

		_ctrl=	_dsp displayCtrl _idc;	
		_l=		loadvest player;

		_w= 	_l*_width;
		_pos= 	ctrlposition _ctrl;
		_x=		__SEL(_pos,0);
		_y=		__SEL(_pos,1);
		_h=		__SEL(_pos,3);
		_w= 	_l*_width;
		
		_ctrl ctrlSetPosition [_x,_y,_w,_h];
		_ctrl ctrlCommit 0; 
	};
	_UpdateBackpackBar= {
		private ["_dsp","_idc","_width","_add","_ctrl","_l","_w","_pos","_x","_y","_h","_w"];
		_dsp= 	__SEL(_this,0);
		_idc= 	__SEL(_this,1);
		_width= __SEL(_this,2);
		_add=	if(count _this >=3) then {__SEL(_this,3)} else {0};				//zusätzliches Gewicht muss noch eingearbeitet werden

		_ctrl=	_dsp displayCtrl _idc;	
		_l=		loadbackpack player;

		_w= 	_l*_width;
		_pos= 	ctrlposition _ctrl;
		_x=		__SEL(_pos,0);
		_y=		__SEL(_pos,1);
		_h=		__SEL(_pos,3);
		_w= 	_l*_width;
		
		_ctrl ctrlSetPosition [_x,_y,_w,_h];
		_ctrl ctrlCommit 0; 
	};	
	//Stamina
	_idc= IDC_GEARMENU_TEXT_GEARMENU_STAMINABAR;
	_width= 13*GUI_GRID_W;
	[_dsp,_idc,_width] call _UpdateStaminaBar;
	
	//Uniform
	_idc= IDC_GEARMENU_TEXT_GEARMENU_UNIFORMUTILIZATIONBAR;
	_width= 4*GUI_GRID_W;
	[_dsp,_idc,_width] call _UpdateUniformBar;
	
	//Westen
	_idc= IDC_GEARMENU_TEXT_GEARMENU_VESTUTILIZATIONBAR;
	_width= 4*GUI_GRID_W;
	[_dsp,_idc,_width] call _UpdateVestBar;
	
	//Rucksack
	_idc= IDC_GEARMENU_TEXT_GEARMENU_BACKPACKUTILIZATIONBAR;
	_width= 4*GUI_GRID_W;
	[_dsp,_idc,_width] call _UpdateBackpackBar;
};
CT_DLG_GearMenu_UpdatePictureInit= {
	private ["_dsp","_item","_idc"];
	
	_dsp= __SEL(_this,0);
	_UpdatePicture= {
		private ["_dsp","_idc","_item","_path","_ctrl"];
		_dsp=	__SEL(_this,0);
		_idc=	__SEL(_this,1);
		_item=	__SEL(_this,2);
	
		_path= _item call CT_DLG_GetConfigPicture;
		_ctrl= 	_dsp displayCtrl _idc;
				
		if(_path != "") then { _ctrl ctrlsettext _path};
	};
	//Uniform
	_item= 	Uniform player;
	_idc=	IDC_GEARMENU_PICTURE_GEARMENU_UNIFORM;
	[_dsp,_idc,_item] call _UpdatePicture;
	
	//Weste
	_item= 	vest player;
	_idc=	IDC_GEARMENU_PICTURE_GEARMENU_VEST;
	[_dsp,_idc,_item] call _UpdatePicture;
	
	//Rucksack
	_item= 	backpack player;
	_idc=	IDC_GEARMENU_PICTURE_GEARMENU_BACKPACK;
	[_dsp,_idc,_item] call _UpdatePicture;
	
	//Primary Weapon
	_item= 	primaryweapon player;
	_idc=	IDC_GEARMENU_PICTURE_GEARMENU_PRIMARYWEAPON;
	[_dsp,_idc,_item] call _UpdatePicture;
	
	//secondaryWeapon
	_item= 	secondaryweapon player;
	_idc=	IDC_GEARMENU_PICTURE_GEARMENU_SECONDARYWEAPON;
	[_dsp,_idc,_item] call _UpdatePicture;
	
	//Backup
	_item= 	handgunWeapon player;
	_idc=	IDC_GEARMENU_PICTURE_GEARMENU_BACKUP;
	[_dsp,_idc,_item] call _UpdatePicture;
	
	//primaryWeaponItems
	_items= primaryWeaponItems player;
	_idcs= [IDC_GEARMENU_PICTURE_GEARMENU_PWMUZZLE,IDC_GEARMENU_PICTURE_GEARMENU_PWSIDE,IDC_GEARMENU_PICTURE_GEARMENU_PWTOP];
	if(count _items != 0) then {
		for "_i" from 0 to ((count _idcs) -1) do
		{
			_item= __SEL(_items,_i); _idc= __SEL(_idcs,_i);
			[_dsp,_idc,_item] call _UpdatePicture;
		}
	};
	//secondaryWeaponItems
	_items= secondaryWeaponItems player;
	_idcs= [IDC_GEARMENU_PICTURE_GEARMENU_SWMUZZLE,IDC_GEARMENU_PICTURE_GEARMENU_SWSIDE,IDC_GEARMENU_PICTURE_GEARMENU_SWTOP];
	if(count _items != 0) then {
		for "_i" from 0 to ((count _idcs) -1) do
		{
			_item= __SEL(_items,_i); _idc= __SEL(_idcs,_i);
			[_dsp,_idc,_item] call _UpdatePicture;
		}
	};
	
	//Backup Items
	_items= handgunItems player;
	_idcs= [IDC_GEARMENU_PICTURE_GEARMENU_BUMUZZLE,IDC_GEARMENU_PICTURE_GEARMENU_BUSIDE,IDC_GEARMENU_PICTURE_GEARMENU_BUTOP];
	if(count _items != 0) then {
		for "_i" from 0 to ((count _idcs) -1) do
		{
			_item= __SEL(_items,_i); _idc= __SEL(_idcs,_i);
			[_dsp,_idc,_item] call _UpdatePicture;
		}
	};
};