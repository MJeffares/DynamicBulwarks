/**
*  fn_fireSupport
*
*  Calls in aircraft fire support to circle the target area with the player in the gunner seat
*
*  Domain: Local
**/

/**
* TODO: 
* remove ALL items from vehicles
* disable take control /co-pilot
* limit loadout of vehicles
* AI control option
* aircraft selection (kajman, huron with gmg "attachto'd", Y-32 Xi'an,)
* handle multiple players in vehicle eg v-44 ??
* infinte ammo option
* infinite time option
* add scroll wheel action to return to bulwark
**/

params ["_player", "_targetPos", "_targetHeight", "_targetRadius", "_targetSpeed", "_aircraft", "_aircraftSeat", "_time"];

// Calculate aircraft start position
_angle = round random 360;
_height = _targetHeight;
_offsX = 0;
_offsY = 1000;
_pointX = _offsX*(cos _angle) - _offsY*(sin _angle);
_pointY = _offsX*(sin _angle) + _offsY*(cos _angle);
_aircraftStartPos  = _targetPos vectorAdd [_pointX, _pointY, _height];

// Create the aircraft and pilot
_pilotGroup = createGroup west;
_vehicle = createVehicle [_aircraft, _aircraftStartPos, [], 0, "FLY"];
_vehicle engineOn true;
_relDir = [_aircraftStartPos, _targetPos ] call BIS_fnc_dirTo;
_vehicle setdir _relDir;
_vehicle setVelocity [(_targetSpeed * 2 / 3.6) * (sin (getDir _vehicle)), (_targetspeed * 2 / 3.6) * (cos(getDir _vehicle)), 0];
_pilot = _pilotGroup createUnit ["B_Helipilot_F", _aircraftStartPos, [], 0, "NONE"];
_pilot allowFleeing 0;
_pilot assignAsDriver _vehicle;
_pilot moveInDriver _vehicle;
clearWeaponCargo _vehicle;
clearMagazineCargo _vehicle;
clearBackpackCargo _vehicle;
removeAllItems _vehicle;


// Create waypoint for chopper
_wp = _pilotGroup addWaypoint [_targetPos , 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointLoiterRadius _targetRadius;
_wp setWaypointBehaviour "CARELESS";
//_wp setWayPointSpeed "LIMITED";
_pilotGroup setCurrentWaypoint _wp;
_pilot disableAI "AUTOTARGET";
_pilotGroup setBehaviour "CARELESS";
_vehicle flyInHeight _targetHeight;
_vehicle limitSpeed _targetSpeed;

// Wait until the helicopter is starting its orbit then move the player into the vehicle
waitUntil { (_vehicle distance2D _targetPos ) < (_targetRadius + 100) };

if (isNil _aircraftSeat) then {
	[_player, _vehicle] remoteExec ["moveInGunner", 0];
}
else {
	[_player, [_vehicle, [_aircraftSeat]]] remoteExec ["moveInTurret", 0];
};
_player setVariable ["In_Support", true, true];

// Start a timer to limit time in support
_timer = _time spawn {
	diag_log _this;
	sleep _this;
	if (true) exitwith{ true };
};

// Keep the player in the chopper until support time is up
while{_player getVariable "In_Support"} do {
	if(vehicle _player != _vehicle) then
	{
		if ( isNil _aircraftSeat) then {
			_player moveInGunner _vehicle;
		}
		else {
			_player moveInTurret [_vehicle, [_aircraftSeat]];
		};
	};

	if (scriptDone _timer) then {
		_newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
		_player setPosASL _newLoc;
		_player setVariable ["In_Support", false, true];
	};
};

// Set a waypoint for the chopper to fly out of view
_wp setWaypointPosition [position _vehicle vectorAdd [3000 * (cos getDir _vehicle), 3000 * (sin getDir _vehicle), 100], 0];
_wp  setWaypointType "MOVE";
_wp setWaypointCompletionRadius 100;
_pilotGroup setCurrentWaypoint _wp;
_vehicle limitSpeed 1000;

// Delete the chopper once it is out of view
waitUntil { unitReady _vehicle };
deleteVehicle _pilot;
deleteVehicle _vehicle;
