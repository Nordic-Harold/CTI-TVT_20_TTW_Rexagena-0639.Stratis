//---HC 
//Functions
_h= [] execVM "functions\functions_hc\Functions_HC_Init.sqf";
waituntil {scriptDone _h};

//Towns
_h= [] execVM "functions\functions_hc\Functions_Towns.sqf";
waituntil {scriptDone _h};

//Functions and loops
_h= [] execVM "functions\functions_hc\Functions_Loops.sqf";
waituntil {scriptDone _h};