local InKart = true
local Kart = {}
local turning = true
local SteerDirection = 0 --1 = Left, 2 = right, 0 = not steering
local Driving = false

--services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

function SteerLeft()
	print("Steer left")
	local wheelFR = game.Workspace.wheelFR --:FindFirstChild("wheelFR")
	local wheelFL = game.Workspace.wheelFL --:FindFirstChild("wheelFL")
	
	wheelFR.Rotation = Vector3.new(0, -75, 0)
	wheelFL.Rotation = Vector3.new(0, -75, 0)	
	turning = true
end
function SteerRight()
	print("Steer right")
	local wheelFR = game.Workspace.wheelFR --:FindFirstChild("wheelFR")
	local wheelFL = game.Workspace.wheelFL --:FindFirstChild("wheelFL"

	wheelFR.Rotation = Vector3.new(0, -105, 0)
	wheelFL.Rotation = Vector3.new(0, -105, 0)
	turning = true

end
function ReleaseSteer()
	print("Steer Release")
	local wheelFR = game.Workspace.wheelFR --:FindFirstChild("wheelFR")
	local wheelFL = game.Workspace.wheelFL --:FindFirstChild("wheelFL")

	wheelFR.Rotation = Vector3.new(0, -90, 0)
	wheelFL.Rotation = Vector3.new(0, -90, 0)
	turning = false 
end

function ReadInput(inputObject, gameProcessedEvent)
	
	--if gameProcessedEvent then return end   --Is event already actioned by another script?

	-- Next, check that the input was a keyboard event
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		local input = inputObject.KeyCode.Name
		print("A key was pressed: " ..input )

		if(input ==Enum.KeyCode.A or input == "A")then
			if(InKart == true)then
				SteerLeft()
			end
		elseif(input == Enum.KeyCode.D or input == "D")then
			if(InKart == true)then
				SteerRight()
			end
		end
	end
end
function ReleaseInput(inputObject, gameProcessedEvent)
	if inputObject.UserInputType == Enum.UserInputType.Keyboard then
		local input = inputObject.KeyCode.Name
		print("A key was Released: " ..input )

		if(input ==Enum.KeyCode.A or input == "A")then
			if(turning == true)then
				ReleaseSteer()
			end
		elseif(input == Enum.KeyCode.D or input == "D")then
			if(turning == true)then
				ReleaseSteer()
			end
		end
	end
end

while true do
	wait(.1)
	if(SteerDirection == 1)then 
		
	elseif(SteerDirection == 2)then
		
	end
	
end
-- Cart event listeners
UserInputService.InputBegan:Connect(ReadInput)
UserInputService.InputEnded:Connect(ReleaseInput)