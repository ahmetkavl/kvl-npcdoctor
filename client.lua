ESX = exports["es_extended"]:getSharedObject()

local ox_target = exports.ox_target

local LegalDoc = false
local IllegalDoc = false

for k, v in pairs(KVL['Doctors'].Legal) do
    ox_target:addSphereZone({
        name = 'Revive' ..k,
        coords = v.coords,
        radius = 0.45,
        debug = drawZones,
        options = {
            {
                name = 'revive',
                label = 'Revive '..KVL['Prices'].LegalPrice..'$',
                onSelect = function()
                    LegalDoc = true
                    MoneyCheck()
                end
            }
        },
    })
end

for k, v in pairs(KVL['Doctors'].Illegal) do
    ox_target:addSphereZone({
        name = 'Revive' ..k,
        coords = v.coords,
        radius = 0.45,
        debug = drawZones,
        options = {
            {
                name = 'revive',
                label = 'Revive '..KVL['Prices'].IllegalPrice..'$',
                onSelect = function()
                    IllegalDoc = true
                    MoneyCheck()
                end
            }
        },
    })
end

RegisterNetEvent('kvl:givehealth', function ()
    if GetEntityHealth(PlayerPedId()) == 0 then
        FreezeEntityPosition(PlayerPedId(), true)
        if KVL.OX then
            if lib.progressBar({
                duration = 10000,
                label = 'You are being treated',
                useWhileDead = true,
                canCancel = true,
                disable = {
                    car = true,
                },
            }) then 
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('esx_ambulancejob:revive')
                TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
            else 
            end
        else
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('esx_ambulancejob:revive')
            TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
        end
        
    else
        FreezeEntityPosition(PlayerPedId(), true)
        if KVL.OX then
            if lib.progressBar({
                duration = 5000,
                label = 'You are being treated',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
            }) then 
                FreezeEntityPosition(PlayerPedId(), false)
                SetEntityHealth(PlayerPedId(), 200) 
            else 
            end
        else
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityHealth(PlayerPedId(), 200)
        end
    end
end)

function MoneyCheck()
    if LegalDoc then
        LegalDoc = false
        ESX.TriggerServerCallback('kvl-rob:paracheckk', function(paracheckk)
            if paracheckk then
                TriggerServerEvent('kvl:removemoney', KVL['Prices']['LegalPrice'])
                TriggerEvent('kvl:givehealth')
            else
                if KVL.OX then
                    lib.notify({title = 'Information', description = ' '..KVL['Locales']['needmoney']..' '..KVL['Prices']['LegalPrice']..'$ ', type = 'error'})
                else
                    ESX.ShowNotification(' '..KVL['Locales']['needmoney']..' '..KVL['Prices']['LegalPrice']..'$ ')
                end
            end
        end, KVL['Prices']['LegalPrice'])

    elseif IllegalDoc then
        IllegalDoc = false
        ESX.TriggerServerCallback('kvl-rob:paracheckk', function(paracheckk)
            if paracheckk then
                TriggerServerEvent('kvl:removemoney', KVL['Prices']['IllegalPrice'])
                TriggerEvent('kvl:givehealth')
            else
                if KVL.OX then
                    lib.notify({title = 'Information', description = ' '..KVL['Locales']['needmoney']..' '..KVL['Prices']['IllegalPrice']..'$ ', type = 'error'})
                else 
                    ESX.ShowNotification(' '..KVL['Locales']['needmoney']..' '..KVL['Prices']['IllegalPrice']..'$ ')
                end
            end
        end, KVL['Prices']['IllegalPrice'])
    end
end


Citizen.CreateThread(function()
    for k,v in pairs(KVL['Doctors'].Legal) do
        RequestModel(v.npc.ped)
        while not HasModelLoaded(v.npc.ped) do
            Wait(1)
        end
        stanley = CreatePed(1, v.npc.ped, v.npc.x, v.npc.y, v.npc.z - 1, v.npc.h, false, true)
        SetBlockingOfNonTemporaryEvents(stanley, true)
        SetPedDiesWhenInjured(stanley, false)
        SetPedCanPlayAmbientAnims(stanley, true)
        SetPedCanRagdollFromPlayerImpact(stanley, false)
        SetEntityInvincible(stanley, true)
        FreezeEntityPosition(stanley, true)
        TaskStartScenarioInPlace(stanley, v.npc.anim, 0, true);
        
    end
    for k,v in pairs(KVL['Doctors'].Illegal) do
        RequestModel(v.npc.ped)
        while not HasModelLoaded(v.npc.ped) do
            Wait(1)
        end
        stanley = CreatePed(1, v.npc.ped, v.npc.x, v.npc.y, v.npc.z - 1, v.npc.h, false, true)
        SetBlockingOfNonTemporaryEvents(stanley, true)
        SetPedDiesWhenInjured(stanley, false)
        SetPedCanPlayAmbientAnims(stanley, true)
        SetPedCanRagdollFromPlayerImpact(stanley, false)
        SetEntityInvincible(stanley, true)
        FreezeEntityPosition(stanley, true)
        TaskStartScenarioInPlace(stanley, v.npc.anim, 0, true);   
    end
end)

