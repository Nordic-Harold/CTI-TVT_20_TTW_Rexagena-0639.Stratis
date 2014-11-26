	private ["_x","_guard","_pos","_areasize"];

	_guard=			_this select 0;
	_pos= 			_this select 1;
	_areasize=		_this select 2;
	
	//player sidechat format ["%1,%2,%3",_guard,_pos,_areasize];
	
	for [{_x=1},{_x<=c_AIDef_WP_Count},{_x=_x+1}] do
	{
		[_guard,_pos,_areasize] spawn C_fnc_GroupCreateWP;
	};
	
	