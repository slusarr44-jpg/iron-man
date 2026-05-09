local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Full | ТЕСТ 25",
   LoadingTitle = "ФИНАЛЬНАЯ СБОРКА",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.ESP = false
_G.FlingActive = false
_G.TornadoActive = false
_G.GodMode = false

local lp = game.Players.LocalPlayer

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
               if hrp and hum then
                  for _, part in pairs(char:GetDescendants()) do
                     if part:IsA("BasePart") then part.CanCollide = false end
                  end
                  hrp.Velocity = Vector3.new(0, 0, 0)
                  local camera = workspace.CurrentCamera
                  local uis = game:GetService("UserInputService")
                  local moveVec = Vector3.new(0,0,0)
                  if uis:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + camera.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - camera.CFrame.LookVector end
                  if uis:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - camera.CFrame.RightVector end
                  if uis:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + camera.CFrame.RightVector end
                  local yMode = 0
                  if uis:IsKeyDown(Enum.KeyCode.Space) then yMode = 1.5
                  elseif uis:IsKeyDown(Enum.KeyCode.LeftControl) then yMode = -1.5 end
                  hrp.CFrame = CFrame.new(hrp.Position + (moveVec * 1.5) + Vector3.new(0, yMode, 0), hrp.Position + Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z))
               end
               game:GetService("RunService").RenderStepped:Wait()
            end
         end)
      end
   end,
})

-- 2. ВЕРНУЛ ХП (РЕГЕН)
MainTab:CreateToggle({
   Name = "God Mode (Реген)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      task.spawn(function()
         while _G.GodMode do
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
               lp.Character.Humanoid.Health = 100
            end
            task.wait(0.1)
         end
      end)
   end,
})

-- 3. ОТКИДЫВАЛКА (БЕЗ ТРЯСКИ)
MainTab:CreateToggle({
   Name = "FE Fling (Откидывалка)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlingActive = v
      if v then
         task.spawn(function()
            local hrp = lp.Character:WaitForChild("HumanoidRootPart")
            local spin = Instance.new("BodyAngularVelocity", hrp)
            spin.Name = "StableSpin"
            spin.MaxTorque = Vector3.new(0, math.huge, 0)
            spin.AngularVelocity = Vector3.new(0, 5000, 0)
            while _G.FlingActive do task.wait() end
            if spin then spin:Destroy() end
         end)
      end
   end,
})

-- 4. ТОРНАДО (ВОКРУГ ТЕБЯ)
MainTab:CreateToggle({
   Name = "Tornado (Вращение)",
   CurrentValue = false,
   Callback = function(v)
      _G.TornadoActive = v
      if v then
         task.spawn(function()
            local offset = 0
            while _G.TornadoActive do
               offset = offset + 0.1
               local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
               if hrp then
                  for _, part in pairs(workspace:GetDescendants()) do
                     if part:IsA("BasePart") and not part:IsDescendantOf(lp.Character) and not part.Anchored then
                        local dist = (part.Position - hrp.Position).Magnitude
                        if dist < 35 then
                           local x = math.cos(offset) * 15
                           local z = math.sin(offset) * 15
                           part.Velocity = (Vector3.new(hrp.Position.X + x, hrp.Position.Y + 5, hrp.Position.Z + z) - part.Position) * 15
                        end
                     end
                  end
               end
               task.wait(0.03)
            end
         end)
      end
   end,
})

-- 5. ESP (ИЗ 19 ТЕСТА)
MainTab:CreateToggle({
   Name = "ESP (ВХ)",
   CurrentValue = false,
   Callback = function(v)
      _G.ESP = v
      if not v then
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
         end
      end
   end,
})
