/*
	Author: IT07

	Description:
	init file for Server Info Menu (standalone mode)
*/

[] spawn
{
	_gs = ["useScrollMenu","customControl"] call SC_fnc_getSimSetting; // GetSettings
	_es = _gs select 0; // EnableScroll
	_ecc = _gs select 1; // EnableCustomControl

	waitUntil { !isNull(findDisplay 46); !isNil"EPOCH_loadingScreenDone" };
	uiSleep 3;

	if ((typeName _es) isEqualTo "SCALAR") then
	{
		_aa = player addAction ["<t color='#57877b'>Server Info</t>",{createDialog'SC_simDiag';}, "", -1, false, true];
	};

	if ((typeName _ecc) isEqualTo "STRING" and not(_ecc isEqualTo "")) then
	{
		[_ecc] spawn // Antihax do not like EHs....
		{
			_ecc = _this select 0;
			while {true} do
			{
				waitUntil { inputAction _ecc > 0 };
				createDialog'SC_simDiag';
				waitUntil { isNull(findDisplay 297) };
			};
		};
	};
};