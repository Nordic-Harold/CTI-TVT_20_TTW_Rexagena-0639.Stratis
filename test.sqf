diag_log "test.sqf";
diag_log _this;

if(count _this >= 4) exitWith {
call compile ((_this select 3));
};