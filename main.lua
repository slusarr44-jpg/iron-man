-- [[ PlutoniumJus Experiment: NDS Edition ]] --

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "PlutoniumJus Experiment", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "NDS_Experiment"
})

-- Глобальные переменные для управления функциями
_G.ESP_Enabled = false

-- Функция для отрисовки ВХ (ESP)
local function applyESP(player)
    if player ~= game.Players.LocalPlayer then
        player.CharacterAdded:Connect(function(character)
            if _G.ESP_Enabled then
                task.wait(0.5)
                if not character:FindFirstChild("ESPHighlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = character
                end
            end
        end)
    end
end

-- Вкладка Main (как на скрине)
local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MainTab:AddSection({
	Name = "Visuals"
})

-- Переключатель ВХ
MainTab:AddToggle({
	Name = "Enable ESP (ВХ)",
	Default = false,
	Callback = function(Value)
		_G.ESP_Enabled = Value
		if Value then
			-- Включаем подсветку для тех, кто уже на карте
			for _, player in pairs(game.Players:GetPlayers()) do
				if player ~= game.Players.LocalPlayer and player.Character then
					if not player.Character:FindFirstChild("ESPHighlight") then
						local highlight = Instance.new("Highlight")
						highlight.Name = "ESPHighlight"
						highlight.FillColor = Color3.fromRGB(255, 0, 0)
						highlight.Parent = player.Character
					end
				end
			end
		else
			-- Удаляем подсветку
			for _, player in pairs(game.Players:GetPlayers()) do
				if player.Character and player.Character:FindFirstChild("ESPHighlight") then
					player.Character.ESPHighlight:Destroy()
				end
			end
		end
	end    
})

-- Обработка новых игроков, которые заходят на сервер
game.Players.PlayerAdded:Connect(applyESP)

MainTab:AddSection({
	Name = "Misc"
})

-- Заглушка для следующих функций
MainTab:AddLabel("Следующие на очереди: Fly и GodMode")

OrionLib:Init()
