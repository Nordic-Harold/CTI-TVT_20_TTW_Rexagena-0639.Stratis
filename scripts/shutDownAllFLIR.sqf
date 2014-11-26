_layer = 85125; 

while {true} do 
{ 
	if (currentVisionMode player == 2) then
		{ 
		  	//hint "Thermals are active";
			_layer	cutText ["FLIR Mode Requires Maintenance. Please Turn off Thermals.","BLACK",-1];
			waituntil {currentVisionMode player != 2};
			_layer cutText ["", "PLAIN"];
		};
		sleep 1; 
};