local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Внешний вид персонажа
local function applyAvatarAppearance()
 local function applyAsset(id)
  local asset = game:GetObjects("rbxassetid://" .. id)[1]
  if asset then
   asset.Parent = LocalPlayer.Character
  end
 end

 -- Pal Hair
 applyAsset(63690008)
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CoolGuiRC7"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderColor3 = Color3.fromRGB(255, 0, 0)
Title.Text = "c00lgui Reborn Rc7 by v3rx"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Крестик закрытия
local CloseX = Instance.new("TextButton", MainFrame)
CloseX.Size = UDim2.new(0, 30, 0, 30)
CloseX.Position = UDim2.new(1, -30, 0, 0)
CloseX.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseX.BorderColor3 = Color3.fromRGB(255, 0, 0)
CloseX.Text = "×"
CloseX.TextColor3 = Color3.new(1, 1, 1)
CloseX.Font = Enum.Font.SourceSansBold
CloseX.TextSize = 24
CloseX.MouseButton1Click:Connect(function()
 ScreenGui:Destroy()
end)

-- Кнопки
local buttonYOffset = 40
local function createButton(text, callback)
 local Button = Instance.new("TextButton", MainFrame)
 Button.Size = UDim2.new(0, 150, 0, 30)
 Button.Position = UDim2.new(0, 10, 0, buttonYOffset)
 Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 Button.BorderColor3 = Color3.fromRGB(255, 0, 0)
 Button.Text = text
 Button.TextColor3 = Color3.fromRGB(255, 255, 255)
 Button.Font = Enum.Font.SourceSans
 Button.TextSize = 16
 Button.MouseButton1Click:Connect(callback)
 buttonYOffset = buttonYOffset + 35
end

-- Флай
local flying = false
local carpet = nil
local flyConnection = nil

local function toggleFly()
 local char = LocalPlayer.Character
 local hrp = char and char:FindFirstChild("HumanoidRootPart")
 local hum = char and char:FindFirstChildOfClass("Humanoid")
 if not (char and hrp and hum) then return end

 if flying then
  if carpet then carpet:Destroy() end
  if flyConnection then flyConnection:Disconnect() end
  flying = false
  hum:ChangeState(Enum.HumanoidStateType.GettingUp)
 else
  carpet = Instance.new("Part")
  carpet.Size = Vector3.new(6, 1, 6)
  carpet.Anchored = false
  carpet.Transparency = 1
  carpet.CanCollide = false
  carpet.Position = hrp.Position - Vector3.new(0, 3, 0)
  carpet.Name = "MagicCarpet"
  carpet.Parent = workspace

  local weld = Instance.new("WeldConstraint", carpet)
  weld.Part0 = carpet
  weld.Part1 = hrp

  local bv = Instance.new("BodyVelocity", carpet)
  bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
  bv.Velocity = Vector3.zero

  hum:ChangeState(Enum.HumanoidStateType.Physics)

  flyConnection = RunService.RenderStepped:Connect(function()
   if flying and carpet and bv then
    local dir = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Vector3.new(0, 0, -1) end
    if UIS:IsKeyDown(Enum.KeyCode.S) then dir += Vector3.new(0, 0, 1) end
    if UIS:IsKeyDown(Enum.KeyCode.A) then dir += Vector3.new(-1, 0, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Vector3.new(1, 0, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir += Vector3.new(0, -1, 0) end
local cam = workspace.CurrentCamera
    if dir.Magnitude > 0 then
     bv.Velocity = cam.CFrame.LookVector * dir.Z * 60 + cam.CFrame.RightVector * dir.X * 60 + Vector3.new(0, dir.Y * 60, 0)
    else
     bv.Velocity = Vector3.zero
    end
   end
  end)

  flying = true
 end
end

-- Skybox
local function openSkyboxInput()
 local inputFrame = Instance.new("Frame", ScreenGui)
 inputFrame.Size = UDim2.new(0, 300, 0, 120)
 inputFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
 inputFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 inputFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
 inputFrame.Name = "SkyboxInput"
 inputFrame.Active = true
 inputFrame.Draggable = true

 local label = Instance.new("TextLabel", inputFrame)
 label.Size = UDim2.new(1, -20, 0, 30)
 label.Position = UDim2.new(0, 10, 0, 10)
 label.Text = "Enter Skybox Asset ID:"
 label.TextColor3 = Color3.new(1, 1, 1)
 label.BackgroundTransparency = 1
 label.Font = Enum.Font.SourceSans
 label.TextSize = 18

 local textBox = Instance.new("TextBox", inputFrame)
 textBox.Size = UDim2.new(1, -20, 0, 30)
 textBox.Position = UDim2.new(0, 10, 0, 45)
 textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
 textBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
 textBox.TextColor3 = Color3.new(1, 1, 1)
 textBox.PlaceholderText = "e.g. 12345678"
 textBox.Font = Enum.Font.SourceSans
 textBox.TextSize = 16

 local confirm = Instance.new("TextButton", inputFrame)
 confirm.Size = UDim2.new(0, 80, 0, 25)
 confirm.Position = UDim2.new(0.5, -40, 1, -35)
 confirm.Text = "Set"
 confirm.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 confirm.BorderColor3 = Color3.fromRGB(255, 0, 0)
 confirm.TextColor3 = Color3.new(1, 1, 1)

 confirm.MouseButton1Click:Connect(function()
  local id = tonumber(textBox.Text)
  if id then
   for _, v in ipairs(Lighting:GetChildren()) do
    if v:IsA("Sky") then v:Destroy() end
   end
   local sky = Instance.new("Sky", Lighting)
   local sid = "rbxassetid://" .. id
   sky.SkyboxBk = sid
   sky.SkyboxDn = sid
   sky.SkyboxFt = sid
   sky.SkyboxLf = sid
   sky.SkyboxRt = sid
   sky.SkyboxUp = sid
   inputFrame:Destroy()
  end
 end)
end

-- Flood
local function floodMap()
 local water = Instance.new("Part")
 water.Name = "FloodWater"
 water.Size = Vector3.new(500, 1, 500)
 water.Position = Vector3.new(0, 0.5, 0)
 water.Anchored = true
 water.Material = Enum.Material.Water
 water.Color = Color3.fromRGB(0, 119, 190)
 water.Transparency = 0.2
 water.Parent = workspace

 local goal = {Position = water.Position + Vector3.new(0, 100, 0)}
 local tween = TweenService:Create(water, TweenInfo.new(15), goal)
 tween:Play()
end

-- Админ панель
local function openAdminGui()
 local adminFrame = Instance.new("Frame", ScreenGui)
 adminFrame.Size = UDim2.new(0, 200, 0, 200)
 adminFrame.Position = UDim2.new(0.5, 260, 0.5, -100)
 adminFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 adminFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
 adminFrame.Name = "AdminGUI"
 adminFrame.Active = true
 adminFrame.Draggable = true

 local title = Instance.new("TextLabel", adminFrame)
 title.Size = UDim2.new(1, 0, 0, 30)
 title.Text = "Admin Panel"
 title.TextColor3 = Color3.new(1, 1, 1)
 title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 title.BorderColor3 = Color3.fromRGB(255, 0, 0)
 title.Font = Enum.Font.SourceSansBold
 title.TextSize = 18

 local function adminButton(name, yPos, callback)
  local btn = Instance.new("TextButton", adminFrame)
  btn.Size = UDim2.new(0, 180, 0, 30)
  btn.Position = UDim2.new(0, 10, 0, yPos)
  btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
  btn.Text = name
  btn.TextColor3 = Color3.new(1, 1, 1)
  btn.Font = Enum.Font.SourceSans
  btn.TextSize = 16
  btn.MouseButton1Click:Connect(callback)
 end

 adminButton("Give Speed", 40, function()
  local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
  if hum then hum.WalkSpeed = 100 end
 end)
adminButton("Give JumpPower", 80, function()
  local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
  if hum then hum.JumpPower = 120 end
 end)

 adminButton("Teleport", 120, function()
  local input = Instance.new("TextBox", adminFrame)
  input.Size = UDim2.new(1, -20, 0, 25)
  input.Position = UDim2.new(0, 10, 0, 160)
  input.PlaceholderText = "X,Y,Z"
  input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
  input.BorderColor3 = Color3.fromRGB(255, 0, 0)
  input.TextColor3 = Color3.new(1, 1, 1)

  input.FocusLost:Connect(function()
   local coords = string.split(input.Text, ",")
   if #coords == 3 then
    local x = tonumber(coords[1])
    local y = tonumber(coords[2])
    local z = tonumber(coords[3])
    if x and y and z and LocalPlayer.Character then
     LocalPlayer.Character:MoveTo(Vector3.new(x, y, z))
    end
   end
  end)
 end)
end

-- Кнопки
createButton("Fly (Magic Carpet)", toggleFly)
createButton("Set Skybox", openSkyboxInput)
createButton("Flood Map", floodMap)
createButton("Admin GUI", openAdminGui)

-- Применение внешности
applyAvatarAppearance()
