local InKart = true --True for dev
local Kart = {}
local turning = true
local SteerDirection = 0 --1 = Left, 2 = right, 0 = not steering
local Driving = false
local Speed = 0
local Boosted  = false
local DriveDirection = nil
local LeftReleased = true
local RightReleased = true
local IsFalling = false
local IsGliding = false

--services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local wheelFL = nil
local wheelFR = nil

function Initialize()
	print("Finding car_"..player.Name)
	local karModel = game.Workspace:WaitForChild("car_"..player.Name)
	Kart = karModel
	DriveDirection = Kart.Base.CFrame.lookVector
	print("Starting Drive Direction: " ..tostring(DriveDirection))
	wheelFR = Kart.wheelFR 
	wheelFL = Kart.wheelFL 
	Speed = 5

end
function StartDriving()	
	Driving = true
	Kart.Base.Velocity = Kart.Base.CFrame.lookVector *50 
	
end
function StopDriving()
	Driving = false
end
function SteerLeft()
	print("Steer left")
	LeftReleased = false
	wheelFL.Rotation = Kart.Base.Rotation + Vector3.new(0, 45, 0)
	wheelFR.Rotation = Kart.Base.Rotation + Vector3.new(0, 45, 0)
	turning = true
	SteerDirection = 1

	wheelFL.Smoke.Enabled = true
	Kart.wheelBL.Smoke.Enabled = true
end
function SteerRight()
	print("Steer right")
	wheelFL.Rotation = Kart.Base.Rotation + Vector3.new(0, -45, 0)	--wheelFL
	wheelFR.Rotation = Kart.Base.Rotation + Vector3.new(0, -45, 0)   --wheelFR
	turning = true
	SteerDirection = 2
	RightReleased = false
	wheelFR.Smoke.Enabled = true
	Kart.wheelBR.Smoke.Enabled = true
end
function ReleaseSteer()
	print("Steer Release")
	wheelFL.Rotation = Kart.Base.Rotation 
	wheelFR.Rotation = Kart.Base.Rotation 
	turning = false 
	SteerDirection = 0
	
	wheelFL.Smoke.Enabled = false
	Kart.wheelBL.Smoke.Enabled = false
	wheelFR.Smoke.Enabled = false
	Kart.wheelBR.Smoke.Enabled = false
end
function RotateKartParts()
	local Kart
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
		end
		if(input == Enum.KeyCode.D or input == "D")then
			if(InKart == true)then
				SteerRight()
			end
		elseif(input ==Enum.KeyCode.E or input == "E")then
			if(Driving == false)then
				StartDriving()
			else
				StopDriving()
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
				LeftReleased = true
			end
		elseif(input == Enum.KeyCode.D or input == "D")then
			if(turning == true)then
				ReleaseSteer()
				RightReleased = true
			end
		end
	end
end

Initialize()
UserInputService.InputBegan:Connect(ReadInput)
UserInputService.InputEnded:Connect(ReleaseInput)

--Main Thread
while true do
	if(Driving == true)then
		print("Driving = true")
	end
	
	wait(.1)
	if(SteerDirection == 0)then
		if(LeftReleased == false)then
			print("Fix left")
			SteerDirection = 1
			SteerBugConsolidationCount = SteerBugConsolidationCount+1
			if(SteerBugConsolidationCount >= 10)then
				LeftReleased = true
			end
		elseif(RightReleased == false)then
			SteerDirection = 2
			print("Fix right")
			SteerBugConsolidationCount = SteerBugConsolidationCount+1
			if(SteerBugConsolidationCount >= 10)then
				RightReleased = true
			end
		end
	end
	
	if(SteerDirection == 1)then 

		Kart.Base.RotVelocity = Kart.Base.RotVelocity +  Vector3.new(0,.7,0)
		local KartParts = Kart:GetChildren()
		print("Starting Drive Direction: " ..tostring(DriveDirection))
		DriveDirection = Kart.Base.CFrame.lookVector

	elseif(SteerDirection == 2)then

		Kart.Base.RotVelocity = Kart.Base.RotVelocity +  Vector3.new(0,-.7,0)
		local KartParts = Kart:GetChildren()
		print("Starting Drive Direction: " ..tostring(DriveDirection))
		DriveDirection = Kart.Base.CFrame.lookVector
	else
		Kart.Base.RotVelocity =  Vector3.new(0,0,0)
	end
	
	if(Driving)then
		if(Boosted == false)then
			Kart.Base.Velocity = (DriveDirection *50) + Vector3.new(0,-75,0)
			print("Drive")
		end
	
	end
	
end
-- Cart event listeners
