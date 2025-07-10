-- Put me in StartGUI
-- C00lkidd GUI Reborned v6.4 (Dark Style)
-- Activation: Q
-- Author: GTA_1103
-- Modifications: c00lkidd Style

local BORDER_COLOR = "#FF0000" -- HEX border color
local BG_COLOR = "#000000" -- HEX background color
local TEXT_COLOR = "#FFFFFF" -- HEX text color
local FONT = "SourceSans" -- Font name
local CHEAT_VERSION = "v6.4" -- Cheat version

-- Convert HEX to Color3
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
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")

-- Anti-Zengi protection
if Player.Name == "Zendzhailov" then
	-- Self-destruct for Zendzhailov
	script:Destroy()
	return
end

-- Create main GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "C00LGUI_Reborned_v6"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

-- Welcome screen
local function createWelcomeScreen()
	-- Overlay
	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.Position = UDim2.new(0, 0, 0, 0)
	overlay.BackgroundColor3 = Color3.new(0, 0, 0)
	overlay.BackgroundTransparency = 0.5
	overlay.ZIndex = 10
	overlay.Parent = GUI

	-- Welcome window
	local welcomeWindow = Instance.new("Frame")
	welcomeWindow.Size = UDim2.new(0, 400, 0, 200)
	welcomeWindow.Position = UDim2.new(0.5, -200, 0.5, -100)
	welcomeWindow.BackgroundColor3 = bgColor
	welcomeWindow.BorderColor3 = borderColor
	welcomeWindow.BorderSizePixel = 3
	welcomeWindow.ZIndex = 11
	welcomeWindow.Parent = GUI

	local title = Instance.new("TextLabel")
	title.Text = "C00lkidd GUI Reborned " .. CHEAT_VERSION .. " welcomes you, " .. Player.Name .. "!"
	title.Size = UDim2.new(1, 0, 0.3, 0)
	title.Position = UDim2.new(0, 0, 0.1, 0)
	title.BackgroundTransparency = 1
	title.TextColor3 = textColor
	title.Font = fontEnum
	title.TextSize = 18
	title.TextWrapped = true
	title.ZIndex = 12
	title.Parent = welcomeWindow

	local closeButton = Instance.new("TextButton")
	closeButton.Text = "OK"
	closeButton.Size = UDim2.new(0.4, 0, 0.2, 0)
	closeButton.Position = UDim2.new(0.3, 0, 0.7, 0)
	closeButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	closeButton.BorderColor3 = borderColor
	closeButton.BorderSizePixel = 2
	closeButton.TextColor3 = textColor
	closeButton.Font = fontEnum
	closeButton.TextSize = 16
	closeButton.ZIndex = 12
	closeButton.Parent = welcomeWindow

	closeButton.MouseButton1Click:Connect(function()
		overlay:Destroy()
		welcomeWindow:Destroy()
		createAntiZengiWarning()
	end)
end

-- Anti-Zengi warning
local function createAntiZengiWarning()
	-- Overlay
	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.Position = UDim2.new(0, 0, 0, 0)
	overlay.BackgroundColor3 = Color3.new(0, 0, 0)
	overlay.BackgroundTransparency = 0.5
	overlay.ZIndex = 10
	overlay.Parent = GUI

	-- Warning window
	local warnWindow = Instance.new("Frame")
	warnWindow.Size = UDim2.new(0, 500, 0, 300)
	warnWindow.Position = UDim2.new(0.5, -250, 0.5, -150)
	warnWindow.BackgroundColor3 = Color3.new(1, 1, 0) -- Yellow
	warnWindow.BorderColor3 = Color3.new(0, 0, 0)
	warnWindow.BorderSizePixel = 3
	warnWindow.ZIndex = 11
	warnWindow.Parent = GUI

	local title = Instance.new("TextLabel")
	title.Text = "#AntiZengi we are against Zengi!"
	title.Size = UDim2.new(1, 0, 0.2, 0)
	title.Position = UDim2.new(0, 0, 0.1, 0)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.new(0, 0, 0)
	title.Font = fontEnum
	title.TextSize = 20
	title.ZIndex = 12
	title.Parent = warnWindow

	local linkButton = Instance.new("TextButton")
	linkButton.Text = "https://www.youtube.com/@dostounakepka/videos"
	linkButton.Size = UDim2.new(0.8, 0, 0.2, 0)
	linkButton.Position = UDim2.new(0.1, 0, 0.4, 0)
	linkButton.BackgroundTransparency = 1
	linkButton.TextColor3 = Color3.new(0, 0, 1)
	linkButton.Font = fontEnum
	linkButton.TextSize = 16
	linkButton.ZIndex = 12
	linkButton.Parent = warnWindow

	linkButton.MouseButton1Click:Connect(function()
		GuiService:OpenBrowserWindow("https://www.youtube.com/@dostounakepka/videos")
	end)

	local info = Instance.new("TextLabel")
	info.Text = "SPREAD THIS INFORMATION!!!"
	info.Size = UDim2.new(1, 0, 0.2, 0)
	info.Position = UDim2.new(0, 0, 0.6, 0)
	info.BackgroundTransparency = 1
	info.TextColor3 = Color3.new(0, 0, 0)
	info.Font = fontEnum
	info.TextSize = 18
	info.ZIndex = 12
	info.Parent = warnWindow

	local continueButton = Instance.new("TextButton")
	continueButton.Text = "Continue"
	continueButton.Size = UDim2.new(0.4, 0, 0.2, 0)
	continueButton.Position = UDim2.new(0.3, 0, 0.8, 0)
	continueButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
	continueButton.BorderColor3 = Color3.new(0, 0, 0)
	continueButton.BorderSizePixel = 2
	continueButton.TextColor3 = Color3.new(1, 1, 1)
	continueButton.Font = fontEnum
	continueButton.TextSize = 16
	continueButton.ZIndex = 12
	continueButton.Parent = warnWindow

	continueButton.MouseButton1Click:Connect(function()
		overlay:Destroy()
		warnWindow:Destroy()
	end)
end

-- Create draggable window with scrolling
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

	-- Create scrolling area
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

-- Create button
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

-- Create input field
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

-- Create dropdown list
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

	-- Create list items
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

-- Create elements with automatic positioning
local function createAutoPositionedElement(parent, element)
	local padding = 5
	local lastElement = nil
	local yPosition = padding
	
	-- Find last added element
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

-- Create interface
local MainWindow, MainContent = createWindow("c00lkidd GUI Reborned " .. CHEAT_VERSION, UDim2.new(0, 350, 0, 300), UDim2.new(0.5, -175, 0.5, -150))
local ChangesWindow, ChangesContent = createWindow("Changes", UDim2.new(0, 350, 0, 250), UDim2.new(0.5, -175, 0.5, -125))
local SettingsWindow, SettingsContent = createWindow("Settings", UDim2.new(0, 300, 0, 200), UDim2.new(0.5, -150, 0.5, -100))
local PlayersWindow, PlayersContent = createWindow("Players", UDim2.new(0, 350, 0, 300), UDim2.new(0.5, -175, 0.5, -150))

-- Show welcome screen on start
createWelcomeScreen()

-- Activation by Q
UIS.InputBegan:Connect(function(Input, GameProcessed)
	if Input.KeyCode == Enum.KeyCode.Q and not GameProcessed then
		MainWindow.Visible = not MainWindow.Visible
	end
end)

-- Main menu buttons
local FlyButton = createAutoPositionedElement(MainContent, createButton(MainContent, "FLY [TOGGLE]", Color3.new(0, 1, 0)))
local NoclipButton = createAutoPositionedElement(MainContent, createButton(MainContent, "NO CLIP [TOGGLE]", Color3.new(0.6, 0, 1)))
local SuperSpeedButton = createAutoPositionedElement(MainContent, createButton(MainContent, "SUPER SPEED [TOGGLE]", Color3.new(0, 0.8, 1)))
local GodButton = createAutoPositionedElement(MainContent, createButton(MainContent, "GOD MODE [TOGGLE]", Color3.new(1, 0, 0)))
local ESPButton = createAutoPositionedElement(MainContent, createButton(MainContent, "ESP [TOGGLE]", Color3.new(1, 0.8, 0)))
local InfoButton = createAutoPositionedElement(MainContent, createButton(MainContent, "INFO DISPLAY [TOGGLE]", Color3.new(0.5, 0.5, 0.5)))
local ChangesButton = createAutoPositionedElement(MainContent, createButton(MainContent, "OPEN CHANGES", Color3.new(1, 0.8, 0)))
local PlayersButton = createAutoPositionedElement(MainContent, createButton(MainContent, "OPEN PLAYERS", Color3.new(0, 0.5, 1)))
local SettingsButton = createAutoPositionedElement(MainContent, createButton(MainContent, "OPEN SETTINGS", Color3.new(0.5, 0.5, 0.5)))

ChangesButton.MouseButton1Click:Connect(function()
	ChangesWindow.Visible = true
end)

PlayersButton.MouseButton1Click:Connect(function()
	PlayersWindow.Visible = true
	updatePlayerList()
end)

SettingsButton.MouseButton1Click:Connect(function()
	SettingsWindow.Visible = true
end)

-- Improved Fly function
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

-- Super Speed Toggle
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

-- Noclip Toggle
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

-- GOD MODE Toggle
local GodMode = false
local GodConnection
GodButton.MouseButton1Click:Connect(function()
	GodMode = not GodMode
	
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		local humanoid = Player.Character.Humanoid
		
		if GodMode then
			GodButton.TextColor3 = Color3.new(0, 1, 0)
			GodButton.BackgroundColor3 = Color3.new(0, 0.2, 0)
			
			GodConnection = humanoid.HealthChanged:Connect(function()
				if humanoid.Health < 100 then
					humanoid.Health = 100
				end
			end)
			
			humanoid.Health = 100
		else
			if GodConnection then
				GodConnection:Disconnect()
				GodButton.TextColor3 = textColor
				GodButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
			end
		end
	end
end)

-- ESP Toggle
local ESPEnabled = false
local ESPHighlights = {}
ESPButton.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	
	if ESPEnabled then
		ESPButton.TextColor3 = Color3.new(0, 1, 0)
		ESPButton.BackgroundColor3 = Color3.new(0, 0.2, 0)
		
		-- Create ESP for all players
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player ~= Player and player.Character then
				local highlight = Instance.new("Highlight")
				highlight.Name = "ESP_" .. player.Name
				highlight.FillColor = Color3.new(1, 0, 0)
				highlight.OutlineColor = Color3.new(1, 0, 0)
				highlight.FillTransparency = 0.5
				highlight.Parent = player.Character
				ESPHighlights[player] = highlight
			end
		end
	else
		ESPButton.TextColor3 = textColor
		ESPButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		
		-- Remove all ESP
		for player, highlight in pairs(ESPHighlights) do
			highlight:Destroy()
		end
		ESPHighlights = {}
	end
end)

-- Info Display Toggle
local InfoDisplayEnabled = false
local InfoDisplayLabel = Instance.new("TextLabel")
InfoDisplayLabel.Size = UDim2.new(0.4, 0, 0.05, 0)
InfoDisplayLabel.Position = UDim2.new(0.01, 0, 0.01, 0)
InfoDisplayLabel.BackgroundColor3 = Color3.new(0, 0, 0)
InfoDisplayLabel.BackgroundTransparency = 0.7
InfoDisplayLabel.TextColor3 = Color3.new(1, 1, 1)
InfoDisplayLabel.Font = Enum.Font.SourceSans
InfoDisplayLabel.TextSize = 14
InfoDisplayLabel.Text = "c00lkidd " .. CHEAT_VERSION .. " | Position: (0, 0, 0)"
InfoDisplayLabel.Visible = false
InfoDisplayLabel.Parent = GUI

InfoButton.MouseButton1Click:Connect(function()
	InfoDisplayEnabled = not InfoDisplayEnabled
	InfoDisplayLabel.Visible = InfoDisplayEnabled
	
	if InfoDisplayEnabled then
		InfoButton.TextColor3 = Color3.new(0, 1, 0)
		InfoButton.BackgroundColor3 = Color3.new(0, 0.2, 0)
		
		RunService.Heartbeat:Connect(function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				local pos = Player.Character.HumanoidRootPart.Position
				InfoDisplayLabel.Text = string.format("c00lkidd %s | Position: (%.1f, %.1f, %.1f)", CHEAT_VERSION, pos.X, pos.Y, pos.Z)
			end
		end)
	else
		InfoButton.TextColor3 = textColor
		InfoButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	end
end)

-- JailBroken HD Admin
local HDAdminButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "JAILBROKEN HD ADMIN", Color3.new(0, 0.5, 1)))
HDAdminButton.MouseButton1Click:Connect(function()
	local remote = game:GetService("ReplicatedStorage"):FindFirstChild("HDAdminRemote")
	if remote then
		remote:FireServer("RunCommand", "!admin " .. Player.Name)
	end
end)

-- Play Sound function
local SoundInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Sound ID"))
local PitchInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Speed (1=normal)"))
local SoundButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "PLAY SOUND", Color3.new(1, 0.8, 0)))

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

-- Kill Player by name
local KillInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Player to Kill"))
local KillButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "KILL PLAYER", Color3.new(1, 0.2, 0.2)))

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

-- SkyBox function
local SkyBoxInput = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "SkyBox ID"))
local SkyBoxButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "SET SKYBOX", Color3.new(0, 0.5, 1)))

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

-- Teleport to coordinates
local TeleportX = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "X Coordinate"))
local TeleportY = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Y Coordinate"))
local TeleportZ = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Z Coordinate"))
local TeleportButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "TELEPORT TO COORDINATES", Color3.new(0, 0.8, 1)))

TeleportButton.MouseButton1Click:Connect(function()
	local x = tonumber(TeleportX.Text)
	local y = tonumber(TeleportY.Text)
	local z = tonumber(TeleportZ.Text)
	
	if x and y and z and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
	end
end)

-- Player list functions
local function updatePlayerList()
	-- Clear previous content
	for _, child in ipairs(PlayersContent:GetChildren()) do
		child:Destroy()
	end
	
	local yPos = 0
	for _, player in ipairs(game.Players:GetPlayers()) do
		if player ~= Player then
			-- Player name label
			local playerLabel = Instance.new("TextLabel")
			playerLabel.Text = player.Name
			playerLabel.Size = UDim2.new(0.95, 0, 0, 30)
			playerLabel.Position = UDim2.new(0.025, 0, 0, yPos)
			playerLabel.BackgroundTransparency = 1
			playerLabel.TextColor3 = textColor
			playerLabel.Font = fontEnum
			playerLabel.TextSize = 16
			playerLabel.TextXAlignment = Enum.TextXAlignment.Left
			playerLabel.Parent = PlayersContent
			
			yPos = yPos + 35
			
			-- Kill button
			local killButton = createButton(PlayersContent, "KILL " .. player.Name, Color3.new(1, 0.2, 0.2))
			killButton.Position = UDim2.new(0.025, 0, 0, yPos)
			killButton.MouseButton1Click:Connect(function()
				if player.Character and player.Character:FindFirstChild("Humanoid") then
					player.Character.Humanoid.Health = 0
				end
			end)
			
			yPos = yPos + 40
			
			-- Teleport button
			local tpButton = createButton(PlayersContent, "TELEPORT TO " .. player.Name, Color3.new(0, 0.5, 1))
			tpButton.Position = UDim2.new(0.025, 0, 0, yPos)
			tpButton.MouseButton1Click:Connect(function()
				if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and
				   player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					Player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
				end
			end)
			
			yPos = yPos + 45
		end
	end
end

-- Theme settings
local THEMES = {
	["Classic Red"] = {
		BORDER = "#FF0000",
		BG = "#000000",
		TEXT = "#FFFFFF"
	},
	["Dark Blue"] = {
		BORDER = "#0044FF",
		BG = "#000022",
		TEXT = "#CCCCFF"
	},
	["Green Matrix"] = {
		BORDER = "#00FF00",
		BG = "#001100",
		TEXT = "#00FF00"
	},
	["Purple Haze"] = {
		BORDER = "#9900FF",
		BG = "#110022",
		TEXT = "#FF99FF"
	},
	["Gold Premium"] = {
		BORDER = "#FFD700",
		BG = "#222200",
		TEXT = "#FFFF99"
	}
}

local ThemeDropdown = createAutoPositionedElement(SettingsContent, createDropdown(SettingsContent, "Select Theme", {"Classic Red", "Dark Blue", "Green Matrix", "Purple Haze", "Gold Premium"}))
ThemeDropdown.Text = "Classic Red"

local ApplyButton = createAutoPositionedElement(SettingsContent, createButton(SettingsContent, "APPLY SETTINGS", Color3.new(0, 1, 0)))

ApplyButton.MouseButton1Click:Connect(function()
	local themeName = ThemeDropdown.Text
	local theme = THEMES[themeName]
	
	if theme then
		BORDER_COLOR = theme.BORDER
		BG_COLOR = theme.BG
		TEXT_COLOR = theme.TEXT
		
		-- Update colors
		borderColor = hexToColor3(BORDER_COLOR)
		bgColor = hexToColor3(BG_COLOR)
		textColor = hexToColor3(TEXT_COLOR)
		
		-- Update all windows
		local windows = {MainWindow, ChangesWindow, SettingsWindow, PlayersWindow}
		for _, window in ipairs(windows) do
			if window then
				window.BackgroundColor3 = bgColor
				window.BorderColor3 = borderColor
				
				-- Update title
				local title = window:FindFirstChild("TextLabel")
				if title then
					title.BackgroundColor3 = Color3.new(0.2, 0, 0)
					title.BorderColor3 = borderColor
					title.TextColor3 = textColor
				end
				
				-- Update close button
				local closeButton = window:FindFirstChild("TextButton")
				if closeButton then
					closeButton.BackgroundColor3 = Color3.new(0.4, 0, 0)
					closeButton.BorderColor3 = borderColor
					closeButton.TextColor3 = textColor
				end
				
				-- Update all elements
				local scrollFrame = window:FindFirstChild("ScrollFrame")
				if scrollFrame then
					local content = scrollFrame:FindFirstChild("Content")
					if content then
						for _, element in ipairs(content:GetChildren()) do
							if element:IsA("TextButton") or element:IsA("TextBox") then
								element.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
								element.BorderColor3 = borderColor
								element.TextColor3 = textColor
							elseif element.Name == "Dropdown" then
								element.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
								element.BorderColor3 = borderColor
								
								for _, child in ipairs(element:GetDescendants()) do
									if child:IsA("TextButton") then
										child.TextColor3 = textColor
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

-- Make main window visible after initialization
MainWindow.Visible = true
