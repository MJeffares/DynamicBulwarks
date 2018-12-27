class paraDrop
{
    text = "Paratroops";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'paraTroop', 'B_T_VTOL_01_vehicle_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class reconUAV
{
    text = "Recon UAV";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'reconUAV', 'B_UAV_01_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\defend_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class reconSuperUAV
{
    text = "Super Recon UAV";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'reconSuperUAV', 'B_UAV_02_dynamicLoadout_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\defend_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};
	
class airStrike
{
    text = "Missle CAS";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'airStrike', 'B_Plane_CAS_01_DynamicLoadout_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class ragePack
{
    text = "Rage Stimpack";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'ragePack'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class armaKart
{
    text = "ARMAKART TM (Player)";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'armaKart'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class mindConGas
{
    text = "Mind Control Gas";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'mindConGas'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class droneControl
{
    text = "Predator Drone";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'droneControl'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\cas_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class mineField
{
    text = "Mine Field";
    submenu = "";
    expression = "[_this select 0, _this select 1, 'mineField'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\Artillery_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class telePlode
{
    text = "Emergency Teleport";
    submenu = "";
    expression = "[_this select 0, _this select 1,'telePlode'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class ghosthawkAI
{
    text = "UH-80 Ghosthawk Fire Support (AI)";
    submenu = "";
    expression = "[_this select 0, bulwarkCity, 'ghosthawkAI', 'B_Heli_Transport_01_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class ghosthawkGunner
{
    text = "UH-80 Ghosthawk Fire Support (Player)";
    submenu = "";
    expression = "[_this select 0, bulwarkCity, 'ghosthawkGunner', 'B_Heli_Transport_01_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class blackfootAI
{
    text = "AH-99 Blackfoot Fire Support (AI)";
    submenu = "";
    expression = "[_this select 0, bulwarkCity, 'blackfootAI', 'B_Heli_Attack_01_dynamicLoadout_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};

class blackfootGunner
{
    text = "AH-99 Blackfoot Fire Support (Player)";
    submenu = "";
    expression = "[_this select 0, bulwarkCity, 'blackfootGunner', 'B_Heli_Attack_01_dynamicLoadout_F'] remoteExec ['killPoints_fnc_support', 2];";
    icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa";
    cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
    enable = "1";
    removeAfterExpressionCall = 1;
};
