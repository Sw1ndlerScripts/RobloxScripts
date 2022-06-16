local virtualUser = game:GetService('VirtualUser')
virtualUser:CaptureController()

function tweenTo(cframe)
    tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(1, Enum.EasingStyle.Linear)
    tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = cframe})
    tween:Play()
end

while wait(0) do
	wait(4)
	tweenTo(CFrame.new(134.151352, 1758.47778, 652.915466, -0.0662579089, -4.84053082e-08, -0.997802556, 4.64131382e-08, 1, -5.1593922e-08, 0.997802556, -4.97296497e-08, -0.0662579089))
	wait(8)
	virtualUser:SetKeyDown('0x65')
	wait(0.2)
	virtualUser:SetKeyUp('0x65')
	wait(0.8)
	firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DIALOGUE.MainFrame.Dialogue1.AnswerButton.MouseButton1Click)
	wait(1.5)
	firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DIALOGUE.MainFrame.Dialogue1.AnswerButton.MouseButton1Click)
	wait(1.5)
	firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DIALOGUE.MainFrame.Dialogue1.CancelButton.MouseButton1Click)
	wait(0.75)
	game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 0
	wait(4)
end


