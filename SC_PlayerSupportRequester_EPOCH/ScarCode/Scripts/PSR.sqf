/*
	Author: IT07

	Description:
	init file for Player Support Requester menu (standalone mode)
*/

"SC_tasks" addPublicVariableEventHandler
{
	if not(isNull(findDisplay 298)) then
	{
		call SC_fnc_reLoadPsr;
	};
};

"SC_psrReply" addPublicVariableEventHandler
{
	[_this select 1] spawn SC_fnc_handlePsrReply;
};

[] spawn SC_fnc_livePsrUnitsOnline;

_gs = ["useScrollMenu","customControl"] call SC_fnc_getPsrSetting; // GetSettings
_es = _gs select 0; // EnableScroll
_ecc = _gs select 1; // EnableCustomControl

waitUntil { !isNull(findDisplay 46); !isNil"EPOCH_loadingScreenDone" };
uiSleep 3;

if ((typeName _es) isEqualTo "SCALAR") then
{
	_aa = player addAction ["<t color='#ffc804'>Player Support</t>",{createDialog'SC_psrDiag';}, "", -1, false, true];
};

if ((typeName _ecc) isEqualTo "STRING" and not(_ecc isEqualTo "")) then
{
	[_ecc] spawn // Antihax do not like EHs....
	{
		_ecc = _this select 0;
		while {true} do
		{
			waitUntil { inputAction _ecc > 0 };
			createDialog'SC_psrDiag';
			waitUntil { isNull(findDisplay 278) };
		};
	};
};