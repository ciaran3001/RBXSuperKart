print("Game Controller Starting")

--enums
State = {
	AwaitingPlayers = "Waiting for Players",
	Building = "Building",
	Waiting = "Waiting",
	OnGoing = "OnGoing"
	}
--End of Variables

ClockDirection = {
	Forward = "Forward",
	Backward = "Backward",
	Undefined = "Undefined"
	}

--end of enums

--Variables


GameController = {}

MapBuild = false
NumberOfPlayer = 0
LeaderBoard = {}
GameStarted = false
GameState = State.AwaitingPlayers  --Waiting for Players, Building, Waiting, OnGoing

map = {}

GameClock = {
	value = 0, 
	direction = ClockDirection.Undefined,
	StateChangeImplemented = false
	}   --in seconds




--Functions


--End of functions
	GameController.CountPlayers = function()
		
	end
	
	GameController.BuildMap = function()
		GameState = State.Building
	
		--Squares of the camp (5x5)  location of [0][0] = -400,2.5,14     [0][1] = -360,2.5,14
		--single square dimensions = 60,1,60
		local squareSize = 5
		local squareNumber = 0
		local startPos = Vector3.new(-400,2.5,14) 

		local offsetX = 0
		local offsetZ = 0
		
		local indexX = 0
		local indexZ = 0
		
		for squareNumber = 1,squareSize * squareSize,1 
		do 
			print("grid square".. tostring(squareNumber))	
			local _sqr = Instance.new("Part", game.Workspace)
			_sqr.Name = "grid square"
			_sqr.Size =  Vector3.new(60,1,60)
			_sqr.Position = Vector3.new((startPos.X + offsetX ),startPos.Y,(startPos.Z + offsetZ))
			_sqr.Anchored = true
			_sqr.Color = Color3.new(105,64,40)
			
			offsetZ = offsetZ + 60
			
			
			if(squareNumber % 5 == 0 and squareNumber > 0)then
				print("Row completed.")
				offsetZ = 0
				offsetX = offsetX + 60
			end
			
			map.squares[squareNumber]= _sqr
		 	print("Plotting Square") 
		end
		print("Game built")
		GameState = State.Waiting
		MapBuild = true
		return
	end
	
	GameController.DestroyMap = function()
		
	end
	
	GameController.StopGame = function()
		
	end
	
	GameController.UpdateLeaderBoard = function()
		
	end
	
	GameController.QueueGame = function()
		GameState = State.Waiting
	end
	
	GameController.GetGameInfo = function()
		local _tmp = {}
		_tmp.numberOfPlayers = NumberOfPlayer
		_tmp.State = GameState
		_tmp.LeaderBoard = LeaderBoard
		_tmp.GameStarted = GameStarted
		
		return _tmp
	end

	GameController.UpdatePlayerVariables = function()
		--[[local players = game.Players:GetChildren()

		for i = 1, #players do
			local player = players[i] 
			print(player.name)
			local BackPack = player:WaitForChild("Backpack")
			local PlayerClock = BackPack:WaitForChild("Clock")
			PlayerClock.Value = GameClock

		end]]--
		
	end
	
	GameController.RunClock = function()
		if(GameClock.direction == ClockDirection.Forward)then
			GameClock.value = GameClock.value +1
		else
			if(GameClock.value <= 0)then 
				GameController.CompleteCountdown()
			else
				GameClock.value = GameClock.value -1
			end
		end
		
		if(GameClock.StateChangeImplemented == false)then
			if(GameState == State.AwaitingPlayers) then
				--Countup from 0
				GameClock.value = 0
				GameClock.direction = ClockDirection.Forward
				GameClock.StateChangeImplemented = true
			elseif(GameState == State.OnGoing)then
				--countdown from game time.
				GameClock.value = 100
				GameClock.direction = ClockDirection.Backward
				GameClock.StateChangeImplemented = true
			elseif(GameState == State.Waiting)then
				--Countdown from 10
				GameClock.value = 10
				GameClock.direction = ClockDirection.Backward
				GameClock.StateChangeImplemented = true
			end
		end

		
		game.ReplicatedStorage.Clock.Value = GameClock.value	
		print("tock")			
	end

	GameController.CompleteCountdown = function()
		print("Countdown Completed")
	end

--Calling of functions
while true do
	wait(1)
	GameController.RunClock()
	game.ReplicatedStorage.GameState.Value = GameState


	if(GameStarted == false) then
		GameController.CountPlayers()
		if(NumberOfPlayer >= 5) then
			--GameController.BuildMap()
			GameController.QueueGame()
		else
			GameState = State.AwaitingPlayers	
		end
	end
	
	--testing building function
	if(GameClock.value >= 20 and GameState == State.AwaitingPlayers)then
		if(MapBuild == false) then
			GameState = State.Building
			GameController.BuildMap()
		end
	end
	
end

--end of calling of functions


