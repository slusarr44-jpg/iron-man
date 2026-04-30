local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- СОЗДАНИЕ ИНТЕРФЕЙСА (Белый, прозрачный)
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0.4
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "RUSTAM HUB"
title.BackgroundTransparency = 1

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, 0, 0, 30)
status.Position = UDim2.new(0, 0, 0.3, 0)
status.Text = "GodMode: OFF"
status.BackgroundTransparency = 1

local repairBtn = Instance.new("TextButton", frame)
repairBtn.Size = UDim2.new(0.8, 0, 0, 40)
repairBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
repairBtn.Text = "ПОЧИНИТЬ ВСЁ"
repairBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)

-- ЛОГИКА БЕССМЕРТИЯ (Чтобы не мигало и не убивало)
local godActive = false
task.spawn(function()
    while true do
        if godActive then
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") then
                    -- Пытаемся заблокировать смерть
                    if char.Humanoid.Health > 0 and char.Humanoid.Health < 100 then
                        char.Humanoid.Health = 100
                    elseif char.Humanoid.Health <= 0 then
                        -- Если всё-таки умерли, пробуем воскреснуть на месте
                        char.Humanoid.Health = 100
                    end
                end
            end)
        end
        task.wait() -- Без задержки, чтобы сервер не успел
    end
end)

-- ЛОГИКА ПОЧИНКИ (Ищем костюм по всему серверу)
repairBtn.MouseButton1Click:Connect(function()
    godActive = not godActive
    status.Text = godActive and "GodMode: ON" or "GodMode: OFF"
    
    print("Запуск тотальной починки...")
    -- Ищем твой ник во всех объектах игры (даже если костюм не в персонаже)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name:find(player.Name) or obj:IsDescendantOf(player.Character) then
            for _, val in pairs(obj:GetDescendants()) do
                if val:IsA("NumberValue") or val:IsA("IntValue") then
                    val.Value = 999999
                end
            end
        end
    end
end)
