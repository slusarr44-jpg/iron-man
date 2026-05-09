local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 19 MOD",
   LoadingTitle = "ТЕСТ 19: REBORN",
   LoadingSubtitle = "by Rustam",
   ConfigurationSaving = { Enabled = false }
})

-- Твои переменные
_G.FlyEnabled = false
_G.GodMode = false
_G.ESP = false
_G.NoFall = true
_G.WalkSpeed = 16 -- Стандартная скорость по умолчанию

local lp = game.Players.LocalPlayer

-- Функция для применения скорости
local function applySpeed(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.WalkSpeed = _G.WalkSpeed
        
        -- Чтобы скорость не сбрасывалась самой игрой
        humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if humanoid.WalkSpeed ~= _G.WalkSpeed then
                humanoid.WalkSpeed = _G.WalkSpeed
            end
        end)
    end
end

-- Следим за спавном персонажа
lp.CharacterAdded:Connect(applySpeed)
if lp.Character then applySpeed(lp.Character) end

-- Создаем вкладку
local MainTab = Window:CreateTab("Основные", 4483362458) -- Иконка настроек

-- Слайдер скорости
local SpeedSlider = MainTab:CreateSlider({
   Name = "Скорость бега (WalkSpeed)",
   Range = {0, 200},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
      _G.WalkSpeed = Value
      local char = lp.Character
      if char and char:FindFirstChild("Humanoid") then
          char.Humanoid.WalkSpeed = Value
      end
   end,
})

Rayfield:Notify({
   Title = "Скрипт запущен",
   Content = "Меню для Rustam успешно загружено!",
   Duration = 5,
   Image = 4483362458,
})
