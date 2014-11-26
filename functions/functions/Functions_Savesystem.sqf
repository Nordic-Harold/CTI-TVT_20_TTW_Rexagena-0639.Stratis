/*
	Script written by TeeTime dont remove this comment
*/
Tee_SS_Gear_Save = {
	private ["_array","_item","_geararray"];
	
	_item		= "";
	_array 		= [];
	_geararray	= [];
	
	//Clothes
		//Save Uniform
		_item 	= uniform player;
		_geararray 	= _geararray + [_item];
	
		_array 	= uniformItems player;
		_geararray 	= _geararray + [_array];
	
	
		//Save Vest
		_item 		= vest player;
		_geararray 	= _geararray + [_item];
	
		_array 		= vestItems player;
		_geararray 	= _geararray + [_array];

		
		//Save Headgear
		_item 		= headgear player;
		_geararray 	= _geararray + [_item];	
		
		
		//Save Goggles
		_item 		= goggles player;
		_geararray 	= _geararray + [_item];
		
		
		//Save Backpack
		_item 		= backpack player;
		_geararray 	= _geararray + [_item];
		
		_array 		= backpackItems player;
		_geararray 	= _geararray + [_array];
	
	
	//Weapon Modifications
		//Weapon Modi Prim
		_array = primaryWeaponItems player;
		_geararray 	= _geararray + [_array];
		
		//Weapon Modi Sec
		_array = secondaryWeaponItems player;
		_geararray 	= _geararray + [_array];
		
		//Weapon Modi Hand
		_array = handgunItems player;
		_geararray 	= _geararray + [_array];
	
	
	//Save Ammunition
	_array		= magazines player;
	_geararray 	= _geararray + [_array];
	
	//Save Weapons
	_array = weapons player;
	_geararray = _geararray + [_array];
	
	Tee_Save_GearArray = _geararray;
	
	titleText[localize "STRS_SS_Save_Geardone", "PLAIN DOWN"];	//Msg
	
	if(debug) then {
		player groupchat str _geararray;	//Msg
	};
	
	
	/*
	geararray = [
		uniform,uniformitems,vest,vestitems,headgear,goggles,backpack,backpackitems
		pWItems,sWItems,hGItem
		weapon,ammo
	];
	*/
	
};



Tee_SS_Gear_Load = {
	private ["_uniform","_uniformitems","_vest","_vestitems","_headgear","_goggles","_backpack","_backpackitems","_wepmodprim","_wepmodsec","_wepmodhand","_magarray","_weaparray"];
	
	//Check
	if(count Tee_Save_GearArray == 0) exitWith {};
	
	_uniform		= Tee_Save_GearArray select 0;
	_uniformitems	= Tee_Save_GearArray select 1;
	_vest			= Tee_Save_GearArray select 2;
	_vestitems		= Tee_Save_GearArray select 3;
	_headgear		= Tee_Save_GearArray select 4;
	_goggles		= Tee_Save_GearArray select 5;
	_backpack		= Tee_Save_GearArray select 6;
	_backpackitems	= Tee_Save_GearArray select 7;
	
	_wepmodprim		= Tee_Save_GearArray select 8;
	_wepmodsec		= Tee_Save_GearArray select 9;
	_wepmodhand		= Tee_Save_GearArray select 10;
	
	_magarray 		= Tee_Save_GearArray select 11;
	_weaparray		= Tee_Save_GearArray select 12;
	
	//Clean Player
	removeAllWeapons player;
	{
		player removeMagazines _x;
	} forEach magazines player;
	
	//Uniform
	removeUniform player;

	//Vest
	removeVest player;
	
	//Headgear
	removeHeadgear player;
	
	//Goggles
	removeGoggles player;
	
	//Backpack
	removeBackpack player;
	
	
	
	
	//Load Clothes
	if(_uniform != "") then {
		player addUniform _uniform;
	};
	if(_vest != "") then {
		player addVest _vest;
	};
	if(_headgear != "") then {
		player addHeadgear _headgear;
	};
	if(_goggles != "") then {
		player addGoggles _goggles;
	};
	if(_backpack != "") then {
		player addBackpack _backpack;
		clearAllItemsFromBackpack player;
	};
	
	
	//Load Items Uniform
	{
		if(_x != "") then {
			player addItem _x;
		};
	} forEach _uniformitems;
	
	//Load Items Vest
	{
		if(_x != "") then {
			player addItem _x;
		};
	} forEach _vestitems;
	
	//Load Items BackPack
	{
		if(_x != "") then {
			player addItem _x;
		};
	} forEach _backpackitems;
	
	//Load Ammunition
	{
		if(_x != "") then {
			player addMagazine _x;
		};
	} forEach _magarray;
	
	//Load Weapons
	{
		if(_x != "") then {
			player addWeapon _x;
		};
	} forEach _weaparray;
	
	//Load Weapon Modi Prim
	{
		player removePrimaryWeaponItem _x;
	} forEach (primaryWeaponItems player);
	{
		if(_x != "") then {
			player addPrimaryWeaponItem _x;
		};
	} forEach _wepmodprim;
	
	//Load Weapon Modi Sec
	{
		if(_x != "") then {
			player addSecondaryWeaponItem _x;
		};
	} forEach _wepmodsec;
	
	//Load Weapon Modi Hand
	{
		if(_x != "") then {
			player addHandgunItem _x;
		};
	} forEach _wepmodhand;
	
	
	if(debug) then {
		player groupchat "Gear loaded";	//Msg
	};
};