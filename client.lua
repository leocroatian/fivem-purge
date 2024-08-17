RegisterNetEvent('purge:start')
RegisterNetEvent('purge:stop')

local purgeActive = false
local count = 0

AddEventHandler('purge:start', function() -- initial purge start
    CreateThread(function()

        local scaleformHandle = RequestScaleformMovie("mp_big_message_freemode")
        while not HasScaleformMovieLoaded(scaleformHandle) do 
            Citizen.Wait(0)
        end
        StartScreenEffect('DeathFailMPDark')

        BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE")
        PushScaleformMovieMethodParameterString("~r~Purge has started")
        EndScaleformMovieMethod()

        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile  = 'purge',
            transactionVolume = 0.5
        })

        while count ~= 1000 do -- wait 1000 counts and then stop drawing the purge text
            DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
            count = count + 1
            Wait(0)
        end
        
    end)
end)

AddEventHandler('purge:start', function() -- handle the weather
    CreateThread(function()
        purgeActive = true
        while purgeActive do
            SetWeatherTypeNow("HALLOWEEN")
            SetOverrideWeather("HALLOWEEN")
            SetArtificialLightsState(true)
            SetArtificialLightsStateAffectsVehicles(false)
            NetworkOverrideClockTime(00, 00, 00)
            SetClockTime(00, 00, 00)
            PauseClock(true)
            Citizen.Wait(0)
        end
    end)
end)

AddEventHandler('purge:stop', function() -- handle the purge stopping
    CreateThread(function()
        purgeActive = false
        count = 0
        ClearOverrideWeather()
        SetWeatherTypeNow("EXTRASUNNY")
        SetOverrideWeather("EXTRASUNNY")
        PauseClock(false)
        StopScreenEffect("DeathFailMPDark")
    end)
end)