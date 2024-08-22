local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")

local function new(name, quest_time_sec, difficulty, quest_functions)
  local quest = {
    name = name,
    quest_time_sec = quest_time_sec,
    difficulty = difficulty,
    status = STATUS.IN_PROGRESS,
    init = function(self)
      quest_functions.init(self)
    end,
    update = function(self)
      if self.status == STATUS.COMPLETED or self.status == STATUS.TIMED_OUT then
        return
      end

      quest_functions.update(self)

      if self.quest_time_sec == 0 then
        self.status = STATUS.TIMED_OUT
      end

      self._after_ation(self)

      if self.status == STATUS.IN_PROGRESS then
        self.quest_time_sec = self.quest_time_sec - 1
      end
    end,

    _after_ation = function(self)
      if self.status == STATUS.IN_PROGRESS then
        quest_functions.in_progress()
      end

      if self.status == STATUS.COMPLETED then
        quest_functions.completed()
      end

      if self.status == STATUS.TIMED_OUT then
        quest_functions.timed_out()
      end
    end
  }

  quest.init(quest)

  return quest
end

return { new = new }
