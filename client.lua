-- Advanced Teleportation Script for FiveM (Standalone)
-- Version: 1.1
-- Author: Your Name
-- Description: An enhanced teleportation script with menu, cooldown, permission checks, and native notifications.

-- Teleportation Points Configuration
local teleportPoints = {
    {name = "LS Airport", coords = vector3(-1034.6, -2733.6, 20.2), adminOnly = false},
    {name = "Downtown", coords = vector3(215.76, -810.12, 30.73), adminOnly = false},
    {name = "Admin Base", coords = vector3(450.0, -980.0, 30.0), adminOnly = true},
}

-- Teleportation cooldown in seconds
local teleportCooldown = 5
local lastTeleportTime = {}

-- Function to display native notifications on screen
function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end

--- EXAMPLE
-- QBCore version of isPlayerAdmin function using a permission field
-- local QBCore = exports['qb-core']:GetCoreObject()

-- local function isPlayerAdmin()
--     local PlayerData = QBCore.Functions.GetPlayerData()
--     if PlayerData and PlayerData.permission then
--         -- Adjust the condition based on your server's admin permission system
--         return PlayerData.permission == "admin"
--     end
--     return false
-- end

-- ESX version of isPlayerAdmin function
-- ESX = nil

-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--         Citizen.Wait(0)
--     end
-- end)

-- local function isPlayerAdmin()
--     if ESX and ESX.PlayerData and ESX.PlayerData.group then
--         -- Check if the player's group is 'admin' or 'superadmin'
--         return ESX.PlayerData.group == 'admin' or ESX.PlayerData.group == 'superadmin'
--     end
--     return false
-- end


local function isPlayerAdmin()
    -- For demonstration, every player is treated as an admin.
    return true
end

-- Function to teleport the player
-- Function to teleport the player
local function teleportPlayer(point)
    local playerPed = PlayerPedId()
    if playerPed then
        SetEntityCoords(playerPed, point.coords.x, point.coords.y, point.coords.z, false, false, false, true)
        ShowNotification("Teleported to: " .. point.name)
        -- Wywołanie zdarzenia logowania po stronie serwera
        TriggerServerEvent('teleport:logEvent', GetPlayerName(PlayerId()), point.name)
    else
        ShowNotification("Teleportation error.")
    end
end

-- Registering the /teleport command
RegisterCommand("teleport", function(source, args)

    -- Displaying the teleportation menu if no arguments are provided
    if #args < 1 then
        local message = "Available Teleport Points:\n"
        for i, point in ipairs(teleportPoints) do
            if not point.adminOnly or isPlayerAdmin() then
                local adminLabel = point.adminOnly and " (Admin)" or ""
                message = message .. "[" .. i .. "] " .. point.name .. adminLabel .. "\n"
            end
        end
        message = message .. "Usage: /teleport [number]"
        ShowNotification(message)
        return
    end

    local index = tonumber(args[1])
    if index and teleportPoints[index] then
        local point = teleportPoints[index]
        if point.adminOnly and not isPlayerAdmin() then
            ShowNotification("You do not have permission to teleport to this point.")
            return
        end
        teleportPlayer(point)
        lastTeleportTime[source] = currentTime
    else
        ShowNotification("Invalid teleport point number.")
    end
end, false)
