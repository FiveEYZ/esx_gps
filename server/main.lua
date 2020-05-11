ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('gps', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_gps:toggleGPS', source)
end)

ESX.RegisterServerCallback('esx_gps:checkIfHas', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local items = xPlayer.getInventoryItem(item)
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
    end
end)
