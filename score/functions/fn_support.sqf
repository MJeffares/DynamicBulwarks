/**
*  fn_support
*
*  Event handler for supports/communications menu
*
*  Domain: Client/Event
**/

_player   = _this select 0;
_target   = _this select 1;
_type     = _this select 2;
_aircraft = _this select 3;


switch (_type) do {
    case ("paraTroop"): {
        [_player, _target, PARATROOP_COUNT, _aircraft, PARATROOP_CLASS] call supports_fnc_paraTroop;
    };
    case ("reconUAV"): {
        [_player, getPos _player, _aircraft] call supports_fnc_reconUAV;
    };
    case ("reconSuperUAV"): {
        [_player, getPos _player, _aircraft] call supports_fnc_reconSuperUAV;
    };
    case ("airStrike"): {
        [_player, _target, _aircraft] call supports_fnc_airStrike;
    };
    case ("ragePack"): {
        // Ragepack is a local effect so it needs to be executed locally
        [] remoteExec ["supports_fnc_ragePack", _player];
    };
    case ("armaKart"): {
        [_player] call supports_fnc_armaKart;
    };
    case ("ghosthawkAI"): {
        [_player, true, _aircraft, _target, [1], 60, BULWARK_RADIUS + 50] call supports_fnc_fireSupport;
    };
    case ("ghosthawkGunner"): {
        [_player, false, _aircraft, _target, [1], 60, BULWARK_RADIUS + 50] call supports_fnc_fireSupport;
    };
    case ("blackfootAI"): {
        [_player, true, _aircraft, _target, [], 200, BULWARK_RADIUS + 75] call supports_fnc_fireSupport;
        //[_player, _target, 200, BULWARK_RADIUS + 75, 70, _aircraft, 'nil', 60, true] call supports_fnc_fireSupport;
    };
    case ("blackfootGunner"): {
        [_player, false, _aircraft, _target, [], 200, BULWARK_RADIUS + 75] call supports_fnc_fireSupport;
        //[_player, _target, 200, BULWARK_RADIUS + 75, 70, _aircraft, 'nil', 60, true] call supports_fnc_fireSupport;
    };
    case ("blackfishGunner"): {
        [_player, false, _aircraft, _target, [], 400, BULWARK_RADIUS + 500] call supports_fnc_fireSupport;
        //[_player, _target, 400, BULWARK_RADIUS + 500, 140, _aircraft, '1', 60, true] call supports_fnc_fireSupport;
    };
};


// params [
// 	"_player",
// 	["_aiControlled", true, [true]],
// 	"_aircraft",
// 	"_targetPos",
// 	["_aircraftSeat", [], [[]], [0, 1, 2]],
// 	["_targetHeight", 100, [1]],
// 	["_targetRadius", 200, [1]],
// 	["_time", 60, [1]],
// 	["_spotting", true, [true]],
// 	["_returnPlace", true, [true]]
// ];