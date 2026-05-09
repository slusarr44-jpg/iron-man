local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus | TOTAL UPDATE 34",
   LoadingTitle = "ЗАГРУЗКА РЕЖИМА ТОНИ",
   LoadingSubtitle = "by Рустам Слюсар",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false
_G.ESP = false
_G.Noclip = false

local lp = game.Players.LocalPlayer

local function getChar()
    local char = lp.Character or lp.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart", 5), char:WaitForChild("Humanoid", 5)
end

-- ВКЛАДКА MAIN (ТВОЯ БАЗА)
local MainTab = Window:CreateTab("Главная")

MainTab:CreateToggle({
   Name = "NoClip-Полет (Тони Старк)",
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

-- ВКЛАДКА DESTRUCTION (ТО, ЧТО ТЫ ПРОСИЛ)
local DestructTab = Window:CreateTab("Разнос")

DestructTab:CreateButton({
   Name = "FE Super Ring (Торнадо)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
   end,
})

DestructTab:CreateButton({
   Name = "Кидалка (Fling)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/InvisibleFling/Main/main/Fling.lua"))()
   end,
})

-- ВКЛАДКА VISUALS
local VisTab = Window:CreateTab("Визуалы")

VisTab:CreateToggle({
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

-- ВКЛАДКА UTILS (ДЛЯ СТАТОВ)
local UtilsTab = Window:CreateTab("Утилиты")

UtilsTab:CreateSlider({
   Name = "Скорость (Max Verstappen)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      local char, hrp, hum = getChar()
      if hum then hum.WalkSpeed = v end
   end,
})

Rayfield:Notify({
   Title = "Готово!",
   Content = "Рустам, старый Rayfield вернулся со всеми функциями! Тёме привет!",
   Duration = 5,
   Image = 4483362458,
})
