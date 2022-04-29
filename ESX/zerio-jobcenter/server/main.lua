ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent("zerio-jobcenter:server:setjob")
AddEventHandler("zerio-jobcenter:server:setjob", function(jobindex, jobcenteridx)
    local Player = ESX.GetPlayerFromId(source)

    if Config.Locations[jobcenteridx] and Config.Locations[jobcenteridx].jobs[jobindex+1] then
        Player.setJob(Config.Locations[jobcenteridx].jobs[jobindex+1].name, 0)
        TriggerClientEvent("esx:showNotification", Player.source, "You changed your job to " .. Config.Locations[jobcenteridx].jobs[jobindex+1].label)
    end
end)