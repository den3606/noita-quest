local quest = dofile_once("mods/noita-quest/files/scripts/quests/quest.lua")
local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")
local QUEST = dofile_once("mods/noita-quest/files/scripts/quests/quest_names.lua")

local function init(self)
  print('init process')
end

local function update(self)
  if not self.count then
    self.count = 0
  end

  self.count = self.count + 1
  print('updated')
  print('count: ' .. self.count)

  if self.count > 5 then
    self.status = STATUS.TIMED_OUT
  end
end

local function in_progress(self)
  print('in_progress process')
end

local function completed(self)
  print('completed process')
end

local function timed_out(self)
  print('timed_out process')
end

local function new()
  local REWARD = dofile_once("mods/noita-quest/files/scripts/rewards/reward_names.lua")
  local PUNISHMENT = dofile_once("mods/noita-quest/files/scripts/punishments/punishment_names.lua")

  local quest_params = {
    id = QUEST.COLLECT_HEART,
    name = 'Strong Heart',
    time_sec = 60 * 5,
    difficulty = 3,
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
