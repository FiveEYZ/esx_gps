ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	hasGps(function (hasGps)
	  if hasGps == true then
		showRadar()
	  else
		hideRadar()
	  end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
        hasGps(function (hasGps)
          if hasGps == true then
            showRadar()
          else
            hideRadar()
          end
        end)
	end
end)

function showRadar()
	DisplayRadar(true)
end

function hideRadar()
	DisplayRadar(false)
end

function hasGps (cb)
	if (ESX == nil) then return cb(0) end
		ESX.TriggerServerCallback('esx_gps:checkIfHas', function(qtty)
			cb(qtty > 0)
		end, 'gps')
end
