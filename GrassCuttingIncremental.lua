_G.autoCollect = false

function teleportTo(position)
    local player = game.Players.LocalPlayer
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = position
    end
end

function autoCollect()
	spawn(function ()
		while _G.autoCollect do
			grass = game:GetService("Workspace").GrassObjects:GetChildren()
			if grass[1] ~= nil then
				for i,v in pairs(grass) do
					if not (v.Identifier.Value == "magic") then
						teleportTo(v.CFrame)
						wait(0)
					end
					if _G.autoCollect == false then
						break
					end
				end
			end
		end
	end)
end




--------- GUI ---------

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Ability Wars", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Main:AddToggle({
	Name = "Auto Collect",
	Default = false,
	Callback = function(Value)
		_G.autoCollect = Value
		if _G.autoCollect == true then
			autoCollect()
		end
	end 
})

OrionLib:Init()