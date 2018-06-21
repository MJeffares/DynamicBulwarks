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
    case ("ghosthawkGunner"): {
        [_player, _target, 60, BULWARK_RADIUS + 50, 70, _aircraft, '1', 60] call supports_fnc_fireSupport;
    };
    case ("blackfootGunner"): {
        [_player, _target, 200, BULWARK_RADIUS + 75, 70, _aircraft, 'nil', 60] call supports_fnc_fireSupport;
    };
    case ("blackfishGunner"): {
        [_player, _target, 350, BULWARK_RADIUS + 150, 140, _aircraft, '1', 60] call supports_fnc_fireSupport;
    };
};
