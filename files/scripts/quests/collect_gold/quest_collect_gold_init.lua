dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")

local function get_current_player_gold()
  local player = GetPlayerEntity()
  if not player then
    error('player not found')
  end
  local wallet = EntityGetFirstComponent(player, "WalletComponent")
  if not wallet then
    error('player had no wallet')
  end

  local gold = ComponentGetValue2(wallet, "money")
  return gold
end

local start_gold = get_current_player_gold()

local entity = GetUpdatedEntityID()

local target_gold = GetInternalVariableValue(entity, "target_gold", "value_int")
local goal_value = start_gold + target_gold

print("goal_value: " .. tostring(goal_value))

SetInternalVariableValue(entity, "goal_value", "value_int", goal_value)

EntityAddComponent2(entity, "LuaComponent", {
  script_source_file =
  "mods/noita-quest/files/scripts/quests/collect_gold/quest_collect_gold_update.lua",
  execute_every_n_frame = 60,
})
