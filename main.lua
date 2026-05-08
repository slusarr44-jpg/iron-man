local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 15",
   LoadingTitle = "ТЕСТ 15: TRUE GODMODE (0 HP)",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false

local MainTab = Window:CreateTab("Main")

-- ТОТ САМЫЙ ПОЛЕТ (БЕЗ ИЗМЕНЕНИЙ)
MainTab:CreateToggle({
   Name = "NoClip-Полет (Клавиатура)",
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
                  for _, part in pairs(char:GetDescendants()) do
                     if part:IsA("BasePart") then part.CanCollide = false end
                  end
                  
                  hrp.Velocity = Vector3.new(0, 0, 0)
                  
                  local moveVec = Vector3.new(0,0,0)
                  if uis:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + camera.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - camera.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - camera.CFrame.RightVector end
                  if uis:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + camera.CFrame.RightVector end
                  
                  local yMode = 0
                  if uis:IsKeyDown(Enum.KeyCode.Space) then yMode = 1.5
                  elseif uis:IsKeyDown(Enum.KeyCode.LeftControl) then yMode = -1.5 end
                  
                  local lookAt = camera.CFrame.LookVector
                  hrp.CFrame = CFrame.new(hrp.Position + (moveVec * 1.5) + Vector3.new(0, yMode, 0), hrp.Position + Vector3.new(lookAt.X, 0, lookAt.Z))
               end
               runService.RenderStepped:Wait()
            end
            
            if lp.Character then
               for _, part in pairs(lp.Character:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = true end
               end
            end
         end)
      end
   end,
})

-- РЕАЛЬНОЕ БЕССМЕРТИЕ (КАК ТЫ ПРОСИЛ - 0 HP)
MainTab:CreateToggle({
   Name = "Real God Mode (0 HP)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      local lp = game.Players.LocalPlayer
      
      task.spawn(function()
         while _G.GodMode do
            local char = lp.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum then
               hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) -- Запрещаем умирать
               hum.Health = 0 -- Ставим 0 ХП
            end
            task.wait()
         end
         -- Если выключил, ресет персонажа, чтобы вернуть ХП
         if not _G.GodMode and lp.Character then
            lp.Character:BreakJoints()
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
