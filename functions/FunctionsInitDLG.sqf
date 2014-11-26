_h= [] execVM "functions\Functions_dlg\OldMenu\dlg_Variables.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\MainMenuStartup.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\Functions_dlg_Basic.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\Functions_dlg_Cart.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\Functions_dlg_Listbox.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\Functions_dlg_MainMenu.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\Functions_dlg_GearMenu.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\Functions_dlg_UnitMenu.sqf";
waituntil {scriptdone _h};
_h= [] execVM "functions\Functions_dlg\OldMenu\Functions_dlg_VehMenu.sqf";
waituntil {scriptdone _h};


//New Gear Menu
_h= execVM "functions\functions_dlg\GearMenu\GearMenuInit.sqf";
waituntil {scriptdone _h};