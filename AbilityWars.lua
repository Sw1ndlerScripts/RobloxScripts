_G.killAll = false
_G.auraRange = 18
_G.lockPosition = false
_G.antiKB = false
_G.lockPositionToggle = false

local UserInputService = game:GetService("UserInputService")

function teleportTo(position)
    local player = game.Players.LocalPlayer
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = position
    end
end

function lockPosition()
	spawn(function()
		position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		while _G.lockPosition or _G.lockPositionToggle do
			teleportTo(position)
			wait(0)
		end
	end)
end

function antiKB()
	spawn(function()	
		while _G.antiKB do
			if game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.PlatformStanding then
				position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				while game.Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.PlatformStanding do
					teleportTo(position)
					wait(0)
				end
			end
			wait(0)
		end
	end)
end

function attackPlayer(player)
	local args = {
		[1] = game:GetService("Players")[player].Character.Humanoid,
		[2] = 0,
		[3] = 0
	}
	game:GetService("Players").LocalPlayer.Character.HitEvent:FireServer(unpack(args))
end

function killAll()
    spawn(function()
        while _G.killAll do
            players = game:GetService("Players"):GetChildren()
            table.remove(players, 1)
            for i,v in pairs(players) do
                player = tostring(v)
				if v.Character ~= nil then
					distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")[player].HumanoidRootPart.Position).magnitude
					if distance < _G.auraRange and game:GetService("Players")[tostring(v)].leaderstats.Ability.Value ~= "Uno" then
						print((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")[player].HumanoidRootPart.Position).magnitude)
						attackPlayer(player)
						wait(0.001)
					end
				end
                if _G.killAll == false then
                    break
                end
				wait(0)
            end
			wait(0)
        end
    end)
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Ability Wars", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Main:AddToggle({
	Name = "Attack Aura",
	Default = false,
	Callback = function(Value)
		_G.killAll = Value
		if _G.killAll == true then
			killAll()
		end
	end 
})

Main:AddSlider({
	Name = "Aura Range",
	Min = 0,
	Max = 35,
	Default = 20,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "range",
	Callback = function(Value)
		_G.auraRange = Value
	end    
})

Main:AddToggle({
	Name = "Lock Position",
	Default = false,
	Callback = function(Value)
		_G.lockPosition = Value
		if _G.lockPosition == true then
			lockPosition()
		end
	end 
})

Main:AddToggle({
	Name = "Anti KB",
	Default = false,
	Callback = function(Value)
		_G.antiKB = Value
		if _G.antiKB == true then
			antiKB()
		end
	end 
})

Misc:AddSlider({
	Name = "Walkspeed",
	Min = 0,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- UserInputService.InputBegan:Connect(function(input)
-- 	if input.KeyCode == Enum.KeyCode.Q then
-- 		if _G.lockPositionToggle == true then
-- 			_G.lockPositionToggle = false
-- 			print("setFalse")
-- 			wait(0.4)
		

-- 		elseif _G.lockPositionToggle == false then
-- 			_G.lockPositionToggle = true
-- 			print("setTrue")
-- 			lockPosition()
-- 			wait(0.4)	
-- 		end
-- 	end
-- 	if input.KeyCode == Enum.KeyCode.F then
-- 		teleportTo(game:GetService("Workspace").Main.Tree.Part.CFrame)
-- 	end
	
-- end)

OrionLib:Init()

