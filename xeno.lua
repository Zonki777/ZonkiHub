--// ZONKI HUB
--// Utility hub for a Roblox experience you own/control

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ZonkiHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main window
local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(320, 360)
main.Position = UDim2.new(0.5, -160, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

-- Make window draggable
local dragging = false
local dragStart
local startPos

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

main.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 50)
title.Position = UDim2.fromOffset(15, 5)
title.BackgroundTransparency = 1
title.Text = "ZONKI HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 23
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(38, 38)
close.Position = UDim2.new(1, -48, 0, 10)
close.Text = "X"
close.TextSize = 18
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(180, 55, 55)
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 25)
status.Position = UDim2.fromOffset(15, 48)
status.BackgroundTransparency = 1
status.Text = "Zonki Hub • Ready"
status.TextColor3 = Color3.fromRGB(170, 170, 170)
status.TextSize = 13
status.Font = Enum.Font.Gotham
status.Parent = main

local function notify(message)
    status.Text = "Zonki Hub • " .. message
    print("[ZONKI] " .. message)
end

local function makeButton(text, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -30, 0, 45)
    button.Position = UDim2.fromOffset(15, y)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.TextSize = 16
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = true
    button.Parent = main

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    return button
end

-- FPS Boost
local fps = makeButton("⚡ FPS Boost", 85)

fps.MouseButton1Click:Connect(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000

    for _, object in ipairs(game:GetDescendants()) do
        if object:IsA("ParticleEmitter")
            or object:IsA("Trail")
            or object:IsA("Smoke")
            or object:IsA("Fire") then
            object.Enabled = false
        end
    end

    notify("FPS Boost enabled")
end)

-- Server Info
local server = makeButton("🌐 Server Info", 140)

server.MouseButton1Click:Connect(function()
    local count = #Players:GetPlayers()
    notify("Players in server: " .. count)
end)

-- Player Info
local info = makeButton("👤 Player Info", 195)

info.MouseButton1Click:Connect(function()
    notify("Username: " .. player.Name)
    print("UserId: " .. player.UserId)
end)

-- Reset
local reset = makeButton("🔄 Reset GUI", 250)

reset.MouseButton1Click:Connect(function()
    main.Position = UDim2.new(0.5, -160, 0.5, -180)
    notify("GUI position reset")
end)

-- Footer
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -30, 0, 30)
footer.Position = UDim2.fromOffset(15, 315)
footer.BackgroundTransparency = 1
footer.Text = "Zonki Hub • Ready"
footer.TextColor3 = Color3.fromRGB(120, 120, 120)
footer.TextSize = 12
footer.Font = Enum.Font.Gotham
footer.Parent = main

print("Zonki Hub loaded successfully!")
