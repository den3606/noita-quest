dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")
local quest = dofile_once("mods/noita-quest/files/scripts/quests/quest.lua")
local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")

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

local function init(self)
  self.start_gold = get_current_player_gold()
end

local function update(self)
  if get_current_player_gold() - self.start_gold >= 2000 then
    self.status = STATUS.COMPLETED
  end
end

local function in_progress(self)
  print('in_progress process')
end

local function completed(self)
  for index, reward_name in ipairs(self.reward_names) do
    local reward_func = dofile_once("mods/noita-quest/files/scripts/rewards/" ..
      reward_name .. ".lua")
    local data = reward_func()
    GamePrintImportant('クエストに成功しました', '報酬として' .. data.gold .. 'Gold支払われました')
  end
end

local function timed_out(self)
  for index, punishment_name in ipairs(self.punishment_names) do
    local punishment_func = dofile_once("mods/noita-quest/files/scripts/punishments/" ..
      punishment_name .. ".lua")
    local data = punishment_func()
    GamePrintImportant('クエストに失敗しました', '罰則として' .. data.gold .. 'Gold失いました')
  end
end

local function new()
  local REWARD = dofile_once("mods/noita-quest/files/scripts/rewards/reward_names.lua")
  local PUNISHMENT = dofile_once("mods/noita-quest/files/scripts/punishments/punishment_names.lua")

  local quest_params = {
    id = 'collect_gold',
    name = 'You are rich',
    time_sec = 60,
    difficulty = 1,
    reward_names = { REWARD.GOLD },
    punishment_names = { PUNISHMENT.GOLD }
  }

  local quest_functions = {
    init = init,
    update = update,
    in_progress = in_progress,
    completed = completed,
    timed_out = timed_out
  }

  return quest.new(quest_params, quest_functions)
end

return {
  new = new
}
