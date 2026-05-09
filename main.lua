local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 19",
   LoadingTitle = "ТЕСТ 19: TOTAL FIX",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false
_G.ESP = false

local lp = game.Players.LocalPlayer

-- Функция для получения персонажа
local function getChar()
    local char = lp.Character or lp.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart", 5), char:WaitForChild("Humanoid", 5)
end

local MainTab = Window:CreateTab("Main")

-- ПОЛЕТ (С ФИКСОМ ПРИЗЕМЛЕНИЯ)
MainTab:CreateToggle({
   Name = "NoClip-Полет",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      if v then
         task.spawn(function()
            while _G.FlyEnabled do
               local char, hrp, hum = getChar()
               local camera = workspace.CurrentCamera
               local uis = game:GetService("UserInputService")
               
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
               game:GetService("RunService").RenderStepped:Wait()
            end
            
            -- Принудительное приземление при ВЫКЛЮЧЕНИИ
            local char, hrp, hum = getChar()
            if char then
               for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = true end
               end
               if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
            end
         end)
      end
   end,
})

-- GOD MODE (0 HP)
MainTab:CreateToggle({
   Name = "Real God Mode (0 HP)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      task.spawn(function()
         while _G.GodMode do
            local char, hrp, hum = getChar()
            if hum then
               hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
               hum.Health = 0
            end
            task.wait(0.1)
         end
      end)
   end,
})

-- ESP (ВХ С ФИКСОМ ВЫКЛЮЧЕНИЯ)
MainTab:CreateToggle({
   Name = "ESP (ВХ)",
   CurrentValue = false,
   Callback = function(v)
      _G.ESP = v
      if v then
         task.spawn(function()
            while _G.ESP do
               for _, p in pairs(game.Players:GetPlayers()) do
                  if p ~= lp and p.Character and not p.Character:FindFirstChild("Highlight") then
                     local h = Instance.new("Highlight", p.Character)
                     h.FillColor = Color3.fromRGB(255, 0, 0)
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- Удаляем всю подсветку при выключении
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Highlight") then
               p.Character.Highlight:Destroy()
            end
         end
      end
   end,
})
