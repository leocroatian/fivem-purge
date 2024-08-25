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
        PushScaleformMovieMethodParameterString("~r~Emergency Broadcast System")
        PushScaleformMovieMethodParameterString("This is your Emergency Broadcast System announcing the commencement of the Annual Purge sanctioned by the U.S. Government")
        EndScaleformMovieMethod()

        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile  = 'purge',
            transactionVolume = 0.5
        })

        while count ~= 1500 do -- wait 1000 counts and then stop drawing the purge text
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
            SetWeatherTypeNow('HALLOWEEN')
            SetOverrideWeather('HALLOWEEN')
            SetWeatherTypePersist('HALLOWEEN')
            SetWeatherTypeNowPersist('HALLOWEEN')
            SetArtificialLightsState(true)
            SetArtificialLightsStateAffectsVehicles(false)
            PauseClock(true)
            NetworkOverrideClockTime(00, 00, 00)
            SetClockTime(00, 00, 00)
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
        NetworkOverrideClockTime(12, 00, 00)
        SetClockTime(12, 00, 00)
        StopScreenEffect("DeathFailMPDark")
    end)
end)