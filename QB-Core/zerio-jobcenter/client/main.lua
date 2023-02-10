CreateThread(function()
    QBCore = exports['qb-core']:GetCoreObject()

    local closestpos, closestidx, closestdist = nil, nil, nil
    local isopen = false

    CreateThread(function()
        while true do
            local playerpos = GetEntityCoords(PlayerPedId())

            local closestpos2, closestidx2, closestdist2 = nil, nil, math.huge

            for i, v in pairs(Config.Locations) do
                local dist = #(playerpos - v.position)
                if dist < closestdist2 then
                    closestdist2 = dist
                    closestidx2 = i
                    closestpos2 = v.position
                end
            end

            closestpos = closestpos2
            closestidx = closestidx2
            closestdist = closestdist2

            Citizen.Wait(500)
        end
    end)

    RegisterNUICallback("close", function(data, cb)
        SetNuiFocus(false, false)
        isopen = false
        TriggerScreenblurFadeOut(250)
        cb("ok")
    end)

    RegisterNUICallback("getjob", function(data, cb)
        TriggerServerEvent("zerio-jobcenter:server:setjob", data.jobindex, closestidx)
        cb("ok")
    end)

    for i, v in pairs(Config.Locations) do
        local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
        SetBlipSprite(blip, 351)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 1.25)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Arbetsförmedlingen")
        EndTextCommandSetBlipName(blip)
    end

    while true do
        if closestpos ~= nil and closestdist < 10.0 and isopen == false then
            AddTextEntry('jobcenterhelp', "~INPUT_CONTEXT~ - Open Jobcenter")
            SetFloatingHelpTextWorldPosition(1, closestpos)
            SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
            DrawMarker(23, closestpos.x, closestpos.y, closestpos.z-1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 100, 155, 85, false, true, 2, nil, nil, false)
            BeginTextCommandDisplayHelp('jobcenterhelp')
            EndTextCommandDisplayHelp(2, false, false, -1)

            if closestdist < 1.0 and IsControlJustReleased(0, 38) then
                SendNUIMessage({
                    action = "open",
                    jobs = Config.Locations[closestidx].jobs,
                    job = QBCore.Functions.GetPlayerData().job.name
                })
                SetNuiFocus(true, true)
                isopen = true
                TriggerScreenblurFadeIn(500)
            end

            Citizen.Wait(0)
        else
            Citizen.Wait(100)
        end
    end
end)
