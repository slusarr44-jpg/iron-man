local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local PlayerInput = Instance.new("TextBox")
local RepairBtn = Instance.new("TextButton")
local GodModeBtn = Instance.new("TextButton")

-- Настройка интерфейса (Белый и Прозрачный)
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "IronManMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.3
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "IRON MAN HUB"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 0, 0)

PlayerInput.Parent = MainFrame
PlayerInput.PlaceholderText = "Ник игрока..."
PlayerInput.Position = UDim2.new(0.1, 0, 0.3, 0)
PlayerInput.Size = UDim2.new(0.8, 0, 0, 30)
PlayerInput.Text = ""

RepairBtn.Parent = MainFrame
RepairBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
RepairBtn.Size = UDim2.new(0.8, 0, 0, 30)
RepairBtn.Text = "ПОЧИНИТЬ МАРК"
RepairBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)

GodModeBtn.Parent = MainFrame
GodModeBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
GodModeBtn.Size = UDim2.new(0.8, 0, 0, 30)
GodModeBtn.Text = "GODMODE: OFF"
GodModeBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)

-- Логика починки
RepairBtn.MouseButton1Click:Connect(function()
    local targetName = PlayerInput.Text
    local targetPlayer = game.Players:FindFirstChild(targetName) or game.Players.LocalPlayer
    
    local char = targetPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                v.Value = 999999
            end
        end
        print("Починка отправлена для: " .. targetPlayer.Name)
    end
end)

-- Логика GodMode
local godModeActive = false
GodModeBtn.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    GodModeBtn.Text = godModeActive and "GODMODE: ON" or "GODMODE: OFF"
    
    spawn(function()
        while godModeActive do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.Health = 100
            end
            task.wait(0.1)
        end
    end)
end)
