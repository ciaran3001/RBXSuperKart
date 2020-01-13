print("Game Brain Started")

local Players = game:GetService("Players")
local NumberOfPlayers =0
local RacePlayers = {}
local PlayerArray = {}

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end



function InitializeRace()

	print("Getting players")
	NumberOfPlayers = tablelength(game.Players:GetPlayers())--Players:GetPlayers())
	print("players got")


	print("Initializing")
	local KartsRelationship = Instance.new("Model",workspace)
	KartsRelationship.Name = "KartsRelationship"
	
	local players = game.Players:GetPlayers()
	for i=1,#players do
	    table.insert(PlayerArray,players[i])
		local UserFolder = Instance.new("Model",KartsRelationship)
		UserFolder.Name = players[i].Name
	end


	--for i = 0,NumberOfPlayers,1 
	--do 

		
	--end
	
	print("Finished Initializing")
end







while true do
    NumberOfPlayers = tablelength(game.Players:GetPlayers())
	print("There are/is " .. NumberOfPlayers .." players in this game.")
	InitializeRace()
	wait(5)
end





