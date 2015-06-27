/*
	Author: IT07

	Description:
	checks if given mags can be packed or not. Does if so.
*/

_dsp = 291;
while {not(isNull(findDisplay 291))} do
{
	private ["_cancel"];
	disableSerialization;
	_lbMags = (findDisplay _dsp) displayCtrl 2100;
	_output = (findDisplay _dsp) displayCtrl 1001;
	_curSel = lbCurSel _lbMags;
	_cn = _lbMags lbData _curSel; // Get the classname
	_max = getNumber (configFile >> "cfgMagazines" >> _cn >> "count");
	_usedMags = 0;
	_fullMags = 0;
	_roundsInUsed = [];
	_output ctrlSetText "Checking...";
	{
		if ((_x select 2) AND (_x select 0) isEqualTo _cn) exitWith
		{
			_cancel = true;
		};
		if ((_x select 0) isEqualTo _cn AND not((_x select 1) isEqualTo _max)) then
		{
			_usedMags = _usedMags + 1;
			_roundsInUsed pushBack [_forEachIndex, (_x select 1)];
		};
		if ((_x select 1) isEqualTo _max) then
		{
			_fullMags = _fullMags + 1;
		};
		uiSleep ((count magazinesAmmoFull player) / 300);
	} forEach (magazinesAmmoFull player);
	if not(isNil"_cancel") exitWith
	{
		_output ctrlSetText "Please remove mags from weapons";
	};
	if (_usedMags < 2) exitWith
	{
		_output ctrlSetText "Error! Need > 1 mag to merge...";
	};
	player removeMagazines _cn;
	uiSleep (1 + random 1);
	_output ctrlSetText "Repacking!";
	_magsToAdd = _fullMags;
	_roundsFromUsed = 0;
	{
		_roundsFromUsed = _roundsFromUsed + (_x select 1);
		if (_roundsFromUsed > _max OR _roundsFromUsed isEqualTo _max) then
		{
			_magsToAdd = _magsToAdd + 1;
			_roundsFromUsed = _roundsFromUsed - _max;
		};
	} forEach _roundsInUsed;
	player addMagazines [_cn, _magsToAdd];
	player addMagazine [_cn, _roundsFromUsed];
	if (true) exitWith
	{
		_output ctrlSetText format["Done! Added %1 mags and 1 with %2 bullets", _magsToAdd, _roundsFromUsed];
	};
};