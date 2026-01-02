repeat task.wait() until game.Players.LocalPlayer
local plr = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local THEME_COLOR = Color3.fromRGB(255,140,0)
local THEME_BG = Color3.fromRGB(15,15,18)

local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "VAEBUpdate"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,150)
frame.Position = UDim2.new(0.5,-130,0.3,0)
frame.BackgroundColor3 = THEME_BG
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = THEME_COLOR
stroke.Transparency = 0.4

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1,0,0,36)
header.BackgroundTransparency = 1
header.Text = "VAEB invisible"
header.Font = Enum.Font.GothamBold
header.TextSize = 18
header.TextColor3 = THEME_COLOR

local updateText = Instance.new("TextLabel", frame)
updateText.Size = UDim2.new(1,-20,0,30)
updateText.Position = UDim2.new(0,10,0,45)
updateText.BackgroundTransparency = 1
updateText.Text = "SCRIPT ON UPDATE"
updateText.Font = Enum.Font.GothamBold
updateText.TextSize = 16
updateText.TextColor3 = THEME_COLOR

local infoText = Instance.new("TextLabel", frame)
infoText.Size = UDim2.new(1,-20,0,20)
infoText.Position = UDim2.new(0,10,0,75)
infoText.BackgroundTransparency = 1
infoText.Text = "More information in discord"
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 14
infoText.TextColor3 = Color3.fromRGB(180,180,180)

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(1,-40,0,36)
copyBtn.Position = UDim2.new(0,20,1,-46)
copyBtn.Text = "COPY LINK"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 15
copyBtn.TextColor3 = Color3.fromRGB(20,20,20)
copyBtn.BackgroundColor3 = THEME_COLOR
copyBtn.BorderSizePixel = 0
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,12)

copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/KHVC7vFs")
        copyBtn.Text = "COPIED!"
        task.wait(1.2)
        copyBtn.Text = "COPY LINK"
    end
end)

local dragging = false
local dragStart
local startPos
local dragInput

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)
