local purgeTriggered = false

RegisterNetEvent('purge:start')
RegisterNetEvent('purge:stop')

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 180 and purgeTriggered == false then
        TriggerClientEvent('purge:start', -1)
        purgeTriggered = true
        print('[DEBUG] Purge has started.')
    end
end)
AddEventHandler('txAdmin:events:skippedNextScheduledRestart', function(eventData)
    if purgeTriggered then
        TriggerClientEvent('purge:stop', -1)
        purgeTriggered = false
        print('[DEBUG] Purge has stopped.')
    end
end)