_h= execVM "functions\functions_dlg\GearMenu\variablen.sqf";
waituntil {scriptdone _h};
_h= execVM "functions\functions_dlg\GearMenu\basicfunctions.sqf";
waituntil {scriptdone _h};
_h= execVM "functions\functions_dlg\GearMenu\DialogFunctions.sqf";
waituntil {scriptdone _h};
_h= execVM "functions\functions_dlg\GearMenu\DialogSetup.sqf";
waituntil {scriptdone _h};