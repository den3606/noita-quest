local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")

---@param quest_params table { id: string, name: string, time_sec: number, difficulty: number, current_value: number, goal_value: number, reward_names: table, punishment_names: table }
---@param quest_functions table { init: function, update: function, in_progress: function, completed: function, timed_out: function  }
local function new(quest_params, quest_functions)
  local quest = {
    id = quest_params.id,
    name = quest_params.name,
    time_sec = quest_params.time_sec,
    difficulty = quest_params.difficulty,
    current_value = quest_params.current_value,
    goal_value = quest_params.goal_value,
    reward_names = quest_params.reward_names,
    punishment_names = quest_params.punishment_names,
    status = STATUS.IN_PROGRESS,
    init = function(self)
      quest_functions.init(self)
    end,
    update = function(self)
      if self.status == STATUS.COMPLETED or self.status == STATUS.TIMED_OUT then
        return
      end

      quest_functions.update(self)

      if self.time_sec == 0 then
        self.status = STATUS.TIMED_OUT
      end

      self._after_ation(self)

      if self.status == STATUS.IN_PROGRESS then
        self.time_sec = self.time_sec - 1
      end
    end,

    _after_ation = function(self)
      if self.status == STATUS.IN_PROGRESS then
        quest_functions.in_progress(self)
      end

      if self.status == STATUS.COMPLETED then
        quest_functions.completed(self)
      end

      if self.status == STATUS.TIMED_OUT then
        quest_functions.timed_out(self)
      end
    end
  }

  quest.init(quest)

  return quest
end

return { new = new }
