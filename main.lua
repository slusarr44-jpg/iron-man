local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 13",
   LoadingTitle = "ТЕСТ 13: SHIFT LOCK FLY",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false

local MainTab = Window:CreateTab("Main")

-- НОВЫЙ ПОЛЕТ С ПРИВЯЗКОЙ К КАМЕРЕ
MainTab:CreateToggle({
   Name = "NoClip-Полет (Свободный)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      local lp = game.Players.LocalPlayer
      local runService = game:GetService("RunService")
      local uis = game:GetService("UserInputService")
      
      task.spawn(function()
         while _G.FlyEnabled do
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            local camera = workspace.CurrentCamera
            
            if hrp and hum then
               -- Проход сквозь стены
               for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = false end
               end
               
               hrp.Velocity = Vector3.new(0, 0, 0)
               
               -- Читаем ввод клавиш
               local moveVec = Vector3.new(0,0,0)
               if uis:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + camera.CFrame.LookVector end
               if uis:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - camera.CFrame.LookVector end
               if uis:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - camera.CFrame.RightVector end
               if uis:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + camera.CFrame.RightVector end
               
               -- Высота
               local yMode = 0
               if uis:IsKeyDown(Enum.KeyCode.Space) then yMode = 1.5
               elseif uis:IsKeyDown(Enum.KeyCode.LeftControl) then yMode = -1.5 end
               
               -- Двигаем и ПОВОРАЧИВАЕМ персонажа за камерой
               local lookAt = camera.CFrame.LookVector
               hrp.CFrame = CFrame.new(hrp.Position + (moveVec * 1.5) + Vector3.new(0, yMode, 0), hrp.Position + Vector3.new(lookAt.X, 0, lookAt.Z))
            end
            runService.Heartbeat:Wait()
         end
         
         if lp.Character then
            for _, part in pairs(lp.Character:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = true end
            end
         end
      end)
   end,
})

-- УЛУЧШЕННОЕ БЕССМЕРТИЕ
MainTab:CreateToggle({
   Name = "God Mode (Фикс урона)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      local lp = game.Players.LocalPlayer
      task.spawn(function()
         while _G.GodMode do
            local hum = lp.Character and lp.Character:FindFirstChild("Humanoid")
            if hum then
               -- Держим ХП на максимуме и блокируем смерть
               hum.Health = hum.MaxHealth
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
