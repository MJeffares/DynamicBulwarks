/**
*  fn_chopperGunner
*
*  Calls in a ghosthawk to circle the bulwark area with the player in the gunner seat
*
*  Domain: Local
**/

/**
* TODO: 
* AI control option
* aircraft selection (kajman, blackfoot, huron with gmg "attachto'd", Y-32 Xi'an, VX-44X blackfish (2 crew? hmmmmm))
* rename script to better reflect the general case ^^
* infinte ammo option
* infinite time option
* add scroll wheel action to return to bulwark
**/

//params ["_player", "_targetPos", "_targetHeight", "_targetRadius", "_aircraft", "_aircraftSeat", "_Time", "_Ammo"];

_player = _this select 0;

// Calculate chopper start position
_angle = round random 180;
_height = 200;
_offsX = 0;
_offsY = 2000;
_pointX = _offsX*(cos _angle) - _offsY*(sin _angle);
_pointY = _offsX*(sin _angle) + _offsY*(cos _angle);
_chopperStartPos  = bulwarkCity vectorAdd [_pointX, _pointY, _height];

// Create the chopper and pilot
_chopperGroup = createGroup west;
_chopper = createVehicle ["B_Heli_Transport_01_F", _chopperStartPos, [], 0, "FLY"];
_chopper engineOn true;
_relDir = [_chopperStartPos, bulwarkCity] call BIS_fnc_dirTo;
_chopper setdir _relDir;
_chopper setVelocity [75 * (sin (getDir _chopper)), 100 * (cos(getDir _chopper)), 0];
_chopperPilot = _chopperGroup createUnit ["B_Helipilot_F", _chopperStartPos, [], 0, "NONE"];
_chopperPilot allowFleeing 0;
_chopperPilot assignAsDriver _chopper;
_chopperPilot moveInDriver _chopper;
_chopperGroup setBehaviour "CARELESS";
_chopper flyInHeight 80;
_chopper limitSpeed 70;
clearWeaponCargo _chopper;
clearMagazineCargo _chopper;
clearBackpackCargo _chopper;
removeAllItems _chopper;

// Create waypoint for chopper
_wp = _chopperGroup addWaypoint [bulwarkCity, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointLoiterRadius BULWARK_RADIUS + 100;
_wp setWaypointBehaviour "CARELESS";
_chopperGroup setCurrentWaypoint _wp;

// Wait until the helicopter is close to the bulwark move player into the chopper
waitUntil { (_chopper distance2D bulwarkCity) < (BULWARK_RADIUS + 500) };
[_player, [_chopper, [1]]] remoteExec ["moveInTurret", 0];
_player setVariable ["In_Support", true, true];

// Wait until the helicopter is starting its orbit
waitUntil { (_chopper distance2D bulwarkCity) < (BULWARK_RADIUS + 150) };

// Start a timer to limit time in support
_timer = [] spawn {
	sleep 60;
	if (true) exitwith{ true };
};

// Keep the player in the chopper until support time is up
while{_player getVariable "In_Support"} do {
	if(vehicle _player != _chopper) then
	{
		_player moveinTurret [_chopper, [1]];
	};

	if (scriptDone _timer) then {
		_newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
		_player setPosASL _newLoc;
		_player setVariable ["In_Support", false, true];
	};
};

// Set a waypoint for the chopper to fly out of view
_wp setWaypointPosition [position _chopper vectorAdd [3000 * (cos getDir _chopper), 3000 * (sin getDir _chopper), 100], 0];
_wp  setWaypointType "MOVE";
_wp setWaypointCompletionRadius 100;
_chopperGroup setCurrentWaypoint _wp;
_chopper limitSpeed 300;
_chopper flyInHeight 80;

// Delete the chopper once it is out of view
waitUntil { unitReady _chopper };
deleteVehicle _chopperPilot;
deleteVehicle _chopper;
