local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 23",
   LoadingTitle = "ТЕСТ 23: FIX FLING & TORNADO",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlingActive = false
_G.TornadoActive = false
local lp = game.Players.LocalPlayer
local power = 500 -- Сила из твоего нового кода

local MainTab = Window:CreateTab("Main")

-- 1. ТА САМАЯ ОТКИДЫВАЛКА (ИЗ ТВОЕГО КОДА)
MainTab:CreateToggle({
   Name = "FE Fling (Откидывалка)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlingActive = v
      if v then
         -- Отключаем коллизию своего тела, чтобы не улетать самому
         local conn
         conn = game:GetService("RunService").Stepped:Connect(function()
            if not _G.FlingActive then conn:Disconnect() return end
            if lp.Character then
               for _, part in pairs(lp.Character:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = false end
               end
            end
         end)
         
         task.spawn(function()
            local hrp = lp.Character:WaitForChild("HumanoidRootPart")
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

-- 2. ТОРНАДО (ПРИТЯГИВАНИЕ)
MainTab:CreateToggle({
   Name = "Tornado (Притягивать обломки)",
   CurrentValue = false,
   Callback = function(v)
      _G.TornadoActive = v
      task.spawn(function()
         while _G.TornadoActive do
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
               for _, part in pairs(workspace:GetDescendants()) do
                  if part:IsA("BasePart") and not part:IsDescendantOf(char) and not part.Anchored then
                     local dist = (part.Position - hrp.Position).Magnitude
                     if dist < 40 then
                        -- Теперь они летят К ТЕБЕ, а не ОТ ТЕБЯ
                        part.Velocity = (hrp.Position - part.Position).Unit * 50
                     end
                  end
               end
            end
            task.wait(0.1)
         end
      end)
   end,
})
