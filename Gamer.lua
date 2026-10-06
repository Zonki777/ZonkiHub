-- =============================================================================
-- ZONKI PREMIUM HUB - STEAL AN EGG MOBILE SHOWCASE EDITION
-- =============================================================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local ButtonLayout = Instance.new("UIListLayout")
local Padding = Instance.new("UIPadding")
local MobileToggleButton = Instance.new("TextButton")
local ButtonUICorner = Instance.new("UICorner")

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Bypasses local resets to keep the Zonki interface active on screen
if getgenv and detoured_gui then
    ScreenGui.Parent = getgenv()
else
    ScreenGui.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
end
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "ZonkiHubMobile"

-- =============================================================================
-- CUSTOM ZONKI NOTIFICATION POPUP FEATURE
-- =============================================================================
local function spawnZonkiNotification()
    local NotifFrame = Instance.new("Frame")
    local NotifCorner = Instance.new("UICorner")
    local NotifTitle = Instance.new("TextLabel")
    local NotifMsg = Instance.new("TextLabel")

    -- Setup layout matching the crimson neon profile
    NotifFrame.Name = "ZonkiNotification"
    NotifFrame.Size = UDim2.new(0, 240, 0, 65)
    NotifFrame.Position = UDim2.new(1, 30, 0.85, 0) -- Starts completely off-screen to the right
    NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
    NotifFrame.BorderSizePixel = 1
    NotifFrame.BorderColor3 = Color3.fromRGB(230, 20, 20)
    NotifFrame.Parent = ScreenGui

    NotifCorner.CornerRadius = UDim.new(0, 6)
    NotifCorner.Parent = NotifFrame

    NotifTitle.Size = UDim2.new(1, -10, 0, 25)
    NotifTitle.Position = UDim2.new(0, 10, 0, 5)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = "SYSTEM NOTICE"
    NotifTitle.TextColor3 = Color3.fromRGB(255, 30, 30)
    NotifTitle.TextSize = 14
    NotifTitle.Font = Enum.Font.FredokaOne
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.Parent = NotifFrame

    NotifMsg.Size = UDim2.new(1, -10, 0, 30)
    NotifMsg.Position = UDim2.new(0, 10, 0, 25)
    NotifMsg.BackgroundTransparency = 1
    NotifMsg.Text = "Zonki Hub Loaded Successfully!"
    NotifMsg.TextColor3 = Color3.fromRGB(220, 220, 225)
    NotifMsg.TextSize = 13
    NotifMsg.Font = Enum.Font.SourceSansBold
    NotifMsg.TextXAlignment = Enum.TextXAlignment.Left
    NotifMsg.Parent = NotifFrame

    -- Animate sliding inside the visible view area
    local slideIn = TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.98, -240, 0.85, 0)
    })
    slideIn:Play()

    -- Display for 3.5 seconds, then cleanly drop transparency down to zero
    task.wait(3.5)
    
    local fadeOut = TweenService:Create(NotifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        BorderTransparency = 1
    })
    TweenService:Create(NotifTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
    TweenService:Create(NotifMsg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
    
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        NotifFrame:Destroy()
    end)
end

-- Fire notification handler instantly upon injection
task.spawn(spawnZonkiNotification)

-- =============================================================================
-- FLOATING TOGGLE BUTTON (Tap to Hide/Show UI)
-- =============================================================================
MobileToggleButton.Name = "ZonkiMobileToggle"
MobileToggleButton.Size = UDim2.new(0, 60, 0, 60)
MobileToggleButton.Position = UDim2.new(0.02, 0, 0.2, 0)
MobileToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
MobileToggleButton.BorderSizePixel = 2
MobileToggleButton.BorderColor3 = Color3.fromRGB(230, 20, 20) -- Neon Red Outline
MobileToggleButton.Text = "ZONKI"
MobileToggleButton.TextColor3 = Color3.fromRGB(255, 30, 30)
MobileToggleButton.TextSize = 13
MobileToggleButton.Font = Enum.Font.FredokaOne
MobileToggleButton.Parent = ScreenGui

ButtonUICorner.CornerRadius = UDim.new(1, 0)
ButtonUICorner.Parent = MobileToggleButton

-- =============================================================================
-- MAIN FRAME INTERFACE (Dark Textured Background / Crimson Glow Theme)
-- =============================================================================
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 420)
MainFrame.Position = UDim2.new(0.15, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(230, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.Text = "ZONKI HUB v1.0"
TitleText.TextColor3 = Color3.fromRGB(240, 240, 245)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.FredokaOne 
TitleText.TextStrokeTransparency = 0.2
TitleText.TextStrokeColor3 = Color3.fromRGB(180, 0, 0)
TitleText.Parent = TitleBar

ButtonLayout.Parent = MainFrame
ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
ButtonLayout.Padding = UDim.new(0, 12)

Padding.Parent = MainFrame
Padding.PaddingTop = UDim.new(0, 60)
Padding.PaddingLeft = UDim.new(0, 15)
Padding.PaddingRight = UDim.new(0, 15)

MobileToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

--------------------------------------------------------------------------------
-- REUSABLE ZONKI PREMIUM BUTTON LAYOUT
--------------------------------------------------------------------------------
local function createZonkiButton(text, order)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 45)
	button.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
	button.BorderSizePixel = 1
	button.BorderColor3 = Color3.fromRGB(80, 10, 10)
	button.Text = text
	button.TextColor3 = Color3.fromRGB(210, 210, 215)
	button.TextSize = 15
	button.Font = Enum.Font.SourceSansBold
	button.LayoutOrder = order
	button.Parent = MainFrame
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button
	
	return button
end

local GodModeBtn = createZonkiButton("GODMODE: OFF", 1)
local AntiHitBtn = createZonkiButton("ANTI-HIT: OFF", 2)
local SpawnEggBtn = createZonkiButton("SPAWN LOCAL EGG", 3)
local AutoCollectBtn = createZonkiButton("AUTO-COLLECT: OFF", 4)
local LoadstringBtn = createZonkiButton("EXECUTE RAW URL", 5)

--------------------------------------------------------------------------------
-- STEAL AN EGG CHEAT LOGIC CORE
--------------------------------------------------------------------------------
local godModeActive = false
local antiHitActive = false
local autoCollectActive = false

local function setToggleVisual(button, status, activeText, inactiveText)
	if status then
		button.Text = activeText
		button.BorderColor3 = Color3.fromRGB(255, 0, 0)
		button.BackgroundColor3 = Color3.fromRGB(100, 10, 10)
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
	else
		button.Text = inactiveText
		button.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
		button.BorderColor3 = Color3.fromRGB(80, 10, 10)
		button.TextColor3 = Color3.fromRGB(210, 210, 215)
	end
end

-- 1. Godmode Activation
GodModeBtn.MouseButton1Click:Connect(function()
	local char = Player.Character
	if char and char:FindFirstChild("Humanoid") then
		godModeActive = not godModeActive
		setToggleVisual(GodModeBtn, godModeActive, "GODMODE: ACTIVE", "GODMODE: OFF")
		
		if godModeActive then
			char.Humanoid.MaxHealth = math.huge
			char.Humanoid.Health = math.huge
		else
			char.Humanoid.MaxHealth = 100
			char.Humanoid.Health = 100
		end
	end
end)

-- 2. Anti-Hit/Trap Collision Bypass
AntiHitBtn.MouseButton1Click:Connect(function()
	local char = Player.Character
	if char then
		antiHitActive = not antiHitActive
		setToggleVisual(AntiHitBtn, antiHitActive, "ANTI-HIT: ON", "ANTI-HIT: OFF")
		
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanTouch = not antiHitActive
			end
		end
	end
end)

-- 3. Fake Client-Side Egg Generator
SpawnEggBtn.MouseButton1Click:Connect(function()
	local char = Player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		local fakeEgg = Instance.new("Part")
		fakeEgg.Size = Vector3.new(2.5, 3.5, 2.5)
		fakeEgg.Shape = Enum.PartType.Ball
		fakeEgg.Color = Color3.fromRGB(255, 30, 30)
		fakeEgg.Material = Enum.Material.Neon
		fakeEgg.Name = "ZonkiClientEgg"
		fakeEgg.Position = char.HumanoidRootPart.Position + char.HumanoidRootPart.CFrame.LookVector * 5
		fakeEgg.Parent = game.Workspace
		
		SpawnEggBtn.Text = "EGG GENERATED!"
		task.wait(0.8)
		SpawnEggBtn.Text = "SPAWN LOCAL EGG"
	end
end)

-- 4. Infinite Auto-Grab Egg Automation
AutoCollectBtn.MouseButton1Click:Connect(function()
	autoCollectActive = not autoCollectActive
	setToggleVisual(AutoCollectBtn, autoCollectActive, "AUTO-COLLECT: ACTIVE", "AUTO-COLLECT: OFF")
	
	task.spawn(function()
		while autoCollectActive do
			local char = Player.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				for _, obj in pairs(game.Workspace:GetDescendants()) do
					if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Name == "ZonkiClientEgg") then
						obj.CFrame = char.HumanoidRootPart.CFrame
					end
				end
          end
          task.wait(0.3)
end
end)
end)
-- 5. Integrated Internal Script Loadstring Execution
LoadstringBtn.MouseButton1Click:Connect(function()
LoadstringBtn.Text = "LOADING..."
-- Runs a pcall block safely so bad links don't crash your entire Zonki Hub UI
local success, err = pcall(function()
-- Swap this raw link target with whatever external module path you want to run!
loadstring(game:HttpGet("pastebin.com"))()
end)
if success then
LoadstringBtn.Text = "LOADED SUCCESS!"
else
LoadstringBtn.Text = "EXECUTION ERROR"
warn("Zonki Core Error: " .. tostring(err))
end
task.wait(1.2)
LoadstringBtn.Text = "EXECUTE RAW URL"
end)
print("Zonki Hub Loaded Successfully via Loadstring!")
