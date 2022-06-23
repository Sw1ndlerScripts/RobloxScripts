_G.autoCollect = false
_G.unfreezeAll = true

_G.safeUnfreezeDistance = 10

function teleportTo(CFrame) 
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame
end

function localplayerFrozen()
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("TagBlock") then
        return true
    end
    return false
end

function taggerIsClose(player)
    
    players = game:GetService("Players"):GetChildren()
    for i,v in pairs(players) do
        if v.IsTagger.Value == true then
            distance =  (game:GetService("Players")[tostring(v)].Character.HumanoidRootPart.Position - game:GetService("Players")[tostring(player)].Character.HumanoidRootPart.Position).magnitude
            print(player, distance)
            if distance < _G.safeUnfreezeDistance then
                return true
            end
        end
    end
    return false
end
            
    

function collectItems()
    while _G.autoCollect do
        for i,v in pairs(game:GetService("Workspace").Map.itemspawns:GetDescendants()) do
            if v.Name == "TouchInterest" and not(localplayerFrozen()) then
                teleportTo(v.Parent.CFrame)
                wait(0.05)
            end
        end
        wait(0)
    end
end

function unfreezeAll()
    while _G.unfreezeAll do
        players = game:GetService("Players"):GetChildren()
        
        for _,player in pairs(players) do
            
            if game:GetService("Workspace"):FindFirstChild(tostring(player)) then
                if game:GetService("Workspace")[tostring(player)]:FindFirstChild("TagBlock") and not(localplayerFrozen()) then
                    
                    if taggerIsClose(player) == false then
                        teleportTo(player.Character.HumanoidRootPart.CFrame)
                        wait(0.01)
                    end
                    
                end
            end
        end
        
        wait()
    end
end


function tagAll()
    players = game:GetService("Players"):GetChildren()
    for _,player in pairs(players) do
        if game:GetService("Players"):FindFirstChild(tostring(player)) then
            if player.IsPlaying.Value == true and player.IsTagger.Value == false  and player.IsTagger.Value == false then
                teleportTo(player.Character.HumanoidRootPart.CFrame)
                wait(0.15)
            end
        end
    end
    wait()
end

function unjailAll() -- broken
    if game:GetService("Workspace"):FindFirstChild("Map") then
        for i,v in pairs(game:GetService("Workspace").Map.JailCells:GetChildren()) do
            if v.IsOccupied.Value == true then
                teleportTo(v.CFrame * CFrame.new(5, 0, 0)) 
            end
        end
    end
end


------------- GUI -------------------------



local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Freeze Tag Extreme - Sw1ndler", "DarkTheme")

local main = Window:NewTab("Main")


local Runner = main:NewSection("Runner")

Runner:NewToggle("Auto Collect Items", "Collects any items that spawn", function(state)
    _G.autoCollect = state 
    collectItems()
end)

Runner:NewToggle("Auto Unfreeze Others", "Will teleport to frozen players", function(state)
    _G.unfreezeAll = state 
    unfreezeAll()
end)

local Tagger = main:NewSection("Tagger")

Tagger:NewButton("Tag All", "Teleports to each untagged player", function()
    tagAll()
end)


