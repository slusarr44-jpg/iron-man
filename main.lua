local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment",
   LoadingTitle = "Rustam Edition",
   LoadingSubtitle = "by slusarr44",
   ConfigurationSaving = { Enabled = false }
})

_G.ESP_Enabled = false
_G.FlingEnabled = false
_G.AirWalkEnabled = false
_G.FlySpeed = 20

-- Вкладка Home для порядка
local HomeTab = Window:CreateTab("Home", 4483362458) 
HomeTab:CreateLabel("Привет, Рустам! Твой кот Тёма следит за читами.")

-- ВКЛАДКА MAIN (ВХ)
local MainTab = Window:CreateTab("Main", 4483345998)

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

-- ВКЛАДКА MOVEMENT (ПОЛЕТ)
local MoveTab = Window:CreateTab("Movement", 4483345998)

MoveTab:CreateSlider({
   Name = "Скорость",
   Min = 16, Max = 200, Default = 20,
   Callback = function(v) 
      _G.FlySpeed = v 
      if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
      end
   end,
})

MoveTab:CreateToggle({
   Name = "AirWalk (Полет)",
   CurrentValue = false,
   Callback = function(v)
      _G.AirWalkEnabled = v
      local lp = game.Players.LocalPlayer
      task.spawn(function()
         while _G.AirWalkEnabled do
            local char = lp.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               local hrp = char.HumanoidRootPart
               -- Замораживаем по оси Y (чтобы не падать)
               hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
               
               -- Управление высотой
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                  hrp.CFrame = hrp.CFrame * CFrame.new(0, 1.5, 0)
               elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                  hrp.CFrame = hrp.CFrame * CFrame.new(0, -1.5, 0)
               end
            end
            task.wait()
         end
      end)
   end,
})

-- ВКЛАДКА COMBAT (ФЛИНГ)
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Fling (Вышибала)",
   CurrentValue = false,
   Callback = function(v)
      _G.FlingEnabled = v
      task.spawn(function()
         while _G.FlingEnabled do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               local hrp = char.HumanoidRootPart
               -- Крутимся бешено
               hrp.AngularVelocity = Vector3.new(0, 999999, 0)
               hrp.Velocity = Vector3.new(1000, 1000, 1000)
               task.wait(0.1)
               hrp.Velocity = Vector3.new(0, 0, 0)
            end
            task.wait()
         end
      end)
   end,
})
