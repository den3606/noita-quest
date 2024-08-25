local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")

local function after_ation(entity, status, quest_functions)
  if status == STATUS.IN_PROGRESS then
    quest_functions.in_progress(entity)
  end

  if status == STATUS.COMPLETED then
    quest_functions.completed(entity)
  end

  if status == STATUS.TIMED_OUT then
    quest_functions.timed_out(entity)
  end
end

local function update(entity, quest_functions)
  local status = GetInternalVariableValue(entity, "status", "value_int")
  if status ~= STATUS.IN_PROGRESS then
    return
  end

  quest_functions.update(entity)

  -- get updated status
  status = GetInternalVariableValue(entity, "status", "value_int")

  local time_sec = GetInternalVariableValue(entity, "time_sec", "value_int")
  if time_sec == 0 then
    status = STATUS.TIMED_OUT
  end

  after_ation(entity, status, quest_functions)

  if status == STATUS.IN_PROGRESS then
    time_sec = time_sec - 1
  end

  SetInternalVariableValue(entity, "status", "value_int", status)
  SetInternalVariableValue(entity, "time_sec", "value_int", time_sec)
end

return { update = update }
