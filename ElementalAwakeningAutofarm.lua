_G.farmSpells = false
_G.spellFound = false

-- Dont mess with these ^^^

_G.levelLimit = 5 -- Will level to this number and then re roll
local WantedRarities = {"Heavenly","Legendary","Exotic"} -- Pick the rarities you want here



local ScreenGui

localPlayer = tostring(game:GetService("Players").LocalPlayer)

local function returnscreengui()
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
        if v.ClassName == "ScreenGui" and v:FindFirstChild("Start") then
            return v
        end
    end
    return nil
end

ScreenGui = returnscreengui()

function playerIsAlive(player) 
	for i,v in pairs(game:GetService("Workspace").Players.Alive:GetChildren()) do
		if v.Name == player then
			return true
		end
	end
	return false
end

function fireSpell(spell)

	game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack[spell])

	local args = {
		[1] = {
			[1] = game:GetService("Players").LocalPlayer.Character[spell],
			[2] = Vector3.new(0, 0, 0),
			[3] = Vector3.new(0, 0, 0),
			[4] = true
		}
	}

	game:GetService("ReplicatedStorage").Events.SpellCast:FireServer(unpack(args))

	wait(0)

	local args = {
		[1] = {
			[1] = game:GetService("Players").LocalPlayer.Character[spell],
			[2] = Vector3.new(0, 0, 0)
		}
	}

	game:GetService("ReplicatedStorage").Events.SpellCast:FireServer(unpack(args))
end


function farmSpells()

	_G.farmSpells = true

	spawn(function ()
		wait(1)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Dune1.CornerWedge.CFrame
		while _G.farmSpells do
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 8.9, 0)
			wait(0)
		end
	end)

	while _G.farmSpells do

		if tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.StatsGUI.Level.Level.Text) >= _G.levelLimit then
			_G.farmSpells = false
		end
		
		game:GetService("Players").LocalPlayer.Character.Humanoid:UnequipTools()
		spells = game:GetService("Players").LocalPlayer.Backpack:GetChildren()

		for i,v in pairs(spells) do
			fireSpell(v.Name)
			if _G.farmSpells == false then
				break
			end
		end

	end
end

function spinElement()

	-- ADDD LIMIT
	while wait(0) do
		local Magic, Rarity
		Magic, Rarity = game:GetService("ReplicatedStorage").Events.Spin:InvokeServer(false)
		if Magic ~= nil then
			print("Rolled "..Magic.." with a rarity of "..Rarity)
			
			if table.find(WantedRarities,Rarity) then
				_G.spellFound = true
				break
			end
		else
			break
		end
	end
end



function autoFarm()
	if not playerIsAlive(LocalPlayer) then
		ScreenGui = returnscreengui()
		if ScreenGui ~= nil then
			firesignal(ScreenGui.Start.PlayButton.MouseButton1Click)
		end
	end
	
	if not (tonumber(game:GetService("Players").LocalPlayer.PlayerGui.Main.StatsGUI.Level.Level.Text) >= _G.levelLimit) then
		farmSpells()
	end
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Watchtower.CornerWedge.CFrame
	game:GetService("Players").LocalPlayer.Character:BreakJoints()
	spinElement()
	ScreenGui = returnscreengui()
	while ScreenGui == nil do
		ScreenGui = returnscreengui()
		wait(0)
	end
	firesignal(ScreenGui.Start.PlayButton.MouseButton1Click)

	wait(0.4)
end

while wait(0) do
	autoFarm()
end
