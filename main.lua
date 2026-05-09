local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 22",
   LoadingTitle = "ТЕСТ 22: FLING + TORNADO",
   LoadingSubtitle = "by Рустам",
   ConfigurationSaving = { Enabled = false }
})

_G.FlingAura = false
_G.Tornado = false
local lp = game.Players.LocalPlayer

local MainTab = Window:CreateTab("Main")

-- 1. ОТКИДЫВАЛКА (YEET АУРА)
MainTab:CreateToggle({
   Name = "Fling Aura (Откидывать людей)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlingAura = v
      task.spawn(function()
         while _G.FlingAura do
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
               -- Создаем безумную силу вращения для флинга
               local velocity = hrp:FindFirstChild("FlingSpin") or Instance.new("BodyAngularVelocity", hrp)
               velocity.Name = "FlingSpin"
               velocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
               velocity.AngularVelocity = Vector3.new(0, 9999, 0) -- Скорость вращения из твоего кода

               -- Поиск цели рядом
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                     local targetHrp = player.Character.HumanoidRootPart
                     if (targetHrp.Position - hrp.Position).Magnitude < 8 then
                        -- Резкий рывок в сторону цели для срабатывания физики
                        hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 0.5)
                     end
                  end
               end
            end
            game:GetService("RunService").Heartbeat:Wait()
         end
         -- Очистка при выключении
         if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            local spin = lp.Character.HumanoidRootPart:FindFirstChild("FlingSpin")
            if spin then spin:Destroy() end
         end
      end)
   end,
})

-- 2. ТОРНАДО (ВРАЩЕНИЕ ОБЛОМКОВ)
MainTab:CreateToggle({
   Name = "Tornado (Крутить обломки)",
   CurrentValue = false,
   Callback = function(v)
      _G.Tornado = v
      task.spawn(function()
         local angle = 0
         while _G.Tornado do
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
               angle = angle + 0.2
               for _, part in pairs(workspace:GetDescendants()) do
                  if part:IsA("BasePart") and not part:IsDescendantOf(char) and not part.Anchored then
                     local dist = (part.Position - hrp.Position).Magnitude
                     if dist < 30 then
                        -- Математика вращения обломков вокруг тебя
                        local x = math.cos(angle) * 15
                        local z = math.sin(angle) * 15
                        part.Velocity = (Vector3.new(hrp.Position.X + x, hrp.Position.Y + 5, hrp.Position.Z + z) - part.Position) * 10
                     end
                  end
               end
            end
            task.wait(0.05)
         end
      end)
   end,
})
