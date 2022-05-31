-- Kinda sucks but will give you all the guns and then mod them

function gunMod(gun)
	gun.MaxAmmo = 1000000000000
	gun.CurrentAmmo = 1000000000000
	gun.AutoFire = true
	gun.FireRate = 0
	gun.Range = 100
	gun.Bullets = 1
	gun.Spread = 1
end

for i,v in pairs(game:GetService("Workspace")["Prison_ITEMS"].giver:GetChildren()) do
	local args = {
    	[1] = workspace.Prison_ITEMS.giver:FindFirstChild(v.Name).ITEMPICKUP
	}
	workspace.Remote.ItemHandler:InvokeServer(unpack(args))
end

for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetDescendants()) do
	if v.Name == "GunStates" then
		gunMod(require(v))
	end
end



