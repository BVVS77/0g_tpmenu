local discordWebhookURL = "YOUR_DISCORD_WEBHOOK_URL_HERE"  -- Wstaw tutaj adres Twojego webhooka Discorda

-- Nasłuchiwanie zdarzenia logowania teleportacji
RegisterNetEvent('teleport:logEvent')
AddEventHandler('teleport:logEvent', function(playerName, teleportPoint)
    local message = string.format("Player **%s** teleported to: **%s**", playerName, teleportPoint)
    
    local data = {
        username = "Teleport Logger",
        content = message
    }
    
    local jsonData = json.encode(data)
    
    PerformHttpRequest(discordWebhookURL, function(err, text, headers)
        if err ~= 200 then
            print("Failed to send Discord log: " .. tostring(err))
        end
    end, "POST", jsonData, { ["Content-Type"] = "application/json" })
end)
