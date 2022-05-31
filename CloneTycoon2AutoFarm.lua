thing = true
local virtualUser = game:GetService('VirtualUser')

spawn(function ()

	while thing do	
	
		for i=1, 50 do
			
			local args = {
				[1] = "mine",
				[2] = "Diamonds"
			}

			workspace.Events.DataStores.uhoh:FireServer(unpack(args))
				local args = {
				[1] = "mine",
				[2] = "Coal"
			}
			
			workspace.Events.DataStores.uhoh:FireServer(unpack(args))

				local args = {
				[1] = "mine",
				[2] = "Gold"
			}
			workspace.Events.DataStores.uhoh:FireServer(unpack(args))

				local args = {
				[1] = "mine",
				[2] = "Iron"
			}
			workspace.Events.DataStores.uhoh:FireServer(unpack(args))

				local args = {
				[1] = "mine",
				[2] = "Stone"
			}
			workspace.Events.DataStores.uhoh:FireServer(unpack(args))

			
		end
		virtualUser:CaptureController()
		virtualUser:SetKeyDown('0x65')
		wait(5.5)
		virtualUser:SetKeyUp('0x65')
		wait(0)

		if thing == false then
			break
		end
	end
end)
