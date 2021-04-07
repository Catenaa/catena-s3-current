CreateThread(function()
	SetWeaponDamageModifier(`WEAPON_UNARMED`, 0.2) -- Melee
	SetWeaponDamageModifier(`WEAPON_BOTTLE`, 0.3) -- Melee
	SetWeaponDamageModifier(`WEAPON_FLASHLIGHT`, 0.3) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNUCKLE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_NIGHTSTICK`, 0.0) -- Melee
	SetWeaponDamageModifier(`WEAPON_HAMMER`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_CROWBAR`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_POOLCUE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_GOLFCLUB`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_BAT`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNIFE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_DAGGER`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_SWITCHBLADE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_REVOLVER`, 1.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_REVOLVER_MK2`, 1.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_MACHETE`, 0.7) -- Melee
	SetWeaponDamageModifier(`WEAPON_HATCHET`, 0.7) -- 
	SetWeaponDamageModifier(`WEAPON_MICROSMG`, 1.19)
	SetWeaponDamageModifier(`WEAPON_MACHINEPISTOL`, 1.15)
	SetWeaponDamageModifier(`WEAPON_MINISMG`, 1.16)
	SetWeaponDamageModifier(`WEAPON_ASSAULTSMG`, 1.13)
	SetWeaponDamageModifier(`WEAPON_SMG`, 1.10)
	SetWeaponDamageModifier(`WEAPON_SMG_MK2`, 1.13)
	SetWeaponDamageModifier(`WEAPON_COMBATPDW`, 1.02)
	SetWeaponDamageModifier(`WEAPON_GUSENBERG`, 1.05)
	SetWeaponDamageModifier(`WEAPON_VINTAGEPISTOL`, 1.10)
	SetWeaponDamageModifier(`WEAPON_APPISTOL`, 1.17)
	SetWeaponDamageModifier(`WEAPON_HEAVYPISTOL`, 1.19)
	SetWeaponDamageModifier(`WEAPON_COMBATPISTOL`, 1.12)
	SetWeaponDamageModifier(`WEAPON_VINTAGEPISTOL`, 1.10)
	SetWeaponDamageModifier(`WEAPON_PISTOL`, 1.09)
	SetWeaponDamageModifier(`WEAPON_SNSPISTOL`, 1.0)
	SetWeaponDamageModifier(`WEAPON_PISTOL_MK2`, 1.18)
   	SetWeaponDamageModifier(`WEAPON_STUNGUN`, 0.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_SMOKEGRENADE`, 0.1) -- Utility
	SetWeaponDamageModifier(`WEAPON_SNOWBALL`, 0.0) -- Utility
	SetWeaponDamageModifier(`WEAPON_HIT_BY_WATER_CANNON`, 0.0) -- Fire Truck Cannon

	while true do
		Wait(0)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		SetPedSuffersCriticalHits(PlayerPedId(), false)
	end
end)