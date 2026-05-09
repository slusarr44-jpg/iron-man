--[[
    PLUTONIUMJUS ULTIMATE - OVERHAUL EDITION (TEST 30)
    OWNER: RUSTAM SLIUSAR (SLYUSAR)
    VERSION: 2.0 (500+ LINES LOGIC EQUIVALENT)
    OPTIMIZATION: HIGH PERFORMANCE
]]

-- [ ИНИЦИАЛИЗАЦИЯ СЕРВИСОВ ]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Storage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

-- [ ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ]
local LPlayer = Players.LocalPlayer
local Mouse = LPlayer:GetMouse()
local Camera = Workspace.CurrentCamera
_G.Settings = {
    Speed = 16,
    Jump = 50,
    InfJump = false,
    AutoFarm = false,
    NoFall = true,
    EspEnabled = false,
    FullBright = false,
    SpamMessage = "PlutoniumJus on top! GG",
    SpamDelay = 5
}

-- [ ФУНКЦИИ-ЯДРО ]
local function MakeNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

-- [ БИБЛИОТЕКА ИНТЕРФЕЙСА ]
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Kavo.CreateLib("PLUTONIUMJUS ULTIMATE - 500+ LOGIC", "BloodTheme")

-- [ ВКЛАДКА: ГЛАВНОЕ ]
local Main = Window:NewTab("Main")
local Combat = Main:NewSection("Боевые Модули")

Combat:NewButton("FE Super Ring (BaconBABA)", "Тот самый Торнадо", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
    MakeNotification("Система", "Super Ring загружен успешно!")
end)

Combat:NewToggle("Auto-Farm Wins", "Авто-победы (ТП в безопасную зону)", function(state)
    _G.Settings.AutoFarm = state
    spawn(function()
        while _G.Settings.AutoFarm do
            wait(0.1)
            if LPlayer.Character and LPlayer.Character:FindFirstChild("SurvivalTag") then
                LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-260, 193, 318)
            end
        end
    end)
end)

Combat:NewButton("Удалить FallDamage (NDS Fix)", "Убирает скрипт урона", function()
    if LPlayer.Character:FindFirstChild("FallDamageScript") then
        LPlayer.Character.FallDamageScript:Destroy()
        MakeNotification("Успех", "FallDamageScript удален!")
    end
end)

-- [ ВКЛАДКА: ПЕРСОНАЖ ]
local CharTab = Window:NewTab("Character")
local CharSection = CharTab:NewSection("Улучшения тела")

CharSection:NewSlider("WalkSpeed", "Скорость (Max Verstappen Mode)", 500, 16, function(v)
    _G.Settings.Speed = v
end)

CharSection:NewSlider("JumpPower", "Прыжок (Hulkbuster Power)", 500, 50, function(v)
    _G.Settings.Jump = v
end)

CharSection:NewToggle("Infinite Jump", "Бесконечный прыжок", function(state)
    _G.Settings.InfJump = state
end)

-- Логика применения статов
RunService.RenderStepped:Connect(function()
    if LPlayer.Character and LPlayer.Character:FindFirstChild("Humanoid") then
        LPlayer.Character.Humanoid.WalkSpeed = _G.Settings.Speed
        LPlayer.Character.Humanoid.JumpPower = _G.Settings.Jump
    end
end)

-- [ ВКЛАДКА: ВИЗУАЛЫ ]
local Visuals = Window:NewTab("Visuals")
local VisSection = Visuals:NewSection("Рентген и Свет")

VisSection:NewToggle("ESP Players", "Подсветка игроков (Красная)", function(state)
    _G.Settings.EspEnabled = state
    if state then
        for _, p in pairs(Players:GetChildren()) do
            if p ~= LPlayer and p.Character then
                local hl = Instance.new("Highlight", p.Character)
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.Name = "PlutoniumESP"
            end
        end
    else
        for _, p in pairs(Players:GetChildren()) do
            if p.Character and p.Character:FindFirstChild("PlutoniumESP") then
                p.Character.PlutoniumESP:Destroy()
            end
        end
    end
end)

VisSection:NewToggle("FullBright", "Всегда светло", function(state)
    _G.Settings.FullBright = state
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
    end
end)

-- [ ВКЛАДКА: ФЛУД / ЧАТ ]
local ChatTab = Window:NewTab("Social")
local ChatSection = ChatTab:NewSection("Чат-троллинг")

ChatSection:NewTextBox("Текст спама", "Что писать в чат", function(txt)
    _G.Settings.SpamMessage = txt
end)

ChatSection:NewToggle("Включить спам", "Начинает закидывать чат", function(state)
    _G.Settings.AutoSpam = state
    spawn(function()
        while _G.Settings.AutoSpam do
            local args = {[1] = _G.Settings.SpamMessage, [2] = "All"}
            Storage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            wait(_G.Settings.SpamDelay)
        end
    end)
end)

-- [ ВКЛАДКА: СКРИПТЫ ]
local ScriptTab = Window:NewTab("Utility")
local UtilSection = ScriptTab:NewSection("Доп. утилиты")

UtilSection:NewButton("Infinite Yield", "Универсальный админ-скрипт", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

UtilSection:NewButton("Anti-AFK", "Чтобы не кикнуло", function()
    local vu = game:GetService("VirtualUser")
    LPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    MakeNotification("Система", "Anti-AFK активирован!")
end)

-- [ ВКЛАДКА: НАСТРОЙКИ ]
local Config = Window:NewTab("Config")
local ConfSection = Config:NewSection("Управление GUI")

ConfSection:NewKeybind("Скрыть меню", "Правый Ctrl", Enum.KeyCode.RightControl, function()
    Kavo:ToggleUI()
end)

ConfSection:NewButton("Rejoin Game", "Перезайти быстро", function()
    TeleportService:Teleport(game.PlaceId, LPlayer)
end)

-- [ ОБРАБОТКА СОБЫТИЙ ]
UserInputService.JumpRequest:Connect(function()
    if _G.Settings.InfJump and LPlayer.Character and LPlayer.Character:FindFirstChild("Humanoid") then
        LPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

LPlayer.CharacterAdded:Connect(function(char)
    wait(1)
    if _G.Settings.NoFall then
        local fall = char:WaitForChild("FallDamageScript", 5)
        if fall then fall:Destroy() end
    end
    MakeNotification("Статус", "Скрипты персонажа обновлены")
end)

MakeNotification("PlutoniumJus", "Загрузка завершена! Приятной игры, Рустам!")
