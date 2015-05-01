/*
	Script written by TeeTime and garisat dont remove this comment
*/

//Ideen
// ServicePoint Building : Military Cargo House V1 	(Cargo_House_V1_F)
// Baracks		 : Military Cargo HQ V1 	(Cargo_HQ_V1_F)
// ComandPost		 : Military Cargo OP V1 	(Cargo_Patrol_V1_F)!?! nicht sicher



//***********************************************************************
//Basic
//***********************************************************************

AddActionCode 	= "test.sqf";
if(isNil "HQ_placed") 			then {HQ_placed = false;};
TW_HQ_Placed_Client = false;
if(isNil "TW_ServerStarted") 	then {TW_ServerStarted = false;};
TW_Mission_End 		= false;
TW_TK_Counter		= 0;
TW_Player_Killed 	= "";
TW_Player_Kick 		= "";
TW_AI_Killed 		= "";

//TW_westplayer_array = [wp_1,wp_2,wp_3,wp_4,wp_5,wp_6,wp_7,wp_8,wp_9,wp_10,wp_11,wp_12,wp_13,wp_14];	//Not used
//TW_eastplayer_array = [ep_1,ep_2,ep_3,ep_4,ep_5,ep_6,ep_7,ep_8,ep_9,ep_10,ep_11,ep_12,ep_13,ep_14];	//Not used

TW_Vehicle_Client 	= [];	//List with player vehicle


//***********************************************************************
//Server
//***********************************************************************

if(isServer) then {
	TW_Server_Restart 	= false;
	TW_Server_HQPos		= [];
};



//***********************************************************************
//Save System
//***********************************************************************

Tee_Save_GearArray = [];



//***********************************************************************
//Vote System
//***********************************************************************

TW_Voting				= false;	//Status only 1 vote can be active
TW_Vote_Time		= 45;		//Time to vote in seconds
TW_Vote_Start 		= [];		//["side","kind","Name"]
TW_Vote_Votes 	= [0,0];//[Yes,No]
TW_Vote_Actions	= [];		//All Actions linked to a vote
TW_Vote_Result		= false;	//Result of the last Vote init by teh player the cariable is local to
	
	
//***********************************************************************
//Money System
//***********************************************************************

Tee_Money_Min					= 50 	* TW_Income;			//Income per Minute
Tee_Money_Town				= 75 	* TW_Income;			//Income per Town
Tee_Money_TownScout	= 200 	* TW_Income;		//Bonus for scouting a town as first
Tee_Money_TownCap		= 500 	* TW_Income;		//Bonus for taking a town
Tee_Konto 							= 1000 	* TW_Income;		//Startmoney
Tee_Money_Kill_Bonus			= 150 	* TW_Income;	//Money for Playerkill
Tee_Money_AI_Kill_Bonus	= 100 	* TW_Income;	//Money for AI Kill
Tee_Money_TK_Punish			= 1000 	* TW_Income;	//TK Punishment


//************************************
//Base
//************************************

TW_Base_TownProtection	= 300;	//Distance in m in which you are not allowed to build a hq

TW_West_BaseMarker 		= "west_base";
TW_West_ShopMarker_V 	= "west_m_veh";	//Vehicle
TW_West_ShopMarker_G 	= "west_m_wp";
TW_West_ShopMarker_AI 	= "west_m_ai";

TW_East_BaseMarker 			= "east_base";
TW_East_ShopMarker_V 	= "east_m_veh";	//Vehicle
TW_East_ShopMarker_G 	= "east_m_wp";	//Weapon
TW_East_ShopMarker_AI 	= "east_m_ai";		//AI

TW_West_Respawn 	= "tw_west_respawn";
TW_East_Respawn 	= "tw_east_respawn";

TW_BasePos_Array = [
	["basepos",		"basepos_1"],
	["basepos_2",	"basepos_3"],
	["basepos_4",	"basepos_5"],
	["basepos_6",	"basepos_7"],
	["basepos_8",	"basepos_9"],
	["basepos_10",	"basepos_11"],
	["basepos_12",	"basepos_13"]
];

//******************************************
//Towns
//******************************************

TW_TownArray = [
//	Object			Marker			Name
	[base,			"town",			"Stratis Airbase"				],
	[base_1,		"town_1",		"Agia Marina Harbour"			],
	[base_2,		"town_2",		"Agia Marina Military Camp"		],
	[base_3,		"town_3",		"Agia Marina Fuel Station"		],
	[base_4,		"town_4",		"Transmitter Tower West"		],
	[base_5,		"town_5",		"Camp Rogain"					],
	[base_6,		"town_6",		"Kill Farm"						],
	[base_7,		"town_7",		"Transmitter Tower East"		],
	[base_8,		"town_8",		"Old Outpost"					],
	[base_9,		"town_9",		"Kamino Firing Range"			],
	[base_10,	"town_10",	"Air Station Mike-26"			],
	[base_11,	"town_11",	"Camp Tempest"					],
	[base_12,	"town_12",	"Camp Maxwell"					],
	[base_13,	"town_13",	"Tsqukalia"						],
	[base_14,	"town_14",	"Girna"							],
	[base_15,	"town_15",	"Agios Ioannis"					],
	[base_16,	"town_16",	"Agios Cephas"					],
	[base_17,	"town_17",	"Jay Cove"						],
	[base_18,	"town_18",	"The Spartan"					]
];

TW_Town_CapDis 			= 35;	//Distance for taking a town
TW_Town_DecDis 			= 150;	//Distance for decteting who is owning the town
TW_Town_Taken			= [];
TW_Town_Taken_Server	= [];



TW_Town_StreetArray = [
//	Object			Roads to
	[base,			[base_3,base_4]							],
	[base_1,		[base_2,base_3,base_5,base_6]			],
	[base_2,		[base_1,base_3,base_4,base_5,base_8]	],
	[base_3,		[base,base_1,base_2]					],
	[base_4,		[base,base_2,base_8]					],
	[base_5,		[base_1,base_6,base_7,base_9]			],
	[base_6,		[base_1,base_5]							],
	[base_7,		[base_5,base_8,base_9,base_10]			],
	[base_8,		[base_2,base_4,base_7,base_10]			],
	[base_9,		[base_5,base_7]							],
	[base_10,	[base_7,base_8,base_11,base_12,base_13]	],
	[base_11,	[base_10,base_12]						],
	[base_12,	[base_10,base_13,base_14,base_15]		],
	[base_13,	[base_10,base_12,base_15]				],
	[base_14,	[base_12,base_15]						],
	[base_15,	[base_12,base_13,base_14,base_16]		],
	[base_16,	[base_15,base_17,base_18]				],
	[base_17,	[base_16,base_18]						],
	[base_18,	[base_16,base_17]						]
];

//***********************************************************************
//Support and Supply
//***********************************************************************

TW_Repair_Cost = 350;
TW_Repair_Time = 30;

TW_Sup_Fuel_Cost = 200;
TW_Sup_Fuel_Time = 5;		//Time to fill up 10% of the tank

TW_Sup_Reammo_Cost = 600;
TW_Sup_Reammo_Time = 60;


//***********************************************
//Shop List Basic
//***********************************************

TW_Vehicle_Shop_West = [
//Boxes
50,51,52,53,

//Bikes
101,

//Boats

//Cars
301,
302,
305,

//Trucks
401,

//Tanks
//501,

//Air
602
];

TW_Vehicle_Shop_East = [
//Boxes
60,61,62,63,

//Bikes
101,

//Boats

//Cars
306,
307,
305,

//Trucks
402,

//Tanks
//502,

//Air
603
];

TW_Vehicle_Shop_Town = [
//Box


//Bikes
101,

//Boats

//Cars
302

//Trucks

//Tanks

//Air

];


TW_Weapon_Shop_West = [
//Boxes

//Equipment
2001,
2002,
2003,
2004,
2005,

//Pistol
2101,
2102,
2100.1,

//Rifle
2201,2202,2204,2205,
2200.1,2200.2,2200.3,2200.4,2200.5,2200.6,2200.7,2200.8,2200.9,

/*
//Sniper
2301,2302,
2300.1,
*/

//MG
2401,2403,
2400.3,2400.4,2400.5,2400.6,

//Rocket
2501,2502,2503,
2500.1,2500.2,2500.3,2500.4,

//Explsoiv
2601,2602,2603

//East Weapons

];


TW_Weapon_Shop_East = [
//Boxes

//Equipment
2001,
2002,
2003,
2004,
2005,

//Pistol
2101,
2103,
2100.1,

//Rifle
2207,2208,2210,2211,
2200.1,2200.2,2200.3,2200.4,2200.5,2200.6,2200.7,2200.11,2200.12,

/*
//Sniper
2303,
2304,
2300.2,
*/

//MG
2404,
2400.1,2400.2,

//Rocket
2504,2505,2506,
2500.1,2500.2,2500.3,2500.5,

//Explsoiv
2601,2602,2603
];


TW_AI_Shop_West = [
7001,
7002,
7003,
7004,
7005,
7006,
7007,
7008,
7009
];


TW_AI_Shop_East = [
6001,
6002,
6003,
6004,
6005,
6006,
6007,
6008,
6009
];



//***********************************************
//Shop List Addons
//***********************************************

if(TW_Addons_Active) then {
	TW_Vehicle_Shop_West = TW_Vehicle_Shop_West + [
	//Here you can add Addon Stuff
	
	];
	
	TW_Vehicle_Shop_East = TW_Vehicle_Shop_East + [
	//Here you can add Addon Stuff
	
	];

	TW_Vehicle_Shop_Town = TW_Vehicle_Shop_Town + [
	//Here you can add Addon Stuff
	
	];
	
	TW_Weapon_Shop_West = TW_Weapon_Shop_West + [
	//Here you can add Addon Stuff
	
	];

	TW_Weapon_Shop_East = TW_Weapon_Shop_East + [
	//Here you can add Addon Stuff
	
	];
	
	TW_AI_Shop_West = TW_AI_Shop_West + [
	//Here you can add Addon Stuff
	
	];
	
	TW_AI_Shop_East = TW_AI_Shop_East + [
	//Here you can add Addon Stuff
	
	];
};



//***********************************************
//Vehicle Weapons AI Item Arrays
//***********************************************


//Vehicle Array ID: 0 - 999
Tee_Veh_Array = 
[
	//ID		Name 									Class 															Price										Needed Towns	"Typ"
	//Weapon Boxes
	//West
	[50,		"Nato Ammo Basic",			"Box_NATO_Ammo_F",						150 * vehicle_price,			0,							"Box"],
	[51,		"Nato Weapon Basic",		"Box_NATO_Wps_F",							400 * vehicle_price,			0,							"Box"],
	[52,		"Nato Grenades",				"Box_NATO_Grenades_F",					200 * vehicle_price,			0,							"Box"],
	[53,		"Nato Ordnance",				"Box_NATO_AmmoOrd_F",				150 * vehicle_price,			0,							"Box"],
//[54,		"Nato Specialweapons",	"Box_NATO_WpsSpecial_F",				800 * vehicle_price,			0,							"Box"],
//[55,		"Nato Supply Crate",			"B_supplyCrate_F",								250 * vehicle_price,			0,							"Box"],	
//[56,		"Nato Support",					"Box_NATO_Support_F",						150 * vehicle_price,			0,							"Box"],

	//East	
	[60,		"East Ammo Basic",			"Box_East_Ammo_F",							150 * vehicle_price,			0,							"Box"],
	[61,		"East Weapon Basic",		"Box_East_Wps_F",								400 * vehicle_price,			0,							"Box"],
	[62,		"East Grenades",				"Box_East_Grenades_F",					200 * vehicle_price,			0,							"Box"],
	[63,		"East Ordnance",				"Box_East_AmmoOrd_F",					150 * vehicle_price,			0,							"Box"],
//[64,		"East Specialweapons",	"Box_East_WpsSpecial_F",					800 * vehicle_price,			0,							"Box"],
//[65,		"East Supply Crate",			"B_supplyCrate_F",								150 * vehicle_price,			0,							"Box"],	
//[66,		"East Support",					"Box_East_Support_F",						150 * vehicle_price,			0,							"Box"],
	
	//Bike
	[101,		"Quad",									"B_Quadbike_01_F",								200 * vehicle_price,			0,							"Bike"],

	
	//Boat
//[201,		"Quad",									"B_Quadbike_01_F",								250 * vehicle_price,			0,							"Boat"],
	
	//Car
	//West	
	[301,		"Hunter",								"B_MRAP_01_F",									1000 * vehicle_price,		0,							"Car"],
	[302,		"Offroad Armed",				"I_G_offroad_01_armed_F",				8000 * vehicle_price,		0,							"Car"],
	[303,		"Hunter GMG",					"B_MRAP_01_gmg_F",							23000 * vehicle_price,		0,							"Car"],
	[304,		"Hunter HMG",					"B_MRAP_01_hmg_F",							20000 * vehicle_price,		0,							"Car"],
	
	//Independent
	[305,		"Offroad",								"C_Offroad_01_F",								500 * vehicle_price,			0,							"Car"],

	//East	
	[306,		"Ifrit",										"O_MRAP_02_F",									1000 * vehicle_price,		0,							"Car"],
	[307,		"Offroad Armed",				"O_G_offroad_01_armed_F",			8000 * vehicle_price,		0,							"Car"],
	[308,		"Ifrit GMG",							"O_MRAP_02_gmg_F",						23000 * vehicle_price,		0,							"Car"],
	[309,		"Ifrit MG",								"O_MRAP_02_hmg_F",						20000 * vehicle_price,		0,							"Car"],
	
	//Truck
	//West	
	[401,		"HEMTT Transport",			"B_Truck_01_transport_F",				1000 * vehicle_price,		0,							"Truck"],
	
	//East	
	[402,		"Zamak Transport",			"I_Truck_02_transport_F",					1000 * vehicle_price,		0,							"Truck"],
	
	 
	//Tank
	[501,		"AMV-7 Marshall",				"B_APC_Wheeled_01_cannon_F",	25000 * vehicle_price,		0,							"Tank"],
	[502,		"MSE-3 Marid",					"Wheeled_APC_F",									22000 * vehicle_price,		0,							"Tank"],
	
	//Air
	[601,		"AH-9 Pawnee",					"B_Heli_Light_01_armed_F",				37500 * airvehicle_price,		0,						"Air"],
	[602,		"MH-9 Hummingbird",		"B_Heli_Light_01_F",							9000 * airvehicle_price,		0,						"Air"],
	[603,		"PO-30 Orca",						"O_Heli_Light_02_unarmed_F",			9000 * airvehicle_price,		0,						"Air"],
	[604,		"PO-30 Orca Armed",		"O_Heli_Light_02_F",							37500 * airvehicle_price,		0,						"Air"],
	[605,		"AH-99 Blackfoot",			"B_Heli_Attack_01_F",							55000 * airvehicle_price,		0,						"Air"],
	[606,		"UH-80 Ghosthawk",		"B_Heli_Transport_01_F",					20000 * airvehicle_price,		0,						"Air"],
	[607,		"Mi-48 Kajman",					"O_Heli_Attack_02_F",						60000 * airvehicle_price,		0,						"Air"],
	[608,		"Mi-48 Kajman (black)",	"O_Heli_Attack_02_black_F",			60000 * airvehicle_price,		0,						"Air"]
];


//Addon Vehicles ID: 1000 - 1999

if(TW_Addons_Active) then {
	Tee_Veh_Array = Tee_Veh_Array + [
	//	ID		Name 						Class 													Price											Needed Towns	Typ
	//Bike
	//[1101,		"Quad",					"B_Quadbike_01_F",						250 * vehicle_price,				0,							"Bike"],

	//Boat
	//[1201,		"Quad",					"B_Quadbike_01_F",						250 * vehicle_price,				0,							"Boat"],

	//Car
	//[1301,		"Hunter",				"B_MRAP_01_F",							1000 * vehicle_price,			0,							"Car"],
	
	//Truck
	//[1401,		"Hunter",				"B_MRAP_01_F",							1000 * vehicle_price,			0,							"Truck"],
	
	//Tank
	//[1501,		"Hunter",				"B_MRAP_01_F",							1000 * vehicle_price,			0,							"Tank"],
	
	//Air
	//[1601,		"AH 9",					"B_Heli_Light_01_armed_F",		15000 * airvehicle_price,		0,							"air"],
	
	//End
	[1999,			"EndDummy",		"B_Heli_Light_01_armed_F",					0 * airvehicle_price,	999,						"Dummy"]
	];

};



//Weapon and Mag Array ID: 2000 - 3999
Tee_Weapon_Array = [
//	ID			Name 					Class 									Price									Needed Towns	Kind
//Equipment
	[2001,		"GPS",					"ItemGPS",						350 * weapon_price,	0,							"item"		],
	[2002,		"Medikit",				"Medikit",							50 * weapon_price,		0,							"item"		],
	[2003,		"First Aid Kit",		"FirstAidKit",						10 * weapon_price,		0,							"item"		],
	[2004,		"Toolkit",				"Toolkit",							500 * weapon_price,	0,							"item"		],
	[2005,		"Mine Detector",	"MineDetector",				500 * weapon_price,	0,							"item"		],

//Pistol
	[2101,		"ACP-C2",				"hgun_ACPC2_F",			800 * weapon_price,	0,							"wep"		],	
	//----West
	[2102,		"P07",					"hgun_P07_F",				800 * weapon_price,	0,							"wep"		],
	//----East
	[2103,		"Rook40",			"hgun_Rook40_F",		800 * weapon_price,	0,							"wep"		],
	//---Magazines
	[2100.1,	"16Rnd 9mm",	"16Rnd_9x21_Mag",		15 * weapon_price,		0,							"mag"	],
	
	
//Rifle
	//----West
	[2201,		"AR MX",									"arifle_MX_F",													1000 * weapon_price,			0,				"wep"		],
	[2202,		"AR MX ACO",							"arifle_MX_ACO_F",										1250 * weapon_price,			0,				"wep"		],
	[2203,		"AR MX RCO",							"arifle_MX_Hamr_pointer_F",						1400 * weapon_price,			0,				"wep"		],
	[2204,		"AR MX GL",								"arifle_MX_GL_F",											1500 * weapon_price,			0,				"wep"		],
	[2205,		"AR MX ACO GL",					"arifle_MX_GL_ACO_F",								1750 * weapon_price,			0,				"wep"		],
	[2206,		"AR MX RCO GL",					"arifle_MX_GL_Hamr_pointer_F",				1900 * weapon_price,			0,				"wep"		],
	//----East
	[2207,		"AR Katiba",								"arifle_Katiba_F",											1000 * weapon_price,			0,				"wep"		],
	[2208,		"AR Katiba ACO",					"arifle_Katiba_ACO_F",									1250 * weapon_price,			0,				"wep"		],
	[2209,		"AR Katiba ARCO",					"arifle_Katiba_ARCO_F",								1400 * weapon_price,			0,				"wep"		],
	[2210,		"AR Katiba GL",						"arifle_Katiba_GL_F",									1500 * weapon_price,			0,				"wep"		],
	[2211,		"AR Katiba ACO GL",				"arifle_Katiba_GL_ACO_F",							1750 * weapon_price,			0,				"wep"		],
	[2212,		"AR Katiba ARCO GL",			"arifle_Katiba_GL_ARCO_pointer_F",		1900 * weapon_price,			0,				"wep"		],
	//----Magazines
	[2200.1,	"40mm HE",											"1Rnd_HE_Grenade_shell",							100 * weapon_price,			0,				"mag"		],
	[2200.2,	"40mm Smoke(Blue)",							"1Rnd_SmokeBlue_Grenade_shell",			100 * weapon_price,			0,				"mag"		],
	[2200.3,	"40mm Smoke(Green)",						"1Rnd_SmokeGreen_Grenade_shell",		100 * weapon_price,			0,				"mag"		],
	[2200.4,	"40mm Smoke(Orange)",					"1Rnd_SmokeOrange_Grenade_shell",	100 * weapon_price,			0,				"mag"		],
	[2200.5,	"40mm Smoke(Purple)",						"1Rnd_SmokePurple_Grenade_shell",		100 * weapon_price,			0,				"mag"		],
	[2200.6,	"40mm Smoke(Red)",							"1Rnd_SmokeRed_Grenade_shell",			100 * weapon_price,			0,				"mag"		],
	[2200.7,	"40mm Smoke(Yellow)",						"1Rnd_SmokeYellow_Grenade_shell",		100 * weapon_price,			0,				"mag"		],
	//---Magazines West
	[2200.8,	"30Rnd 6.5mm",									"30Rnd_65x39_caseless_mag",				25 * weapon_price,				0,				"mag"		],
	[2200.9,	"30Rnd 6.5mm Caseless Tracer",		"30Rnd_65x39_caseless_mag_Tracer",	25 * weapon_price,				0,				"mag"		],	
	//---Magazines East
	[2200.11,	"30Rnd 6.5mm",								"30Rnd_65x39_caseless_mag",				25 * weapon_price,				0,				"mag"		],
	[2200.12,	"30Rnd 6.5mm Caseless Tracer",	"30Rnd_65x39_caseless_mag_Tracer",	25 * weapon_price,				0,				"mag"		],
	

	//Sniper
	//West
	[2301,		"M320 LRR",				"srifle_LRR_SOS_F",										5000 * weapon_price,			0,				"wep"		],
	[2302,		"MXM SOS",					"arifle_MXM_SOS_pointer_F",					1250 * weapon_price,			0,				"wep"		],
	//East
	[2303,		"GM6 Lynx",				"srifle_GM6_SOS_F",									5000 * weapon_price,			0,				"wep"		],
	[2304,		"EBR MRCO",				"srifle_EBR_MRCO_pointer_F",					1500 * weapon_price,			0,				"wep"		],
	//--Mags West
	[2300.1,	"7Rnd 12.7mm ",		"7Rnd_408_Mag",											150 * weapon_price,			0,				"mag"	],
	//--Mags East
	[2300.2,	"5Rnd 12.7mm",		"5Rnd_127x108_Mag",								150 * weapon_price,			0,				"mag"	],
	
	
//MG
	//West
	[2401,		"MX SW",						"arifle_MX_SW_F",										1200 * weapon_price,		0,				"wep"		],
	[2402,		"MX SW RCO",			"arifle_MX_SW_Hamr_pointer_F",		1600 * weapon_price,		0,				"wep"		],
	[2403,		"Mk200 LMG",				"LMG_Mk200_F",										1600 * weapon_price,		0,				"wep"		],
	
	//East
	[2404,		"Zafir LMG",					"LMG_Zafir_F",											1600 * weapon_price,		0,				"wep"		],
	
	//Magazines
	[2400.1,	"150Rnd Box 7.62mm",					"150Rnd_762x54_Box",									100 * weapon_price,			0,				"mag"		],
	[2400.2,	"150Rnd Box 7.62mm Tracer",		"150Rnd_762x54_Box_Tracer",					100 * weapon_price,			0,				"mag"		],
	[2400.3,	"200Rnd Box 6.5mm",						"200Rnd_65x39_cased_Box",						100 * weapon_price,			0,				"mag"		],
	[2400.4,	"200Rnd Box 6.5mm Tracer",		"200Rnd_65x39_cased_Box_Tracer",			100 * weapon_price,			0,				"mag"		],
	[2400.5,	"100Rnd 6.5mm (MX SW)",			"100Rnd_65x39_caseless_mag",					100 * weapon_price,			0,				"mag"		],
	[2400.6,	"100Rnd 6.5mm (MX SW)",			"100Rnd_65x39_caseless_mag_Tracer",	100 * weapon_price,			0,				"mag"		],
	
//Rockets
	//West
	[2501,		"Titan MPRL",						"launch_B_Titan_short_F",			3500 * weapon_price,			0,				"wep"		],
	[2502,		"Titan MPRL AA",					"launch_B_Titan_F",						3000 * weapon_price,			0,				"wep"		],
	[2503,		"PCML",									"launch_NLAW_F",							1500 * weapon_price,			0,				"wep"		],
	//East
	[2504,		"Titan MPRL",						"launch_O_Titan_short_F",			3500 * weapon_price,			0,				"wep"		],
	[2505,		"Titan MPRL AA",					"launch_O_Titan_F",						3000 * weapon_price,			0,				"wep"		],
	[2506,		"RPG32",								"launch_RPG32_F",						1500 * weapon_price,			0,				"wep"		],
	//Magazines
	[2500.1,	"Titan AA",			"Titan_AA",							500 * weapon_price,				0,				"mag"		],
	[2500.2,	"Titan AT",			"Titan_AT",							450 * weapon_price,				0,				"mag"		],
	[2500.3,	"Titan AP",			"Titan_AP",							400 * weapon_price,				0,				"mag"		],
	//---West
	[2500.4,	"PCML",					"NLAW_F",							200 * weapon_price,				0,				"mag"		],
	//---East
	[2500.5,	"RPG32 AT",		"RPG32_F",							200 * weapon_price,				0,				"mag"		],

//Explosivs 	
	[2601,		"AT Mine",					"ATMine_Range_Mag",										250 * weapon_price,				0,				"mag"		],
	[2603,		"HandGrenade",		"HandGrenade",													75 * weapon_price,					0,				"mag"		],
	[2602,		"Claymore Mine",	"ClaymoreDirectionalMine_Remote_Mag",	200 * weapon_price,				0,				"mag"		],
	
	
	//End
	[3999,		"HandGrenade",		"HandGrenade",													125 * weapon_price,				999,			"mag"		]
];



//Addon Weapon and Mag Array ID: 4000 - 5999

if(TW_Addons_Active) then {
	Tee_Weapon_Array = Tee_Weapon_Array + [
	//	ID			Name 					Class 							Price							Needed Towns	Kind
	//Equipment
	//[4001,		"GPS",					"ItemGPS",						50 * weapon_price,				0,				"wep"		],

	//Pistol
	
	//Rifle
	
	//Sniper
	//[4301,		"Khaybar ACO F",		"arifle_Katiba_C_ACO_pointer_F",	1250 * weapon_price,			0,				"wep"		],

	//MG
	
	//Rocket
	
	//Explosivs
	//[4601,		"NLAW F",			"launch_NLAW_F",					2000 * weapon_price,			0,				"wep"		],

	
	//End
	[5999,		"HandGrenade",		"HandGrenade",						125 * weapon_price,				0,				"mag"		]
	];
};



//AI Array
Tee_AI_Array = [
//	ID			Name 									Class 									Price									Needed Towns		Side
	//East
	[6001,		"Rifleman",							"O_Soldier_F",				150 * ai_price,				0,								"east"		],
	[6002,		"Medic",									"O_medic_F",					750 * ai_price,				0,								"east"		],
	[6003,		"Rifleman AT",						"O_Soldier_LAT_F",		500 * ai_price,				0,								"east"		],
	[6004,		"Marksman",						"O_soldier_M_F",			550 * ai_price,				0,								"east"		],
	[6005,		"Automatic Rifleman",		"O_Soldier_AR_F",			300 * ai_price,				0,								"east"		],
	[6006,		"Grenadier",							"O_Soldier_GL_F",			350 * ai_price,				0,								"east"		],
	[6007,		"Repair Specialist",				"O_soldier_repair_F",	1000 * ai_price,				0,								"east"		],
	[6008,		"Explosiv Specialist",			"O_soldier_exp_F",		600 * ai_price,				0,								"east"		],
	[6009,		"Rifleman",							"O_Soldier_lite_F",			150 * ai_price,				0,								"east"		],
	
	
	
	//West
	[7001,		"Rifleman",							"B_Soldier_F",					150 * ai_price,				0,								"west"		],
	[7002,		"Automatic Rifleman",		"B_soldier_AR_F",			500 * ai_price,				0,								"west"		],
	[7003,		"Medic",									"B_medic_F",					750 * ai_price,				0,								"west"		],
	[7004,		"Rifleman AT",						"B_soldier_LAT_F",		550 * ai_price,				0,								"west"		],
	[7005,		"Repair Specialist",				"B_soldier_repair_F",	1000 * ai_price,				0,								"west"		],
	[7006,		"Grenadier",							"B_Soldier_GL_F",			350 * ai_price,				0,								"west"		],
	[7007,		"Marksman",						"B_soldier_M_F",			550 * ai_price,				0,								"west"		],
	[7008,		"Explosiv Specialist",			"B_soldier_exp_F",		600 * ai_price,				0,								"west"		],
	[7009,		"Rifleman Light",					"B_Soldier_lite_F",			150 * ai_price,				0,								"west"		],
	
	//Resistance
	
	//Civilian
	[9001,		"Team Leader",					"I_Soldier_TL_F",			150 * ai_price,				0,			"civ"		],
	[9002,		"Automatic Rifleman",		"I_Soldier_AR_F",			150 * ai_price,				0,			"civ"		],
	[9003,		"AA Specialist",					"I_Soldier_AA_F",			150 * ai_price,				0,			"civ"		],
	[9004,		"Rifleman",							"I_soldier_F",					150 * ai_price,				0,			"civ"		],
	[9005,		"Rifleman AT",						"I_Soldier_LAT_F",			150 * ai_price,				0,			"civ"		],
	[9006,		"AT Specialist",					"I_Soldier_AT_F",			150 * ai_price,				0,			"civ"		],
	[9007,		"Medic",									"I_medic_F",					150 * ai_price,				0,			"civ"		],
	[9008,		"Squad Leader",					"I_Soldier_SL_F",			150 * ai_price,				0,			"civ"		],

	
	//End
	[9999,		"Rifleman (west)",				"B_soldier_LAT_F",		250 * ai_price,				999,		"west"	]
];



//Addon Weapon and Mag Array ID: 10000 - ?
if(TW_Addons_Active) then {
	Tee_AI_Array = Tee_AI_Array + [
	//	ID			Name 					Class 							Price							Needed Towns	Kind

	//End
	[11999,		"Rifleman (west)",				"B_soldier_LAT_F",	250 * ai_price,				999,			"west"	]
	];
};

//Variablen CT
TW_VotePlayerRequested		= false;	
