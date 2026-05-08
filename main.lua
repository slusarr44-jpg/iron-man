local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment",
   LoadingTitle = "Загрузка чит-эксперимента...",
   LoadingSubtitle = "by Rustam",
   ConfigurationSaving = { Enabled = false }
})

_G.ESP_Enabled = false
_G.FlingEnabled = false

-- ВКЛАДКА MAIN (ВХ)
local MainTab = Window:CreateTab("Main")

MainTab:CreateToggle({
   Name = "Enable ESP (ВХ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP_Enabled = Value
      while _G.ESP_Enabled do
         for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
               if not player.Character:FindFirstChild("Highlight") then
                  local h = Instance.new("Highlight", player.Character)
                  h.FillColor = Color3.fromRGB(255, 0, 0)
               end
            end
         end
         task.wait(1)
         if not _G.ESP_Enabled then
            for _, p in pairs(game.Players:GetPlayers()) do
               if p.Character and p.Character:FindFirstChild("Highlight") then
                  p.Character.Highlight:Destroy()
               end
            end
         end
      end
   end,
})

-- ВКЛАДКА COMBAT (ФЛИНГ)
local CombatTab = Window:CreateTab("Combat")

CombatTab:CreateToggle({
   Name = "Fling (Вышибала челиков)",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlingEnabled = Value
      local lp = game.Players.LocalPlayer
      task.spawn(function()
         while _G.FlingEnabled do
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
               lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 10000, 0)
               task.wait(0.1)
               lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
            task.wait()
         end
      end)
   end,
})

-- ВКЛАДКА MOVEMENT (ПОЛЕТ И БЕССМЕРТИЕ)
local MoveTab = Window:CreateTab("Movement")

MoveTab:CreateButton({
   Name = "Super Fast Fly (Вверх/Вниз)",
   Callback = function()
      -- Логика быстрого полета
      local player = game.Players.LocalPlayer
      local mouse = player:GetMouse()
      local char = player.Character
      local hum = char:WaitForChild("Humanoid")
      local root = char:WaitForChild("HumanoidRootPart")
      
      local bv = Instance.new("BodyVelocity", root)
      bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      
      task.spawn(function()
         while task.wait() do
            bv.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 150
         end
      end)
   end,
})

MoveTab:CreateButton({
   Name = "God Mode (Бессмертие)",
   Callback = function()
      local lp = game.Players.LocalPlayer
      if lp.Character then
         lp.Character:FindFirstChildOfClass("Humanoid").MaxHealth = math.huge
         lp.Character:FindFirstChildOfClass("Humanoid").Health = math.huge
      end
   end,
})
