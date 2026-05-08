local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 10",
   LoadingTitle = "ТЕСТ 10: FIX GODMODE",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false
_G.FlySpeed = 50

local MainTab = Window:CreateTab("Main")

-- РЕГУЛИРОВКА СКОРОСТИ
MainTab:CreateSlider({
   Name = "Скорость полёта",
   Min = 10,
   Max = 300,
   Default = 50,
   Callback = function(v)
      _G.FlySpeed = v
   end,
})

-- ПОЛЁТ КЛАВИАТУРОЙ (КАК ТЫ ХОТЕЛ)
MainTab:CreateToggle({
   Name = "NoClip-Полёт (Клавиатура)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      local lp = game.Players.LocalPlayer
      task.spawn(function()
         while _G.FlyEnabled do
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            
            if hrp and hum then
               -- Сквозь стены
               for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = false end
               end
               
               -- Движение WASD
               local moveDir = hum.MoveDirection
               local velocity = moveDir * _G.FlySpeed
               local yVel = 0
               
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                  yVel = _G.FlySpeed
               elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                  yVel = -_G.FlySpeed
               end
               
               hrp.Velocity = Vector3.new(velocity.X, yVel, velocity.Z)
            end
            task.wait()
         end
         -- Возврат коллизии
         if lp.Character then
            for _, part in pairs(lp.Character:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = true end
            end
         end
      end)
   end,
})

-- РЕАЛЬНОЕ БЕССМЕРТИЕ (HP = 0)
MainTab:CreateToggle({
   Name = "Real God Mode (0 HP)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      local lp = game.Players.LocalPlayer
      if _G.GodMode then
         task.spawn(function()
            while _G.GodMode do
               local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
               if hum then
                  hum.Health = 0 -- Ставим 0, чтобы игра не могла нанести урон
                  hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) -- Запрещаем умирать
               end
               task.wait()
            end
         end)
      else
         -- Сброс персонажа при выключении, чтобы вернуть нормальное ХП
         lp.Character:BreakJoints()
      end
   end,
})

-- ВХ
MainTab:CreateToggle({
   Name = "ESP (ВХ)",
   CurrentValue = false,
   Callback = function(v)
      _G.ESP = v
      task.spawn(function()
         while _G.ESP do
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= game.Players.LocalPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
                  Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
               end
            end
            task.wait(1)
         end
      end)
   end,
})
