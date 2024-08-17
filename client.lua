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

        while count ~= 500 do -- wait 500 counts and then stop drawing the purge text
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
            count = count + 1
            print(count)
        end
        StopScreenEffect("DeathFailMPDark")
    end)
end)

AddEventHandler('purge:start', function() -- handle the weather
    CreateThread(function()
        purgeActive = true
        while purgeActive do
            SetWeatherTypeNow("HALLOWEEN")
            SetOverrideWeather("HALLOWEEN")
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
        ClearOverrideWeather()
        SetWeatherTypeNow("EXTRASUNNY")
        SetOverrideWeather("EXTRASUNNY")
        PauseClock(false)
    end)
end)