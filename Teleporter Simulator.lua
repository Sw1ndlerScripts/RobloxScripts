_G.autoTrain = false
_G.collectOrbs = false
_G.collectObject = false
_G.killAll = false


function teleportTo(placeCFrame)
    local player = game.Players.LocalPlayer
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = placeCFrame
    end
end

function teleportToTrain(number)
	teleportTo(game:GetService("Workspace").TrainingItems[number].Part.CFrame * CFrame.new(25, 0, 25))
end

function autoTrain()
	spawn(function()
		while _G.autoTrain do
			local args = {[1] = {[1] = "Train"}}
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
			wait(0)
		end
	end)
end

function autoCollectItem()
	while _G.collectObject do
		collectNextObject()
        wait(0)
	end
end




function collectOrbs(level)
	spawn(function()
		while _G.collectOrbs do
			-- while true do
			-- 	orbs = game:GetService("Workspace").TimeSpheres[level]:GetChildren()[1]
			-- 	wait(0.4)
			-- 	if orbs.PrimaryPart.CFrame then
			-- 		teleportTo(orbs.PrimaryPart.CFrame)
			-- 		game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
			-- 	end
			-- 	if _G.collectOrbs == false then
			-- 		break
			-- 	end
			-- 	wait(0)
			-- end
			
			for i,v in pairs(game:GetService("Workspace").TimeSpheres[level]:GetChildren())do
				if v.PrimaryPart and v.PrimaryPart.TouchInterest then
					teleportTo(v.PrimaryPart.CFrame) 
					game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
					wait(0)
					print(v.PrimaryPart.CFrame)
				end
				if _G.collectOrbs == false then
					break
				end
				wait(0.4)
			end
			wait(0)
		end
	end)
end
function collectNextObject()
	object = game.Players.LocalPlayer.leaderstats.Item.Value + 1
	fireclickdetector(game:GetService("Workspace").TrainingItems[object].ClickDetector)
end


function killAll()
    spawn(function()
        while _G.killAll do
            players = game:GetService("Players"):GetChildren()
            table.remove(players, 1)
            for i,v in pairs(players) do
                player = tostring(v)
                if v ~= nil and v.Character ~= nil and v.Character.Humanoid ~= nil then
                    local curHP = v.Character.Humanoid.Health
                    if curHP > 0 then
                        if game:GetService("Players")[player] then
                            if game:GetService("Players")[player].leaderstats.Item.Value > 4 then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[player].Character.HumanoidRootPart.CFrame
                                wait(0.25)
                                local args = {    [1] = { [1] = "AttackTargetPlr",[2] = player  }}
                                game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                                wait(0.05)
                            end
                        end
                    end
                end
                if _G.killAll == false then
                    break
                end
            end
        end
    end)
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Teleporter Simulator", "DarkTheme")

local Window1 = Window:NewTab("Farming")
local Window2 = Window:NewTab("Murder😈")

local farming = Window1:NewSection("Auto Farm")
local murder = Window2:NewSection("Auto Kill")

farming:NewToggle("Auto Train", "Auto Train with the training tool", function(bool)
    _G.autoTrain = bool
    if bool then
        autoTrain()
    end
end)

collectLevel = 1

farming:NewToggle("Auto Collect Orbs", "Auto collect orbs", function(bool)
    _G.collectOrbs = bool
    if bool then
        collectOrbs(collectLevel)
    end
end)

farming:NewSlider("Orb Level", "Orb Level", 7, 1, function(value) -- 500 (MaxValue) | 0 (MinValue)
    collectLevel = value
end)

farming:NewToggle("Auto Collect Tool", "Auto collect tool", function(bool)
    _G.collectObject = bool
    if bool then
        autoCollectItem()
    end
end)

murder:NewToggle("Loop Kill Everyone", "Loop Kill Everyone", function(bool)
    _G.killAll = bool
    if bool then
        killAll()
    end
end)