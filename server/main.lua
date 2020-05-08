ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'gps' then
		TriggerClientEvent('esx_gps:addGPS', source)
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'gps' and item.count < 1 then
		TriggerClientEvent('esx_gps:removeGPS', source)
	end
end)

ESX.RegisterServerCallback('gps:checkIfHas', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)

        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
end)
