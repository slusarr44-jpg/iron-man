local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- ИНТЕРФЕЙС (Белый, прозрачный)
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 220, 0, 130)
frame.Position = UDim2.new(0.5, -110, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0.4
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "RUSTAM - NO COOLDOWN"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 0, 0)

local cdBtn = Instance.new("TextButton", frame)
cdBtn.Size = UDim2.new(0.9, 0, 0, 40)
cdBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
cdBtn.Text = "УБРАТЬ КД (COOLDOWN)"
cdBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)

-- ЛОГИКА УДАЛЕНИЯ КД
cdBtn.MouseButton1Click:Connect(function()
    print("Попытка сброса КД...")
    
    -- 1. Обнуляем все цифровые таймеры в игроке
    for _, v in pairs(player:GetDescendants()) do
        if v:IsA("NumberValue") or v:IsA("IntValue") then
            if v.Name:lower():find("cooldown") or v.Name:lower():find("timer") or v.Name:lower():find("wait") then
                v.Value = 0
            end
        end
    end
    
    -- 2. Сбрасываем атрибуты (часто КД на смену костюма сидит тут)
    local char = player.Character
    if char then
        for name, _ in pairs(char:GetAttributes()) do
            if name:lower():find("cooldown") or name:lower():find("can") then
                char:SetAttribute(name, 0)
                char:SetAttribute("CanSpawn", true) -- Пытаемся разрешить спавн сразу
            end
        end
    end
    
    print("КД сброшен (если он был локальным)!")
end)
