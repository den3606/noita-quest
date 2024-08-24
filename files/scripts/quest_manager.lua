local METADATA = dofile_once("mods/noita-quest/files/scripts/metadata.lua")
dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")

local quest_manager_entity = nil

local function add(quest_names)
  local player = GetPlayerEntity()

  if not player then
    error('player does not exist')
  end

  if not quest_manager_entity then
    quest_manager_entity = EntityCreateNew(METADATA.MOD_NAME)
    EntityAddChild(player, quest_manager_entity)
  end

  for index, quest_name in ipairs(quest_names) do
    local quest_entity = EntityLoad("mods/noita-quest/files/entities/quests/" .. quest_name .. ".xml")
    EntityAddChild(quest_manager_entity, quest_entity)
  end
end

local function get_assigned_quest_entities()
  if quest_manager_entity then
    return EntityGetAllChildren(quest_manager_entity)
  end

  return {}
end

return {
  add = add,
  get_assigned_quest_entities = get_assigned_quest_entities
}
