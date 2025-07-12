-- ForkSaken 1.0 (Purple Theme)
-- Activation: Q
-- Features: Fly, Noclip, ESP, Teleport, God Mode, Info Display

local BORDER_COLOR = "#AA00FF" -- Фиолетовый
local BG_COLOR = "#110022" -- Темно-фиолетовый
local TEXT_COLOR = "#FFFFFF" -- Белый
local FONT = "SourceSans"

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

-- Основной GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "ForkSaken_v1"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

-- Создание окна
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
    title.BackgroundColor3 = Color3.new(0.15, 0, 0.3)
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
    closeButton.BackgroundColor3 = Color3.new(0.3, 0, 0.6)
    closeButton.BorderColor3 = borderColor
    closeButton.BorderSizePixel = 2
    closeButton.TextColor3 = textColor
    closeButton.Font = fontEnum
    closeButton.Parent = window

    closeButton.MouseButton1Click:Connect(function()
        window.Visible = false
    end)

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
    button.BackgroundColor3 = Color3.new(0.1, 0.05, 0.2)
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
    input.BackgroundColor3 = Color3.new(0.1, 0.05, 0.2)
    input.BorderColor3 = borderColor
    input.BorderSizePixel = 2
    input.TextColor3 = textColor
    input.Font = fontEnum
    input.TextSize = 14
    input.Parent = parent
    return input
end

-- Автопозиционирование элементов
local function createAutoPositionedElement(parent, element)
    local padding = 5
    local yPosition = padding
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("GuiObject") then
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

-- Создаем окна
local MainWindow, MainContent = createWindow("ForkSaken 1.0", UDim2.new(0, 300, 0, 300), UDim2.new(0.5, -150, 0.5, -150))
local ChangesWindow, ChangesContent = createWindow("Changes", UDim2.new(0, 300, 0, 200), UDim2.new(0.5, -150, 0.5, -100))

-- Активация по Q
UIS.InputBegan:Connect(function(Input, GameProcessed)
    if Input.KeyCode == Enum.KeyCode.Q and not GameProcessed then
        MainWindow.Visible = not MainWindow.Visible
    end
end)

-- Fly
local Flying = false
local FlyConnection
local FlyBodyPosition

local FlyButton = createAutoPositionedElement(MainContent, createButton(MainContent, "FLY [TOGGLE]", Color3.new(0.8, 0.4, 1)))
FlyButton.MouseButton1Click:Connect(function()
    Flying = not Flying
    if Flying then
        FlyButton.TextColor3 = Color3.new(0, 1, 0)
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = Player.Character.HumanoidRootPart
            FlyBodyPosition = Instance.new("BodyPosition")
            FlyBodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            FlyBodyPosition.Position = HRP.Position
            FlyBodyPosition.Parent = HRP

            local BodyGyro = Instance.new("BodyGyro")
            BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyGyro.CFrame = HRP.CFrame
            BodyGyro.Parent = HRP

            FlyConnection = RunService.Heartbeat:Connect(function(delta)
                if not Player.Character then return end
                local Camera = workspace.CurrentCamera
                local FlySpeed = 50
                local FlyVelocity = Vector3.new()

                if UIS:IsKeyDown(Enum.KeyCode.W) then FlyVelocity += Camera.CFrame.LookVector * FlySpeed end
                if UIS:IsKeyDown(Enum.KeyCode.S) then FlyVelocity -= Camera.CFrame.LookVector * FlySpeed end
                if UIS:IsKeyDown(Enum.KeyCode.D) then FlyVelocity += Camera.CFrame.RightVector * FlySpeed end
                if UIS:IsKeyDown(Enum.KeyCode.A) then FlyVelocity -= Camera.CFrame.RightVector * FlySpeed end
                if UIS:IsKeyDown(Enum.KeyCode.E) then FlyVelocity += Vector3.new(0, FlySpeed, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.Q) then FlyVelocity += Vector3.new(0, -FlySpeed, 0) end

                FlyBodyPosition.Position += FlyVelocity * delta
                BodyGyro.CFrame = Camera.CFrame
            end)
        end
    else
        if FlyConnection then FlyConnection:Disconnect() end
        FlyButton.TextColor3 = textColor
        if FlyBodyPosition then FlyBodyPosition:Destroy() end
    end
end)

-- Noclip
local Noclip = false
local NoclipConnection
local NoclipButton = createAutoPositionedElement(MainContent, createButton(MainContent, "NO CLIP [TOGGLE]", Color3.new(0.6, 0.2, 1)))
NoclipButton.MouseButton1Click:Connect(function()
    Noclip = not Noclip
    if Noclip then
        NoclipButton.TextColor3 = Color3.new(0, 1, 0)
        NoclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then
                for _, v in ipairs(Player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    else
        if NoclipConnection then NoclipConnection:Disconnect() end
        NoclipButton.TextColor3 = textColor
    end
end)

-- God Mode
local GodMode = false
local GodButton = createAutoPositionedElement(MainContent, createButton(MainContent, "GOD MODE [TOGGLE]", Color3.new(1, 0.4, 0.8)))
GodButton.MouseButton1Click:Connect(function()
    GodMode = not GodMode
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        local humanoid = Player.Character.Humanoid
        if GodMode then
            GodButton.TextColor3 = Color3.new(0, 1, 0)
            humanoid.HealthChanged:Connect(function()
                if humanoid.Health < 100 then humanoid.Health = 100 end
            end)
            humanoid.Health = 100
        else
            GodButton.TextColor3 = textColor
        end
    end
end)

-- ESP
local ESPEnabled = false
local ESPHighlights = {}
local ESPButton = createAutoPositionedElement(MainContent, createButton(MainContent, "ESP [TOGGLE]", Color3.new(0.4, 0.8, 1)))
ESPButton.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        ESPButton.TextColor3 = Color3.new(0, 1, 0)
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= Player and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP_" .. player.Name
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 0.7
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Parent = player.Character
                ESPHighlights[player] = highlight
            end
        end
    else
        ESPButton.TextColor3 = textColor
        for player, highlight in pairs(ESPHighlights) do
            if highlight then highlight:Destroy() end
        end
        ESPHighlights = {}
    end
end)

-- Info Display
local InfoDisplayEnabled = false
local InfoDisplayLabel = Instance.new("TextLabel")
InfoDisplayLabel.Size = UDim2.new(0.4, 0, 0.05, 0)
InfoDisplayLabel.Position = UDim2.new(0.01, 0, 0.01, 0)
InfoDisplayLabel.BackgroundColor3 = Color3.new(0, 0, 0)
InfoDisplayLabel.BackgroundTransparency = 0.7
InfoDisplayLabel.TextColor3 = Color3.new(1, 1, 1)
InfoDisplayLabel.Font = fontEnum
InfoDisplayLabel.TextSize = 14
InfoDisplayLabel.Text = "ForkSaken 1.0"
InfoDisplayLabel.Visible = false
InfoDisplayLabel.Parent = GUI

local InfoButton = createAutoPositionedElement(MainContent, createButton(MainContent, "INFO DISPLAY [TOGGLE]", Color3.new(1, 0.8, 0.4)))
InfoButton.MouseButton1Click:Connect(function()
    InfoDisplayEnabled = not InfoDisplayEnabled
    InfoDisplayLabel.Visible = InfoDisplayEnabled
    if InfoDisplayEnabled then
        InfoButton.TextColor3 = Color3.new(0, 1, 0)
        RunService.Heartbeat:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local pos = Player.Character.HumanoidRootPart.Position
                InfoDisplayLabel.Text = string.format("ForkSaken 1.0 | Position: (%.1f, %.1f, %.1f)", pos.X, pos.Y, pos.Z)
            end
        end)
    else
        InfoButton.TextColor3 = textColor
    end
end)

-- Changes Menu
local ChangesButton = createAutoPositionedElement(MainContent, createButton(MainContent, "OPEN CHANGES", Color3.new(0.5, 1, 0.8)))
ChangesButton.MouseButton1Click:Connect(function()
    ChangesWindow.Visible = true
end)

-- Teleport to Coordinates
local TeleportX = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "X Coordinate"))
local TeleportY = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Y Coordinate"))
local TeleportZ = createAutoPositionedElement(ChangesContent, createInput(ChangesContent, "Z Coordinate"))
local TeleportButton = createAutoPositionedElement(ChangesContent, createButton(ChangesContent, "TELEPORT TO COORDINATES", Color3.new(0.4, 0.8, 1)))

TeleportButton.MouseButton1Click:Connect(function()
    local x = tonumber(TeleportX.Text)
    local y = tonumber(TeleportY.Text)
    local z = tonumber(TeleportZ.Text)
    if x and y and z and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end)

-- Делаем главное окно видимым
MainWindow.Visible = true
