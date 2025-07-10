-- Put me in StartGUI
-- C00LGUI Reborned v6.3 (Dark Style)
-- Активация: Q
-- Автор: GTA_1103
-- Модификации: c00lkidd Style

local BORDER_COLOR = "#FF0000" -- HEX цвет обводки
local BG_COLOR = "#000000" -- HEX цвет фона
local TEXT_COLOR = "#FFFFFF" -- HEX цвет текста
local FONT = "SourceSans" -- Название шрифта

-- Конвертация HEX в Color3
local function hexToColor3(hex)
	hex = hex:gsub("#", "")
	return Color3.fromRGB(
		tonumber("0x"..hex:sub(1, 2)),
		tonumber("0x"..hex:sub(3, 4)),
		tonumber("0x"..hex:sub(5, 6))
	)
end

local borderColor = hexToColor3(BORDER_COLOR)
local bgColor = hexToColor3(BG_COLOR)
local textColor = hexToColor3(TEXT_COLOR)
local fontEnum = Enum.Font.SourceSans

local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- Список доступных шрифтов
local FONT_LIST = {
	"SourceSans",
	"SciFi",
	"Gotham",
	"GothamBold",
	"GothamBlack",
	"GothamMedium",
	"GothamSemibold",
	"Arcade",
	"Arial",
	"ArialBold",
	"Bodoni",
	"Cartoon",
	"Code",
	"Fantasy",
	"Highway",
	"Oswald",
	"Roboto"
}

-- Создаем главный GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "C00LGUI_Reborned_v6"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

-- Создание перетаскиваемого окна с возможностью скролла
local function createWindow(name, size, position)
	local window = Instance.new("Frame")
	window.Name = name
	window.Size = size
	window.Position = position
	window.BackgroundColor3 = bgColor
	window.BorderColor3 = borderColor
	window.BorderSizePixel = 3
	window.Active = true
	window.Draggable = true
	window.Visible = false
	window.ClipsDescendants = true
	window.Parent = GUI

	local title = Instance.new("TextLabel")
	title.Text = name
	title.Size = UDim2.new(1, 0, 0, 30)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.BackgroundColor3 = Color3.new(0.2, 0, 0)
	title.BorderColor3 = borderColor
	title.BorderSizePixel = 2
	title.TextColor3 = textColor
	title.Font = fontEnum
	title.TextSize = 18
	title.Parent = window

	local closeButton = Instance.new("TextButton")
	closeButton.Text = "X"
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -30, 0, 0)
	closeButton.BackgroundColor3 = Color3.new(0.4, 0, 0)
	closeButton.BorderColor3 = borderColor
	closeButton.BorderSizePixel = 2
	closeButton.TextColor3 = textColor
	closeButton.Font = fontEnum
	closeButton.Parent = window

	closeButton.MouseButton1Click:Connect(function()
		window.Visible = false
	end)

	-- Создаем область для скроллинга
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "ScrollFrame"
	scrollFrame.Size = UDim2.new(1, 0, 1, -35)
	scrollFrame.Position = UDim2.new(0, 0, 0, 35)
	scrollFrame.BackgroundTransparency = 1
	scrollFrame.ScrollBarThickness = 10
	scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	scrollFrame.Parent = window

	local content = Instance.new("Frame")
	content.Name = "Content"
	content.Size = UDim2.new(1, 0, 0, 0)
	content.BackgroundTransparency = 1
	content.AutomaticSize = Enum.AutomaticSize.Y
	content.Parent = scrollFrame

	return window, content
end

-- Создание кнопки
local function createButton(parent, text, color)
	local button = Instance.new("TextButton")
	button.Text = text
	button.Size = UDim2.new(0.95, 0, 0, 35)
	button.Position = UDim2.new(0.025, 0, 0, 0)
	button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	button.BorderColor3 = borderColor
	button.BorderSizePixel = 2
	button.TextColor3 = color or textColor
	button.Font = fontEnum
	button.TextSize = 16
	button.Parent = parent
	return button
end

-- Создание поля ввода
local function createInput(parent, placeholder)
	local input = Instance.new("TextBox")
	input.PlaceholderText = placeholder
	input.Size = UDim2.new(0.95, 0, 0, 30)
	input.Position = UDim2.new(0.025, 0, 0, 0)
	input.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	input.BorderColor3 = borderColor
	input.BorderSizePixel = 2
	input.TextColor3 = textColor
	input.Font = fontEnum
	input.TextSize = 14
	input.Parent = parent
	return input
end

-- Создание выпадающего списка
local function createDropdown(parent, placeholder, options)
	local dropdown = Instance.new("Frame")
	dropdown.Name = "Dropdown"
	dropdown.Size = UDim2.new(0.95, 0, 0, 30)
	dropdown.Position = UDim2.new(0.025, 0, 0, 0)
	dropdown.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	dropdown.BorderColor3 = borderColor
	dropdown.BorderSizePixel = 2
	dropdown.ClipsDescendants = true
	dropdown.Parent = parent

	local selected = Instance.new("TextButton")
	selected.Text = placeholder
	selected.Size = UDim2.new(1, 0, 1, 0)
	selected.Position = UDim2.new(0, 0, 0, 0)
	selected.BackgroundTransparency = 1
	selected.TextColor3 = textColor
	selected.Font = fontEnum
	selected.TextSize = 14
	selected.Parent = dropdown

	local list = Instance.new("Frame")
	list.Name = "List"
	list.Size = UDim2.new(1, 0, 0, 0)
	list.Position = UDim2.new(0, 0, 1, 0)
	list.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	list.BorderColor3 = borderColor
	list.BorderSizePixel = 2
	list.Visible = false
	list.Parent = dropdown

	-- Создание элементов списка
	local yPos = 0
	for _, option in ipairs(options) do
		local item = Instance.new("TextButton")
		item.Text = option
		item.Size = UDim2.new(1, 0, 0, 30)
		item.Position = UDim2.new(0, 0, 0, yPos)
		item.BackgroundTransparency = 1
		item.TextColor3 = textColor
		item.Font = fontEnum
		item.TextSize = 14
		item.Parent = list
		
		item.MouseButton1Click:Connect(function()
			selected.Text = option
			list.Visible = false
			dropdown.Size = UDim2.new(0.95, 0, 0, 30)
		end)
		
		yPos = yPos + 30
	end
	list.Size = UDim2.new(1, 0, 0, yPos)

	selected.MouseButton1Click:Connect(function()
		list.Visible = not list.Visible
		dropdown.Size = list.Visible and UDim2.new(0.95, 0, 0, 30 + yPos) or UDim2.new(0.95, 0, 0, 30)
	end)

	return selected
end

-- Создание интерфейса
local MainWindow, MainContent = createWindow("c00lkidd GUI Reborned v6.3", UDim2.new(0, 350, 0, 300), UDim2.new(0.5, -175, 0.5, -150))
MainWindow.Visible = true

local ChangesWindow, ChangesContent = createWindow("Changes", UDim2.new(0, 350, 0, 250), UDim2.new(0.5, -175, 0.5, -125))
local SettingsWindow, SettingsContent = createWindow("Settings", UDim2.new(0, 300, 0, 200), UDim2.new(0.5, -150, 0.5, -100))

-- Активация по Q
UIS.InputBegan:Connect(function(Input, GameProcessed)
	if Input.KeyCode == Enum.KeyCode.Q and not GameProcessed then
		MainWindow.Visible = not MainWindow.Visible
	end
end)

-- Создаем элементы с автоматическим позиционированием
local function createAutoPositionedElement(parent, element, height)
	local padding = 5
	local lastElement = nil
	local yPosition = padding
	
	-- Найти последний добавленный элемент
	for _, child in ipairs(parent:GetChildren()) do
		if child:IsA("GuiObject") and child ~= element then
			local childEnd = child.Position.Y.Offset + child.Size.Y.Offset
			if childEnd > yPosition then
				yPosition = childEnd + padding
			end
		end
	end
	
	element.Position = UDim2.new(0.025, 0, 0, yPosition)
	element.Parent = parent
	
	return element
end

-- Кнопки главного меню
local FlyButton = createAutoPositionedElement(MainContent, createButton(MainContent, "FLY [TOGGLE]", Color3.new(0, 1, 0)), 35)
local NoclipButton = createAutoPositionedElement(MainContent, createButton(MainContent, "NO CLIP [TOGGLE]", Color3.new(0.6, 0, 1)), 35)
local SuperSpeedButton = createAutoPositionedElement(MainContent, createButton(MainContent, "SUPER SPEED [TOGGLE]", Color3.new(0, 0.8, 1)), 35)
local ChangesButton = createAutoPositionedElement(MainContent, createButton(MainContent, "OPEN CHANGES", Color3.new(1, 0.8, 0)), 35)
local SettingsButton = createAutoPositionedElement(MainContent, createButton(MainContent, "OPEN SETTINGS", Color3.new(0.5, 0.5, 0.5)), 35)

ChangesButton.MouseButton1Click:Connect(function()
	ChangesWindow.Visible = true
end)

SettingsButton.MouseButton1Click:Connect(function()
	SettingsWindow.Visible = true
end)

-- Функция: Улучшенный Fly
local Flying = false
local FlyConnection
local FlyBodyPosition

FlyButton.MouseButton1Click:Connect(function()
	Flying = not Flying

	if Flying then
		FlyButton.TextColor3 = Color3.new(0, 1, 0)
		FlyButton.BackgroundColor3 = Color3.new(0, 0.2, 0)

		if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
			local HRP = Player.Character.HumanoidRootPart

			FlyBodyPosition = Instance.new("BodyPosition")
			FlyBodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			FlyBodyPosition.P = 10000
			FlyBodyPosition.Position = HRP.Position
			FlyBodyPosition.Parent = HRP

			local BodyGyro = Instance.new("BodyGyro")
			BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			BodyGyro.P = 10000
			BodyGyro.CFrame = HRP.CFrame
			BodyGyro.Parent = HRP

			FlyConnection = RunService.Heartbeat:Connect(function(delta)
				if not Player.Character or not HRP then return end

				local Camera = workspace.CurrentCamera
				local FlySpeed = 50
				local FlyVelocity = Vector3.new()

				if UIS:IsKeyDown(Enum.KeyCode.W) then
					FlyVelocity = FlyVelocity + Camera.CFrame.LookVector * FlySpeed
				end
				if UIS:IsKeyDown(Enum.KeyCode.S) then
					FlyVelocity = FlyVelocity - Camera.CFrame.LookVector * FlySpeed
				end
				if UIS:IsKeyDown(Enum.KeyCode.D) then
					FlyVelocity = FlyVelocity + Camera.CFrame.RightVector * FlySpeed
				end
				if UIS:IsKeyDown(Enum.KeyCode.A) then
					FlyVelocity = FlyVelocity - Camera.CFrame.RightVector * FlySpeed
				end
				if UIS:IsKeyDown(Enum.KeyCode.E) then
					FlyVelocity = FlyVelocity + Vector3.new(0, FlySpeed, 0)
				end
				if UIS:IsKeyDown(Enum.KeyCode.Q) then
					FlyVelocity = FlyVelocity + Vector3.new(0, -FlySpeed, 0)
				end

				FlyBodyPosition.Position = FlyBodyPosition.Position + FlyVelocity * delta
				BodyGyro.CFrame = Camera.CFrame
			end)
		end
	else
		if FlyConnection then
			FlyConnection:Disconnect()
			FlyButton.TextColor3 = textColor
			FlyButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

			if FlyBodyPosition then
				FlyBodyPosition:Destroy()
			end

			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				for _, v in ipairs(Player.Character.HumanoidRootPart:GetChildren()) do
					if v:IsA("BodyGyro") then
						v:Destroy()
					end
				end
			end
		end
	end
end)

-- Функция: Super Speed Toggle
local SpeedActive = false
SuperSpeedButton.MouseButton1Click:Connect(function()
	SpeedActive = not SpeedActive

	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		if SpeedActive then
			Player.Character.Humanoid.WalkSpeed = 50
			SuperSpeedButton.TextColor3 = Color3.new(0, 1, 0)
			SuperSpeedButton.BackgroundColor3 = Color3.new(0, 0.2, 0)
		else
			Player.Character.Humanoid.WalkSpeed = 16
			SuperSpeedButton.TextColor3 = textColor
			SuperSpeedButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		end
	end
end)

-- Функция: Noclip Toggle
local Noclip = false
local NoclipConnection
NoclipButton.MouseButton1Click:Connect(function()
	Noclip = not Noclip
	if Noclip then
		NoclipButton.TextColor3 = Color3.new(0, 1, 0)
		NoclipButton.BackgroundColor3 = Color3.new(0, 0.2, 0)
		NoclipConnection = RunService.Stepped:Connect(function()
			if Player.Character then
				for _, v in ipairs(Player.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		end)
	else
		if NoclipConnection then
			NoclipConnection:Disconnect()
			NoclipButton.TextColor3 = textColor
			NoclipButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		end
	end
end)

-- Функции в окне Changes
local SoundInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Sound ID"), 30)
local PitchInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Speed (1=normal)"), 30)
local SoundButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "PLAY SOUND", Color3.new(1, 0.8, 0)), 35)

local KillInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Player to Kill"), 30)
local KillButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "KILL PLAYER", Color3.new(1, 0.2, 0.2)), 35)

local SkyBoxInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "SkyBox ID"), 30)
local SkyBoxButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "SET SKYBOX", Color3.new(0, 0.5, 1)), 35)

-- Play Sound
SoundButton.MouseButton1Click:Connect(function()
	local SoundId = SoundInput.Text
	local PitchValue = tonumber(PitchInput.Text) or 1
	PitchValue = math.clamp(PitchValue, 0.5, 10)

	if tonumber(SoundId) then
		if Player.Character and Player.Character:FindFirstChild("Head") then
			local Sound = Instance.new("Sound")
			Sound.SoundId = "rbxassetid://" .. SoundId
			Sound.Pitch = PitchValue
			Sound.Volume = 1
			Sound.Parent = Player.Character.Head
			Sound:Play()
			PitchInput.Text = tostring(PitchValue)
			game:GetService("Debris"):AddItem(Sound, 10)
		end
	end
end)

-- Kill Player
KillButton.MouseButton1Click:Connect(function()
	local TargetName = KillInput.Text
	for _, v in ipairs(game.Players:GetPlayers()) do
		if string.find(string.lower(v.Name), string.lower(TargetName)) and v.Character then
			local Humanoid = v.Character:FindFirstChild("Humanoid")
			if Humanoid then
				Humanoid.Health = 0
			end
		end
	end
end)

-- SkyBox
SkyBoxButton.MouseButton1Click:Connect(function()
	local SkyId = SkyBoxInput.Text
	if tonumber(SkyId) then
		for _, obj in ipairs(Lighting:GetChildren()) do
			if obj:IsA("Sky") then
				obj:Destroy()
			end
		end

		local Sky = Instance.new("Sky")
		Sky.SkyboxBk = "rbxassetid://" .. SkyId
		Sky.SkyboxDn = "rbxassetid://" .. SkyId
		Sky.SkyboxFt = "rbxassetid://" .. SkyId
		Sky.SkyboxLf = "rbxassetid://" .. SkyId
		Sky.SkyboxRt = "rbxassetid://" .. SkyId
		Sky.SkyboxUp = "rbxassetid://" .. SkyId
		Sky.Parent = Lighting
	end
end)

-- Настройки в Settings Window
local BorderInput = createAutoPositionedElement(SettingsContent, createInput(SettingsContent, "Border HEX"), 30)
BorderInput.Text = BORDER_COLOR

local BgInput = createAutoPositionedElement(SettingsContent, createInput(SettingsContent, "Background HEX"), 30)
BgInput.Text = BG_COLOR

local TextInput = createAutoPositionedElement(SettingsContent, createInput(SettingsContent, "Text HEX"), 30)
TextInput.Text = TEXT_COLOR

local FontDropdown = createAutoPositionedElement(SettingsContent, createDropdown(SettingsContent, "Select Font", FONT_LIST), 30)
FontDropdown.Text = FONT

local ApplyButton = createAutoPositionedElement(SettingsContent, createButton(SettingsContent, "APPLY SETTINGS", Color3.new(0, 1, 0)), 35)

ApplyButton.MouseButton1Click:Connect(function()
	BORDER_COLOR = BorderInput.Text
	BG_COLOR = BgInput.Text
	TEXT_COLOR = TextInput.Text
	FONT = FontDropdown.Text
	
	-- Обновляем интерфейс без перезагрузки
	borderColor = hexToColor3(BORDER_COLOR)
	bgColor = hexToColor3(BG_COLOR)
	textColor = hexToColor3(TEXT_COLOR)
	fontEnum = Enum.Font[FONT] or Enum.Font.SourceSans
	
	-- Обновляем все окна
	local windows = {MainWindow, ChangesWindow, SettingsWindow}
	for _, window in ipairs(windows) do
		if window then
			window.BackgroundColor3 = bgColor
			window.BorderColor3 = borderColor
			
			-- Обновляем заголовок
			local title = window:FindFirstChild("TextLabel")
			if title then
				title.BackgroundColor3 = Color3.new(0.2, 0, 0)
				title.BorderColor3 = borderColor
				title.TextColor3 = textColor
				title.Font = fontEnum
			end
			
			-- Обновляем кнопку закрытия
			local closeButton = window:FindFirstChild("TextButton")
			if closeButton then
				closeButton.BackgroundColor3 = Color3.new(0.4, 0, 0)
				closeButton.BorderColor3 = borderColor
				closeButton.TextColor3 = textColor
				closeButton.Font = fontEnum
			end
			
			-- Обновляем все элементы
			local scrollFrame = window:FindFirstChild("ScrollFrame")
			if scrollFrame then
				local content = scrollFrame:FindFirstChild("Content")
				if content then
					for _, element in ipairs(content:GetChildren()) do
						if element:IsA("TextButton") or element:IsA("TextBox") then
							element.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
							element.BorderColor3 = borderColor
							element.TextColor3 = textColor
							element.Font = fontEnum
						elseif element.Name == "Dropdown" then
							element.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
							element.BorderColor3 = borderColor
							
							-- Обновляем элементы выпадающего списка
							for _, child in ipairs(element:GetDescendants()) do
								if child:IsA("TextButton") then
									child.TextColor3 = textColor
									child.Font = fontEnum
								end
							end
						end
					end
				end
			end
		end
	end
end)
