local quest = dofile_once("mods/noita-quest/files/scripts/quests/quest.lua")
local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")

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

  if self.count > 30 then
    self.status = STATUS.COMPLETED
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
  local quest_name = 'collect_gold'
  local quest_time_sec = 60
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
