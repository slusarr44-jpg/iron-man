--[[
    PLUTONIUMJUS - ULTIMATE WHITE (FIXED)
    Оптимизировано для slusarr44-jpg/iron-man
    Стиль: Classic White (Light)
]]

local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)

if not success then return end

-- Используем "Light" для белой темы, как ты просил
local Window = Library.CreateLib("PLUTONIUMJUS - RUSTAM EDITION", "Light")

-- ГЛАВНАЯ
local Main = Window:NewTab("Главная")
local MainSection = Main:NewSection("Торнадо и Разнос")

MainSection:NewButton("FE Super Ring (Торнадо)", "Запуск крутилки", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
end)

MainSection:NewButton("Кидалка (Fling)", "Убрать тех, кто руинит", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/InvisibleFling/Main/main/Fling.lua"))()
end)

-- ДВИЖЕНИЕ
local MoveTab = Window:NewTab("Движение")
local MoveSection = MoveTab:NewSection("Полет и Ноуклип")

MoveSection:NewButton("Fly (Полет)", "Как Тони Старк", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

MoveSection:NewToggle("Noclip (Сквозь стены)", "Ходить через всё", function(state)
    _G.Noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Noclip and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- ПЕРСОНАЖ
local CharTab = Window:NewTab("Персонаж")
local CharSection = CharTab:NewSection("Статы и ХП")

CharSection:NewButton("Защита ХП", "Удалить урон от падения", function()
    if game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") then
        game.Players.LocalPlayer.Character.FallDamageScript:Destroy()
    end
end)

CharSection:NewSlider("Скорость (Max)", "Трасса F1", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- НАСТРОЙКИ
local Settings = Window:NewTab("Настройки")
Settings:NewSection("Управление")
Settings:NewKeybind("Скрыть меню", "Right Control", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

print("PLUTONIUMJUS LOADED FOR RUSTAM SLIUSAR")
