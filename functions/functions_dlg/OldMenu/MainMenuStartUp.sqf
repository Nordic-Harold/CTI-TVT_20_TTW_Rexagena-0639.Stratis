//Script fügt eventhandler zu den keys dazu um festzustellen, wann welcher key gedrückt wird
// key "u" erstellt das hauptmenü

disableSerialization;
waituntil {!isNull (finddisplay 46)};

_dsp= finddisplay 46;

// _dsp displaySetEventHandler ["KeyDown","if(_this select 1 == 22 and !dialog) then {call CT_dlg_MainMenu_StartUp}"];
