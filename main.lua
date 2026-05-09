--[[
    PLUTONIUMJUS - CLASSIC WHITE EDITION (TEST 32)
    Основано на Тесте 19 + Все новые функции
    Стиль: СТАРЫЙ БЕЛЫЙ (Light)
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- ВОЗВРАЩАЕМ БЕЛУЮ ТЕМУ (Light)
local Window = Library.CreateLib("PLUTONIUMJUS - CLASSIC WHITE", "Light")

-- [ ПЕРЕМЕННЫЕ ]
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RunService = game:GetService("RunService")
local noclip = false

-- [ ВКЛАДКА: ГЛАВНОЕ ]
local Main = Window:NewTab("Главная")
local MainSection = Main:NewSection("Торнадо и Кидалка")

MainSection:NewButton("FE Super Ring (Торнадо)", "Оригинальная крутилка", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
end)

MainSection:NewButton("Кидалка (Fling)", "Выкинуть всех с карты", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/InvisibleFling/Main/main/Fling.lua"))()
end)

-- [ ВКЛАДКА: ДВИЖЕНИЕ ]
local MoveTab = Window:NewTab("Движение")
local MoveSection = MoveTab:NewSection("Полет и Стены")

MoveSection:NewButton("Fly (Полет)", "Летать как Железный Человек", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

MoveSection:NewToggle("Noclip (Сквозь стены)", "Проход через объекты", function(state)
    noclip = state
    RunService.Stepped:Connect(function()
        if noclip and Player.Character then
            for _, v in pairs(Player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

-- [ ВКЛАДКА: ПЕРСОНАЖ ]
local CharTab = Window:NewTab("Персонаж")
local CharSection = CharTab:NewSection("Статы и ХП")

CharSection:NewButton("Защита ХП (Anti-Damage)", "Удаляет урон от падения", function()
    if Player.Character:FindFirstChild("FallDamageScript") then
        Player.Character.FallDamageScript:Destroy()
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Система", Text = "ХП защищено!"})
end)

CharSection:NewSlider("Скорость (Max Mode)", "Беги как Макс", 500, 16, function(s)
    Player.Character.Humanoid.WalkSpeed = s
end)

CharSection:NewSlider("Прыжок (Hulkbuster)", "Высокие прыжки", 500, 50, function(s)
    Player.Character.Humanoid.JumpPower = s
end)

-- [ ВКЛАДКА: НАСТРОЙКИ ]
local SetTab = Window:NewTab("Настройки")
local SetSection = SetTab:NewSection("Управление")

SetSection:NewKeybind("Скрыть меню", "Нажми, чтобы спрятать", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

SetSection:NewButton("Перезайти (Rejoin)", "Быстрый реконнект", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)

-- Авто-обновление при смерти (как в Тесте 19)
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    wait(1)
    if noclip then
        -- Ноуклип подхватится автоматически через Stepped
    end
end)

print("PLUTONIUMJUS: CLASSIC WHITE LOADED. ENJOY, RUSTAM!")
