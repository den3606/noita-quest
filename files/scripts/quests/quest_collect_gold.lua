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
  if get_current_player_gold() - self.start_gold >= 200 then
    self.status = STATUS.COMPLETED
  end
end

local function in_progress(self)
  print('in_progress process')
end

local function completed(self)
  GamePrint('あなたはお金持ちです！')
end

local function timed_out(self)
  GamePrint('あなたはクソ貧乏です！')
end

local function new()
  local quest_name = 'collect_gold'
  local quest_time_sec = 10
  local difficulty = 1
  local quest_functions = {
    init = init,
    update = update,
    in_progress = in_progress,
    completed = completed,
    timed_out = timed_out
  }
  return quest.new(quest_name, quest_time_sec, difficulty, quest_functions, quest_functions)
end

return {
  new = new
}
