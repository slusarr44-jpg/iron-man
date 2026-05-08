local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment",
   LoadingTitle = "Тест на Основе",
   LoadingSubtitle = "by Rustam",
   ConfigurationSaving = { Enabled = false }
})

_G.ESP_Enabled = false
_G.FlingEnabled = false
_G.FlyEnabled = false
_G.FlySpeed = 20

-- ВКЛАДКА MAIN
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
                     local h = Instance.new("Highlight", p.Character)
                     h.FillColor = Color3.fromRGB(255, 0, 0)
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

-- ВКЛАДКА MOVEMENT
local MoveTab = Window:CreateTab("Movement")

MoveTab:CreateSlider({
   Name = "Скорость ходьбы/полета",
   Min = 16,
   Max = 200,
   Default = 20,
   Callback = function(v)
      _G.FlySpeed = v
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
      end
   end,
})

MoveTab:CreateToggle({
   Name = "AirWalk (Ходить по воздуху)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlyEnabled = v
      local lp = game.Players.LocalPlayer
      task.spawn(function()
         while _G.FlyEnabled do
            local char = lp.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               -- Создаем невидимый пол под ногами
               local ray = RaycastParams.new()
               char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, 0, char.HumanoidRootPart.Velocity.Z)
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                  char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
               end
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                  char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)
               end
            end
            task.wait()
         end
      end)
   end,
})

-- ВКЛАДКА COMBAT
local CombatTab = Window:CreateTab("Combat")

CombatTab:CreateToggle({
   Name = "Fling (Вышибала)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlingEnabled = v
      task.spawn(function()
         while _G.FlingEnabled do
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            hrp.AngularVelocity = Vector3.new(0, 99999, 0)
            hrp.Velocity = Vector3.new(500, 500, 500)
            task.wait(0.1)
            hrp.Velocity = Vector3.new(0, 0, 0)
            task.wait()
         end
      end)
   end,
})
