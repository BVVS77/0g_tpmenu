```md
# ✈️ 0Gravity - Advanced Teleportation Script

A standalone teleportation system for FiveM servers with admin permissions, native notifications, and optional Discord logging support.

---

## 📦 Features

✅ `/teleport` command with point selection  
✅ Native GTA V notification support  
✅ Admin-only teleport destinations  
✅ Cooldown logic scaffolded (expandable)  
✅ Server-side logging via Discord Webhook  
✅ Easily extendable for ESX/QBCore

---

## 📁 Files Included

```
advanced_teleport/
├── fxmanifest.lua
├── client.lua
└── server.lua
```

---

## 🧠 How It Works

- Players use `/teleport` to list and select teleport points.
- Some points can be marked `adminOnly`.
- Teleportation is logged to Discord if a webhook is configured.
- Built-in notification system guides players.

---

## 🛠️ Installation

1. Place the folder in your server’s `resources` directory.
2. Add this to your `server.cfg`:
   ```
   ensure advanced_teleport
   ```

3. In `server.lua`, set your webhook URL:
   ```lua
   local discordWebhookURL = "https://discord.com/api/webhooks/your-webhook-url"
   ```

---

## 💡 Usage

### Command:
```
/teleport
```

- Shows all available teleport points.
- Then use:
```
/teleport [number]
```

Example:
```
/teleport 1
```

---

## ⚙️ Configuration

Teleport points are defined in `client.lua`:

```lua
local teleportPoints = {
    {name = "LS Airport", coords = vector3(-1034.6, -2733.6, 20.2), adminOnly = false},
    {name = "Downtown", coords = vector3(215.76, -810.12, 30.73), adminOnly = false},
    {name = "Admin Base", coords = vector3(450.0, -980.0, 30.0), adminOnly = true},
}
```

---

## 🔐 Admin Detection

You can easily integrate with ESX or QBCore by replacing this stub function:

```lua
local function isPlayerAdmin()
    return true -- default: everyone is admin
end
```

Example for ESX:
```lua
return ESX.PlayerData.group == 'admin' or ESX.PlayerData.group == 'superadmin'
```

---

## 🔔 Discord Webhook (Optional)

Teleportation logs are sent via `teleport:logEvent`.  
Format:
```
Player **Name** teleported to: **Location**
```

Configure in `server.lua`:
```lua
local discordWebhookURL = "https://discord.com/api/webhooks/..."
```

---

## 📜 License

MIT

---

## 🤝 Support

Join the 0Gravity dev community on Discord:  
**[https://discord.gg/YbuNXpwkWY](https://discord.gg/YbuNXpwkWY)**
```