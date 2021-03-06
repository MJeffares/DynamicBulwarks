while {true} do {
    _allHCs = entities "HeadlessClient_F";
    _allHPs = allPlayers - _allHCs;

    // Keep players in the bulwark zone
    {
        switch (true) do {
            // If player is WAYYY outside the bounds. Move them to the bulwark
            case ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 2): {
                _newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
                _x setPosASL _newLoc;
            };

            // If player is trying to leave, bounce them back.
            case ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 1.1): {
                _dir = bulwarkCity getDir _x;
                _newLoc = bulwarkCity getPos [(BULWARK_RADIUS * 1.1)-8, _dir];
                _x setPosASL _newLoc;
                [_x, "teleportHit"] remoteExec ["sound_fnc_say3DGlobal", 0];
                0 = ["DynamicBlur", 200, [10]] spawn {
                    params ["_name", "_priority", "_effect", "_handle"];
                    while {
                        _handle = ppEffectCreate [_name, _priority];
                        _handle < 0
                    } do {
                            _priority = _priority + 1;
                    };
                    _handle ppEffectEnable true;
                    _handle ppEffectAdjust [10];
                    _handle ppEffectCommit 0;
                    waitUntil {ppEffectCommitted _handle};
                    _handle ppEffectAdjust [0];
                    _handle ppEffectCommit 1;
                    waitUntil {ppEffectCommitted _handle};
                    _handle ppEffectEnable false;
                    ppEffectDestroy _handle;
                };
            };

            // Warn the player that they're too far from the centre
            case ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 0.99): {
                ["<t color='#ff0000'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _x];
            };
            case ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 0.95): {
                ["<t color='#ffff00'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _x];
            };
            case ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 0.9): {
                ["<t color='#ffffff'>Warning: Leaving mission area!</t>", 0, 0.1, 2, 0] remoteExec ["BIS_fnc_dynamicText", _x];
            };

            default {};
        };
    } foreach _allHPs;

    sleep 0.01;
};
