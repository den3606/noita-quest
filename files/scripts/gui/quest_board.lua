local Gui = dofile_once("mods/noita-quest/files/scripts/gui/gui.lua")
local STATUS = dofile_once("mods/noita-quest/files/scripts/quests/quest_status.lua")

local function draw_quest_board(gui, assigned_quest_entities)
  -- TODO: 死亡後も表示するかは検討
  local player_entity_id = GetPlayerEntity()
  if not player_entity_id then
    return
  end


  if #assigned_quest_entities ~= 0 then
    GuiLayoutBeginVertical(gui, 15, 75, true, 0, 0)

    for index, quest_entity in ipairs(assigned_quest_entities) do
      GuiLayoutBeginHorizontal(gui, 0, 0, true, -3, -4)
      GuiImageButton(gui, Gui.new_id('quest_status_' .. index), 0, 0, "",
        "data/ui_gfx/perk_icons/perks_lottery.png")
      GuiImageButton(gui, Gui.new_id('quest_icon_' .. index), 0, 0, "",
        "data/ui_gfx/perk_icons/perks_lottery.png")

      local current_value = GetInternalVariableValue(quest_entity, "current_value", "value_int")
      local goal_value = GetInternalVariableValue(quest_entity, "goal_value", "value_int")
      local status = GetInternalVariableValue(quest_entity, "status", "value_int")
      local name = GetInternalVariableValue(quest_entity, "name", "value_string") or ""
      local time_sec = GetInternalVariableValue(quest_entity, "time_sec", "value_int")

      local quest_text = name

      if status == STATUS.IN_PROGRESS then
        quest_text = time_sec .. "s " .. quest_text
      end

      if current_value and goal_value then
        quest_text = quest_text .. " [" .. current_value .. "/" .. goal_value .. "]"
      end

      GuiText(gui, 4, 2.5, quest_text)
      GuiLayoutEnd(gui)
    end
    GuiLayoutEnd(gui)

    -- if ((show_button_in_inventory_only and (inventory_is_open or is_open)) or not show_button_in_inventory_only) and then
    --   is_open = not is_open
    --   if is_open then
    --     rebuild_perk_table()
    --     if show_button_in_inventory_only and inventory_gui_comp then
    --       ComponentSetValue2(inventory_gui_comp, "mActive", false)
    --     end
    --   end
    -- end
  end
end

return {
  draw_quest_board = draw_quest_board,
}
