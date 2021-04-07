Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = Config or {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
    if length > 0 then
        return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
    else
        return ''
    end
end

Config.RandomInt = function(length)
    if length > 0 then
        return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end


Config.DrugsPrice = {
    ["joint"] = {
        min = 100,
        max = 200,
    },
}

Config.CornerSellingZones = {
    [1] = {
        ["coords"] = {
            ["x"] = -1415.53,
            ["y"] = -1041.51,
            ["z"] = 4.62,
        },
        ["time"] = {
            ["min"] = 10,
            ["max"] = 23,
        },
    },
}




Config.Delays = {
	WeedProcessing = 1000 * 3
}

-- Config.LicensePrices = {
-- 	weed_processing = {label = _U('license_weed'), price = 10000}
-- }

Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(2223.42, 5578.1, 53.71), name = 'blip_weedfield', color = 25, sprite = 496, radius = 120.0},
	WeedProcessing = {coords = vector3(2193.23, 5594.63, 53.76), name = 'blip_weedprocessing', color = 25, sprite = 496, radius = 100.0},
	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = 'blip_drugdealer', color = 6, sprite = 378, radius = 25.0},
}