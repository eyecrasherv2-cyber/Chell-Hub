--========================--
--   CHELL HUB | ORION   --
--========================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ORION UI
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

OrionLib:MakeNotification({
	Name = "Chell Hub",
	Content = "Loading...",
	Image = "rbxassetid://4483345998",
	Time = 3
})

local Window = OrionLib:MakeWindow({
	Name = "Chell Hub",
	HidePremium = false,
	SaveConfig = false
})

--========================--
-- TABS
--========================--
local InfoTab = Window:MakeTab({Name="Info", Icon="rbxassetid://4483345998"})
local MainTab = Window:MakeTab({Name="Main", Icon="rbxassetid://4483345998"})
local VisualTab = Window:MakeTab({Name="Visuals", Icon="rbxassetid://4483345998"})
local MoveTab = Window:MakeTab({Name="Movement", Icon="rbxassetid://4483345998"})
local ToolsTab = Window:MakeTab({Name="Tools", Icon="rbxassetid://4483345998"})
local MiscTab = Window:MakeTab({Name="Misc", Icon="rbxassetid://4483345998"})

--========================--
-- INFO
--========================--
local player = game.Players.LocalPlayer

InfoTab:AddParagraph("Nama Hub", "Chell Hub")

InfoTab:AddParagraph("CR", "Eye")

InfoTab:AddParagraph("Versi", "v1.0")

InfoTab:AddParagraph("Type", "Universal")

InfoTab:AddParagraph("User", player.Name)

InfoTab:AddParagraph("User ID", tostring(player.UserId))

--========================--
-- MAIN (TELEPORT / BRING)
--========================--
local targetName = ""

MainTab:AddTextbox({
	Name = "Nama Player",
	Default = "",
	TextDisappear = false,
	Callback = function(v)
		targetName = v
	end
})

MainTab:AddButton({
	Name = "Teleport To Player",
	Callback = function()
		local target = Players:FindFirstChild(targetName)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame =
			target.Character.HumanoidRootPart.CFrame
		end
	end
})

MainTab:AddButton({
	Name = "Bring Player",
	Callback = function()
		local target = Players:FindFirstChild(targetName)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			target.Character.HumanoidRootPart.CFrame =
			LocalPlayer.Character.HumanoidRootPart.CFrame
		end
	end
})

--========================--
-- VISUALS (ESP HIGHLIGHT)
--========================--
local espEnabled = false
local highlights = {}

local function clearESP()
	for _,h in pairs(highlights) do
		if h then h:Destroy() end
	end
	highlights = {}
end

local function applyESP()
	clearESP()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local hl = Instance.new("Highlight")
			hl.Parent = plr.Character
			hl.FillColor = Color3.fromRGB(255,0,0)
			hl.OutlineColor = Color3.fromRGB(255,255,255)
			hl.FillTransparency = 0.5
			table.insert(highlights, hl)
		end
	end
end

VisualTab:AddToggle({
	Name = "ESP Highlight",
	Default = false,
	Callback = function(v)
		espEnabled = v
		if v then
			applyESP()
		else
			clearESP()
		end
	end
})

Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		if espEnabled then
			task.wait(1)
			applyESP()
		end
	end)
end)

--========================--
-- MOVEMENT
--========================--
local noclip = false
RunService.Stepped:Connect(function()
	if noclip and LocalPlayer.Character then
		for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

MoveTab:AddToggle({
	Name = "Noclip",
	Default = false,
	Callback = function(v)
		noclip = v
	end
})

local speedOn = false
local jumpOn = false

MoveTab:AddToggle({
	Name = "Speed Boost",
	Default = false,
	Callback = function(v)
		speedOn = v
		if LocalPlayer.Character then
			LocalPlayer.Character.Humanoid.WalkSpeed = v and 50 or 16
		end
	end
})

MoveTab:AddButton({
	Name = "Reset Speed",
	Callback = function()
		if LocalPlayer.Character then
			LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end
	end
})

MoveTab:AddToggle({
	Name = "Jump Boost",
	Default = false,
	Callback = function(v)
		jumpOn = v
		if LocalPlayer.Character then
			LocalPlayer.Character.Humanoid.JumpPower = v and 100 or 50
		end
	end
})

MoveTab:AddButton({
	Name = "Reset Jump",
	Callback = function()
		if LocalPlayer.Character then
			LocalPlayer.Character.Humanoid.JumpPower = 50
		end
	end
})

--========================--
-- TOOLS
--========================--
ToolsTab:AddButton({
	Name = "Open DEX",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end
})

ToolsTab:AddButton({
	Name = "CoolKidd99(gui)",
	Callback = function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-C00lkidd-Gui-111755"))()
	end
})

ToolsTab:AddButton({
	Name = "Tiger X V4",
	Callback = function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Tiger-hub-x-v4-42180"))()
	end
})

ToolsTab:AddButton({
	Name = "Fly",
	Callback = function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
	end
})

--========================--
-- MISC
--========================--
MiscTab:AddButton({
	Name = "Keyboard Script",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt", true))()
	end
})

OrionLib:Init()
