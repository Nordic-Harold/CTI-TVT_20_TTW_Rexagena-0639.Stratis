#define __cppfln(root) compile preprocessFileLineNumbers root

//General Functions
//functions
#define __root_fnc_dir(directory,file) format ["functions\functions\%1\%2.sqf",#directory,#file]
#define __cppfln_fnc_dir(directory,file) __cppfln(__root_fnc_dir(directory,file))

#define __root_fnc(file) format ["functions\functions\%1.sqf",#file]
#define __cppfln_fnc(file) __cppfln(__root_fnc(file))

//functions_action
#define __root_fnc_action(file) format ["functions\functions_action\%1.sqf",#file]
#define __cppfln_fnc_action(file) __cppfln(__root_fnc_action(file))

//functions_ai
#define __root_fnc_ai(file) format ["functions\functions_ai\%1.sqf",#file]
#define __cppfln_fnc_ai(file) __cppfln(__root_fnc_ai(file))

//functions_group
#define __root_fnc_grp(file) format ["functions\functions_group\%1.sqf",#file]
#define __cppfln_fnc_grp(file) __cppfln(__root_fnc_grp(file))


//Server Functions
#define __root_fnc_server_dir(directory,file) format ["functions\functions_server\%1\%2.sqf",#directory,#file]
#define __cppfln_fnc_server_dir(directory,file) __cppfln(__root_fnc_server_dir(directory,file))

#define __root_fnc_server(file) format ["functions\functions_server\%1.sqf",#file]
#define __cppfln_fnc_server(file) __cppfln(__root_fnc_server(file))

//HC Functions
#define __root_fnc_hc_dir(directory,file) format ["functions\functions_hc\%1\%2.sqf",#directory,#file]
#define __cppfln_fnc_hc_dir(directory,file) __cppfln(__root_fnc_hc_dir(directory,file))

#define __root_fnc_hc(file) format ["functions\functions_hc\%1.sqf",#file]
#define __cppfln_fnc_hc(file) __cppfln(__root_fnc_hc(file))

//---AIDEF
#define __root_aidef_dir(directory,file) format ["functions\AIDef\%1\%2.sqf",#directory,#file]
#define __cppfln_aidef_dir(directory,file) __cppfln(__root_aidef_dir(directory,file))
