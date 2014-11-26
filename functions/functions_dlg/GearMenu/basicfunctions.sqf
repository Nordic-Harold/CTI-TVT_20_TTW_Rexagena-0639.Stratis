#include "macros.sqf"
#include "setup.sqf"
CT_DLG_GetConfigType= {
	private ["_t","_isweapon","_ismagazine","_isvehicle"];
	_t= _this;

	_isweapon= 		if(str(configfile >> "CfgWeapons" >> _t) != "") then {true} else {false};
	_ismagazine=	if(str(configfile >> "CfgMagazines" >> _t) !="") then {true} else {false};
	_isvehicle=		if(str(configfile >> "CfgVehicles" >> _t) !="") then {true} else {false};
	_isglass=		if(str(configfile >> "CfgGlasses" >> _t) !="") then {true} else {false};
	
	_return= [_isweapon,_ismagazine,_isvehicle,_isglass];
	_return
};
CT_DLG_GetConfigPicture=
{
	private ["_t","_kind","_root"];
	_t=	 	_this;
	_kind=	_t call CT_DLG_GetConfigType;
	_root= "";
	
	if(_kind find true != -1) then {
		if(_kind find true == 0) then {
			_root= gettext(configfile >> "CfgWeapons" >> _t >> "picture");
		};
		if(_kind find true == 1) then
		{
			_root=gettext(configfile >> "CfgMagazines" >> _t >> "picture");
		};
		if(_kind find true == 2) then
		{
			_root=gettext(configfile >> "CfgVehicles" >> _t >> "picture");
		};
		if(_kind find true == 3) then
		{
			_root=gettext(configfile >> "CfgGlasses" >> _t >> "picture");
		};
	};
	
	_return= _root;
	
	_return
};