local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment",
   LoadingTitle = "Загрузка для Основы...",
   LoadingSubtitle = "by Rustam (Смотри не отлети!)",
   ConfigurationSaving = { Enabled = false }
})

_G.ESP_Enabled = false
_G.FlingEnabled = false
_G.NoClipEnabled = false
_G.FlySpeed = 20

-- ВХ (ESP)
local MainTab = Window:CreateTab("Main")
MainTab:CreateToggle({
   Name = "Enable ESP (ВХ)",
   CurrentValue = false,
   Callback = function(v)
      _G.ESP_Enabled = v
      task.spawn(function()
         while _G.ESP_Enabled do
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= game.Players.LocalPlayer and p.Character then
                  if not p.Character:FindFirstChild("Highlight") then
                     Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
                  end
               end
            end
            task.wait(1)
         end
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
         end
      end)
   end,
})

-- ДВИЖЕНИЕ (Walking Fly)
local MoveTab = Window:CreateTab("Movement")
MoveTab:CreateSlider({
   Name = "Скорость полета",
   Min = 16, Max = 100, Default = 20,
   Callback = function(v) _G.FlySpeed = v end,
})

MoveTab:CreateToggle({
   Name = "Walking Fly (Полет как ходьба)",
   CurrentValue = false,
   Callback = function(v)
      _G.NoClipEnabled = v
      local lp = game.Players.LocalPlayer
      local char = lp.Character or lp.CharacterAdded:Wait()
      local hum = char:WaitForChild("Humanoid")
      local hrp = char:WaitForChild("HumanoidRootPart")

      task.spawn(function()
         while _G.NoClipEnabled do
            local dir = hum.MoveDirection
            hrp.Velocity = dir * _G.FlySpeed + Vector3.new(0, 2, 0) -- Небольшая поддержка в воздухе
            
            -- Проход сквозь стены
            for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") then part.CanCollide = false end
            end
            task.wait()
         end
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
         end
      end)
   end,
})

-- COMBAT (Fling)
local CombatTab = Window:CreateTab("Combat")
CombatTab:CreateToggle({
   Name = "Fling (Вышибала)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlingEnabled = v
      task.spawn(function()
         while _G.FlingEnabled do
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            hrp.AngularVelocity = Vector3.new(0, 99999, 0) -- Бешеное вращение (невидимое)
            hrp.Velocity = Vector3.new(500, 500, 500)
            task.wait(0.1)
            hrp.Velocity = Vector3.new(0, 0, 0)
            task.wait()
         end
      end)
   end,
})
