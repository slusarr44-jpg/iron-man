local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 12",
   LoadingTitle = "ТЕСТ 12: ФИКС ТРЯСКИ",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false

local MainTab = Window:CreateTab("Main")

-- НОРМАЛЬНЫЙ ПОЛЕТ (БЕЗ ТРЯСКИ И ПОЛОСОК)
MainTab:CreateToggle({
   Name = "NoClip-Полет (Клавиатура)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      local lp = game.Players.LocalPlayer
      local runService = game:GetService("RunService")
      
      task.spawn(function()
         while _G.FlyEnabled do
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            
            if hrp and hum then
               -- Отключаем столкновения
               for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = false end
               end
               
               -- Останавливаем падение
               hrp.Velocity = Vector3.new(0, 0, 0)
               
               -- Рассчитываем движение
               local moveDir = hum.MoveDirection
               local flyVec = moveDir * 1.5 -- Скорость вперед/назад
               
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                  flyVec = flyVec + Vector3.new(0, 1.5, 0)
               elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                  flyVec = flyVec + Vector3.new(0, -1.5, 0)
               end
               
               hrp.CFrame = hrp.CFrame + flyVec
            end
            runService.Heartbeat:Wait()
         end
         
         -- Возврат физики
         if lp.Character then
            for _, part in pairs(lp.Character:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = true end
            end
         end
      end)
   end,
})

-- РЕАЛЬНОЕ БЕССМЕРТИЕ
MainTab:CreateToggle({
   Name = "God Mode (0 HP)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      local lp = game.Players.LocalPlayer
      task.spawn(function()
         while _G.GodMode do
            local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
            if hum then
               hum.Health = 0
               hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            end
            task.wait()
         end
      end)
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
