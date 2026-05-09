local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Full Edition | ТЕСТ 24",
   LoadingTitle = "ПОЛНАЯ СБОРКА: РУСТАМ EDITION",
   LoadingSubtitle = "by Рустам & Gemini",
   ConfigurationSaving = { Enabled = false }
})

-- Переменные состояний
_G.FlyEnabled = false
_G.ESP = false
_G.FlingActive = false
_G.TornadoActive = false

local lp = game.Players.LocalPlayer
local power = 500 -- Сила флинга

-- Функция для получения данных персонажа (из 19 теста)
local function getChar()
    local char = lp.Character or lp.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart", 5), char:WaitForChild("Humanoid", 5)
end

local MainTab = Window:CreateTab("Main")

-- 1. ПОЛЕТ (БАЗА ИЗ 19 ТЕСТА)
MainTab:CreateToggle({
   Name = "NoClip-Полет (WASD)",
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
                  -- Проход сквозь стены
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
            
            -- СБРОС ПРИ ВЫКЛЮЧЕНИИ
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

-- 2. ESP (ВХ С ФИКСОМ ВЫКЛЮЧЕНИЯ ИЗ 19 ТЕСТА)
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
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Highlight") then
               p.Character.Highlight:Destroy()
            end
         end
      end
   end,
})

-- 3. FE FLING (ОТКИДЫВАЛКА)
MainTab:CreateToggle({
   Name = "FE Fling (Убивать касанием)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlingActive = v
      if v then
         task.spawn(function()
            local char, hrp, hum = getChar()
            local thrust = Instance.new("BodyThrust", hrp)
            thrust.Name = "FlingForce"
            thrust.Force = Vector3.new(power, 0, power)
            thrust.Location = hrp.Position
            
            while _G.FlingActive do
               task.wait()
            end
            if thrust then thrust:Destroy() end
         end)
      end
   end,
})

-- 4. TORNADO (КРУТИТЬ ОБЛОМКИ)
MainTab:CreateToggle({
   Name = "Tornado (Притяжение деталей)",
   CurrentValue = false,
   Callback = function(v)
      _G.TornadoActive = v
      if v then
         task.spawn(function()
            while _G.TornadoActive do
               local char, hrp, hum = getChar()
               if hrp then
                  for _, part in pairs(workspace:GetDescendants()) do
                     if part:IsA("BasePart") and not part:IsDescendantOf(char) and not part.Anchored then
                        local dist = (part.Position - hrp.Position).Magnitude
                        if dist < 40 then
                           part.Velocity = (hrp.Position - part.Position).Unit * 60
                        end
                     end
                  end
               end
               task.wait(0.1)
            end
         end)
      end
   end,
})
