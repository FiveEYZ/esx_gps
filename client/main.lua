local radar = false
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()  
    hasGps(function (hasGps)
        if hasGps == true then
            toggleRadar(true)
        else
            toggleRadar(false)
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if IsPedInAnyVehicle(GetPlayerPed(-1),  false) then
            toggleRadar(true)
            radar = false
        else
            hasGps(function (hasGps)
                if hasGps == false then
                    toggleRadar(false)
                    radar = true
                end
            end)
        end
    end
end)

RegisterNetEvent('esx_gps:toggleGPS')
AddEventHandler('esx_gps:toggleGPS', function()
    if radar == true then
        toggleRadar(radar)
        radar = false
    else
        if radar == false then
            toggleRadar(radar)
            radar = true
        end
    end
end)

function toggleRadar(toggle)
    DisplayRadar(toggle)
end

function hasGps (cb)
    if (ESX == nil) then return cb(0) end
        ESX.TriggerServerCallback('esx_gps:checkIfHas', function(qtty)
            cb(qtty > 0)
        end, 'gps')
end
