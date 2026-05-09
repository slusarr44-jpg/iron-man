--[[
    PLUTONIUMJUS - SLYUSAR EDITION (TEST 33)
    STYLE: CLASSIC WHITE (LIGHT)
    BASE: TEST 19 LOGIC
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("PLUTONIUMJUS - CLASSIC WHITE", "Light")

-- ПЕРЕМЕННЫЕ
local Player = game.Players.LocalPlayer
local noclip = false

-- ГЛАВНАЯ (ТОРНАДО И КИДАЛКА)
local Main = Window:NewTab("Главная")
local MainSection = Main:NewSection("Разнос")

MainSection:NewButton("FE Super Ring (Торнадо)", "Оригинальный скрипт", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
end)

MainSection:NewButton("Кидалка (Fling)", "Выкинуть всех", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/InvisibleFling/Main/main/Fling.lua"))()
end)

-- ДВИЖЕНИЕ (ПОЛЕТ И НОУКЛИП)
local MoveTab = Window:NewTab("Движение")
local MoveSection = MoveTab:NewSection("Полет")

MoveSection:NewButton("Fly (Полет)", "Летать как Тони", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

MoveSection:NewToggle("Noclip (Сквозь стены)", "Ходи через всё", function(state)
    noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if noclip and Player.Character then
            for _, v in pairs(Player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- ПЕРСОНАЖ (СТАТЫ И ХП)
local CharTab = Window:NewTab("Персонаж")
local CharSection = CharTab:NewSection("Характеристики")

CharSection:NewButton("Защита ХП (No Fall)", "Убрать урон от падения", function()
    if Player.Character:FindFirstChild("FallDamageScript") then
        Player.Character.FallDamageScript:Destroy()
    end
end)

CharSection:NewSlider("Скорость (Max)", "Трасса Red Bull", 500, 16, function(s)
    Player.Character.Humanoid.WalkSpeed = s
end)

-- НАСТРОЙКИ
local Settings = Window:NewTab("Настройки")
Settings:NewSection("Управление")
Settings:NewKeybind("Скрыть меню", "Right Control", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

print("PLUTONIUMJUS: ВСЁ ГОТОВО ДЛЯ РУСТАМА")
