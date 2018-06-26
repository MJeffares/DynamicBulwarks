/**
*  fn_fireSupport
*
*  Calls in aircraft fire support to circle the target area with the player in the gunner seat
*
*  Domain: Local
**/

/**
* TODO: 
* aircraft selection (kajman, huron, huron with gmg "attachto'd", Y-32 Xi'an,)
* handle multiple players in vehicle eg v-44 ??
* infinite time option
* add scroll wheel action to return to bulwark
* use bounding boxes instead of target markers for spotting
**/

params [
	"_player",
	["_aiControlled", true, [true]],
	"_aircraft",
	"_targetPos",
	["_aircraftSeat", [], [[]], [0, 1, 2]],
	["_targetHeight", 100, [1]],
	["_targetRadius", 200, [1]],
	["_time", 60, [1]],
	["_infAmmo", true, [true]],
	["_spotting", true, [true]],
	["_returnPlace", true, [true]]
];

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
_vehicle setVelocity [50 * (sin (getDir _vehicle)), 50 * (cos(getDir _vehicle)), 0];
_pilot = _pilotGroup createUnit ["B_Helipilot_F", _aircraftStartPos, [], 0, "NONE"];
_pilot allowFleeing 0;
_pilot moveInDriver _vehicle;

// lock copilot from "take controls"
if (isCopilotEnabled _vehicle) then {
    _vehicle enableCopilot false;
};

// Empty the vehicles inventory
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;

// Empty the plyons from the vehicle
{ 
	_vehicle removeWeaponGlobal getText (
		configFile 
		>> "CfgMagazines" 
		>> _x 
		>> "pylonWeapon") 
} forEach getPylonMagazines _vehicle;

// Add event handler for infinite ammo
if (_infAmmo) then {
	_vehicle addEventHandler["Fired", {(_this select 0) setVehicleAmmo 1}];
};

// Create waypoint for vehicle
_wp = _pilotGroup addWaypoint [_targetPos , 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterType "CIRCLE_L";
_wp setWaypointLoiterRadius _targetRadius;
_wp setWayPointSpeed "FULL";
_pilotGroup setCurrentWaypoint _wp;
_vehicle flyInHeight _targetHeight;
_pilot setCombatMode "RED";
_pilot setbehaviour "CARELESS";
_pilot disableAI "AUTOTARGET";

// Vehicle will move at full speed until it gets closer to the AO
waitUntil { (_vehicle distance2D _targetPos ) < (_targetRadius + 400) };
_wp setWayPointSpeed "LIMITED";
_pilotGroup setCurrentWaypoint _wp;
_pilotGroup setSpeedMode "LIMITED";

// Wait until the vehicel is close to the AO before moving in the gunner / player
waitUntil { (_vehicle distance2D _targetPos ) < (_targetRadius + 50) };

// Save where the player was when they called in support
_playerLocation = (getPosASL _player) vectorAdd [0,0,0.2]; 

_gunner = ObjNull;
if (_aiControlled) then {

	// Create AI gunner
	_gunnerGroup = createGroup west;
	_gunner = _gunnerGroup createUnit ["B_Helipilot_F", _aircraftStartPos, [], 0, "NONE"];
	_gunner allowFleeing 0;
	_gunner setSkill ["aimingAccuracy", 1.0];
	_gunner setSkill ["aimingShake", 	1.0];
    _gunner setSkill ["aimingSpeed", 	1.0];
	_gunner setSkill ["spotDistance", 	1.0];
    _gunner setSkill ["spotTime", 		1.0];
	_gunner setCombatMode "RED";
	_gunner setbehaviour "COMBAT";
	_gunner setVariable ["Owner", _player, true];

	// Move gunner into vehicle
	if (count _aircraftSeat == 0) then {
		[_gunner, _vehicle] remoteExec ["moveInGunner", 0];
	}
	else {
		[_gunner, [_vehicle, _aircraftSeat]] remoteExec ["moveInTurret", 0];
	};
} else {
	
	// Move player into vehicle
	if (count _aircraftSeat == 0) then {
		[_player, _vehicle] remoteExec ["moveInGunner", 0];
	}
	else {
		[_player, [_vehicle, _aircraftSeat]] remoteExec ["moveInTurret", 0];
	};
	_player setVariable ["In_Support", true, true];

	// if player controlled and spotting enabled we add targetting marks
	if (_spotting) then {
		addMissionEventHandler["Draw3D", {
			{
				if ((side _x) == east) then {
					drawIcon3D [
						"\a3\ui_f\data\IGUI\Cfg\Targeting\MarkedTarget_ca.paa",
						[1,0,0,1],
						(visiblePosition _x vectorAdd [0, 0, 1]),
						1,
						1,
						45,
						"",
						1,
						0.02, 
						"TahomaB",
						"center",
						false
					];
				};

				if ((side _x) == west) then {
					drawIcon3D [
						"\a3\ui_f\data\IGUI\Cfg\Targeting\MarkedTarget_ca.paa",
						[0,0,1,1],
						(visiblePosition _x vectorAdd [0, 0, 1]),
						1,
						1,
						45,
						"",
						1,
						0.02, 
						"TahomaB",
						"center",
						false
					];
				};

			} forEach allUnits;
		}];
	};
};

//Start a timer to limit time in support
_timer = _time spawn {
	sleep _this;
	if (true) exitwith{ true};
};

// While support is active
_supportActive = true;
while {_supportActive} do {

	// If player controlled we keep the player in the vehicle
	if !(_aiControlled) then {
		if(vehicle _player != _vehicle) then
		{
			if (count _aircraftSeat == 0) then {
				_player moveInGunner _vehicle;
			}
			else {
				_player moveInTurret [_vehicle, _aircraftSeat];
			};
		};
	} 
	else {
		{
			if ((side _x) == east) then {
				_gunner reveal [_x, 4];
				sleep 0.1;
			};
		} forEach allUnits;
	};

	if (scriptDone _timer) then {
		_supportActive = false;
	};

};

if !(_aiControlled) then {
	if (_spotting) then {
		removeAllMissionEventHandlers "Draw3d";
	};		

	if (_returnPlace) then {
		_player setPosASL _playerLocation;
	} else {
		_newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
		_player setPosASL _newLoc;
	};
	_player setVariable ["In_Support", false, true];
};

// Set a waypoint for the chopper to fly out of view
_wp setWaypointPosition [position _vehicle vectorAdd [3000 * (cos getDir _vehicle), 3000 * (sin getDir _vehicle), 100], 0];
_wp setWaypointType "MOVE";
_wp setWayPointSpeed "FULL";
_wp setWaypointCompletionRadius 100;
_pilotGroup setCurrentWaypoint _wp;

// Delete the chopper once it is out of view
waitUntil { unitReady _vehicle };
deleteVehicle _pilot;
deleteVehicle _vehicle;	
