
//---Functions
//-----------------------------------Debug-----------------------------------
_h= [] execVM "functions\functions\Functions_Debug.sqf";
waituntil {scriptDone _h};
//-----------------------------------Basic-----------------------------------
_h= [] execVM "functions\functions\Functions_Basic.sqf";
waituntil {scriptDone _h};

//-----------------------------------Savesystem-----------------------------------
_h= [] execVM "functions\functions\Functions_Savesystem.sqf";
waituntil {scriptDone _h};

//-----------------------------------Voting-----------------------------------
_h= [] execVM "functions\functions\Functions_Voting.sqf";
waituntil {scriptDone _h};

//-----------------------------------Player-----------------------------------
_h= [] execVM "functions\functions\Functions_Player.sqf";
waituntil {scriptDone _h};

//-----------------------------------Money-----------------------------------
_h= [] execVM "functions\functions\Functions_Money.sqf";
waituntil {scriptDone _h};

//-----------------------------------Base-----------------------------------
_h= [] execVM "functions\functions\Functions_Base.sqf";
waituntil {scriptDone _h};

//-----------------------------------Towns-----------------------------------
_h= [] execVM "functions\functions\Functions_Towns.sqf";
waituntil {scriptDone _h};

//-----------------------------------Strategic-----------------------------------
_h= [] execVM "functions\functions\Functions_Strategic.sqf";
waituntil {scriptDone _h};

//-----------------------------------Support and Supply Functions----------------
_h= [] execVM "functions\functions\Functions_Support.sqf";
waituntil {scriptDone _h};

//-----------------------------------Marker-----------------------------------
_h= [] execVM "functions\functions\Functions_Marker.sqf";
waituntil {scriptDone _h};

//-----------------------------------Vehicles-----------------------------------
_h= [] execVM "functions\functions\Functions_Vehicles.sqf";
waituntil {scriptDone _h};

//-----------------------------------Weapons-----------------------------------
_h= [] execVM "functions\functions\Functions_Weapons.sqf";
waituntil {scriptDone _h};

//-----------------------------------AI-----------------------------------
_h= [] execVM "functions\functions\Functions_AI.sqf";
waituntil {scriptDone _h};


//---Actions Loop
_h= [] execVM "functions\functions_action\Functions_Action.sqf";
waituntil {scriptDone _h};

//---AI
_h= [] execVM "functions\functions_ai\Functions_AI.sqf";
waituntil {scriptDone _h};

//---group 
_h= [] execVM "functions\functions_group\Functions_Group.sqf";
waituntil {scriptDone _h};
