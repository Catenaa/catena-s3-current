
Citizen.CreateThread(function()
    TriggerEvent('bh-inventoryhud:RegisterInventory', {
        name = 'stashh',
        label = ('Stash'),
        slots = 300,
        maxweight = 350
    })
end)