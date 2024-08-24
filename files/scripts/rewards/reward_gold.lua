dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")

local function reward()
  local player = GetPlayerEntity()
  local x, y = EntityGetTransform(player)
  EntityLoad("data/entities/items/pickup/goldnugget_50.xml", x + 20, y - 20)
  EntityLoad("data/entities/items/pickup/goldnugget_50.xml", x + 10, y - 30)
  EntityLoad("data/entities/items/pickup/goldnugget_50.xml", x + 00, y - 30)
  EntityLoad("data/entities/items/pickup/goldnugget_50.xml", x - 10, y - 40)
  EntityLoad("data/entities/items/pickup/goldnugget_50.xml", x - 20, y - 20)

  return {
    gold = 250
  }
end

return reward
