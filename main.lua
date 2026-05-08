local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 9",
   LoadingTitle = "ТЕСТ 9: ПАНЕЛЬНОЕ УПРАВЛЕНИЕ",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false
_G.ESP = false

local MainTab = Window:CreateTab("Main")

-- ПОЛЕТ ЧЕРЕЗ ПАНЕЛЬ (БЕЗ ИНСТРУМЕНТОВ)
MainTab:CreateToggle({
   Name = "NoClip-Полет (За мышкой)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      local lp = game.Players.LocalPlayer
      local mouse = lp:GetMouse()
      local char = lp.Character
      local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
      local hum = char:FindFirstChild("Humanoid")

      if _G.FlyEnabled then
         local bodyPos = Instance.new("BodyPosition", hrp)
         local bodyGyro = Instance.new("BodyGyro", hrp)
         local particles = Instance.new("ParticleEmitter", hrp)
         
         bodyPos.Name = "FlyPos"
         bodyGyro.Name = "FlyGyro"
         bodyPos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
         bodyGyro.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
         particles.Texture = "rbxassetid://243098098"
         particles.Rate = 100

         hum.PlatformStand = true

         task.spawn(function()
            while _G.FlyEnabled do
               local targetPos = mouse.Hit.p
               bodyPos.Position = hrp.Position + (targetPos - hrp.Position).unit * 50
               bodyGyro.CFrame = CFrame.new(hrp.Position, targetPos) * CFrame.Angles(-math.pi/2, 0, 0)
               
               -- NoClip (проход сквозь стены) пока летим
               for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = false end
               end
               task.wait()
            end
            
            -- Очистка при выключении
            bodyPos:Destroy()
            bodyGyro:Destroy()
            particles:Destroy()
            hum.PlatformStand = false
            for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = true end
            end
         end)
      end
   end,
})

-- БЕССМЕРТИЕ
MainTab:CreateToggle({
   Name = "God Mode (Бессмертие)",
   CurrentValue = false,
   Callback = function(v)
      _G.GodMode = v
      task.spawn(function()
         while _G.GodMode do
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
               game.Players.LocalPlayer.Character.Humanoid.Health = 100
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
