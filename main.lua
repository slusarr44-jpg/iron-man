local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PlutoniumJus Experiment | ТЕСТ 19 MOD",
   LoadingTitle = "ТЕСТ 19: REBORN",
   LoadingSubtitle = "by Rustam",
   ConfigurationSaving = { Enabled = false }
})

_G.FlyEnabled = false
_G.GodMode = false
_G.ESP = false
_G.NoFall = true -- Включено по умолчанию

local lp = game.Players.LocalPlayer

local function getChar()
    local char = lp.Character or lp.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart", 5), char:WaitForChild("Humanoid", 5)
end

-- Авто-удаление урона от падения (NDS Fix)
task.spawn(function()
    while true do
        if _G.NoFall then
            local char = lp.Character
            if char and char:FindFirstChild("FallDamageScript") then
                char.FallDamageScript:Destroy()
            end
        end
        task.wait(1)
    end
end)

local MainTab = Window:CreateTab("Main")

-- ПОЛЕТ
MainTab:CreateToggle({
   Name = "NoClip-Полет",
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

-- ТОРНАДО И КИДАЛКА (С ФИКСОМ ЭРОРОВ)
local CombatTab = Window:CreateTab("Combat")

CombatTab:CreateButton({
   Name = "FE Super Ring (Торнадо)",
   Callback = function()
      task.spawn(function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
      end)
   end,
})

CombatTab:CreateButton({
   Name = "Fling (Кидалка)",
   Callback = function()
      task.spawn(function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/InvisibleFling/Main/main/Fling.lua"))()
      end)
   end,
})

-- СТАТЫ
local StatsTab = Window:CreateTab("Stats")

StatsTab:CreateSlider({
   Name = "Speed",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      local _, _, hum = getChar()
      if hum then hum.WalkSpeed = v end
   end,
})

StatsTab:CreateToggle({
   Name = "No Fall Damage",
   CurrentValue = true,
   Callback = function(v) _G.NoFall = v end,
})

-- ESP
local VisTab = Window:CreateTab("Visuals")

VisTab:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Callback = function(v)
      _G.ESP = v
      if v then
          task.spawn(function()
             while _G.ESP do
                for _, p in pairs(game.Players:GetPlayers()) do
                   if p ~= lp and p.Character and not p.Character:FindFirstChild("Highlight") then
                      Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
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
