dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")

local function punishment()
  local player = GetPlayerEntity()
  if not player then
    error('player not found')
  end
  local wallet = EntityGetFirstComponent(player, "WalletComponent")
  if not wallet then
    error('player had no wallet')
  end

  local gold = ComponentGetValue2(wallet, "money")
  local punishment_gold = 200
  local punishmented_gold = gold - punishment_gold
  if punishmented_gold < 0 then
    punishmented_gold = 0
  end
  ComponentSetValue2(wallet, "money", punishmented_gold)

  return {
    gold = punishment_gold
  }
end

return punishment
