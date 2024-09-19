dofile_once("mods/noita-quest/files/scripts/gui/gui_utilities.lua")
dofile_once("mods/noita-quest/files/scripts/lib/utilities.lua")
local Gui = dofile_once("mods/noita-quest/files/scripts/gui/gui.lua")
local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")
local METADATA = dofile_once("mods/noita-quest/files/scripts/metadata.lua")
local defined_quests = dofile_once("mods/noita-quest/files/scripts/quests/defined_quests.lua")

local function split_string(str, length)
  local result = {}
  local i = 1
  while i <= #str do
    table.insert(result, str:sub(i, i + length - 1))
    i = i + length
  end
  return result
end

local function create_randam_quest_entity(target_difficulty)
  local year, month, day, hour, minute, second = GameGetDateAndTimeUTC()
  SetRandomSeed(year + month + day, hour + minute + second)

  local sign = Random(0, 1) == 0 and -1 or 1

  local quests = {}
  for _, quest in pairs(defined_quests) do
    for index, difficulity in ipairs(quest.difficulties) do
      if target_difficulty == difficulity then
        local quest = {
          value_string = {
            id = quest.id,
            name = quest.name,
            description = quest.description,
            entity_file = quest.entity_file,
            icon_file = quest.icon_file
          },
          value_int = {
            difficulity = quest.difficulties[index],
            time_sec = quest.time_secs[index] + sign * Random(1, quest.time_fluctuation),
            target = quest.targets[index],
            current_value = 0,
            goal_value = 0,
            status = STATUS.IN_PROGRESS
          }
        }
        table.insert(quests, quest)
      end
    end
  end

  local rand = Random(1, #quests)
  local entity = EntityLoad(quests[rand].value_string.entity_file)
  for value_x, params in pairs(quests[rand]) do
    for key, value in pairs(params) do
      AddNewInternalVariable(entity, key, value_x, value)
    end
  end

  return entity
end

local function draw_quest_selection_board(gui)
  -- TODO: 死亡後も表示するかは検討
  local player_entity_id = GetPlayerEntity()
  if not player_entity_id then
    return
  end

  -- この時点でクエストのEntityは生成されている必要がある
  -- 1. ランダムに3つクエストを生成する
  -- 2. 表示し続ける
  -- 3. ユーザがクエストを選択したら、QuestManager.addでクエストを追加する
  -- 4. 1を実施する
  -- 5. 指定数クエストが追加されたら、

  local player_entity = GetPlayerEntity()
  if not player_entity then
    error('player does not exists')
  end

  local quest_selection_board_entity = tonumber(GlobalsGetValue(
    METADATA.QUEST_SELECTION_BOARD_ENTITY, '0'))

  if quest_selection_board_entity == 0 then
    quest_selection_board_entity = EntityLoad(
      "mods/noita-quest/files/entities/quest_selection_board_entity.xml")
    GlobalsSetValue(METADATA.QUEST_SELECTION_BOARD_ENTITY, tostring(quest_selection_board_entity))
  end

  if not quest_selection_board_entity then
    error('Can not get quest_selection_board_entity')
    return;
  end

  -- 選択可能なクエストがない場合、候補を3つ用意する
  local selectable_quest_entities = EntityGetAllChildren(quest_selection_board_entity) or {}
  if #selectable_quest_entities == 0 then
    for i = 1, 3, 1 do
      local quest_entity = create_randam_quest_entity(1)
      EntityAddChild(quest_selection_board_entity, quest_entity)
      table.insert(selectable_quest_entities, quest_entity)
    end
  end

  GuiLayoutHorizontalCallback(gui, { x = 20, y = 20 }, function()
    for index, quest_entity in ipairs(selectable_quest_entities) do
      GuiLayoutVerticalCallback(gui, { margin_x = 10 }, function()
        GuiZCallback(gui, { z_index = -10 }, function()
          GuiScrollContainerCallback(gui, { id = Gui.new_id('quest_box_' .. index), width = 100, height = 200 }, function()
            GuiLayoutVerticalCallback(gui, {}, function()
              GuiLayoutHorizontalCallback(gui, { margin_y = 5 }, function()
                local icon_file = GetInternalVariableValue(quest_entity, "icon_file", "value_string") or ""
                GuiImage(gui, Gui.new_id('quest_icon_' .. index), 0, 0, icon_file, 1, 1, 0)
                local name = GetInternalVariableValue(quest_entity, "name", "value_string") or ""
                GuiText(gui, 0, 2.5, name)
              end)

              local description = GetInternalVariableValue(quest_entity, "description", "value_string") or ""
              local text_list = Split(GameTextGet(description), '\n')
              for i, text in ipairs(text_list) do
                if i == 1 then
                  GuiLayoutHorizontalCallback(gui, {}, function()
                    GuiImage(gui, Gui.new_id('description_icon_' .. index), 0, 0, "mods/noita-quest/files/ui_gfx/icons/description.png", 1, 1, 0)
                    GuiText(gui, 0, 2.5, text)
                  end)
                elseif i == #text_list then
                  GuiLayoutHorizontalCallback(gui, { margin_y = 5 }, function()
                    GuiText(gui, 16, 0, text)
                  end)
                else
                  GuiLayoutHorizontalCallback(gui, {}, function()
                    GuiText(gui, 16, 0, text)
                  end)
                end
              end


              GuiLayoutHorizontalCallback(gui, {}, function()
                GuiImage(gui, Gui.new_id('time_icon_' .. index), 0, 0, "mods/noita-quest/files/ui_gfx/icons/time.png", 1, 1, 0)
                local time_sec = GetInternalVariableValue(quest_entity, "time_sec", "value_int")
                GuiText(gui, 0, 2.5, time_sec .. 's')
              end)

              GuiLayoutHorizontalCallback(gui, {}, function()
                GuiImage(gui, Gui.new_id('ok_icon_' .. index), 0, 0, "mods/noita-quest/files/ui_gfx/icons/ok.png", 1, 1, 0)
                local time_sec = GetInternalVariableValue(quest_entity, "time_sec", "value_int")
                GuiText(gui, 0, 2.5, '成功条件')
              end)

              GuiLayoutHorizontalCallback(gui, {}, function()
                GuiImage(gui, Gui.new_id('ng_icon_' .. index), 0, 0, "mods/noita-quest/files/ui_gfx/icons/ng.png", 1, 1, 0)
                local time_sec = GetInternalVariableValue(quest_entity, "time_sec", "value_int")
                GuiText(gui, 0, 2.5, '失敗条件')
              end)
            end)
          end)
        end)
        GuiImageButton(gui, Gui.new_id('select_button_' .. index), 0, 5, '', "mods/noita-quest/files/ui_gfx/select.png")
      end)
    end
  end)




  -- QuestManagerEntityにいれるように変更する
  -- QuestManager.add(player_picked_quest_ids)
end

return {
  draw_quest_selection_board = draw_quest_selection_board,
}
