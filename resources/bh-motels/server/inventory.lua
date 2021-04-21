Citizen.CreateThread(function()
    TriggerEvent('bh-inventoryhud:RegisterInventory', {
        name = 'cupboard',
        label = ('Cupboard'),
        slots = 50,
        maxweight = 100
    })
end)
