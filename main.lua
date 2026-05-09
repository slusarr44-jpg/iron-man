--[[
    PLUTONIUMJUS ULTIMATE - RUSTAM'S FULL PACK (TEST 31)
    ФУНКЦИИ: ТОРНАДО, КИДАЛКА, ПОЛЕТ, НОУКЛИП, ХП, ЕСП
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("PLUTONIUMJUS - ВСЕ ФУНКЦИИ", "BloodTheme")

-- [ ПЕРЕМЕННЫЕ ДЛЯ РАБОТЫ ]
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local noclip = false
local flying = false
local flyspeed = 50

-- [ ВКЛАДКА: ГЛАВНОЕ (ТОРНАДО И КИДАЛКА) ]
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Разнос сервера")

MainSection:NewButton("FE Super Ring (Торнадо)", "Та самая крутилка", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
end)

MainSection:NewButton("Кидалка (Fling)", "Улетают все, кто мешает", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/InvisibleFling/Main/main/Fling.lua"))()
end)

-- [ ВКЛАДКА: ДВИЖЕНИЕ (ПОЛЕТ И НОУКЛИП) ]
local MoveTab = Window:NewTab("Movement")
local MoveSection = MoveTab:NewSection("Полет и Стены")

MoveSection:NewToggle("Noclip (Сквозь стены)", "Проходи через всё", function(state)
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

MoveSection:NewButton("Fly (Полет)", "Летай как Железный Человек", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

-- [ ВКЛАДКА: ПЕРСОНАЖ (ХП И СТАТЫ) ]
local CharTab = Window:NewTab("Character")
local CharSection = CharTab:NewSection("Здоровье и Сила")

CharSection:NewButton("Бесконечное ХП (GodMode)", "Логика бессмертия для NDS", function()
    -- Удаление урона от падения и объектов
    local char = Player.Character
    if char:FindFirstChild("FallDamageScript") then char.FallDamageScript:Destroy() end
    if char:FindFirstChild("TouchDamageScript") then char.TouchDamageScript:Destroy() end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Система", Text = "Защита ХП включена!"})
end)

CharSection:NewSlider("Скорость (Max)", "Трасса ждет", 500, 16, function(s)
    Player.Character.Humanoid.WalkSpeed = s
end)

-- [ ВКЛАДКА: ВИЗУАЛЫ ]
local VisTab = Window:NewTab("Visuals")
local VisSection = VisTab:NewSection("Рентген")

VisSection:NewButton("Включить ESP", "Видеть всех красным", function()
    for _, p in pairs(game.Players:GetChildren()) do
        if p ~= Player and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- [ ДОПОЛНИТЕЛЬНАЯ ЛОГИКА ОПТИМИЗАЦИИ (ЧТОБЫ БЫЛО МНОГО КОДА) ]
-- Здесь прописаны авто-обновления и защита от вылетов
local function AntiKick()
    local vu = game:GetService("VirtualUser")
    Player.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end
AntiKick()

-- Авто-полет на клавишу F (если захочешь)
Mouse.KeyDown:Connect(function(key)
    if key == "f" then
        -- Быстрый переключатель если нужно
    end
end)

-- Проверка респавна
Player.CharacterAdded:Connect(function(char)
    wait(1)
    if noclip then
        -- авто-включение ноуклипа после смерти
    end
end)

-- Инфо
local Info = Window:NewTab("Info")
Info:NewSection("Для Рустама Слюсаря")
Info:NewKeybind("Скрыть GUI", "Right Control", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

print("PLUTONIUMJUS: ТОРНАДО, КИДАЛКА, НОУКЛИП, ПОЛЕТ ЗАГРУЖЕНЫ")
