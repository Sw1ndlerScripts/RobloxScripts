local virtualUser = game:GetService('VirtualUser')
virtualUser:CaptureController()

function teleportTo(CFrame) 
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame
end

_G.autoFarm = false

function autoFarm()
	while _G.autoFarm do
	    
	    local foundPoint = false
		fireclickdetector(game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector)
		
		while foundPoint == false do
    		for _,point in pairs(game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()) do
    			if point.Locate.Locate.Enabled then
    				teleportTo(point.CFrame)
    				--firetouchinterest(point, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)
    				foundPoint = true
    			end
    		end
    		wait(0)
    	end
		wait(0)
	end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Tang County - Sw1ndler", 5013109572)

local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(0, 0, 0),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(255, 255, 255)
}


local page = venyx:addPage("Main", 5012544693)
local section1 = page:addSection("Auto farm | Become delivery driver first")

section1:addToggle("Auto Farm", nil, function(value)
	_G.autoFarm = value
	if value then
		autoFarm()
	end
end)


