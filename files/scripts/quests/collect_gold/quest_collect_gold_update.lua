dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")
local quest = dofile_once("mods/noita-quest/files/scripts/quests/update_quest.lua")
local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")

local function update(entity)
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

  local current_value = get_current_player_gold()
  SetInternalVariableValue(entity, "current_value", "value_int", current_value)

  local goal_value = GetInternalVariableValue(entity, "goal_value", "value_int")
  if current_value >= goal_value then
    SetInternalVariableValue(entity, "status", "value_int", STATUS.COMPLETED)
  end
end

local function in_progress(entity)
end

local function completed(entity)
  local reward_names = Split(GetInternalVariableValue(entity, "reward_names", "value_string"))
  for index, reward_name in ipairs(reward_names) do
    local reward_func = dofile_once("mods/noita-quest/files/scripts/rewards/" ..
      reward_name .. ".lua")
    local data = reward_func()
    GamePrintImportant('クエストに成功しました', '報酬として' .. data.gold .. 'Gold支払われました')
  end
end

local function timed_out(entity)
  local punishment_names = Split(GetInternalVariableValue(entity, "punishment_names", "value_string"))
  for index, punishment_name in ipairs(punishment_names) do
    local punishment_func = dofile_once("mods/noita-quest/files/scripts/punishments/" ..
      punishment_name .. ".lua")
    local data = punishment_func()
    GamePrintImportant('クエストに失敗しました', '罰則として' .. data.gold .. 'Gold失いました')
  end
end


local entity = GetUpdatedEntityID()

quest.update(entity, {
  update = update,
  in_progress = in_progress,
  completed = completed,
  timed_out = timed_out
})
