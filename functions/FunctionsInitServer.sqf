//---Server
//basic functions
_h= [] execVM "functions\functions_server\functions_SBasic.sqf";
waituntil {scriptdone _h};

//Towns
_h= [] execVM "functions\functions_server\functions_STowns.sqf";
waituntil {scriptdone _h};

//Functions and loops
_h= [] execVM "functions\functions_server\functions_SLoops.sqf";
waituntil {scriptdone _h};