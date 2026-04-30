local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

print("--- Iron Man: Reimagined Script Loaded ---")

-- 1. Бессмертие (GodMode)
-- Цикл проверяет ХП и мгновенно его восстанавливает
spawn(function()
    while task.wait() do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                if player.Character.Humanoid.Health < player.Character.Humanoid.MaxHealth then
                    player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
                end
            end
        end)
    end
end)

-- 2. Починка по нажатию кнопки "K"
UIS.InputBegan:Connect(function(input, chat)
    if not chat and input.KeyCode == Enum.KeyCode.K then
        print("Чиним твой Марк...")
        -- Ищем все детали костюма в персонаже
        for _, obj in pairs(player.Character:GetDescendants()) do
            -- Ищем переменные прочности
            if obj:IsA("NumberValue") and (obj.Name == "Health" or obj.Name == "Durability") then
                obj.Value = 100
            end
        end
    end
end)
