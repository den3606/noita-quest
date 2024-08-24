local assigned_quests = {}

local function add(quest_names)
  for index, value in ipairs(quest_names) do
    local quest = dofile_once("mods/noita-quest/files/scripts/quests/quest_" .. value .. ".lua")

    if quest then
      table.insert(assigned_quests, quest.new())
    end
  end
end

local function update()
  for index, quest in ipairs(assigned_quests) do
    quest.update(quest)
  end
end

local function get_assigned_quests()
  return assigned_quests
end

return {
  add = add,
  update = update,
  get_assigned_quests = get_assigned_quests
}
