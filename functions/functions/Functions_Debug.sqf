/*
	Script written by TeeTime dont remove this comment
*/
Tee_Debug_Spawn = {

	//[] spawn Tee_Player_TK_Punish;

/*
	_mags = magazines player;
	player groupchat str _mags;
	diag_log str _mags;
*/
	//call Tee_Base_Set_Base;
	//call Tee_AttackTown;
	//_marker = createMarker ["Test", getPos player];

	//[] call Tee_CreateTownMarker;
	// ServicePoint Building : Military Cargo House V1     (Land_Cargo_House_V1_F)
	// Baracks         : Military Cargo HQ V1     (Land_Cargo_HQ_V1_F)
	// ComandPost         : Military Cargo OP V1     (Land_Cargo_Patrol_V1_F)!?! nicht sicher
	//_veh = createVehicle ["Land_Cargo_HQ_V1_F",getPos player,[],0,""];
	
	Tee_Konto 			= 100000;

};



Tee_Debug_Spawn_Weapon = {

	player globalChat str TW_HC_ID;

	//[base_1,base_2] call Tee_Marker_ConnectMarker;
	//[base_2,base_4] call Tee_Marker_ConnectMarker;



	//[player] call Tee_Town_CreateAIDef;
	
	//_mags = weapons player;
	//player groupchat str _mags;
	//diag_log str _mags;
	
	//player addMagazine "30Rnd_65x39_caseless_green";
	//player addWeapon "arifle_Katiba_C_ACO_pointer_F";
};



Tee_Debug_Teleport = {
	onMapSingleClick "(vehicle player) setPos _pos;";
};