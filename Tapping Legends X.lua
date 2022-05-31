_G.autoClick = false
_G.autoRebirth = false
_G.autoEgg = false
_G.collectCoin = false

function collectCoin(area)
	spawn(function()
		
		while _G.collectCoin do
			item = game:GetService("Workspace").Drops[area]:GetChildren()[1]
			item = tostring(item)
			teleportTo(game:GetService("Workspace").Drops[area][item].Circle.CFrame * CFrame.new(6,3,0) )
			local args = {[1] = item}
			game:GetService("ReplicatedStorage").Remotes.Tap:FireServer(unpack(args))
			wait(0)
		end

	end)
end


function getPlayerPos()
    local player = game.Players.LocalPlayer
    if player.Character then
        return player.Character.HumanoidRootPart.Position
    else
        return false
    end
end

function teleportTo(placeCFrame)
    local player = game.Players.LocalPlayer
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = placeCFrame
    end
end


function autoClick()
    spawn(function()
        while _G.autoClick == true do
            game:GetService("ReplicatedStorage").Remotes.Tap:FireServer()
            wait(0.000)
        end
    end)
end

function autoRebirth(amount)
    spawn(function()
        while _G.autoRebirth do
            local args = {[1] = amount}
            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer(unpack(args))
            wait(0.001)
        end
    end)
end

function autoEgg(egg)
    spawn(function()
        teleportTo(game:GetService("Workspace").Eggs[egg].EggModel.Egg.CFrame * CFrame.new(7,0,0))
        while _G.autoEgg do
            local args = {[1] = egg, [2] = 1}
            game:GetService("ReplicatedStorage").Remotes.BuyEgg:InvokeServer(unpack(args))

            wait(0.001)
        end
    end)
end

function teleportToArea(area)
    spawn(function()
        teleportTo(game:GetService("Workspace").Teleporters[area].CFrame)
    end)
end

----------- UI -----------

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()

local w = library:CreateWindow("Clicking Sim") -- Creates the window

local b = w:CreateFolder("Farming") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Pets")
local d = w:CreateFolder("Teleport")


local tokenWorld

b:Dropdown("World to collect tokens in",{"Spawn","Forest","Desert", "Winter", "Lava", "Aqua"},true,function(value)
    tokenWorld = tostring(value)
end)

b:Toggle("Auto Collect Tokens",function(bool)
    _G.collectCoin = bool
    print("Auto token triggered", bool)
    if bool then
        collectCoin(tokenWorld)
    end
end)



b:Toggle("Auto Click",function(bool)
    _G.autoClick = bool
    print("Auto tap triggered", bool)
    if bool then
        autoClick()
    end
end)

local rebirthAmount

b:Box("Rebirth Amount","number",function(value) -- "number" or "string"
    rebirthAmount = tonumber(value)
    
end)


b:Toggle("Auto Rebirth",function(bool)
    _G.autoRebirth = bool
    print("Auto rebirth triggered", bool)
    if bool then
        autoRebirth(rebirthAmount)
    end
end)

local eggType

c:Box("Egg Type⠀⠀⠀⠀","string",function(value) -- "number" or "string"
    eggType = value
end)

c:Toggle("Auto Buy Egg",function(bool)
    _G.autoEgg = bool
    print("Auto egg triggered", bool)
    if bool then
        autoEgg(eggType)

    elseif not bool then
        game:GetService("ReplicatedStorage").Remotes.UnequipAll:InvokeServer()
        game:GetService("ReplicatedStorage").Remotes.EquipBest:InvokeServer()
    end
end)


local selectedWorld

d:Dropdown("World Select",{"Spawn","Forest","Desert", "Winter", "Lava", "Aqua"},true,function(value)
    selectedWorld = value
end)

d:Button("Teleport",function()
    if selectedWorld then
        teleportToArea(selectedWorld)
    end
end)

d:DestroyGui()




