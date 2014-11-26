//Löscht Einheit aus der Welt und setzt objektnull
//Typ: script
//bsp: this spawn fnc_AIDef_AIKilled_HideBody

private ["_killed"];
_killed= _this;

sleep AIDef_BodyRemovalTime;					//setzt zeit bis zum entfernen der Einheit

hidebody _killed;									//lässt einheit im boden versinken und löscht sie	

sleep 15;

deletevehicle _killed;								// löscht Einheit
					
_killed= objNull;									// setzt einheit auf objNull