local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 17",
   LoadingTitle = "ТЕСТ 17: FIX FLY RESET",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false

local lp = game.Players.LocalPlayer

local function getChar()
    local char = lp.Character or lp.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid")
end

local MainTab = Window:CreateTab("Main")

-- ИСПРАВЛЕННЫЙ ПОЛЕТ (СБРОС ФИЗИКИ ПРИ ВЫКЛЮЧЕНИИ)
MainTab:CreateToggle({
   Name = "NoClip-Полет (Фикс сброса)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      if _G.FlyEnabled then
         task.spawn(function()
            while _G.FlyEnabled do
               local char, hrp, hum = getChar()
               local camera = workspace.CurrentCamera
               local uis = game:GetService("UserInputService")
               
               if hrp and hum and _G.FlyEnabled then
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
               game:GetService("RunService").RenderStepped:Wait()
            end
         end)
      else
         -- ПРИНУДИТЕЛЬНЫЙ СБРОС ФИЗИКИ ПРИ ВЫКЛЮЧЕНИИ
         local char, hrp, hum = getChar()
         if char then
            for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = true end
            end
            if hum then 
               hum.PlatformStand = false
               hum:ChangeState(Enum.HumanoidStateType.GettingUp) -- Заставляем встать
            end
         end
      end
   end,
})

-- РАБОЧИЙ GOD MODE (0 HP)
MainTab:CreateToggle({
   Name = "Real God Mode (0 HP)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      task.spawn(function()
         while _G.GodMode do
            local char, hrp, hum = getChar()
            if hum and _G.GodMode then
               hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
               hum.Health = 0
            end
            task.wait(0.1)
         end
      end)
   end,
})

-- ESP
MainTab:CreateToggle({
   Name = "ESP (ВХ)",
   CurrentValue = false,
   Callback = function(v)
      _G.ESP = v
      task.spawn(function()
         while _G.ESP do
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= lp and p.Character and not p.Character:FindFirstChild("Highlight") then
                  Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
               end
            end
            task.wait(1)
         end
      end)
   end,
})
