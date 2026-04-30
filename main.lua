-- Глобальные настройки
getgenv().GodMode = true
getgenv().RepairKey = Enum.KeyCode.K

local player = game.Players.LocalPlayer

-- 1. МОЩНЫЙ GODMODE (Метод подмены индекса)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if getgenv().GodMode and t:IsA("Humanoid") and (k == "Health" or k == "Value") then
        return t.MaxHealth -- Всегда говорим игре, что у нас макс. ХП
    end
    return oldIndex(t, k)
end)
setreadonly(mt, true)

-- 2. ПОЧИНКА БРОНИ (Через поиск объектов)
game:GetService("UserInputService").InputBegan:Connect(function(input, chat)
    if not chat and input.KeyCode == getgenv().RepairKey then
        print("Активация ремонта...")
        local char = player.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                -- Ищем любые цифры, которые могут отвечать за броню
                if v:IsA("NumberValue") or v:IsA("IntValue") then
                    v.Value = 100000 
                end
            end
        end
    end
end)

print("!!! НОВЫЙ КОД ЗАГРУЖЕН: ПРОВЕРЯЙ В ИГРЕ !!!")
