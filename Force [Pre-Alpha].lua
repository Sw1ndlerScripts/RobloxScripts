_G.autoCollect = false

local virtualUser = game:GetService('VirtualUser')
virtualUser:CaptureController()

function teleportTo(pos)
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end

function tweenTo(cframe)

    tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(1, Enum.EasingStyle.Linear)
    tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = cframe})
    tween:Play()

end

function openSellMenu()
	tweenTo(CFrame.new(134.151352, 1758.47778, 652.915466, -0.0662579089, -4.84053082e-08, -0.997802556, 4.64131382e-08, 1, -5.1593922e-08, 0.997802556, -4.97296497e-08, -0.0662579089))
	wait(2.5)
	virtualUser:SetKeyDown('0x65')
	wait(0.15)
	virtualUser:SetKeyUp('0x65')
end

function openTpMenu()
	tweenTo(CFrame.new(-353.468903, 1635.56799, 2369.06885, 0.996863186, -1.99043004e-08, -0.0791442916, 1.89571736e-08, 1, -1.27184538e-08, 0.0791442916, 1.11782059e-08, 0.996863186))
	wait(2.5)
	virtualUser:SetKeyDown('0x65')
	wait(0.15)
	virtualUser:SetKeyUp('0x65')
end

function teleportToTemple()
	tweenTo(CFrame.new(-429.229706, 1512.8927, -5485.87256, 0.646094263, 3.67857105e-08, 0.763257623, 3.26642464e-08, 1, -7.58458114e-08, -0.763257623, 7.39347783e-08, 0.646094263))
end

function objectsTouching(object)

    objectsTouchingAmt = 0
		
	for i,v in pairs(game:GetService("Players").LocalPlayer.Character["Left Leg"]:GetTouchingParts()) do
		if v.Parent.Name ~= tostring(game:GetService("Players").LocalPlayer) then
			objectsTouchingAmt = objectsTouchingAmt + 1
		end
	end
	return objectsTouchingAmt

end


function noClip()

    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.ClassName == "Part" or v.ClassName == "MeshPart" then
            v.CanCollide = false
        end
    end
    
    --game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)

end



function autoCollect()
    
    spawn(function()
        while _G.autoCollect do
            noClip()
            wait(0)
        end
    end)

	tweenTo(CFrame.new(134.151352, 1758.47778, 652.915466, -0.0662579089, -4.84053082e-08, -0.997802556, 4.64131382e-08, 1, -5.1593922e-08, 0.997802556, -4.97296497e-08, -0.0662579089))

	wait(3)

	while _G.autoCollect do
		for _,trinket in pairs(game:GetService("Workspace"):GetChildren()) do

			if _G.autoCollect == false then
				break
			end

			if trinket:FindFirstChild("Rarity") and not(trinket:FindFirstChild("Attachment")) and trinket.position.y > 800 then

				centerOfMap = Vector3.new(342.396088, 1804.64246, 765.361084)
				distanceToTrinket = (centerOfMap - trinket.position).magnitude


				-- if distanceToTrinket < 500 and trinket.position.Y > 1000 then

				print(trinket.Position.X)
				tweenTo(trinket.CFrame)
				wait(1.75)

				if objectsTouching() > 0 then

					virtualUser:SetKeyDown('0x65')
					wait(0.15)
					virtualUser:SetKeyUp('0x65')
					wait(0.3)
					trinket:Destroy()
				else 
					trinket:Destroy()
				end
				-- end 
			end    
		end
		wait(0)
	end
end

function collectCrystal()
	for _,crystal in pairs(game:GetService("Workspace"):GetChildren()) do
		if crystal:FindFirstChild("Rarity") and crystal:FindFirstChild("Attachment") then
			tweenTo(crystal.CFrame)
			break
		end
	end
end


---------------- UI -------------

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local main = OrionLib:MakeWindow({Name = "Force [Pre-Alpha] - Sw1ndler", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local AutoFarm = main:MakeTab({
	Name = "AutoFarm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Teleports = main:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Misc = main:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

AutoFarm:AddToggle({
	Name = "AutoCollect",
	Default = false,

	Callback = function(Value)
		_G.autoCollect = Value  
        autoCollect()
	end
})


AutoFarm:AddButton({
	Name = "CollectCrystal",
	Callback = function()
        collectCrystal()
  	end    
})

local teleports = {
    SellMenu = CFrame.new(134.151352, 1758.47778, 652.915466, -0.0662579089, -4.84053082e-08, -0.997802556, 4.64131382e-08, 1, -5.1593922e-08, 0.997802556, -4.97296497e-08, -0.0662579089),
    TpMenu = CFrame.new(-353.468903, 1635.56799, 2369.06885, 0.996863186, -1.99043004e-08, -0.0791442916, 1.89571736e-08, 1, -1.27184538e-08, 0.0791442916, 1.11782059e-08, 0.996863186),
    Temple = CFrame.new(-429.229706, 1512.8927, -5485.87256, 0.646094263, 3.67857105e-08, 0.763257623, 3.26642464e-08, 1, -7.58458114e-08, -0.763257623, 7.39347783e-08, 0.646094263)
}


Teleports:AddDropdown({
	Name = "TeleportTo",
	Default = "1",
	Options = {"SellMenu", "TpMenu", "Temple"},
	Callback = function(Value)
		tweenTo(teleports[Value])
	end    
})


Misc:AddButton({
	Name = "AntiFallDamage",
	Callback = function()
        game:GetService("ReplicatedStorage").Requests.FallDamage:remove()
  	end    
})


OrionLib:Init()

