Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

Consumeables = {
    ["null"] = math.random(1, 5),
}

Config = {}

Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25

Config.JointEffectTime = 60

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`LAZER`] = true,
    [`BUZZARD`] = true,
    [`BUZZARD2`] = true,
    [`ANNIHILATOR`] = true,
    [`SAVAGE`] = true,
    [`RHINO`] = true,
    [`SHERIFF`] = true,
    [`SHERIFF2`] = true,
    [`FIRETRUK`] = true,
    [`MULE2`] = true,
    [`MULE3`] = true,
    [`MULE4`] = true,
    [`BLIMP`] = true,
    [`BLIMP2`] = true,
    [`BLIMP3`] = true,
    [`AIRTUG`] = true,
    [`LUXOR`] = true,
    [`FROGGER`] = true,
    [`FROGGER2`] = true,
    --[[[`akuma`] = true,
    [`Bagger`] = true,
    [`bati`] = true,
    [`bati2`] = true,
    [`blazer`] = true,
    [`blazer2`] = true,
    [`blazer3`] = true,
    [`carbonrs`] = true,
    [`daemon`] = true,
    [`double`] = true,
    [`faggio`] = true,
    [`double`] = true,
    [`hexer`] = true,
    [`nemesis`] = true,
    [`pcj`] = true,
    [`policeb`] = true,
    [`ruffian`] = true,
    [`sanchez`] = true,
    [`vader`] = true,
    [`thrust`] = true,
    [`sovereign`] = true,
    [`hakuchou`] = true,
    [`innovation`] = true,
    [`enduro`] = true,
    [`lectro`] = true,
    [`vindicator`] = true,
    [`bf400`] = true,
    [`cliffhanger`] = true,
    [`gargoyle`] = true,
    [`avarus`] = true,
    [`chimera`] = true,
    [`daemon2`] = true,
    [`defiler`] = true,
    [`esskey`] = true,
    [`faggio`] = true,
    [`faggio2`] = true,
    [`hakuchou2`] = true,
    [`manchez`] = true,
    [`nightblade`] = true,
    [`ratb`] = true,
    [`sanctus`] = true,
    [`shotaro`] = true,
    [`blazer5`] = true,
    [`vortex`] = true,
    [`wplfsbane`] = true,
    [`diabolus`] = true,]]



}
Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
    [`s_m_y_blackops_01`] = true,
    [`s_m_y_blackops_02`] = true,
    [`s_m_y_blackops_03`] = true,
}