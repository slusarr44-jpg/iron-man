local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 14",
   LoadingTitle = "ТЕСТ 14: ПЛАВНЫЙ ПОЛЕТ",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false

local MainTab = Window:CreateTab("Main")

-- МАКСИМАЛЬНО ПЛАВНЫЙ ПОЛЕТ
MainTab:CreateToggle({
   Name = "NoClip-Полет (Ultra Smooth)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      local lp = game.Players.LocalPlayer
      local runService = game:GetService("RunService")
      local uis = game:GetService("UserInputService")
      
      if _G.FlyEnabled then
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
                  
                  -- Полная остановка стандартной физики (чтобы не трясло)
                  hrp.Velocity = Vector3.new(0, 0, 0)
                  hrp.RotVelocity = Vector3.new(0, 0, 0)
                  
                  -- Ввод управления
                  local moveVec = Vector3.new(0,0,0)
                  if uis:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + camera.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - camera.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - camera.CFrame.RightVector end
                  if uis:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + camera.CFrame.RightVector end
                  
                  local yMode = 0
                  if uis:IsKeyDown(Enum.KeyCode.Space) then yMode = 1.5
                  elseif uis:IsKeyDown(Enum.KeyCode.LeftControl) then yMode = -1.5 end
                  
                  -- Плавное перемещение CFrame
                  local lookAt = camera.CFrame.LookVector
                  hrp.CFrame = CFrame.new(hrp.Position + (moveVec * 1.5) + Vector3.new(0, yMode, 0), hrp.Position + Vector3.new(lookAt.X, 0, lookAt.Z))
               end
               runService.RenderStepped:Wait()
            end
            
            -- СБРОС ПРИ ВЫКЛЮЧЕНИИ (чтобы не парить)
            if lp.Character then
               for _, part in pairs(lp.Character:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = true end
               end
               local hum = lp.Character:FindFirstChild("Humanoid")
               if hum then hum.PlatformStand = false end
            end
         end)
      end
   end,
})

-- БЕССМЕРТИЕ
MainTab:CreateToggle({
   Name = "God Mode (Стабильный)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      task.spawn(function()
         while _G.GodMode do
            local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
               hum.Health = hum.MaxHealth
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
