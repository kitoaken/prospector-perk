dofile_once( "data/scripts/lib/utilities.lua" )

-- simple utility function to return the player entity
function getPlayerEntity()
	local players = EntityGetWithTag("player_unit")
	if #players == 0 then return end

	return players[1]
end

-- function to add or subtract gold from player
-- amount can be either negative or positive
function addPlayerGold(amount)

	local player = getPlayerEntity()

	local wallet = EntityGetFirstComponent(player, "WalletComponent")
	local money = ComponentGetValueInt(wallet, "money")
	local player_money = money + amount

	edit_component(player, "WalletComponent", function(comp,vars)
		vars.money = player_money
	end)
end