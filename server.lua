

RegisterServerEvent('kvl:removemoney')
AddEventHandler('kvl:removemoney', function(price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer ~= nil then
        xPlayer.removeMoney(price)
    end
end)

ESX.RegisterServerCallback('kvl-rob:paracheckk', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)


    if xPlayer ~= nil then
        cb(xPlayer.getAccount("money").money >= price)
    end

end)