/**
*  fn_killed
*
*  Event handler for unit death.
*
*  Domain: Event
**/

if (isServer) then {
    _instigator = _this select 2;
    if (isPlayer _instigator) then {
        [_instigator, SCORE_KILL] call killPoints_fnc_add;
    } else {
        _player = _instigator getVariable["Owner", objNull];
        if(!isNull _player) then {
            [_player, SCORE_HIT + (SCORE_DAMAGE_BASE * _dmg)] call killPoints_fnc_add;
        };
    };
};
